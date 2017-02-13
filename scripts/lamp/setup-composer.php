<?php

$expectedSignature = trim(file_get_contents('https://composer.github.io/installer.sig'));
copy('https://getcomposer.org/installer', 'composer-setup.php');
$signature = hash_file('SHA384', 'composer-setup.php');

if($expectedSignature != $signature) {
  echo "ERROR: Invalid installer signature\r\n";
  exit(1);
}

include 'composer-setup.php';
exit(0);
