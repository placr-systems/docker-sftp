FROM  	debian:jessie

RUN \
        apt-get update && apt-get -y upgrade && \
        apt-get install -y openssh-server && \
        rm -rf /var/lib/apt/lists/*
  		
# Prepare sftp only part
RUN     addgroup sftponly
RUN     useradd -d /home/sftpuser -s /usr/lib/sftp-server -M -N -g sftponly sftpuser
RUN     mkdir -p /home/sftpuser /home/sftpuser/.ssh
#ADD     sshd/authorized_keys.conf /home/sftpuser/.ssh/authorized_keys
RUN     chown -R sftpuser:sftponly /home/sftpuser/.ssh
RUN     chmod 700 /home/sftpuser/.ssh
RUN     mkdir -p /home/sftpuser/Transmit
RUN     mkdir -p /home/sftpuser/ToLoad
RUN     mkdir -p /home/sftpuser/Loaded
RUN     mkdir -p /home/sftpuser/Failed
RUN     chown -R sftpuser:sftponly /home/sftpuser/Transmit
RUN     chown -R sftpuser:sftponly /home/sftpuser/ToLoad
RUN     chown -R sftpuser:sftponly /home/sftpuser/Loaded
RUN     chown -R sftpuser:sftponly /home/sftpuser/Failed
RUN     chmod -R a+rw /home/sftpuser/Transmit
RUN     chmod -R a+rw /home/sftpuser/ToLoad
RUN     chmod -R a+rw /home/sftpuser/Loaded
RUN     chmod -R a+rw /home/sftpuser/Failed

# Setup SSHD
ADD     sshd_config /etc/ssh/
# Jessie complains about this:
RUN     mkdir -p /var/run/sshd

# Copy the init script to get the keys in
COPY    set_keys.sh /

# Allow other dockers to view the files in the sftpuser folder
VOLUME  /home/sftpuser

EXPOSE 	22

CMD     /set_keys.sh && /usr/sbin/sshd -D
