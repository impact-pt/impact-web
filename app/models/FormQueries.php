<?php

class FormQueries{

  public $firstName;
  public $lastName;
  public $queryType;
  public $email;
  public $queryMessage;

  public function __construct($data){
    $this->firstName = $data['queryID'];
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

  // public function create() {
  //   $db = new PDO(DB_SERVER, DB_USER, DB_PW);
  //   $sql = 'INSERT COMMENT_PHP(comment) VALUES (?)';
  //   $statement = $db->prepare($sql);
  //   $success = $statement->execute([
  //     $this->comment
  //   ]);
  //   $this->id = $db->lastInsertId();
  //   $temp = array (
  //         "id"=>$this->id,
  //         "comment"=>$this->comment
  //       );
  // }
}
