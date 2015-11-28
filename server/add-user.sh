#!/bin/bash

[[ $EUID -ne 0 ]] && echo "Must run as root." && exit

BACKUP_NAME=$1

[[ ! "$BACKUP_NAME" =~ ^[a-z0-9_]+$ ]] && echo "Pass name of valid backup. ([a-z0-9_] e.g. will_backup_01)" && exit 1

useradd --no-create-home --home-dir /tmp -s /bin/bash -G backupusers $BACKUP_NAME

PATH_TO_JAIL=/jails/$BACKUP_NAME

WORKING_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

bash $WORKING_DIR/create-jail.sh $PATH_TO_JAIL
chmod 775 $PATH_TO_JAIL/mnt
chown $BACKUP_NAME:$BACKUP_NAME $PATH_TO_JAIL/mnt
chown $BACKUP_NAME:$BACKUP_NAME $PATH_TO_JAIL/tmp

ssh-keygen -f $PATH_TO_JAIL/etc/$BACKUP_NAME-SSH -t rsa -N ''

echo "# Key for $BACKUP_NAME. Added here at $(date)." >> /etc/ssh/authorized_keys
cat $PATH_TO_JAIL/etc/$BACKUP_NAME-SSH.pub >> /etc/ssh/authorized_keys
echo -e "\n" >> /etc/ssh/authorized_keys

