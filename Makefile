nginx=/usr/sbin/nginx
wd=/home/azer/www/nginx
stats_hostname=stats.kodfabrik.com
hostname="nonexisting"

all:
	@echo "Available Commands: start, stop, reload, new, rm, new-webalizer, update-stats"

reload:
	sudo kill -HUP `cat $(wd)/pid`

start:
	sudo $(nginx) -c $(wd)/sites.conf

stop:
	sudo kill -QUIT `cat $(wd)/pid`

new:
	./new.sh $(hostname) $(git)

rm:
	rm -rf sites/$(hostname)
	rm enabled/$(hostname).conf
	
new-webalizer:
	mkdir sites/$(stats_hostname)/public/$(hostname)

	sed "s/HOSTNAME/$(hostname)/g" draft/webalizer.conf > sites/$(hostname)/webalizer.conf

	echo "$(hostname)" >> $(stats_hostname)/hostnames

update-stats:
	cd sites/$(stats_hostname); \
	./refresh
