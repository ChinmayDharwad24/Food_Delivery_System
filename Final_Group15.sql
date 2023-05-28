Use DishDrop_Group15;
----------------------

/* GROUP 15
INFO 6210 Database Management and Database Design
Project Name : DishDrop - Food Ordering/Delivery Management System
Database Implementation

Submitted by
Chinmay Dharwad			NUID: 002771031
Kishor Channal			NUID: 002737089
Manoj Chandrasekaran	NUID: 002767647
Nagarjun Mallesh		NUID: 002788601
Sanjay Bhaskar Kashyap	NUID: 002780659
*/

--Create Database
CREATE DATABASE DishDrop_Group15;

--Use database
USE DishDrop_Group15;


--Create table scripts
CREATE TABLE Restaurant (
    RestaurantID INT NOT NULL PRIMARY KEY,
    CuisineType VARCHAR(20),
    IsOpen BIT,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE RestaurantAddress (
    AddressID INT NOT NULL PRIMARY KEY,
    Street VARCHAR(50),
    City VARCHAR(20),
    State VARCHAR(20),
    Zipcode INT,
    RestaurantID INT NOT NULL REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE Menu (
    MenuID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(20),
    RestaurantID INT NOT NULL REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE UserAccount (
    UserAccountID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    Password VARCHAR(20),
    Contact INT
);
 
CREATE TABLE DeliveryExecutive (
    DeliveryExecutiveID INT NOT NULL PRIMARY KEY,
    UserAccountID INT NOT NULL,
    IsAvailable BIT,
    FOREIGN KEY (UserAccountID) REFERENCES UserAccount(UserAccountID)
);
 
CREATE TABLE Payment (
    PaymentID INT NOT NULL PRIMARY KEY,
    PaymentMethod VARCHAR(20),
    PaymentTime DATETIME,
	CustomerOrderID INT NOT NULL,
	FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrders(CustomerOrderID)
);

select * from UserAccount ua 
CREATE TABLE MenuItems (
    MenuItemID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50),
    Description VARCHAR(255),
    Price FLOAT,
    Calories INT,
    Inventory INT,
    MenuID INT NOT NULL ,
	FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)
);

CREATE TABLE Customer (
    CustomerID INT NOT NULL PRIMARY KEY,
    UserAccountID INT NOT NULL,
    IsPremium BIT,
    JoiningDate DATE,
	FOREIGN KEY (UserAccountID) REFERENCES UserAccount(UserAccountID)
);

CREATE TABLE CustomerAddress (
    AddressID INT NOT NULL PRIMARY KEY,
    CustomerID INT NOT NULL,
    UnitNo INT,
    Street VARCHAR(50),
    City VARCHAR(20),
    State VARCHAR(20),
    Zipcode INT
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE PremiumAccount (
    CustomerID INT NOT NULL PRIMARY KEY,
    SubscriptionID INT NOT NULL,
    RenewalDate DATE,
    StartDate DATE,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	FOREIGN KEY (SubscriptionID) REFERENCES Subscription(SubscriptionID)
);

CREATE TABLE CustomerOrders (
  CustomerOrderID INT NOT NULL PRIMARY KEY,
  CustomerID INT NOT NULL,
  Status VARCHAR(50),
  RestaurantID INT,
  OrderDate DATE,
  OrderTime TIME,
  PickupTime TIME,
  DeliveryTime TIME,
  Price FLOAT,
  Note VARCHAR(255),
  DeliveryExecutiveID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
  FOREIGN KEY (DeliveryExecutiveID) REFERENCES DeliveryExecutive(DeliveryExecutiveID)
);

CREATE TABLE CustomerOrderReview (
  ReviewID INT NOT NULL PRIMARY KEY,
  CustomerOrderID INT NOT NULL,
  Rating INT,
  FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrders(CustomerOrderID)
);

CREATE TABLE CustomerSupport
(
    CustomerSupportID INT PRIMARY KEY,
    UserAccountID INT NOT NULL,
	FOREIGN KEY (UserAccountID) REFERENCES UserAccount(UserAccountID)
);

CREATE TABLE CustomerOrderSupport
(
    CustomerOrderID INT NOT NULL,
    CustomerSupportID INT NOT NULL,
    Rating INT,
    IsResolved BIT,
    PRIMARY KEY (CustomerOrderID, CustomerSupportID),
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrders(CustomerOrderID),
    FOREIGN KEY (CustomerSupportID) REFERENCES CustomerSupport(CustomerSupportID)
);

CREATE TABLE Subscription (
    SubscriptionID INT NOT NULL PRIMARY KEY,
    SubscriptionType VARCHAR(20) NOT NULL,
    DiscountPercent DECIMAL(5, 2) NOT NULL
);

CREATE TABLE CustomerOrderItems
(
    MenuItemID INT NOT NULL,
    CustomerOrderID INT NOT NULL,
    Quantity INT,
    PRIMARY KEY (MenuItemID, CustomerOrderID),
    FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID),
    FOREIGN KEY (CustomerOrderID) REFERENCES CustomerOrders(CustomerOrderID)
);

--Insert scripts for few tables
INSERT INTO Restaurant (RestaurantID, CuisineType, IsOpen, Name)
VALUES (1, 'Italian', 1, 'Mamma Maria'),
       (2, 'Chinese', 0, 'Gourmet Dumpling House'),
       (3, 'Mexican', 1, 'El Ranchito'),
       (4, 'American', 1, 'Johnny Rockets'),
       (5, 'Japanese', 0, 'Sushi House'),
       (6, 'Indian', 1, 'Wow Tikka'),
       (7, 'French', 0, 'Le Bistro'),
       (8, 'Mediterranean', 1, 'The Olive Tree'),
       (9, 'Thai', 0, 'Bangkok Palace'),
       (10, 'Korean', 1, 'Seoul Kitchen');

INSERT INTO RestaurantAddress (AddressID, Street, City, State, Zipcode, RestaurantID)
VALUES (1, '10 Huntington Ave', 'Boston', 'MA', 02116, 1),
       (2, '2 Avery St', 'Boston', 'MA', 02111, 2),
       (3, '50 Park Plaza', 'Boston', 'MA', 02116, 3),
       (4, '225 Franklin St', 'Boston', 'MA', 02110, 4),
       (5, '100 Stuart St', 'Boston', 'MA', 02116, 5),
       (6, '1394 Massachusetts Ave', 'Cambridge', 'MA', 02138, 6),
       (7, '660 Beacon St', 'Boston', 'MA', 02215, 7),
       (8, '250 Northern Ave', 'Boston', 'MA', 02210, 8),
       (9, '145 Dartmouth St', 'Boston', 'MA', 02116, 9),
       (10, '1128 Cambridge St', 'Cambridge', 'MA', 02139, 10),
	   (11, '70 Union Square', 'Somerville', 'MA', 02143, 1),
       (12, '10 Brookline St', 'Cambridge', 'MA', 02139, 2);

INSERT INTO Menu (MenuID, Name, RestaurantID)
VALUES (1, 'Pizza Menu', 1),
       (2, 'Chinese Menu', 2),
       (3, 'Mexican Menu', 3),
       (4, 'Burger Menu', 4),
       (5, 'Sushi Menu', 5),
       (6, 'Indian Menu', 6),
       (7, 'French Menu', 7),
       (8, 'Mediterranean Menu', 8),
       (9, 'Thai Menu', 9),
       (10, 'Korean Menu', 10);

-- We have inserted the Data into other Tables using the Data import Wizard
      

--VIEW 1
--View to Display Customers with Premium Account who have placed atleast one order

CREATE VIEW PremiumCustomersWithOrders AS
SELECT c.CustomerID, u.FirstName, u.LastName, s.SubscriptionID AS SubscriptionID, s.SubscriptionType, COUNT(o.CustomerOrderID) AS OrderCount
FROM Customer c
JOIN CustomerOrders o ON c.CustomerID = o.CustomerID
JOIN PremiumAccount p ON c.CustomerID = p.CustomerID
JOIN UserAccount u ON c.UserAccountID = u.UserAccountID
JOIN Subscription s ON p.SubscriptionID = s.SubscriptionID
WHERE c.IsPremium = 1
GROUP BY c.CustomerID, u.FirstName, u.LastName, s.SubscriptionID, s.SubscriptionType
HAVING COUNT(o.CustomerOrderID) >= 1;

SELECT * FROM PremiumCustomersWithOrders;

--VIEW 2
--View to Display the Restaurant which has sold most number of unique Menu Items in descending order

CREATE VIEW DifferentMenuItemsSold AS
SELECT r.Name AS RestaurantName, COUNT(DISTINCT o.MenuItemID)  AS NumDifferentItemsSold,
STUFF((SELECT DISTINCT ', ' + mi.Name
              FROM CustomerOrders c2
              JOIN CustomerOrderItems o2 ON o2.CustomerOrderID = c2.CustomerOrderID
              JOIN MenuItems mi ON mi.MenuItemID = o2.MenuItemID
              WHERE c2.RestaurantID = r.RestaurantID
              FOR XML PATH('')), 1, 2, '') AS MenuItemNames
FROM CustomerOrders c
JOIN Restaurant r
ON c.RestaurantID = r.RestaurantID
JOIN CustomerOrderItems o
ON o.CustomerOrderID = c.CustomerOrderID
JOIN MenuItems mi 
ON mi.MenuItemID = o.MenuItemID
GROUP BY r.RestaurantID, r.Name
HAVING COUNT(DISTINCT o.MenuItemID) >= 1;

SELECT * FROM DifferentMenuItemsSold
ORDER BY NumDifferentItemsSold DESC;

--VIEW 3
--View to display the most sold MenuItem in each Restaurant

CREATE VIEW MostSoldMenuItem AS
WITH TotalQuantityOfMenuItemsSold AS (
  SELECT orders.RestaurantID, oi.MenuItemID, item.Name, SUM(oi.Quantity) AS TotalQuantity
  FROM CustomerOrderItems oi
  JOIN CustomerOrders orders 
  ON orders.CustomerOrderID = oi.CustomerOrderID
  JOIN MenuItems item 
  ON item.MenuItemID = oi.MenuItemID
  GROUP BY orders.RestaurantID, oi.MenuItemID, item.Name
)
SELECT RestaurantID, MenuItemID, Name, TotalQuantity
FROM (
  SELECT RestaurantID, MenuItemID, Name, TotalQuantity, RANK() OVER (PARTITION BY RestaurantID ORDER BY TotalQuantity DESC) AS rank
  FROM TotalQuantityOfMenuItemsSold
) AS ranked
WHERE rank = 1;

SELECT * FROM MostSoldMenuItem;

--IMPLEMENTATION

-- Table-level CHECK Constraints based on a function
--Add a Constraint to not allow a User with the same name and email to register
GO
CREATE OR ALTER FUNCTION CheckUserRegistered(@FirstName VARCHAR(50), @LastName VARCHAR(50), @Email VARCHAR(50))
RETURNS SMALLINT
AS
BEGIN
   DECLARE @Count SMALLINT;
   SET @Count = 0;
	
	SELECT @Count = COUNT(UserAccountID) FROM UserAccount
		WHERE Email = @Email and FirstName = @FirstName and LastName = @LastName
	RETURN @Count;
END;
GO
ALTER TABLE UserAccount ADD CONSTRAINT CheckUserConstraint CHECK(dbo.CheckUserRegistered(FirstName, LastName, Email) = 1);

INSERT INTO UserAccount VALUES(23, 'John', 'Doe', 'john.doe@gmail.com',4234567890, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'mypass456')));

------------------- Encryption for Password ----------------
CREATE MASTER KEY ENCRYPTION 
BY PASSWORD = 'password@2023';

CREATE CERTIFICATE PasswordProtect
WITH SUBJECT = 'User Password';

--Create Symmetric Key
CREATE SYMMETRIC KEY password_protec
WITH ALGORITHM= AES_256 -- it can be AES_128,AES_192,DES etc
ENCRYPTION BY CERTIFICATE PasswordProtect;

--Encryption
ALTER TABLE UserAccount ADD PasswordProtected VARBINARY(128);

OPEN SYMMETRIC KEY password_protec
DECRYPTION BY CERTIFICATE PasswordProtect;

UPDATE UserAccount 
SET PasswordProtected = EncryptByKey(key_GUID('password_protec'),CONVERT(VARCHAR(50), Password));

--Close Symmetric Key
CLOSE SYMMETRIC KEY password_protec

--Deleting the old Password column
ALTER TABLE UserAccount DROP COLUMN Password

--Decryption
OPEN SYMMETRIC KEY password_protec
DECRYPTION BY CERTIFICATE PasswordProtect;

--To view encrypted passwords
SELECT FirstName, LastName,Email, PasswordProtected, CONVERT(VARCHAR, DecryptByKey(PasswordProtected)) AS 'Decrypted Password' FROM UserAccount;

/* ALTER TABLE UserAccount ADD PASSWORD VARCHAR(50);
UPDATE UserAccount
SET Password = CONVERT(VARCHAR, DecryptByKey(PasswordProtected))
ALTER TABLE UserAccount DROP COLUMN PasswordProtected */

--View all the records from UserAccount
SELECT * FROM UserAccount;

--COMPUTE COLUMN BASED ON A FUNCTION

--Calculate Total Revenue of a Restaurant

CREATE FUNCTION calculateTotalRevenueOfRestaurant(@RestaurantID INT)
RETURNS FLOAT
AS
	BEGIN

	DECLARE @Revenue AS FLOAT

	SELECT @Revenue = SUM(Price) FROM CustomerOrders c
	WHERE c.RestaurantID = @RestaurantID

	RETURN @Revenue
END

--Calculate Most Sold Item of a Restaurant
CREATE FUNCTION getMostSoldItemName (@RestaurantID INT)
RETURNS VARCHAR(50)
AS
BEGIN
  DECLARE @ItemName VARCHAR(50)
  SELECT TOP 1 @ItemName = Name
  FROM MenuItems item
  JOIN CustomerOrderItems oi 
  ON item.MenuItemID = oi.MenuItemID
  JOIN CustomerOrders orders 
  ON orders.CustomerOrderID = oi.CustomerOrderID
  WHERE orders.RestaurantID = @RestaurantID
  GROUP BY item.MenuItemID, item.Name
  ORDER BY SUM(oi.Quantity) DESC
  RETURN @ItemName
END

ALTER TABLE Restaurant
ADD TotalRevenue AS (dbo.calculateTotalRevenueOfRestaurant(RestaurantID)),
	MostSoldItem AS (dbo.getMostSoldItemName(RestaurantID));

SELECT * FROM Restaurant;




--------------- Triggers---------------------------


-- Trigger to check if the OrderTime does not exceed 23:30:00  

CREATE TRIGGER OrderRestrictions
ON CustomerOrders
AFTER Insert
AS
IF EXISTS (SELECT 1 FROM inserted WHERE OrderTime > '23:30:00')
BEGIN
    RAISERROR('Warning: Order time is after 11:30PM', 16, 1);
END

-- Trigger to regulate the inventory based on the Customer Orders 

CREATE TRIGGER ReduceInventoryOnOrder
ON CustomerOrderItems
AFTER INSERT
AS
BEGIN
    UPDATE MenuItems
    SET Inventory = Inventory - i.Quantity
    FROM MenuItems m
    INNER JOIN inserted i ON m.MenuItemID = i.MenuItemID;
END


-------- Trigger to Update the Delivery Time after Order is delivered ---- 

CREATE TRIGGER DeliveryTimeUpdate
ON CustomerOrders
AFTER UPDATE
AS
IF UPDATE(Status)
BEGIN
    UPDATE CustomerOrders
    SET DeliveryTime = GETDATE()
    FROM CustomerOrders c
    INNER JOIN inserted i ON c.CustomerOrderID = i.CustomerOrderID
    WHERE i.Status = 'Delivered';
END


--- Trigger to Update the OrderPrice based on quantity and unit price

CREATE TRIGGER CalculateOrderPrice
ON CustomerOrderItems
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE c
    SET c.Price = oi.TotalPrice
    FROM CustomerOrders c
    INNER JOIN (
        SELECT CustomerOrderID, SUM(Quantity * Price) AS TotalPrice
        FROM CustomerOrderItems oi
        INNER JOIN MenuItems mi ON oi.MenuItemID = mi.MenuItemID
        GROUP BY CustomerOrderID
    ) oi ON c.CustomerOrderID = oi.CustomerOrderID
    WHERE c.CustomerOrderID IN (SELECT CustomerOrderID FROM inserted);
END


select * from UserAccount ua;

select * from CustomerAddress ca;


INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email,Contact, PasswordProtected ) VALUES (23, 'John', 'Doe', 'johndoe@example.com', 1234567890, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password1')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (24, 'Jane', 'Doe', 'janedoe@example.com', 2345678901,EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password2')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (25, 'Alice', 'Smith', 'alicesmith@example.com', 3456789012,EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password3')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (26, 'Bob', 'Johnson', 'bobjohnson@example.com', 4567890123, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password4')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (27, 'Charlie', 'Brown', 'charliebrown@example.com', 5678901234,EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password5')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (28, 'David', 'Williams', 'davidwilliams@example.com', 6789012345, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password6')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (29, 'Eva', 'Davis', 'evadavis@example.com', 7890123456, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password7')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (30, 'Frank', 'Miller', 'frankmiller@example.com', 8901234567, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password8')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (31, 'Grace', 'Wilson', 'gracewilson@example.com', 9012345678, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password9')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (32, 'Hannah', 'Moore', 'hannahmoore@example.com',1023456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password10')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (33, 'Ivan', 'Taylor', 'ivantaylor@example.com', 1123456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password11')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (34, 'Jack', 'Anderson', 'jackanderson@example.com',1223456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password12')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (35, 'Katie', 'Thomas', 'katiethomas@example.com', 1323456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password13')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (36, 'Luke', 'Jackson', 'lukejackson@example.com',  1423456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password14')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact , PasswordProtected) VALUES (37, 'Megan', 'White', 'meganwhite@example.com',  1523456789, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password15')));
INSERT INTO UserAccount (UserAccountID, FirstName, LastName, Email, Contact, PasswordProtected) VALUES (21, 'Janeth', 'Jones', 'janiejones@example.com', 9876543210, EncryptByKey(key_GUID('password_protec'),convert(varchar(50), 'password2')));


delete from UserAccount where UserAccountID in 25 and;
DELETE FROM UserAccount
WHERE UserAccountID BETWEEN 25 AND 37;

select * from customer;

INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (11, 20, 0, '2023-01-01');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (12, 21, 1, '2023-01-15');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (13, 22, 0, '2023-02-05');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (14, 23, 1, '2023-02-20');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (15, 24, 0, '2023-03-01');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (16, 25, 1, '2023-03-15');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (17, 26, 0, '2023-04-01');
INSERT INTO Customer (CustomerID, UserAccountID, IsPremium, JoiningDate) VALUES (18, 27, 1, '2023-04-10');


INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (31, 11, 101, 'Main St', 'Boston', 'MA', 02108);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (32, 12, 102, 'Elm St', 'Cambridge', 'MA', 02138);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (33, 13, 103, 'Maple St', 'Worcester', 'MA', 01602);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (34, 14, 104, 'Oak St', 'Springfield', 'MA', 01103);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (35, 15, 105, 'Pine St', 'Lowell', 'MA', 01850);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (36, 16, 106, 'Birch St', 'Brockton', 'MA', 02301);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (37, 17, 107, 'Cedar St', 'New Bedford', 'MA', 02740);
INSERT INTO CustomerAddress (AddressID, CustomerID, UnitNo, Street, City, State, Zipcode) VALUES (38, 18, 108, 'Walnut St', 'Quincy', 'MA', 02169);

SELECT * FROM DeliveryExecutive de

INSERT INTO CustomerOrders (
    CustomerOrderID, CustomerID, Status, RestaurantID,
    OrderDate, OrderTime, PickupTime, DeliveryTime,
    Price, Note, DeliveryExecutiveID
) VALUES
(1018, 12, 'Delivered', 8, '2023-01-15', '19:00:00', '19:30:00', '20:00:00', 18.49, 'No onions', 2),
(1019, 13, 'Pending', 3, '2023-01-20', '20:00:00', '20:30:00', '21:00:00', 22.99, 'Spicy sauce', 3),
(1020, 14, 'Delivered', 10, '2023-01-25', '18:45:00', '19:15:00', '19:45:00', 15.99, 'Extra toppings', 4),
(1021, 15, 'Delivered', 9, '2023-01-30', '19:15:00', '19:45:00', '20:15:00', 20.49, 'Gluten-free', 5);

select * from CustomerOrderItems coi;
select * from CustomerOrders co;
select * from customer;
SELECT * FROM Restaurant r;
select * from MenuItems mi;
select * from Payment p;


