#!/bin/bash

if [ ! -d "/sys/class/gpio/gpio$2" ]; then echo "$2" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$2/direction" | grep out) ]; then echo out > "/sys/class/gpio/gpio$2/direction"; fi
echo "$1" > "/sys/class/gpio/gpio$2/value"

