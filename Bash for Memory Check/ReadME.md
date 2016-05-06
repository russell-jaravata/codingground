First try at Bash Script

Tutorials and Links Used:
https://www.digitalocean.com/community/tutorials/how-to-send-e-mail-alerts-on-a-centos-vps-for-system-monitoring

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Disk Space Alert' mailid@domainname.com << EOF
Your root partition remaining free space is critically low. Used: $CURRENT%
EOF
fi


delete git repository
rm -r .git from the root of the repository.

Install git
http://www.liquidweb.com/kb/how-to-install-git-on-centos-6/

mailx
http://www.computerhope.com/unix/umailx.htm
http://www.binarytides.com/linux-mailx-command/

http://www.tutorialspoint.com/codingground.htm
http://www.tutorialspoint.com/execute_bash_online.php
https://linuxconfig.org/bash-scripting-tutorial

http://superuser.com/questions/306163/what-is-the-you-have-new-mail-message-in-linux-unix
http://www.cyberciti.biz/faq/delete-all-root-email-mailbox/
