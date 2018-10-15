#!/bin/sh

if [ "$1" -eq "" ]; then
	cpu=1
else
	cpu=$1
fi

echo "Loading $cpu CPUs..."
perl -e 'while (--$ARGV[0] and fork) {}; while () {}' $cpu

