<?php

// OPENING
if(!file_exists('/sys/class/gpio/gpio12')) {
	echo 'Pin file not created, creating.. ';
	
	$stream = fopen('/sys/class/gpio/export', 'w');
	$bytesWritten = fwrite($stream, '12');
	fclose($stream);
	sleep(1);
	
	echo 'ok!'.PHP_EOL;
}

// SETTING UP INPUT DIRECTION
if('in' != str_replace(PHP_EOL, '', file('/sys/class/gpio/gpio12/direction')[0])) {
	echo 'Setting up direction to IN.. ';
	
	$stream = fopen('/sys/class/gpio/gpio12/direction', 'w');
	$bytesWritten = fwrite($stream, 'in');
	fclose($stream);
	
	echo 'ok!'.PHP_EOL;
}

// CHECKING MAX FREQUENCY OF READING
echo 'Checking max frequency.. ';
$stream = fopen('/sys/class/gpio/gpio12/value', 'r');
$startTime = microtime(true); 
for($i = 1; $i <= 1000000; $i++) {
	echo stream_get_contents($stream)[0];
	fseek($stream, 0);
}
$endTime = microtime(true); 
$executionTime = ($endTime - $startTime); 
fclose($stream);
echo 'ok!'.PHP_EOL;
echo $executionTime.' secs'.PHP_EOL;
echo (1000000/$executionTime).' Hzs'.PHP_EOL;

if(file_exists('/sys/class/gpio/gpio12')) {
	echo 'Pin file created, and used. Removing.. ';
	
	$stream = fopen('/sys/class/gpio/unexport', 'w');
	$bytesWritten = fwrite($stream, '12');
	fclose($stream);
	sleep(1);
	
	echo 'ok!'.PHP_EOL;
}

