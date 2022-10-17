# Using Cronjob to run a backupScript
Using cronjob I succeded to run a bash script to backup a dir every 1 min

## Installation
First, to use cron jobs, you'll need to check the status of the cron service. If cron is not installed, you can easily download it through the package manager. Just use this to check:
```bash
# Check cron service on Linux system
sudo systemctl status cron.service
```

# Adding cronjob
```bash
crontab -e
```
this will open an editable file to add you cronjob
Format should be :

1   2   3   4   5  sh /path/to/script/script.sh sourcedir backupdir maxbackups
|   |   |   |   |              |
|   |   |   |   |      Command or Script to Execute
|   |   |   |   |
|   |   |   |   |
|   |   |   |   |
|   |   |   | Day of the Week(0-6)
|   |   |   |
|   |   | Month of the Year(1-12)
|   |   |
|   | Day of the Month(1-31)
|   |
| Hour(0-23)
Mins(0-59)
# What should be the cron expression if i need to run it every 3rd friday of the month at 12:31 am
it should be 
```bash
*/31 0 15-21 * 5 /home/hossam/Desktop/Lab2/Bonus/backup-cron.sh /home/hossam/Desktop/source /home/hossam/Desktop/cronbackup 2 >> /home/hossam/Desktop/backup1.log 2>&1
```

“At 00:31 on every day-of-month from 15 through 21 and on Friday.”
Note the 3rd friday usually falls in from 15 to 21 day of the month

Note : 
 2>&1 actually mean here is a short explanation:

    2 - refers to a file descriptor used to identify stderr

    1 - refers to a file descriptor used to identify stdout

So 2>&1 basically translates to: Redirect stderrtostdout
# To Run every minute
```bash
*/1 * * * * /home/hossam/Desktop/Lab2/Bonus/backup-cron.sh /home/hossam/Desktop/source /home/hossam/Desktop/cronbackup 2 >> /home/hossam/Desktop/backup1.log 2>&1
```
After this you should Ctrl+O to write and Ctrl+X to exit
then your crontab should have been installed successfully.

# snippet from the log file

```
2022-10-17-15:51:03 : No changes Occured,No need to backup
2022-10-17-15:52:01 : No changes Occured,No need to backup
2022-10-17-15:53:01 : No changes Occured,No need to backup
Backup was done successfully at 2022-10-17-15:54:01
Backup was done successfully at 2022-10-17-15:55:01
Backup was done successfully at 2022-10-17-15:56:01
Number of backups were excceded..the oldest version was removed
2022-10-17-15:57:01 : No changes Occured,No need to backup
2022-10-17-15:58:01 : No changes Occured,No need to backup
2022-10-17-15:59:01 : No changes Occured,No need to backup
2022-10-17-16:00:01 : No changes Occured,No need to backup
2022-10-17-16:01:01 : No changes Occured,No need to backup
2022-10-17-16:02:01 : No changes Occured,No need to backup
```

## Bash script Code

Taking the input

```bash
sdir=$1
bdir=$2
maxBackups=$3
```
Calculating the number of existing backupdirs so that we don't exceed the max backups
```bash
ls -IR $sdir > $bdir/directory-info.new
nodirs=$(expr $(ls $bdir | wc -l) - 2 )
```

removing the oldest backup dir
```bash
	counter=$((counter+1))
	if [ $counter -gt $maxBackups ]
	then
		rm -r $bdir/"$(ls $bdir -t | tail -1)"
		echo "Number of backups were excceded..the oldest version was removed"
```
