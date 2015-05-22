# Pi Backup

## What is this?

A collection of scripts to standardize my backup process for various computers.

## Dependencies

* Cron (linux)
* Cygwin (windows)
* SSH
* rsync

## Setup

### Client

Clone the repo.

Create a `config` file.  See `sample-config` for an example.

Add your ssh-key to the remote server (First, generate keys with ssh-keygen if needed).

	ssh-copy-id -p 22 user@address
	
Make sure your `BACKUP_NAME` directory in the config is created in `/bak` on the backup server.

#### Linux Backup Scheduling

Configure cron.

	# This will run once an hour, ever hour.
	0 */1 * * * /path/to/pi-backup

#### Windows Backup Scheduling

Add your Cygwin bin path to PATH in Windows.

	...;C:\cygwin\bin
	
Configure scheduler.

	# Run cmd.exe as Administrator.
	# This will run once an hour, every hour.
	schtasks /create /tn "backup-agent" /SC Hourly /tr C:\cygwin\path\to\pi-backup\run-invisible.vbs

You may also need to run this in Cygwin.

	# 777 is rather liberal, but whatever.
	chmod 777 run-invisible.vbs

### Server

Try and make SSH a bit more secure.

	# Non-standard port gives us some obscurity
	Port 11111
	PasswordAuthentication no
	PermitRootLogin no
	AllowUsers user1 user2

Create backup directory at `/bak`.  You can make it a bit more secure by making permissions on `/bak` a bit restrictive and then explicitly creating the backup buckets under `/bak`.  This would prevent a misconfigured client from accidentally wiping out other backups.

Use luks disk encryption for the drive where `/bak` is housed.

Don't run an HTTP server or any other potential security risk on this server.  The less that's running, the less that can be compromised.

## Typical Architecture (ideally)

[Site A]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site B]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site A <==> Site B]

Raspberry Pis backup to one another so that backups exist on-site and off-site for each location.

The Pis all mount an encrypted partition on boot to `/bak`.  That is the destination to which clients should backup their data.

It's up to the clients to ensure the data they're sending out in a state that is acceptable.  If you're worried about sending any data over the wire, use something like `encfs` before hand to make sure the files are in a state which which you are comfortable.
