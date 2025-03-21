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

# Make the init script executable
chmod 755 etc/rc.d/rc.nhsupsclient

# Create symlink for automatic startup
( cd etc/rc.d/rc0.d ; rm -rf K00nhsupsclient )
( cd etc/rc.d/rc0.d ; ln -sf ../rc.nhsupsclient K00nhsupsclient )
( cd etc/rc.d/rc6.d ; rm -rf K00nhsupsclient )
( cd etc/rc.d/rc6.d ; ln -sf ../rc.nhsupsclient K00nhsupsclient )
( cd etc/rc.d/rcS.d ; rm -rf S99nhsupsclient )
( cd etc/rc.d/rcS.d ; ln -sf ../rc.nhsupsclient S99nhsupsclient )

# Start the service immediately after installation
/etc/rc.d/rc.nhsupsclient start