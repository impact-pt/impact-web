<?php
require '../../app/common.php';

session_start();

$queryArr = new RegisterUser($_POST);
if ($_POST['request'] == 'register') {
  $queryArr->create();
}
else if ($_POST['request'] == 'log-in') {
  $queryArr->checkUser();
}

else if ($_POST['request'] == 'log-in-phy') {
  $queryArr->checkPhysician();
}
