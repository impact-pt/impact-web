<?php

class FetchPatients{

  public $username;

  public function __construct($data){
    $this->username = isset($data['username']) ? $data['username'] : null;
  }

  public function fetchPatients() {
    $db= new PDO(DB_SERVER,DB_USER,DB_PW);
    // $sql = 'SELECT * FROM RegisteredUser';
    $sql = 'SELECT ru.username AS username, ru.firstName AS firstName, ru.lastName as lastName, ru.email as email, ru.phone AS phone FROM Physician phy, RegisteredUser ru, AssignedPhysician ap WHERE ap.userID = ru.userID AND ap.assignedPhysicianID = phy.physicianID AND phy.username = ?';
    $statement = $db->prepare($sql);
    $success = $statement->execute($this->username);
    $arr=[];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      // $username->$row['username'];
      // $firstname->$row['firstName'];
      // $temp
      array_push($arr, $row);
    }
    return $arr;
  }
}
