# Usage
This docker is a simple SFTP server with 4 upload folders and linkable folders. Main goal is to provide a server for the upload of large files. It does not allow the use of username and passwords, only SSH key pairs. Keys must be provided as environment variables.

The intent of this docker is not 'internet facing' deployments.

Example:

	docker run -d --name sftp -v $PWD/upload:/home/sftpuser -e PUB_KEY1="slkfowi...ldjlsf" -p 2200:22 placr/sftp
	
will run the sftp server with a volume share in ~/sftpuser, using the provided public key and is reachable on port 2200 on the host machine.

Users or processes can connect using their private key:

	sftp -P 2200 sftpuser@host
	

The other environment variables are:

	PUB_KEY1
	PUB_KEY2
	PUB_KEY3
	PUB_KEY4
	
The provided folders are intended to be used in the following manner:

	Transmit: This can be used to transmit a file non-atomically
	ToLoad: Move it to 'ToLoad' when done
	Loaded: Another process may take the files in the 'ToLoad' folder and move them to 'Loaded' when done.
	Failed: The process may also move the files to 'Failed' in case of failure.
	
