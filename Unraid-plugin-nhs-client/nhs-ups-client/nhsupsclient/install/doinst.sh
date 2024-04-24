#!/bin/sh
RC_SCRIPT="/etc/rc.d/rc.nhsupsclient"
SD_RCFILE="/etc/rc.d/rc.local_shutdown"

# Update file permissions of scripts
chmod +0755 /usr/sbin/nhsupsclient \
 $RC_SCRIPT

###Stop Scripts###

# Add stop script to rc.local_shutdown script	
if ! grep "$RC_SCRIPT" $SD_RCFILE >/dev/null 2>&1
	then echo -e "\n[ -x $RC_SCRIPT ] && $RC_SCRIPT stop" >> $SD_RCFILE
fi
[ ! -x $SD_RCFILE ] && chmod u+x $SD_RCFILE