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

Kill all processes that have been running for more than [num] seconds.

In order for a process to be killed. It must be one of the blacklisted commands and cannot have been
ran by one of the whitelisted users.

FLAGS:

- -q QUIET. Kill processes silently
- -v VERBOSE. Print information about the processes that will be killed
- -t TEST RUN. Print information about processes to be killed, but do not actually kill the processes

CONFIG:
- Whitelisted Users: /etc/prune-processes/user-whitelist.txt
- Blacklisted Commands: /etc/prune-processes/cmd-blacklist.txt

## EXAMPLE:
```
# Usage inside of a crontab. Every 15 minutes, kill processes that have been running for 15+ minutes.
*/15 * * * * prune-processes 900 -q
```
