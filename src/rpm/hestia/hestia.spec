%define debug_package %{nil}
%global _hardened_build 1

Name:              hestia
Version:           1.8.0~alpha
Release:           1%{dist}
Summary:           Hestia Control Panel
Group:             System Environment/Base
License:           GPLv3
URL:               https://www.hestiacp.com
Source0:           https://github.com/hestiacp/hestiacp/archive/refs/tags/%{version}.tar.gz#/hestia-%{version}.tar.gz
Source1:           hestia.service
Source2:           hestia.tmpfiles
Vendor:            hestiacp.com
BuildArch:         noarch

BuildRequires:     redhat-rpm-config
BuildRequires:     systemd

Requires:          bash
Requires:          gawk
Requires:          sed
Requires:          acl
Requires:          sysstat
Requires:          util-linux
Requires:          zstd
Requires:          jq
Requires(post):    systemd
Requires(preun):   systemd
Requires(postun):  systemd

Provides:          hestia = %{version}-%{release}
Conflicts:         redhat-release < 8
Conflicts:         vesta

%description
This package contains the Hestia Control Panel.

%prep
%autosetup -p1 -n hestiacp

%build

%install
mkdir -p %{buildroot}%{_unitdir} %{buildroot}%{_tmpfilesdir} %{buildroot}/usr/local/hestia
cp -R %{_builddir}/hestiacp/* %{buildroot}/usr/local/hestia/
install -m644 %{SOURCE1} %{buildroot}%{_unitdir}/hestia.service
install -D %SOURCE2 %{buildroot}%{_tmpfilesdir}/%{name}.conf

# Cleanup not required files so package will be smaller
rm -rf %{buildroot}/usr/local/hestia/src/deb %{buildroot}/usr/local/hestia/src/archive %{buildroot}/usr/local/hestia/test %{buildroot}/usr/local/hestia/docs

%clean


%pre
# Run triggers only on updates
if [ -e "/usr/local/hestia/data/users/admin" ]; then
    # Validate version number and replace if different
    HESTIA_V=$(rpm --queryformat="%{VERSION}" -q hestia)
    if [ ! "$HESTIA_V" = "%{version}" ]; then
        sed -i "s/VERSION=.*/VERSION='$HESTIA_V'/g" /usr/local/hestia/conf/hestia.conf
    fi
fi

%post
%tmpfiles_create_package %{name} %SOURCE2
%systemd_post hestia.service

if [ ! -e /etc/profile.d/hestia.sh ]; then
    HESTIA='/usr/local/hestia'
    echo "export HESTIA='$HESTIA'" > /etc/profile.d/hestia.sh
    echo 'PATH=$PATH:'$HESTIA'/bin' >> /etc/profile.d/hestia.sh
    echo 'export PATH' >> /etc/profile.d/hestia.sh
    chmod 755 /etc/profile.d/hestia.sh
    source /etc/profile.d/hestia.sh
fi

if [ -e "/usr/local/hestia/data/users/admin" ]; then
    ###############################################################
    #                Initialize functions/variables               #
    ###############################################################

    # Load upgrade functions and refresh variables/configuration
    source /usr/local/hestia/func/upgrade.sh
    upgrade_refresh_config

    ###############################################################
    #             Set new version numbers for packages            #
    ###############################################################
    # Hestia Control Panel
    new_version=$(rpm --queryformat="%{VERSION}" -q hestia)

    # phpMyAdmin
    pma_v='5.0.2'

    ###############################################################
    #               Begin standard upgrade routines               #
    ###############################################################

    # Initialize backup directories
    upgrade_init_backup

    # Set up console display and welcome message
    upgrade_welcome_message

    # Execute version-specific upgrade scripts
    upgrade_start_routine

    # Update Web domain templates
    upgrade_rebuild_web_templates | tee -a $LOG

    # Update Mail domain templates
    upgrade_rebuild_mail_templates | tee -a $LOG

    # Update DNS zone templates
    upgrade_rebuild_dns_templates | tee -a $LOG

    # Upgrade File Manager and update configuration
    upgrade_filemanager | tee -a $LOG

    # Upgrade SnappyMail if applicable
    upgrade_snappymail | tee -a $LOG

    # Upgrade Roundcube if applicable
    upgrade_roundcube | tee -a $LOG

    # Upgrade PHPMailer if applicable
    upgrade_phpmailer | tee -a $LOG

    # Update Cloudflare IPs if applicable
    upgrade_cloudflare_ip | tee -a $LOG

    # Upgrade phpMyAdmin if applicable
    upgrade_phpmyadmin | tee -a $LOG

    # Upgrade phpPgAdmin if applicable
    upgrade_phppgadmin | tee -a $LOG

    # Upgrade blackblaze-cli-took if applicable
    upgrade_b2_tool | tee -a $LOG

	# update whitelabel logo's
	update_whitelabel_logo | tee -a $LOG

    # Set new version number in hestia.conf
    upgrade_set_version

    # Perform account and domain rebuild to ensure configuration files are correct
    upgrade_rebuild_users

    # Restart necessary services for changes to take full effect
    upgrade_restart_services

    # Add upgrade notification to admin user's panel and display completion message
    upgrade_complete_message
fi

%preun
%systemd_preun hestia.service

%postun
%systemd_postun_with_restart hestia.service

%files
%defattr(-,root,root)
%attr(755,root,root) /usr/local/hestia
%{_unitdir}/hestia.service
%{_tmpfilesdir}/%{name}.conf

%changelog
* Sun May 14 2023 Istiak Ferdous <hello@istiak.com> - 1.8.0-1
- HestiaCP RHEL 9 support

* Thu Jun 25 2020 Ernesto Nicolás Carrea <equistango@gmail.com> - 1.2.0
- HestiaCP CentOS 8 support