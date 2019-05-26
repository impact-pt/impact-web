<?php

class RegisterUser{

  public $username;
  public $firstName;
  public $lastName;
  public $email;
  public $password;
  public $phone;

  public function __construct($data){
    $this->username = $data['username'];
    $this->firstName = $data['firstName'];
    $this->lastName = $data['lastName'];
    $this->email = $data['email'];
    $this->password = $data['password'];
    $this->phone = $data['phone'];
  }

  // for future use
  // public static function fetchAll(){
  //   $db= new PDO(DB_SERVER,DB_USER,DB_PW);
  //   $sql= 'SELECT * from RegisteredUsers';
  //   $statement=$db->prepare($sql);
  //   $success=$statement->execute();
  //   $arr=[];
  //   while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
  //     $temp =  new RegisterUser($row);
  //     array_push($arr, $temp);
  //   }
  //   return $arr;
  // }

  public function create() {

    // checking if the user already pcntl_wexitstatus
    $db = new PDO(DB_SERVER, DB_USER, DB_PW);
    $user_check_query = "SELECT * FROM RegisteredUsers WHERE email = ? LIMIT 1";
    $user_check_stmt = $db->prepare($user_check_query);
    $status = $user_check_stmt->execute([
      $this->email
    ]);

    if($row = $user_check_stmt->fetch(PDO::FETCH_ASSOC)) {
      $queryArr = "User already exists";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }
    else {
      $db = new PDO(DB_SERVER, DB_USER, DB_PW);
      $sql = 'INSERT INTO RegisteredUsers(username, firstName, lastName, email, pass, phone) VALUES (?, ?, ?, ?, ?, ?)';
      $statement = $db->prepare($sql);
      $success = $statement->execute([
        $this->username,
        $this->firstName,
        $this->lastName,
        $this->email,
        $this->password,
        $this->phone
      ]);
      $_SESSION['username'] = $username;
  	  $_SESSION['success'] = "You are now logged in";
      $queryArr = "User registered successfully";
      $json = json_encode($queryArr, JSON_PRETTY_PRINT);
      header('Content-Type: application/json');
      echo $json;
    }
  }
}
