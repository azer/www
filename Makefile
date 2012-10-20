nginx=/usr/sbin/nginx
wd=/home/azer/www/nginx
stats_hostname=stats.kodfabrik.com

reload:
	sudo kill -HUP `cat $(wd)/pid`

start:
	sudo $(nginx) -c $(wd)/sites.conf

stop:
	sudo kill -QUIT `cat $(wd)/pid`

new:
	mkdir enabled -p
	mkdir sites/$(hostname) -p

	mkdir sites/$(hostname)/logs
	mkdir sites/$(hostname)/public

	sed "s/HOSTNAME/$(hostname)/g" draft/nginx.conf > sites/$(hostname)/nginx.conf
	sed "s/HOSTNAME/$(hostname)/g" draft/index.html > sites/$(hostname)/public/index.html

	ln sites/$(hostname)/nginx.conf enabled/$(hostname).conf
	
new-webalizer:
	mkdir sites/$(stats_hostname)/public/$(hostname)

	sed "s/HOSTNAME/$(hostname)/g" draft/webalizer.conf > sites/$(hostname)/webalizer.conf

	echo "$(hostname)" >> $(stats_hostname)/hostnames

update-stats:
	cd sites/$(stats_hostname); \
	./refresh
