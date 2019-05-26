<?php
require '../../app/common.php';

session_start();

$queryArr = new RegisterUser($_POST);
if ($_POST['request'] == 'register') {
  $queryArr->create();
}
else {
  $queryArr->check();
}
