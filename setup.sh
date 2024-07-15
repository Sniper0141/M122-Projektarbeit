#!/bin/bash

# write out current crontab
crontab -l > .temp
# echo new cron into cron file
echo "@reboot sh startup.sh" >> .temp
# install new cron file
crontab .temp
rm .temp

# give rights to startup program
chmod +x startup.sh

echo The program now will start listening on reboot.