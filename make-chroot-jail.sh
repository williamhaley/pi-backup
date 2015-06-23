#!/bin/bash

JAIL=/var/jail

mkdir -p $JAIL/{dev,etc,lib,lib64,usr,bin}
mkdir -p $JAIL/usr/bin
chown root.root $JAIL

mknod -m 666 $JAIL/dev/null c 1 3

JAIL_BIN=$JAIL/usr/bin/
JAIL_ETC=$JAIL/etc/

cp /etc/ld.so.cache $JAIL_ETC
cp /etc/ld.so.conf $JAIL_ETC
cp /etc/nsswitch.conf $JAIL_ETC
cp /etc/hosts $JAIL_ETC

copy_binary()
{
	BINARY=$(which $1)

	cp $BINARY $JAIL/$BINARY

	./l2chroot $JAIL $BINARY
}

copy_binary ls
copy_binary sh
