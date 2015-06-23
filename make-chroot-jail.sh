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

	copy_dependencies $BINARY
}

# http://www.cyberciti.biz/files/lighttpd/l2chroot.txt
copy_dependencies()
{
	FILES="$(ldd $1 | awk '{ print $3 }' |egrep -v ^'\(')"

	echo "Copying shared files/libs to $JAIL..."

	for i in $FILES
	do
		d="$(dirname $i)"

		[ ! -d $JAIL$d ] && mkdir -p $JAIL$d || :

		/bin/cp $i $JAIL$d
	done

	sldl="$(ldd $1 | grep 'ld-linux' | awk '{ print $1}')"

	# now get sub-dir
	sldlsubdir="$(dirname $sldl)"

	if [ ! -f $JAIL$sldl ];
	then
		echo "Copying $sldl $JAIL$sldlsubdir..."
		/bin/cp $sldl $JAIL$sldlsubdir
	else
		:
	fi
}

copy_binary ls
copy_binary sh
