#!/bin/bash

[[ $EUID -ne 0 ]] && echo "Must run as root." && exit

[[ -z "$1" ]] && echo "Pass name of backup. (e.g. will_backup_user)" && exit 1

BACKUP_NAME=$1

useradd --no-create-home --home-dir /tmp -s /bin/bash -G backupusers $BACKUP_NAME

wget https://raw.githubusercontent.com/williamhaley/configs/master/create-jail.sh -P /tmp/

PATH_TO_JAIL=/mnt/storage1/backup-jail/$BACKUP_NAME

bash /tmp/create-jail.sh $PATH_TO_JAIL
chmod 775 $PATH_TO_JAIL/mnt
chown $BACKUP_NAME:$BACKUP_NAME $PATH_TO_JAIL/mnt

ssh-keygen -f $PATH_TO_JAIL/etc/$BACKUP_NAME-SSH -t rsa -N ''

echo "Key for $BACKUP_NAME. Added here at $(date)." >> /etc/ssh/authorized_keys
cat $PATH_TO_JAIL/etc/$BACKUP_NAME-SSH.pub >> /etc/ssh/authorized_keys
echo "" >> /etc/ssh/authorized_keys

