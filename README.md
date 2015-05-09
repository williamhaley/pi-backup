## Windows Client Installation

### Dependencies

* cron (Linux only)
* rsync
* SSH

### Setup

Clone the repo.

Update `backup-agent` to use proper server, username, src, dest.

#### Windows Installation

Configure scheduler.

	# Run cmd.exe as Administrator.
	# This will run once an hour, every hour.
	schtasks /create /tn "backup-agent" /SC Hourly /tr C:\cygwin64\backup-agent\run-invisible.vbs

#### Linux Installation

Configure cron.

	# This will run once an hour, ever hour.
	0 */1 * * * /home/will/backup-agent/backup-agent
