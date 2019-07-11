#!/bin/bash
# Author: jbreed
# Purpose: setup the Nessus docker environment

set -e

# Setup permissions
echo "Setting user permissions..."
if [[ "$PUID" ]]
then
	echo "Modifying ID for nobody."
	usermod -a -G users -o -u "$PUID" nobody &>/dev/null
fi

if [[ "$PGID" ]]
then
	echo "Modifying ID for the users group."
	groupmod -o -g "$PGID" users &>/dev/null
fi

# Add DNS resolvers
echo "Adding nameservers to /etc/resolv.conf..."
echo 'nameserver 1.1.1.1' >> /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

# Extract nessus to either upgrade, or place initial install files
echo "Extracting packaged nessus debian package: Nessus 8.5.1..."
dpkg -x /tmp/Nessus-8.5.1-ubuntu1110_amd64.deb /config

# Set permissions on configuration files
echo "Changing owner and group of configuration files..."
chown -R nobody:users /config

# With nessus installed to the volume path; create symbolic links
echo "Creating symbolic links..."
ln -s /config/etc/init.d/nessusd /etc/init.d/nessusd
ln -s /config/opt/nessus/ /opt/nessus

# Cleanup .deb file no longer needed
echo "Cleaning up..."
rm -rf /tmp/Nessus-8.5.1-ubuntu1110_amd64.deb 

# Start the nessusd process
service nessusd start && tail -f /dev/null

exec "$@"