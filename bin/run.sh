#!/usr/bin/env php
<?php

chdir('/var/www/html');
$args = implode(' ', array_map('escapeshellarg', array_slice($argv, 1)));
$cmd = 'su -c "' . $args . '" -s /bin/sh www-data';

$stdout = fopen('php://stdout', 'w');
passthru($cmd, $stdout);