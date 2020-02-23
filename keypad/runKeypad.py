import RPi.GPIO as GPIO
import serial
import time
import sys
import os
import psutil
import subprocess
from gtts import gTTS


# It closes the app if it's already running..
if len(os.popen("pgrep -f runKeypad.py").readlines()) > 3:
    print "I'm already running, exiting.."
    exit(0)


# Configure Keypad..
ROWS = [27, 22, 10, 9]
COLS = [23, 24, 25, 5]
GPIO.setmode(GPIO.BCM)
# GPIO.setmode(GPIO.BOARD)
# GPIO.setwarnings(False)
for i in range(0, 4):
    GPIO.setup(ROWS[i], GPIO.OUT)
    GPIO.output(ROWS[i], GPIO.LOW)
    GPIO.setup(COLS[i], GPIO.IN, pull_up_down=GPIO.PUD_DOWN)


# The pins connected to the relays..
OCTOPINS = [12, 16, 20, 21, 6, 13, 19, 26]
for pin in OCTOPINS:
    GPIO.setup(pin, GPIO.OUT)
    # GPIO.output(pin, GPIO.HIGH)


# Configure serial comunication with Arduino..
ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=0.5)
print("Configed for " + ser.name)


# It's just a text to speech function..
def saySomething(somethingToSay):
    myobj = gTTS(text=somethingToSay,
                 lang="es", slow=False)
    myobj.save("piTalking.mp3")
    os.system("mpg321 piTalking.mp3")


# Toggle pin output..
def togglePin(thePin):
    if GPIO.input(thePin) == GPIO.HIGH:
        GPIO.output(thePin, GPIO.LOW)
    else:
        GPIO.output(thePin, GPIO.HIGH)


# Just for launching actions when buttons are pressed..
def generateAction(currentRow, currentCol):
    if currentRow == 0 and currentCol == 0:  # button 1
        print 'Button 1!'
    elif currentRow == 0 and currentCol == 1:  # button 2
        print 'Button 2!'
    elif currentRow == 0 and currentCol == 2:  # button 3
        print 'Button 3!'
    elif currentRow == 0 and currentCol == 3:  # button A
        print 'Button A!'
    elif currentRow == 1 and currentCol == 0:  # button 4
        print 'Button 4!'
    elif currentRow == 1 and currentCol == 1:  # button 5
        print 'Button 5!'
    elif currentRow == 1 and currentCol == 2:  # button 6
        print 'Button 6!'
    elif currentRow == 1 and currentCol == 3:  # button B
        print 'Button B!'
    elif currentRow == 2 and currentCol == 0:  # button 7
        print 'Button 7!'
    elif currentRow == 2 and currentCol == 1:  # button 8
        print 'Button 8!'
    elif currentRow == 2 and currentCol == 2:  # button 9
        print 'Button 9!'
    elif currentRow == 2 and currentCol == 3:  # button C
        print 'Button C!'
    elif currentRow == 3 and currentCol == 0:  # button *
        print 'Button *!'
    elif currentRow == 3 and currentCol == 1:  # button 0
        print 'Button 0!'
    elif currentRow == 3 and currentCol == 2:  # button #
        print 'Button #!'
    elif currentRow == 3 and currentCol == 3:  # button D
        print 'Button D!'


# The main loop that checks for buttons pressed..
try:
    while True:
        for currentRow in range(0, 4):
            GPIO.output(ROWS[currentRow], GPIO.HIGH)
            time.sleep(0.02)
            for currentCol in range(0, 4):
                if GPIO.input(COLS[currentCol]) == GPIO.HIGH:
                    ser.write('Ardu>> runLights\n')
                    generateAction(currentRow, currentCol)
                    sys.stdout.write(ser.readline())
                    time.sleep(1)
            GPIO.output(ROWS[currentRow], GPIO.LOW)
            time.sleep(0.02)
except:
    print 'GOT AN ERROR!'
finally:
    print 'FINALLY GOT AN ERROR!'

# GPIO.cleanup()
