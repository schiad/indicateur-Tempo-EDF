#/bin/bash

sudo python3 ./tempo.py $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="1 days").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="0 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-1 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-2 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-3 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-4 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-5 day").txt | cut -d'_' -f2) $(cat /home/pi/sh/tempo/results/$(date +%Y-%m-%d --date="-6 day").txt | cut -d'_' -f2)

