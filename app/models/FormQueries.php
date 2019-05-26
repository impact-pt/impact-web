<?php

class FormQueries{

  public $queryID;
  public $firstName;
  public $lastName;
  public $queryType;
  public $email;
  public $queryMessage;

  public function __construct($data){
    $this->queryID= isset($data['queryID']) ? intval($data['queryID']) : null;
    $this->firstName = $data['firstName'];
    $this->lastName = $data['lastName'];
    $this->queryType = $data['queryType'];
    $this->email = $data['email'];
    $this->queryMessage = $data['queryMessage'];
  }

  public static function fetchAll(){
    $db= new PDO(DB_SERVER,DB_USER,DB_PW);
    $sql= 'SELECT * from FormQueries';
    $statement=$db->prepare($sql);
    $success=$statement->execute();
    $arr=[];
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
      $temp =  new FormQueries($row);
      array_push($arr, $temp);
    }
    return $arr;
  }

  public function create() {
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $sql = 'INSERT INTO FormQueries(firstName, lastName, email, queryType, queryMessage) VALUES (?, ?, ?, ?, ?)';
    $statement = $db->prepare($sql);
    $success = $statement->execute([
      $this->firstName,
      $this->lastName,
      $this->email,
      $this->queryType,
      $this->queryMessage
    ]);
    $queryResponse = "Thank you ". $this->firstName .".We\'ll get back to you shortly!";
    $json = json_encode($queryResponse, JSON_PRETTY_PRINT);
    header('Content-Type: application/json');
    echo $json;
  }
}
