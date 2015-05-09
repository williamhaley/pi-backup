#!/bin/bash

USER=will

#USERID=`id -u ${USER} 2>/dev/null`                                              
#GROUPID=`id -g ${USER} 2>/dev/null`                              
                                                          
#if [ ${USERID}"X" != "X" -a ${GROUPID}"X" != "X" ] ; then                       
#	echo "Run as user $USER"                                                    
#else                                                                            
#	echo "invalid user"                                                         
#	exit 1                                                                      
#fi

#line="* * * * * exec env UID=${USERID} GID=${GROUPID} /path/to/command"
line="* * * * * /usr/local/bin/backup-agent"

crontab -u $USER -l | grep -q -F "$line" || (crontab -u $USER -l; echo "$line" ) | crontab -u $USER -
