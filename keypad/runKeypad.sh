#!/bin/bash

ROW1=27
ROW2=22
ROW3=10
ROW4=9
COL1=23
COL2=24
COL3=25
COL4=5

# Config input pins
if [ ! -d "/sys/class/gpio/gpio$ROW1" ]; then echo "$ROW1" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$ROW1/direction" | grep in) ]; then echo in > "/sys/class/gpio/gpio$ROW1/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$ROW2" ]; then echo "$ROW2" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$ROW2/direction" | grep in) ]; then echo in > "/sys/class/gpio/gpio$ROW2/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$ROW3" ]; then echo "$ROW3" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$ROW3/direction" | grep in) ]; then echo in > "/sys/class/gpio/gpio$ROW3/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$ROW4" ]; then echo "$ROW4" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$ROW4/direction" | grep in) ]; then echo in > "/sys/class/gpio/gpio$ROW4/direction"; fi
echo "Input PINs configured.."

# Config output pins
if [ ! -d "/sys/class/gpio/gpio$COL1" ]; then echo "$COL1" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$COL1/direction" | grep out) ]; then echo out > "/sys/class/gpio/gpio$COL1/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$COL2" ]; then echo "$COL2" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$COL2/direction" | grep out) ]; then echo out > "/sys/class/gpio/gpio$COL2/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$COL3" ]; then echo "$COL3" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$COL3/direction" | grep out) ]; then echo out > "/sys/class/gpio/gpio$COL3/direction"; fi
if [ ! -d "/sys/class/gpio/gpio$COL4" ]; then echo "$COL4" > /sys/class/gpio/export; sleep 1; fi
if [ ! $(cat "/sys/class/gpio/gpio$COL4/direction" | grep out) ]; then echo out > "/sys/class/gpio/gpio$COL4/direction"; fi
echo "Output PINs configured.."

echo "0" > "/sys/class/gpio/gpio$COL1/value"
echo "0" > "/sys/class/gpio/gpio$COL2/value"
echo "0" > "/sys/class/gpio/gpio$COL3/value"
echo "0" > "/sys/class/gpio/gpio$COL4/value"

SLEEPTIME=0.2
while true
do
    echo "1" > "/sys/class/gpio/gpio$COL1/value"; sleep $SLEEPTIME
    if [ $(cat "/sys/class/gpio/gpio$ROW1/value" | grep 1) ]; then
        # This is button 1
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW2/value" | grep 1) ]; then
        # This is button 4
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW3/value" | grep 1) ]; then
        # This is button 7
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW4/value" | grep 1) ]; then
        # This is button *
    fi
    echo "0" > "/sys/class/gpio/gpio$COL1/value"; sleep $SLEEPTIME
    echo "1" > "/sys/class/gpio/gpio$COL2/value"; sleep $SLEEPTIME
    if [ $(cat "/sys/class/gpio/gpio$ROW1/value" | grep 1) ]; then
        # This is button 2
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW2/value" | grep 1) ]; then
        # This is button 5
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW3/value" | grep 1) ]; then
        # This is button 8
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW4/value" | grep 1) ]; then
        # This is button 0
    fi
    echo "0" > "/sys/class/gpio/gpio$COL2/value"; sleep $SLEEPTIME
    echo "1" > "/sys/class/gpio/gpio$COL3/value"; sleep $SLEEPTIME
    if [ $(cat "/sys/class/gpio/gpio$ROW1/value" | grep 1) ]; then
        # This is button 3
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW2/value" | grep 1) ]; then
        # This is button 6
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW3/value" | grep 1) ]; then
        # This is button 9
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW4/value" | grep 1) ]; then
        # This is button #
    fi
    echo "0" > "/sys/class/gpio/gpio$COL3/value"; sleep $SLEEPTIME
    echo "1" > "/sys/class/gpio/gpio$COL4/value"; sleep $SLEEPTIME
    if [ $(cat "/sys/class/gpio/gpio$ROW1/value" | grep 1) ]; then
        # Button A
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW2/value" | grep 1) ]; then echo "Button B";
        # Button B
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW3/value" | grep 1) ]; then
        # Button C
    fi
    if [ $(cat "/sys/class/gpio/gpio$ROW4/value" | grep 1) ]; then
        # Button D
    fi
    echo "0" > "/sys/class/gpio/gpio$COL4/value"; sleep $SLEEPTIME
done

echo "0" > "/sys/class/gpio/gpio$COL1/value"
echo "0" > "/sys/class/gpio/gpio$COL2/value"
echo "0" > "/sys/class/gpio/gpio$COL3/value"
echo "0" > "/sys/class/gpio/gpio$COL4/value"
