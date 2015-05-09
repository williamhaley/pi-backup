## Windows Client Installation

### Dependencies

* cron (Linux only)
* rsync
* SSH
* git
* make

### Setup

Clone the repo.

Update `backup-agent` to use proper server, username, src, dest.

#### Windows Installation

Install.

	make install-windows

Configure scheduler.

	# Run cmd.exe as Administrator.
	# This will run once an hour, every hour.
	schtasks /create /tn "backup-agent" /SC Hourly /tr C:\cygwin64\usr\local\bin\run-invisible.vbs


#### Linux Installation

Install

	make install-linux

Configure cron.

	# This will run once an hour, ever hour.
	0 */1 * * * /usr/local/bin/backup-agent
