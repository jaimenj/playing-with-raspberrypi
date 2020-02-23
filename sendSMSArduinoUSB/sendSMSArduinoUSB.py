import serial
import time
import sys

ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=0.5)
ser.flush()
print("Configed for " + ser.name)

print('Sending something to Arduino..')
ser.write(b"Linux>> Hi!\n")
print('Sent! Now waiting..')
time.sleep(1)

print('Reading from USB..')
line = ser.readline().decode('utf-8').rstrip()
print(line)
time.sleep(1)

print('Closing serial USB..')
ser.close()
