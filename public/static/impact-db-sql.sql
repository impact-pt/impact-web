DROP TABLE IF EXISTS Exercise;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Physician;
DROP TABLE IF EXISTS AssignedExercise;

CREATE TABLE Exercise (
    exerciseID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    productID INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(200) NOT NULL
);

CREATE TABLE Patient (
    patientID INT PRIMARY KEY AUTO_INCREMENT,
    verified VARCHAR(10) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    middleName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    phone BIGINT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Physician (
    physicianID INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE AssignedExercise (
    patientID INT NOT NULL,
    assignedExerciseID INT PRIMARY KEY,
    duration INT NOT NULL, #duration in hours
    reps INT NOT NULL,
    times INT NOT NULL,
    CONSTRAINT assignedExerciseFK1 FOREIGN KEY (assignedExerciseID) REFERENCES Exercise(exerciseID),
    CONSTRAINT assignedExerciseFK2 FOREIGN KEY (patientID) REFERENCES Patient(patientID)
);

CREATE TABLE AssignedProduct (
    patientID INT NOT NULL,
    assignedProductID INT NOT NULL,
    CONSTRAINT assignedProductFK1 FOREIGN KEY (assignedProductID) REFERENCES Product(productID),
    CONSTRAINT assignedProductPK PRIMARY KEY (patientID, assignedProductID)
);

CREATE TABLE Appointment (
    appointmentID INT PRIMARY KEY AUTO_INCREMENT,
    physicianID INT NOT NULL,
    patientID INT NOT NULL,
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL
    CONSTRAINT appointmentFK1 FOREIGN KEY (physicianID) REFERENCES Product(productID),
    CONSTRAINT appointmentFK2 FOREIGN KEY (patientID) REFERENCES User(productID)
);

CREATE TABLE FormQueries (
    queryID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    queryType INT NOT NULL,
    queryMessage TEXT NOT NULL
);

CREATE TABLE RegisteredUsers (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    pass VARCHAR(200) NOT NULL
)



SELECT * FROM AssignedExercise;
SELECT * FROM FormQueries;
SELECT * FROM RegisteredUsers;

INSERT INTO FormQueries VALUE (1, 'Ashok', 'Patel', 'asmpatel@gmail.com', 1, 'testing form queries')
INSERT INTO FormQueries(firstName, lastName, email, queryType, queryMessage) VALUE ( 'Ashok', 'Patel', 'asmpatel@gmail.com', 1, 'this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text')
