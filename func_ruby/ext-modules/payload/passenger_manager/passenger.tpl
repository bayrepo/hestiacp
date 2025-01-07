# Default Web Domain Template                                             #
# DO NOT MODIFY THIS FILE! CHANGES WILL BE LOST WHEN REBUILDING DOMAINS   #
#=========================================================================#

server {
	listen      %ip%:%proxy_port%;
	server_name %domain_idn% %alias_idn%;
	root %docroot%;
	error_log   /var/log/%web_system%/domains/%domain%.error.log error;

	include %home%/%user%/conf/web/%domain%/nginx.forcessl.conf*;

	location ~ /\.(?!well-known\/|file) {
		deny all;
		return 404;
	}

	passenger_enabled on;
	passenger_user %user%;
	passenger_group %user%;
	passenger_ruby %rubypath%;
	passenger_friendly_error_pages %rubylog%;

	location / {
	    passenger_base_uri /;
        passenger_app_root %docrtpriv%;
        passenger_document_root %docroot%;
        passenger_startup_file config.rb;
	    passenger_app_type rack;
	}

	disable_symlinks if_not_owner from=%docroot%;

	include %home%/%user%/conf/web/%domain%/nginx.conf_*;
}