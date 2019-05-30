<?php
require '../../app/common.php';

$queryArr = new FetchPatients($_POST);
$queryResp = $queryArr->fetchPatients();
$json = json_encode($queryResp, JSON_PRETTY_PRINT);
header('Content-Type: application/json');
echo $json;
