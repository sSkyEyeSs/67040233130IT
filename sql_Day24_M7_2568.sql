SELECT PRODUCTID, PRODUCTNAME,
UnitPrice, UnitsInStock,UnitPrice * UnitsInStock AS StockValue

FROM Products

SELECT ProductID as รหัส, ProductName as สินค้า,UnitsinStock + UnitsOnOrder as จำนสนคงเหลิอทั้งหมด,ReorderLevel as จุดคำสั่งซื้อ
FROM Products
where (UnitsInStock + UnitsOnOrder) < ReorderLevel

Select ProductID, ProductName,UnitPrice, ROUND(UnitPrice * 0.07,2) As Vat7
From Products

Select employeeID, TitleOfCourtesy+FirstName+space(1)+LastName as [Employee Name]
From Employees

Select employeeID, TitleOfCourtesy+FirstName+''+LastName as [Employee Name]
From Employees

Select orderID, ProductID, UnitPrice, Quantity, Discount,
	(UnitPrice* Quantity) as TotalPrice,
	(UnitPrice* Quantity) as DiscountPrice,
	(UnitPrice*Quantity)-(UnitPrice* Quantity*Discount) as NetPrice
from [Order Details]

Select orderID, ProductID, UnitPrice, Quantity, Discount,
	(UnitPrice* Quantity) as TotalPrice,
	(UnitPrice* Quantity) as DiscountPrice,
	UnitPrice*Quantity*(1-Discount) as NetPrice
from [Order Details]
Select (42.40*35) - (42.40*35*0.15)

Select employeeID, firstName, BirthDate, Datediff(YEAR,BirthDate,'2024-12-31') Age,
	HireDate, DATEDIFF(YEAR,HireDate,GETDATE()) YearInOffice
from employees

Select count(*) from Customers where country = 'USA'
Select count(*) from Employees where City = 'London'
Select count(*) from Orders where year(OrderDate) = 1997
select count(*) from [Order Details] where ProductID=1

Select sum(quantity)
from [Order Details]
where productID = 2


Select sum(UnitPrice * UnitsInStock)
From Products

Select sum(UnitsOnOrder)
from products
where CategoryID = 8

select max(Unitprice), min(UnitPrice)
from [Order Details]
where ProductId =71

Select avg(Unitprice), min(UnitPrice), max(UnitPrice)
from [Order Details]
where ProductID = 5

select Country, COUNT(*) as [Num of Country]
From Customers
Group by Country

select categoryID, avg(Unitprice), min(UnitPrice), max(UnitPrice)
from products
Group by categoryID

select OrderID, count(*)
from [Order Details]
GROUP BY ORDERID
Having count(*)>3

select ShipCountry, Count(*)
from orders
group by ShipCountry
HAVING count(*)>=100

select Country, Count(*) as "Num of Country"
From Customers
Group by Country
HAVING COUNT(*)<5

Select OrderID, Sum(UnitPrice*Quantity*(1-Discount))
from [Order Details] 
group by OrderID
having sum(UnitPrice*Quatity(1-Discount)) < 100

Select ShipCountry, Count(*) as numOfOrders
from Orders
Where Year(OrderDate)=1997
Group By ShipCountry
Having Count(*)<20
Order By Count(*) Desc

Select top 1 OrderID, Sum(UnitPrice*Quantity*(1-Discount)) as total
from [Order Details] 
group by OrderID
Order by total desc

Select top 5 OrderID, Sum(UnitPrice*Quantity*(1-Discount)) as total
from [Order Details] 
group by OrderID
Order by total asc