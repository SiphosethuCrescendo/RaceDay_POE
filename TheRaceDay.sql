-- Database: TheRaceDay
-- Author Sefako Siphosethu Mongalo

-- Create the Database
IF DB_ID('TheRaceDayDB') Is Not Null
BEGIN
Alter Database TheRaceDayDB Set Single_User With RollBack Immediate;
Drop Database TheRaceDayDB;
END
GO

Use master;
GO

Create Database TheRaceDayDB;
GO

USE TheRaceDayDB;
GO



-- Create Tables for Usres authentication

Create Table Users (UserID INT Identity(1,1) Primary Key,
FullName Varchar(100) Not Null,
Email Varchar(100) Not Null Unique, PasswordHash Varchar(225) Not Null,
Role Varchar(20) Not Null Default 'Participant' Check (Role IN ('organiser', 'Participant')),
PhoneNumber Varchar(20) Null, CreatedAt DateTime Not Null Default GetDate());
GO


--Events Table
Create Table Events( EventID INT Identity(1,1) Primary Key,
OrganiserID INT Not Null, EventName Varchar(100) Not Null,
EventDate Date Not Null, Location Varchar(150) Not Null,
Description Varchar (500) Null, CreatedAt DateTime Not Null Default GetDate(),
Constraint FK_Event_Users Foreign Key (OrganiserID)
References Users(UserID));
GO

-- Categories Table
Create Table Categories( CategoryID INT Identity(1,1) Primary Key,
EventID INT Not Null, CategoryName VARCHAR(100) Not Null,
MaxParticipants INT Not Null Default 100,
EntryFee Decimal(10,2) Not Null, DistanceKM Decimal(9,2) Not Null,
Constraint FK_Categories_Events Foreign KEY (EventID)
References Events(EventID));
GO

--Routes Table
Create Table Routes ( RouteID INT Identity(1,1) Primary Key,
EventID INT Not Null, RouteName Varchar(100) Not Null,
DistanceKM Decimal(5,2) Not Null, ElevationGainM INT Null,
Map Varchar(200) Null,
Constraint FK_Routes_Events Foreign Key (EventId)
References Events(EventID));
GO


-- enrollment Table
Create Table Enrolments (EnrolmentID INT Identity(1,1) Primary Key,
ParticipantID INT NOT nULL, CategoryID INT Not Null,
EnrolmentDate DateTime Default GetDate(), 
Status VARCHAR(20) Default 'Confirmed' Check (Status IN ( 'Confirmed',
'Cancelled', 'Pending')), PaymentStatus Varchar(20) Not Null Default 'Unpaid'
Check (PaymentStatus IN ('Paid', 'Unpaid')),
Constraint FK_Enrolments_Users Foreign Key (ParticipantID)
References Users(UserID),
Constraint FK_Enrolments_Categories Foreign Key (CategoryID)
References Categories(CategoryID));
GO

-- Results Table
Create Table Results ( ResultsID INT Identity (1,1) Primary Key,
EnrolmentID INT Not Null Unique, FinishTime Time Null,
Position INT Null, RecordedAt DateTime Not Null Default GetDate(),
Constraint FK_Enrolments Foreign Key (EnrolmentID)
References Enrolments(EnrolmentID));
GO

--Seed Data

--Organisers
Insert Into Users (FullName, Email, PasswordHash, Role, PhoneNumber)
Values ('Siya Kholisi', 'Siya.Kholisi@raceday.com', 'Hashed_Password_1', 'Organiser', '0123456789'),
('Sipho Pheza', 'Sipho.Pheza@raceday.com', 'Hashed_Password_2', 'Organiser', '0346274987');

-- Participants 
Insert Into Users (FullName, Email, PasswordHash, Role, PhoneNumber)
Values ('Sethu Azazel', 'AzazelFallen@gmail.com', 'Hashed_Password_3', 'Participant', '0760160121'),
('Damian Kagano', 'DamianShadow@gmail.com', 'Hashed_Password_4', 'Participant', '0760260122'),
('Vusi Amenadiel', 'VusiAngel@gmail.com', 'Hashed_Password_5', 'Participant', '0760360123'),
('Thami Escannor', 'ThamiTheOne@gmail.com', 'Hashed_Password_6', 'Participant', '0760460124'),
('Ndikwe Uzumaki', 'NdikweTailedBeast@gmail.com', 'Hashed_Password_7', 'Participant', '0760560125'),
('Mbuso Luci', 'MbusoKing@gmail.com', 'Hashed_Password_8', 'Participant', '0760660126'),
('Kewarona Merlin', 'KewaMage@gmail.com', 'Hashed_Password_9', 'Participant', '0760760127');

--Events
Insert Into Events(OrganiserID, EventName, EventDate, Location, Description)
Values (1, 'Allse Park Run Challenge', '2026-11-14', 'Allse Park Gauteng', 'A Community-focused Road Running event through allse park'),
(1, 'Gauteng Circle Classic', '2026-10-23', 'Pretoria, Gauteng', 'Annual Cycling Event For road Cycling all levels'),
(2, 'Durban Cpastal Marathon', '2026-09-28', 'Durban, kzn', 'a marathon along Durban coastalline');

--Categories
Insert Into Categories (EventID, CategoryName, DistanceKM, MaxParticipants, EntryFee)
Values (1, '5km Fun Run', 5.00, 3.00, 100.00),
(1, '10km Road Race', 10.00, 300, 150.00),
(2, '40km Road Cycle', 40.00, 150, 250.00),
(2, '80km Road Cycle', 80.00, 100, 200.00),
(3, '21km Half Marathon', 21.00, 250, 200.00),
(3, '42km full Marathon', 42.20, 150, 300.00);

--Routes
Insert Into Routes (EventID, RouteName, DistanceKM, ElevationGainM, Map)
Values (1, 'Allse Park Statium', 80.00, 620, 'https://maps.AllsePark.com/Allse-park'),
(2, 'Pretoria Hills Circuit', 10.00, 45, 'https://maps.Pretoria.com/Hills-circuit'),
(3, 'Durban BeachFront Route', 42.20, 120, 'https://maps.Durban.com/Durban-Beach');

--Enrolments
Insert Into Enrolments (ParticipantID, CategoryID, Status, PaymentStatus)
Values (3, 2, 'Confirmed', 'Paid'),
(4, 5, 'Confirmed', 'Paid'), -- Half Marathon
(3, 6, 'Pending', 'Unpaid'); --Full Marathon

--Results are only for completed/confirmed enrolments

Insert Into Results (EnrolmentID, FinishTime, Position)
values (1, '00:51:30',12), (2, '01:56:06', 34);

GO