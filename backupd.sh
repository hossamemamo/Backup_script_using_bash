#!/bin/bash
: 'This script will automatically 
backup a dir with time-intervals'
#taking the input
sdir=$1
bdir=$2
interval=$3
maxBackups=$4
counter=1;
currentDate=`date +"%Y-%m-%d-%T"`
mkdir $bdir/$currentDate
dest=$bdir/$currentDate
cp -r $sdir $dest
ls -IR $sdir > $bdir/directory-info.last
echo "Backup was done successfully at "$currentDate
while :
do
	sleep $interval
	ls -IR $sdir > $bdir/directory-info.new
	if cmp -s "$bdir/directory-info.last" "$bdir/directory-info.new"
	then
		echo $interval" Seconds have passed...No changes Occured"
		continue
	else
		currentDate=`date +"%Y-%m-%d-%T"`
		mkdir $bdir/$currentDate
		dest=$bdir/$currentDate
		cp -r $sdir $dest
		ls -IR $sdir > $bdir/directory-info.last 
		echo "Backup was done successfully at "$currentDate
	fi
	counter=$((counter+1))
	if [ $counter -gt $maxBackups ]
	then
		rm -r $bdir/"$(ls $bdir -t | tail -1)"
		echo "Number of backups were excceded..the oldest version was removed"
	fi
done
