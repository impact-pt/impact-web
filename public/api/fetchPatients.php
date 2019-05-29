<?php
require '../../app/common.php';

$queryArr = new FetchPatients($_POST);
$queryArr->fetchPatients();
$json = json_encode($queryArr, JSON_PRETTY_PRINT);
header('Content-Type: application/json');
echo $json;
