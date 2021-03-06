#!/bin/bash

[[ $EUID -ne 0 ]] && echo "Must run as root." && exit

BACKUP_NAME=$1

[[ ! "$BACKUP_NAME" =~ ^[a-z0-9_]+$ ]] && echo "Pass name of valid backup. ([a-z0-9_] e.g. will_backup_01)" && exit 1

read -r -p "Are you sure? All data will be deleted. [Type YES to proceed] " response
[[ "$response" != "YES" ]] && exit 1

userdel $BACKUP_NAME

PATH_TO_JAIL=/jails/$BACKUP_NAME

rm -r $PATH_TO_JAIL

echo "Manually remove the key from /etc/ssh/authorized_keys"

