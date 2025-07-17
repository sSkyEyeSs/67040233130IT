Select * from Employees
Select EmployeeID, FirstName, LastName From Employees
Select * From Employees Where city = 'London'
SELECT EmployeeID, FirstName, LastName From Employees Where city ='London'
SELECT City, Country From Customers
SELECT Distinct city, Country From Customers
SELECT * From Products Where UnitPrice>200
SELECT * From Customers Where City='London' or City ='Vancouver'
SELECT * From Customers Where City='Usa' or City ='Vancouver'
SELECT * From Products Where Unitprice >=50 And UnitsinStock<20
SELECT * from Products Where UnitsInStock<20 or UnitsInStock <= ReorderLevel
SELECT * From Products Where UnitPrice BETWEEN 50 AND 100
SELECT * FROM Products where UnitPrice >= 50 AND Unitprice<=100
SELECT * From Customers where Country IN ('Brazil','Argentina','Mexico')
SELECT * From Employees WHERE FirstName LIKE 'N%'
SELECT * From Customers where CompanyName like 'A%'
SELECT * From Customers where CompanyName like '%Y'
SELECT FirstName, LastName from Employees where FirstName Like '%an%'
SELECT * From Employees where FirstName Like '_____'
SELECT CompanyName from customers where CompanyName like '_A%'
SELECT productID, ProductName, UnitPrice From Products ORDER BY UnitPrice DESC
SELECT productID, ProductName, UnitPrice From Products ORDER BY UnitPrice 
SELECT top 10 ProductName, Unitprice, UnitsInStock  from Products order by UnitsInStock DESC
SELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID ASC, UnitPrice Desc
SELECT CategoryID, ProductName, UnitPrice FROM Products ORDER BY CategoryID Desc, UnitPrice ASC