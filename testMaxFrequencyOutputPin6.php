<?php

// OPENING
if(!file_exists('/sys/class/gpio/gpio6')) {
	echo 'Pin file not created, creating.. ';
	
	$stream = fopen('/sys/class/gpio/export', 'w');
	$bytesWritten = fwrite($stream, '6');
	fclose($stream);
	sleep(1);
	
	echo 'ok!'.PHP_EOL;
}

// SETTING UP OUTPUT DIRECTION
if('out' != str_replace(PHP_EOL, '', file('/sys/class/gpio/gpio6/direction')[0])) {
	echo 'Setting up direction to OUT.. ';
	
	$stream = fopen('/sys/class/gpio/gpio6/direction', 'w');
	$bytesWritten = fwrite($stream, 'out');
	fclose($stream);
	
	echo 'ok!'.PHP_EOL;
}

// CHECKING MAX FREQUENCY OF PWM SIGNAL OUTPUT
echo 'Checking max frequency.. ';
$stream = fopen('/sys/class/gpio/gpio6/value', 'w');
$startTime = microtime(true); 
for($i = 1; $i <= 1000000; $i++) {
	$bytesWritten = fwrite($stream, '1');
	$bytesWritten = fwrite($stream, '0');
}
$endTime = microtime(true); 
$executionTime = ($endTime - $startTime); 
fclose($stream);
echo 'ok!'.PHP_EOL;
echo $executionTime.' secs'.PHP_EOL;
echo (1000000/$executionTime).' Hzs'.PHP_EOL;

if(file_exists('/sys/class/gpio/gpio6')) {
	echo 'Pin file created, and used. Removing.. ';
	
	$stream = fopen('/sys/class/gpio/unexport', 'w');
	$bytesWritten = fwrite($stream, '6');
	fclose($stream);
	sleep(1);
	
	echo 'ok!'.PHP_EOL;
}

