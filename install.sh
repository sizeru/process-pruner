echo "Moving script to bin and setting permissions"
cp prune-processes.sh /usr/bin/prune-processes
chown root:root /usr/bin/prune-processes
chmod 774 /usr/bin/prune-processes

echo "Moving config files into place"
mkdir /etc/prune-processes
cp default-user-whitelist.txt /etc/prune-processes/user-whitelist.txt
cp default-cmd-blacklist.txt /etc/prune-processes/cmd-blacklist.txt
chown -R root:root /etc/prune-processes
chmod -R 774 /etc/prune-processes

echo "Completed install. This directory can now be deleted"
