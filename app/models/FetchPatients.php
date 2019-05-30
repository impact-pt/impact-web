<?php

class FetchPatients{

  public $username;

  public function __construct($data){
    $this->username = isset($data['username']) ? $data['username'] : null;
  }

  public static function fetchPatients() {
    global $username;
    $db= new PDO(DB_SERVER,DB_USER,DB_PW);
    // $sql = 'SELECT * FROM RegisteredUser';
    $sql = 'SELECT ru.username, ru.firstName, ru.lastName, ru.email, ru.phone FROM Physician phy, RegisteredUser ru, AssignedPhysician ap WHERE ap.userID = ru.userID AND ap.assignedPhysicianID = phy.physicianID AND phy.username = ?';
    $statement = $db->prepare($sql);
    $statement->bindParam("s", $this->username);
    $success = $statement->execute();
    $arr=[];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $temp =  new FetchPatients($row);
      array_push($arr, $temp);
    }
    return $arr;
  }
}
