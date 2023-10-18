TEMPDIR='prune-processes-install-temp-dir'

# Download contents for script into tmp dir
echo "Creating tempdir"
mkdir $TEMPDIR
cd $TEMPDIR

echo "Downloading contents"
curl -L http://github.com/sizeru/process-prunr/archive/main.tar.gz | tar zxf -

echo "Moving script to bin and setting permissions"
mv prune-processes.sh /usr/bin/prune-processes
chown root:root /usr/bin/prune-processes
chmod 666 /usr/bin/prune-processes

echo "Moving config files into place"
mkdir /etc/prune-processes
mv default-user-whitelist.txt /etc/prune-processes/user-whitelist.txt
mv default-cmd-blacklist.txt /etc/prune-processes/cmd-blacklist.txt

echo "Removing tempdir"
cd ..
rm -r $TEMPDIR

echo "Completed install"
