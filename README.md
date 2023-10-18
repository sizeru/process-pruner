# process-pruner
A bash script that prunes long running processes. Can be used in cronjobs.

Usage: prune-processes [num] [flag]
	
  Kill all processes that have been running for more than [num] seconds

FLAGS:

  -v VERBOSE. Print information about the processes that will be killed
  -t TEST RUN. Print information about processes to be killed, but do not actually kill the processes
