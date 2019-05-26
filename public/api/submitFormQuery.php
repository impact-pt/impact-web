<?php
require '../../app/common.php';

$queryArr = new FormQueries($_POST);
$queryArr->create();
