nginx=/usr/sbin/nginx
wd=/home/azer/www/nginx
stats_site=stats.kodfabrik.com
site="nonexisting"

all:
	@echo "Available Commands: start, stop, reload, new, rm, new-webalizer, update-stats"

reload:
	sudo kill -HUP `cat $(wd)/pid`

start:
	sudo $(nginx) -c $(wd)/sites.conf

stop:
	sudo kill -QUIT `cat $(wd)/pid`

new:
	./new.sh $(site) $(git)

rm:
	rm -rf sites/$(site)
	rm enabled/$(site).conf
	
up:
	cd sites/$(site)/git && make up
	
down:
	cd sites/$(site)/git && make down;

new-webalizer:
	mkdir sites/$(stats_site)/public/$(site)

	sed "s/site/$(site)/g" draft/webalizer.conf > sites/$(site)/webalizer.conf

	echo "$(site)" >> $(stats_site)/sites

update-stats:
	cd sites/$(stats_site); \
	./refresh
