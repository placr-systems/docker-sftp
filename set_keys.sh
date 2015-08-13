#!/bin/bash

echo $PUB_KEY1 > /home/sftpuser/.ssh/authorized_keys
echo $PUB_KEY2 >> /home/sftpuser/.ssh/authorized_keys
echo $PUB_KEY3 >> /home/sftpuser/.ssh/authorized_keys
echo $PUB_KEY4 >> /home/sftpuser/.ssh/authorized_keys
chown sftpuser /home/sftpuser/.ssh/authorized_keys
chmod 600 /home/sftpuser/.ssh/authorized_keys
