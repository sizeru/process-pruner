# process-pruner
A bash script that prunes long running processes. Can be used in cronjobs.

## Installation
```
git clone https://github.com/sizeru/process-pruner
cd process-pruner
sudo ./install.sh
```

## Usage: 
prune-processes [num] [flag]

Kill all processes that have been running for more than [num] seconds

FLAGS:

- -q QUIET. Kill processes silently
- -v VERBOSE. Print information about the processes that will be killed
- -t TEST RUN. Print information about processes to be killed, but do not actually kill the processes

CONFIG:
- Whitelisted Users: /etc/prune-processes/user-whitelist.txt
- Blacklisted Commands: /etc/prune-processes/cmd-blacklist.txt
