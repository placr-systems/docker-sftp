#!/bin/bash

set -ex

# Add sshd as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- /usr/sbin/sshd "$@"
fi

# Update folder ownerships and set pub keys
if [ "$1" = '/usr/sbin/sshd' ]; then
	# Create data folder if they don't exist yet
    mkdir -p /home/sftpuser/data/Transmit
    mkdir -p /home/sftpuser/data/ToLoad
    mkdir -p /home/sftpuser/data/Loaded
    mkdir -p /home/sftpuser/data/Failed
	# Update the ownership of /home/sftpuser/data
	chown -R sftpuser:sftponly /home/sftpuser/data/*
	# Open it up for other users in case folder is shared.
	# Note: Cannot open data folder itself or sshd will not start.
	chmod -R a+rw /home/sftpuser/data/Transmit
	chmod -R a+rw /home/sftpuser/data/ToLoad
	chmod -R a+rw /home/sftpuser/data/Loaded
	chmod -R a+rw /home/sftpuser/data/Failed
	# Set public keys provided via env vars
	echo $PUB_KEY1 > /home/sftpuser/.ssh/authorized_keys
	echo $PUB_KEY2 >> /home/sftpuser/.ssh/authorized_keys
	echo $PUB_KEY3 >> /home/sftpuser/.ssh/authorized_keys
	echo $PUB_KEY4 >> /home/sftpuser/.ssh/authorized_keys
	chown sftpuser /home/sftpuser/.ssh/authorized_keys
	chmod 600 /home/sftpuser/.ssh/authorized_keys
	exec "$@"
fi

# As argument is not related to sshd,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
