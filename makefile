SDIR ?= $(shell bash -c 'read -p "Source dir: " sdir; echo $$sdir')
INTERVAL ?= $(shell bash -c 'read -p "TimeInterval: " interval; echo $$interval')
MAXBACKUPS ?= $(shell bash -c 'read -p "Maxbackups: " maxback; echo $$maxback')
run:
	mkdir -p ~/Desktop/backup
	./backupd.sh $(SDIR) ~/Desktop/backup $(INTERVAL) $(MAXBACKUPS)
clean:
	rm -r ~/Desktop/backup
