#!/bin/bash
#taking the input
sdir=$1
bdir=$2
maxBackups=$3
ls -IR $sdir > $bdir/directory-info.new
nodirs=$(expr $(ls $bdir | wc -l) - 2 )
if cmp -s "$bdir/directory-info.last" "$bdir/directory-info.new"
then
	currentDate=`date +"%Y-%m-%d-%T"`
	echo $currentDate" : No changes Occured,No need to backup"
else
	currentDate=`date +"%Y-%m-%d-%T"`
	mkdir $bdir/$currentDate
	dest=$bdir/$currentDate
	cp -r $sdir $dest
	ls -IR $sdir > $bdir/directory-info.last 
	echo "Backup was done successfully at "$currentDate
	nodirs=$(expr $nodirs + 1 )
	if [ $nodirs -gt $maxBackups ]
	then
		rm -r $bdir/"$(ls $bdir -t | tail -1)"
		echo "Number of backups were excceded..the oldest version was removed"
	fi
fi
