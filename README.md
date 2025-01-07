<h1 align="center">Hestia Control Panel</h1>

<h2 align="center">Lightweight and powerful control panel for the modern web</h2>

<p align="center"><strong>Original project:</strong> | <a href="https://github.com/hestiacp/hestiacp/blob/release/CHANGELOG.md">View Changelog</a> |
<a href="https://www.hestiacp.com/">HestiaCP.com</a> |
	<a href="https://docs.hestiacp.com/">Documentation</a> |
	<a href="https://forum.hestiacp.com/">Forum</a>
	<br/><br/></p>


<p align="center">
	<strong>RPM support project:</strong> |
	<a href="https://hestiadocs.brepo.ru/">Documentation for version with RPM support</a>
</p>

## **Welcome!**

Hestia Control Panel is designed to provide administrators an easy to use web and command line interface, enabling them to quickly deploy and manage web domains, mail accounts, DNS zones, and databases from one central dashboard without the hassle of manually deploying and configuring individual components or services.

## Features and Services

- Apache2 and NGINX with PHP-FPM
- Multiple PHP versions (5.6 - 8.2, 8.0 as default)
- DNS Server (Bind) with clustering capabilities
- POP/IMAP/SMTP mail services with Anti-Virus, Anti-Spam, and Webmail (ClamAV, SpamAssassin, Sieve, Roundcube)
- MariaDB/MySQL and/or PostgreSQL databases
- Let's Encrypt SSL support with wildcard certificates
- Firewall with brute-force attack detection and IP lists (iptables, fail2ban, and ipset).

## Supported platforms and operating systems

- **MSVSphere:** 9
- **AlmaLinux:** 9
- **RockyLinux:** 9

Currently stayed support of Debian and Ubuntu, but new functional will be available only for RPM based systems. For full supportin of Debian and Ubuntu use original [HestiaCP](https://github.com/hestiacp/hestiacp)

**NOTES:**

- Hestia Control Panel does not support 32 bit operating systems!
- Hestia Control Panel in combination with OpenVZ 7 or lower might have issues with DNS and/or firewall. If you use a Virtual Private Server we strongly advice you to use something based on KVM or LXC!

## Installing Hestia Control Panel

- **NOTE:** You must install Hestia Control Panel on top of a fresh operating system installation to ensure proper functionality.

While we have taken every effort to make the installation process and the control panel interface as friendly as possible (even for new users), it is assumed that you will have some prior knowledge and understanding in the basics how to set up a Linux server before continuing.

### Step 1: Log in

To start the installation, you will need to be logged in as **root** or a user with super-user privileges. You can perform the installation either directly from the command line console or remotely via SSH:

```bash
ssh root@your.server
```

### Step 2: Download

Download the installation script for the latest release:

```bash
wget https://dev.brepo.ru/bayrepo/hestiacp/raw/branch/master/install/hst-install.sh
```

If the download fails due to an SSL validation error, please be sure you've installed the ca-certificate package on your system - you can do this with the following command:

```bash
yum update
```

### Step 3: Run

To begin the installation process, simply run the script and follow the on-screen prompts:

```bash
bash hst-install.sh
```

You will receive a welcome email at the address specified during installation (if applicable) and on-screen instructions after the installation is completed to log in and access your server.

### Custom installation

You may specify a number of various flags during installation to only install the features in which you need. To view a list of available options, run:

```bash
bash hst-install.sh -h
```

## How to upgrade an existing installation

Automatic Updates are enabled by default on new installations of Hestia Control Panel and can be managed from **Server Settings > Updates**. To manually check for and install available updates, use the system package manager:

```bash
dnf update
```

## Issues & Support Requests

- If you encounter a general problem while using Hestia Control Panel for RPM based system use [issue report](https://github.com/bayrepo/hestiacp/issues)

For original HestiaCP for Debian and Ubuntu use [original version](https://github.com/hestiacp/hestiacp):

## Copyright

See original copyright of [HestiaCP](https://github.com/hestiacp/hestiacp)

## License

Hestia Control Panel is licensed under [GPL v3](https://github.com/hestiacp/hestiacp/blob/release/LICENSE) license, and is based on the [VestaCP](https://vestacp.com/) project.<br>
