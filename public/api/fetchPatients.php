<?php
require '../../app/common.php';

$queryArr = new FetchPatients($_POST);
$queryArr->fetchPatients();
