<?php
require '../../app/common.php';

session_start();

$queryArr = new RegisterUser($_POST);
$queryArr->create();
