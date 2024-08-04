#!/bin/bash

# Clean installation bootstrap for development purposes only
# Usage:    ./hst_bootstrap_install.sh [fork] [branch] [os]
# Example:  ./hst_bootstrap_install.sh hestiacp main ubuntu

# Define variables
fork=$1
branch=$2
os=$3

# Download specified installer and compiler
if [ -f "/etc/redhat-release" ]; then
	wget https://dev.putey.net/bayrepo/hestiacp/raw/branch/master/install/hst-install-rhel.sh
else
	wget https://dev.putey.net/bayrepo/hestiacp/raw/branch/master/install/hst-install-$os.sh
fi
wget https://dev.putey.net/bayrepo/hestiacp/raw/branch/master/src/hst_autocompile.sh

# Execute compiler and build hestia core package
chmod +x hst_autocompile.sh
./hst_autocompile.sh --hestia $branch no

# Execute Hestia Control Panel installer with default dummy options for testing
if [ -f "/etc/redhat-release" ]; then
	bash hst-install-rhel.sh -f -y no -e admin@test.local -p P@ssw0rd -s hestia-$branch-rhel.test.local --with-rpms /tmp/hestiacp-src/rpms
else
	bash hst-install-$os.sh -f -y no -e admin@test.local -p P@ssw0rd -s hestia-$branch-$os.test.local --with-debs /tmp/hestiacp-src/debs
fi
