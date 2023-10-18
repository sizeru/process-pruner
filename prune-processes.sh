#!/bin/bash
# Constants
USAGE=$'Usage: prune-processes [num] [flag]\n\tKill all processes that have been running for more than [num] seconds\nFLAGS:\n\t-q QUIET. Kill processes silently\n\t-v VERBOSE. Print information about the processes that will be killed\n\t-t TEST RUN. Print information about processes to be killed, but do not actually kill the processes'
NEW_PROCESS_ELAPSED_TIME=4123168608 # A brand new process will sometimes have this be its elapsed time. I'm not sure why. Doesn't look like overflow exactly. Could be a bug in ps.
TIME=0
PID=1
USER=2
CMD=3

#Globals
VERBOSE=0
TEST_RUN=0
readarray -t USER_WHITELIST < /etc/prune-processes/user-whitelist.txt
readarray -t CMD_BLACKLIST < /etc/prune-processes/cmd-blacklist.txt

#Assert correct number of arguments
if [[ $# -lt 2 ]]; then
	echo "$USAGE"
	exit
fi

# Check for non-integer/null arguments in number
NUMBER="${@: -2:1}"
case $NUMBER in 
	''|*[!0-9]*)
		echo "$USAGE"
		exit
		;;
esac

# Check and set flags
FLAG="${@: -1}"
case $FLAG in
	"-v")
		VERBOSE=1
		;;
	"-t")
		TEST_RUN=1
		;;
	"-q")
		;;
	*)
		echo "$USAGE"
		exit
		;;
esac

# Query info about all processes. Kill those where:
# 	1. The command contains an expression on the blacklist
# 	2. The command is not run by a user on the whitelist
# 	3. The command has been running for longer than the time specified
ps -eo etimes=,pid=,user=,cmd= | while read process; do
	USER_OKAY=1
	CMD_OKAY=0
	read -r -a pinfo <<< "$process"
	for user in "${USER_WHITELIST[@]}"; do
		if [[ "$user" == "${pinfo[USER]}" ]]; then
			USER_OKAY=0
			break
		fi
	done
	for cmd in "${CMD_BLACKLIST[@]}"; do
		if [[ "${pinfo[CMD]}" =~ $cmd ]]; then
			CMD_OKAY=1
			break
		fi
	done
	if [[ $USER_OKAY == 1 && $CMD_OKAY == 1 && "${pinfo[$TIME]}" -gt "$NUMBER" && "${pinfo[$TIME]}" -lt "$NEW_PROCESS_ELAPSED_TIME" ]]; then
		if [[ $TEST_RUN == 1 ]]; then 
			echo "Test run - Process found, but no action will be taken:"
			echo "Time: ${pinfo[$TIME]} PID:  ${pinfo[$PID]} USER: ${pinfo[$USER]} CMD: ${pinfo[$CMD]}"
		else
			if [[ $VERBOSE == 1 ]]; then
				echo "Time: ${pinfo[$TIME]} PID:  ${pinfo[$PID]} USER: ${pinfo[$USER]} CMD: ${pinfo[$CMD]}"
			fi
			kill "${pinfo[$PID]}"
		fi
	fi 
done

