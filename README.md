#Shell Script to Backup a Directory

I used simple shell commands toghter with a makefile to run the script
and pass the arguments to backup a dir after it have been modified

##Installation

I installed [make](https://linuxhint.com/install-make-ubuntu/) to run and make a "makefile"

```
$sudo apt install make
```

##Run

```bash
#Reading input from terminal
SDIR ?= $(shell bash -c 'read -p "Source dir: " sdir; echo $$sdir')
INTERVAL ?= $(shell bash -c 'read -p "TimeInterval: " interval; echo $$interval')
MAXBACKUPS ?= $(shell bash -c 'read -p "Maxbackups: " maxback; echo $$maxback')

make #to run the code and create the backup dir if it doesn't exist
make clean #to remove the backup dir (prefer to do this before running)
```

##Code

Reading the parameters

```bash
sdir=$1
bdir=$2
interval=$3
maxBackups=$4
```
Making the first backup
1-get the current time/date
2-make dir for the 1st backup
3-assigning it as the dest to copy the current content to it
4-list the content in a text file to compare it later to find out if it have been modified or not
```bash
currentDate=`date +"%Y-%m-%d-%T"` #gets the current time in the wanted format
mkdir $bdir/$currentDate
dest=$bdir/$currentDate
cp -r $sdir $dest
ls -IR $sdir > $bdir/directory-info.last
echo "Backup was done successfully at "$currentDate
```
looping (runs forever and sleeps every certain interval)
```bash
while :
do
	sleep $interval
```

removing the oldest backup dir
```bash
	counter=$((counter+1))
	if [ $counter -gt $maxBackups ]
	then
		rm -r $bdir/"$(ls $bdir -t | tail -1)"
		echo "Number of backups were excceded..the oldest version was removed"
```
