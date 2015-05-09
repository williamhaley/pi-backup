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
