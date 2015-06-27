# Pi Backup

## What is this?

A collection of scripts to standardize my backup process for various computers.

## Dependencies

* Cron (linux)
* Cygwin (windows)
* SSH
* rsync

## Setup

### Server

Setup user account to handle backups.

	sudo useradd -m -s /bin/bash pi-backup
	sudo su pi-backup
	mkdir .ssh && chmod 700 .ssh
	touch ~/.ssh/authorized_keys && chmod 700 ~/.ssh/authorized_keys

Try and make SSH a bit more secure.

	# Non-standard port gives us some obscurity
	Port 11111
	PasswordAuthentication no
	PermitRootLogin no
	AllowUsers user1 user2 ... pi-backup

Use rssh to allow scp but not an interactive login.

	sudo apt-get install rssh
	sudo usermod -s /usr/bin/rssh pi-backup

	cat << EOF > /etc/rssh.conf
	logfacility = LOG_USER
	allowrsync
	umask = 022
	EOF

Make sure you have all keys copied to the server *before* you deny password authentication.

Create backup directory at `/bak`.  You can make it a bit more secure by making permissions on `/bak` a bit restrictive and then explicitly creating the backup buckets under `/bak`.  This would prevent a misconfigured client from accidentally wiping out other backups.

Use luks disk encryption for the drive where `/bak` is housed.

Don't run an HTTP server or any other potential security risk on this server.  The less that's running, the less that can be compromised.

### Client

Clone the repo.

Install.

	ssh-keygen -f $HOME/.ssh/pi_backup_rsa -t rsa -N ''
	ssh-add $HOME/.ssh/pi_backup_rsa # Required?
	cp sample-config config

Update config file as needed.

Add your ssh-key to the remote server's `authorized_keys` file.
	
Make sure your `BACKUP_NAME` directory in `config` exists in `/bak` on the backup server.

#### Linux Backup Scheduling

Configure cron.

	# This will run once every hour on the hour.
	0 * * * * /path/to/pi-backup

#### Windows Backup Scheduling

Add your Cygwin bin path to PATH in Windows.

	...;C:\cygwin\bin
	
Configure scheduler.

	# This will run once every hour on the hour.
	schtasks /create /tn "pi-backup" /ST 00:00 /SC Hourly /tr "C:\cygwin\bin\bash C:\path\to\pi-backup"

Mark the task as hidden and be sure to also check "Run task whether user is logged in or not".  That is the magic to making sure it runs hidden.

## Typical Architecture (ideally)

[Site A]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site B]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site A <==> Site B]

Raspberry Pis backup to one another so that backups exist on-site and off-site for each location.

The Pis all mount an encrypted partition on boot to `/bak`.  That is the destination to which clients should backup their data.

It's up to the clients to ensure the data they're sending out in a state that is acceptable.  If you're worried about sending any data over the wire, use something like `encfs` before hand to make sure the files are in a state which which you are comfortable.
