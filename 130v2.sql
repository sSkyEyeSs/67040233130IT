SELECT EmployeeID, TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE Country = 'USA';

SELECT *
FROM Products
WHERE CategoryID in (1, 2, 4, 8
  and UnitPrice BETWEEN 50 AND 100;

SELECT Country, City, CompanyName, ContactName, Phone
FROM Customers
WHERE Region IN ('WA', 'WY');

SELECT *
FROM Products
WHERE (CategoryID = 1 AND UnitPrice <= 20)
   OR (CategoryID = 8 AND UnitPrice >= 150);

SELECT CompanyName
FROM Customers
WHERE Fax IS NULL
ORDER BY CompanyName;

SELECT *
FROM Customers
WHERE CompanyName LIKE '%Com%';