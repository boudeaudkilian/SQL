CREATE TABLE Restaurants (
    IdRestaurant INTEGER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Planet VARCHAR(50) NOT NULL,
    Opening_year DATE NOT NULL
);

CREATE TABLE Employees (
    IdEmployees INTEGER PRIMARY KEY,
    Firstname VARCHAR(50) NOT NULL,
    Lastname VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    IdRestaurant INT NOT NULL
);

CREATE TABLE Dishes (
    IdDishes INTEGER PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Price FLOAT,
    Category VARCHAR(50) NOT NULL
);

CREATE TABLE Orders (
    IdOrders INTEGER PRIMARY KEY,
    IdRestaurant INT NOT NULL,
    Total_amount FLOAT NOT NULL,
    Customer_name VARCHAR(50)
);

CREATE TABLE OrderItems (
    IdOrderItems INTEGER PRIMARY KEY,
    IdOrders INT NOT NULL,
    IdDishes INT NOT NULL,
    Quantity INT NOT NULL
);

ALTER TABLE Employees ADD COLUMN hire_date DATE;
ALTER TABLE Dishes ADD COLUMN is_vegan BOOLEAN;
ALTER TABLE Orders RENAME TO CustomerOrders;

INSERT INTO Restaurants ( Name, Planet, Opening_year ) VALUES ( "Milky Way Diner", "Earth", 2025 );
INSERT INTO Dishes ( Name, Price, Category, is_vegan ) VALUES ( "Burger d’Astéroïde", 12.5, "Burgers", FALSE );
INSERT INTO Employees ( FirstName, LastName, Role, IdRestaurant ) VALUES ( "Zorglub", "Test", "Chef cuisinier", 1 );

SELECT * FROM Restaurants;
SELECT * FROM Dishes ORDER BY Price DESC;
SELECT * FROM Employees GROUP BY Role;

SELECT * FROM Dishes WHERE Name = 'vegetarian';
SELECT * FROM Dishes WHERE Price  >  (SELECT AVG(Price) FROM Dishes);

SELECT * FROM Dishes WHERE is_vegan IS NULL;
SELECT * FROM Employees WHERE hire_date IS NULL;

INSERT INTO CustomerOrders VALUES (1, 2, 20, "Fish");
INSERT INTO CustomerOrders VALUES (2, 1, 10, "fries");
INSERT INTO CustomerOrders VALUES (3, 2, 7, "Ice");
INSERT INTO CustomerOrders VALUES (4, 1, 5, "Coffee");

INSERT INTO OrderItems VALUES (1, 1, 2, 1);
INSERT INTO OrderItems VALUES (2, 2, 3, 1);
INSERT INTO OrderItems VALUES (3, 3, 4, 1);
INSERT INTO OrderItems VALUES (4, 4, 5, 1);

SELECT COUNT(IdOrders), SUM(Total_amount) FROM CustomerOrders;

SELECT * FROM CustomerOrders ORDER BY Total_amount DESC;

SELECT e.*, r.Name AS Restaurant_Name FROM Employees e INNER JOIN Restaurants r ON e.IdRestaurant = r.IdRestaurant;

SELECT Dishes.Name, CustomerOrders.Customer_name, Restaurants.Planet
FROM OrderItems
INNER JOIN Dishes ON Dishes.IdDishes = OrderItems.IdDishes
INNER JOIN CustomerOrders ON CustomerOrders.IdOrders = OrderItems.IdOrders
INNER JOIN Restaurants ON Restaurants.IdRestaurant = CustomerOrders.IdRestaurant; 

SELECT r.Name, COUNT(e.IdRestaurant) AS employee_Count FROM Employees e  INNER JOIN Restaurants r ON e.IdRestaurant = r.IdRestaurant GROUP BY e.IdRestaurant;

UPDATE Dishes
SET Price = CASE
    WHEN Price > 12 THEN Price * 0.90
    ELSE Price * 0.95
END;

DELETE FROM Dishes
WHERE Price IS NULL;

DELETE FROM Orders
WHERE Total_amount < 5;

SELECT Category, ROUND(AVG(Price), 2) AS Prix_moyen
FROM Dishes
GROUP BY Category;

SELECT SUM(Total_amount) AS Montant_total
FROM Orders;

SELECT Name, Price
FROM Dishes
ORDER BY Price DESC
LIMIT 3;

SELECT Firstname, Lastname
FROM Employees
WHERE Lastname LIKE '%a%' OR Firstname LIKE '%a%';