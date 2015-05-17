# Pi Sync

## What is this?

I was using BTSync to keep my computer and my various family computers backed up to multiple Raspberry Pis.  This worked well for a while, but I encountered enough small nitpicky issues (sync directories that seemed to get stuck on certain files, read-only destinations keeping files that were deleted on the source, the upgrade to version 2.0 was jarring, conflict folders up the wazoo) that I decided to simplify (complicate) my backup solution.

So I down(up?)graded my setup to use SSH and rsync.  Collected here are scripts and configuration files to try and make this experience consistent across all devices.

If I'm doing this myself, I should at least be consistent to make this system as painless as possible.

## Typical Setup

[Site A]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site B]

Clients backup (rsync + SSH) to a Raspberry Pi on the local network.

[Site A <==> Site B]

Raspberry Pis backup to one another so that backups exist on-site and off-site for each location.

The Pis all mount an encrypted partition on boot to `/bak`.  That is the destination to which clients should backup their data.

It's up to the clients to ensure the data they're sending out in a state that is acceptable.  If you're worried about sending any data over the wire, use something like `encfs` before hand to make sure the files are in a state which which you are comfortable.

## Windows Client Installation

### Dependencies

* cron (Linux only)
* rsync
* SSH

### Setup

Clone the repo.

Update `backup-agent` to use proper server, username, src, dest.

Add your ssh-key to the remote server (First generate with ssh-keygen if needed).

	ssh-copy-id -p 22 user@address

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
	0 */1 * * * /home/will/backup-agent/backup-agent
