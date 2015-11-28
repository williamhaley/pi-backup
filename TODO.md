Make sure we only allow alphanumeric for backup names. Regex test in scripts.

Document creation of the backup-jail dir.

Make sure you install rsync (of course)

mkdir /jails
/jails/%u #sshd_config
/mnt/storage1/backup-jails                       /jails          none    bind,nofail

