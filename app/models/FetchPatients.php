<?php

class FetchPatients{

  public $username;
  public $firstName;
  public $lastName;
  public $email;
  public $phone;

  public function __construct($data){
    $this->username = isset($data['username']) ? $data['username'] : null;
    $this->firstName = isset($data['firstName']) ? $data['firstName'] : null;
    $this->lastName = isset($data['lastName']) ? $data['lastName'] : null;
    $this->email = isset($data['email']) ? $data['email'] : null;
    $this->phone = isset($data['phone']) ? $data['phone'] : null;
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
