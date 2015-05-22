# Pi Backup

## What is this?

A collection of scripts to standardize my backup process for various computers.

## Setup

Clone the repo.

Create a `config` file.  See `sample-config` for an example.

Add your ssh-key to the remote server (First, generate keys with ssh-keygen if needed).

	ssh-copy-id -p 22 user@address
	
Make sure your `DEST` directory in the config is created in `/bak` on the backup server.

#### Windows Installation

Configure scheduler.

	# Run cmd.exe as Administrator.
	# This will run once an hour, every hour.
	schtasks /create /tn "backup-agent" /SC Hourly /tr C:\cygwin\backup-agent\run-invisible.vbs

You may also need to run this in Cygwin.

	# 777 is rather liberal, but whatever.
	chmod 777 run-invisible.vbs

And add your Cygwin bin path to PATH in Windows.

	...;C:\cygwin\bin

#### Linux Installation

Configure cron.

	# This will run once an hour, ever hour.
	0 */1 * * * /path/to/pi-backup

## Typical Setup (ideally)

[Site A]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site B]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site A <==> Site B]

Raspberry Pis backup to one another so that backups exist on-site and off-site for each location.

The Pis all mount an encrypted partition on boot to `/bak`.  That is the destination to which clients should backup their data.

It's up to the clients to ensure the data they're sending out in a state that is acceptable.  If you're worried about sending any data over the wire, use something like `encfs` before hand to make sure the files are in a state which which you are comfortable.
