echo "Moving script to bin and setting permissions"
mv prune-processes.sh /usr/bin/prune-processes
chown root:root /usr/bin/prune-processes
chmod 666 /usr/bin/prune-processes

echo "Moving config files into place"
mkdir /etc/prune-processes
mv default-user-whitelist.txt /etc/prune-processes/user-whitelist.txt
mv default-cmd-blacklist.txt /etc/prune-processes/cmd-blacklist.txt
chown -R root:root /etc/prune-processes
chmod -R 666 root:root /etc/prune-processes

echo "Completed install. This directory can now be deleted"
