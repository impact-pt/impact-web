DROP TABLE IF EXISTS Exercise;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Physician;
DROP TABLE IF EXISTS AssignedProduct;
DROP TABLE IF EXISTS AssignedExercise;
DROP TABLE IF EXISTS RegisteredUser;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS AssignedPhysician;

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

-- not needed anymore ---------------------------
-- CREATE TABLE Patient (
--     patientID INT PRIMARY KEY AUTO_INCREMENT,
--     verified VARCHAR(10) NOT NULL,
--     firstName VARCHAR(100) NOT NULL,
--     middleName VARCHAR(100) NOT NULL,
--     lastName VARCHAR(100) NOT NULL,
--     phone BIGINT NOT NULL,
--     email VARCHAR(100) NOT NULL
-- );
-- not needed anymore ---------------------------

CREATE TABLE Physician (
    physicianID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    accessCode VARCHAR(10) NOT NULL
);

CREATE TABLE AssignedExercise (
    userID INT NOT NULL,
    assignedExerciseID INT NOT NULL,
    duration INT NOT NULL, #duration in hours
    reps INT NOT NULL,
    times INT NOT NULL,
    CONSTRAINT assignedExerciseFK1 FOREIGN KEY (assignedExerciseID) REFERENCES Exercise(exerciseID),
    CONSTRAINT assignedExerciseFK2 FOREIGN KEY (userID) REFERENCES RegisteredUser(userID),
    CONSTRAINT assignedExercisePK PRIMARY KEY (userID, assignedExerciseID)
);

CREATE TABLE AssignedProduct (
    patientID INT NOT NULL,
    assignedProductID INT NOT NULL,
    CONSTRAINT assignedProductFK1 FOREIGN KEY (assignedProductID) REFERENCES Product(productID),
    CONSTRAINT assignedProductPK PRIMARY KEY (patientID, assignedProductID)
);

CREATE TABLE Appointment (
    appointmentID INT PRIMARY KEY AUTO_INCREMENT,
    physicianUsername VARCHAR(100) NOT NULL,
    userID INT NOT NULL,
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL,
    CONSTRAINT appointmentFK2 FOREIGN KEY (userID) REFERENCES RegisteredUser(userID)
);

CREATE TABLE FormQueries (
    queryID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    queryType INT NOT NULL,
    queryMessage TEXT NOT NULL
);

CREATE TABLE RegisteredUser (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(100) NOT NULL,
    pass VARCHAR(200) NOT NULL
)

CREATE TABLE AssignedPhysician(
    assignedPhysicianID INT NOT NULL,
    userID INT NOT NULL,
    CONSTRAINT assignedPhysicianFK1 FOREIGN KEY (assignedPhysicianID) REFERENCES Physician(physicianID),
    CONSTRAINT assignedPhysicianFK2 FOREIGN KEY (userID) REFERENCES RegisteredUser(userID)
)



SELECT * FROM AssignedExercise;
SELECT * FROM FormQueries;
SELECT * FROM RegisteredUser;
SELECT * FROM Physician;
SELECT * FROM AssignedPhysician;

INSERT INTO FormQueries VALUE (1, 'Ashok', 'Patel', 'asmpatel@gmail.com', 1, 'testing form queries')
INSERT INTO FormQueries(firstName, lastName, email, queryType, queryMessage) VALUE ( 'Ashok', 'Patel', 'asmpatel@gmail.com', 1, 'this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text this is me testing form queries with a larger text')

INSERT INTO Physician(username, firstName, lastName, accessCode) VALUES ('kayla', 'Kayla', 'Armstrong', '1234');
INSERT INTO Physician(username, firstName, lastName, accessCode) VALUES ('liz', 'Elizabeth', 'Klingler', '4567');

INSERT INTO AssignedPhysician(assignedPhysicianID, userID) VALUES (1, 1);
INSERT INTO AssignedPhysician(assignedPhysicianID, userID) VALUES (1, 2);
INSERT INTO AssignedPhysician(assignedPhysicianID, userID) VALUES (1, 3);
INSERT INTO AssignedPhysician(assignedPhysicianID, userID) VALUES (2, 4);

INSERT INTO Exercise(exerciseID, name, description) VALUES (1, 'push ups', 'diamond pushups, in supervision')
INSERT INTO Exercise(exerciseID, name, description) VALUES (2, 'sit ups', 'note position')

INSERT INTO AssignedExercise(userID, assignedExerciseID, duration, reps, times) VALUES (1, 1, 30, 3, 2)
INSERT INTO AssignedExercise(userID, assignedExerciseID, duration, reps, times) VALUES (1, 2, 30, 3, 3)
INSERT INTO AssignedExercise(userID, assignedExerciseID, duration, reps, times) VALUES (2, 1, 20, 3, 4)
INSERT INTO AssignedExercise(userID, assignedExerciseID, duration, reps, times) VALUES (3, 2, 20, 3, 4)
INSERT INTO AssignedExercise(userID, assignedExerciseID, duration, reps, times) VALUES (4, 1, 50, 3, 4)

INSERT INTO Appointment(physicianUsername, userID, appointmentDate, appointmentTime) VALUES ('kayla','1','2019-05-28','08:00:00')
INSERT INTO Appointment(physicianUsername, userID, appointmentDate, appointmentTime) VALUES ('kayla','2','2019-05-28','10:00:00')
INSERT INTO Appointment(physicianUsername, userID, appointmentDate, appointmentTime) VALUES ('liz','4','2019-05-28','08:00:00')

-- selecting assigned exercises for each user
SELECT ae.userID, ru.username, ae.assignedExerciseID, e.name, e.description, ae.duration, ae.reps, ae.times
FROM AssignedExercise ae, RegisteredUser ru, Exercise e
WHERE ru.userID = ae.userID AND ae.assignedExerciseID = e.exerciseID AND ru.username = 'rishabh'

-- selecting assigned exercises for each user under a physician
SELECT  ru.username, e.name, e.description, ae.duration, ae.reps, ae.times
FROM Physician phy, AssignedExercise ae, AssignedPhysician ap, Exercise e, RegisteredUser ru
WHERE phy.username = 'liz' AND phy.physicianID = ap.assignedPhysicianID AND ap.userID = ae.userID AND ae.assignedExerciseID = e.exerciseID AND ap.userID = ru.userID

-- selecting each patient assigned to a physician username
SELECT ru.username, ru.firstName, ru.lastName, ru.email, ru.phone
FROM Physician phy, RegisteredUser ru, AssignedPhysician ap
WHERE ap.userID = ru.userID AND ap.assignedPhysicianID = phy.physicianID AND phy.username = 'kayla'

-- selecting patient personal information
SELECT ru.username, ru.firstName, ru.lastName, ru.email, ru.phone, COUNT(ae.assignedExerciseID) AS numOfExercises
FROM RegisteredUser ru, AssignedExercise ae
WHERE ru.username = 'ashok' AND ru.userID = ae.userID
GROUP BY ru.username, ru.firstName, ru.lastName, ru.email, ru.phone,

-- selecting patient's exercises
SELECT ru.username, ru.phone, ru.firstName, ru.lastName, ru.email, e.name, e.description, ae.duration, ae.reps, ae.times
FROM RegisteredUser ru, AssignedExercise ae, Exercise e
WHERE ru.username = 'ashok' AND ru.userID = ae.userID AND ae.assignedExerciseID = e.exerciseID

-- select all appointments for a physician
SELECT ru.firstName, ru.lastName, a.appointmentDate, a.appointmentTime
FROM Appointment a, Physician phy, RegisteredUser ru
WHERE phy.username = a.physicianUsername AND phy.username = 'liz' AND ru.userID = a.userID

SELECT ru.username AS username, ru.firstName AS firstName, ru.lastName as lastName, ru.email as email, ru.phone AS phone FROM Physician phy, RegisteredUser ru, AssignedPhysician ap WHERE ap.userID = ru.userID AND ap.assignedPhysicianID = phy.physicianID AND phy.username = 'kayla'
