-- 1. แสดง Order + ลูกค้า + พนักงาน + บริษัทขนส่ง + ยอดเงิน
SELECT 
    o.OrderID,
    c.CompanyName AS CustomerCompany,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    o.OrderDate,
    s.CompanyName AS Shipper,
    o.ShipCity,
    o.ShipCountry,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.CompanyName, e.FirstName, e.LastName, 
         o.OrderDate, s.CompanyName, o.ShipCity, o.ShipCountry;

-- 2. ลูกค้า + Order Count + Total Amount (ม.ค.-มี.ค.1997)
SELECT 
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country,
    COUNT(o.OrderID) AS OrderCount,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-03-31'
GROUP BY c.CompanyName, c.ContactName, c.City, c.Country;

-- 3. พนักงาน + Order Count + Total Amount (พ.ย.-ธ.ค.1996) + USA/Canada/Mexico
SELECT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    e.Title,
    e.HomePhone,
    COUNT(DISTINCT o.OrderID) AS OrderCount,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1996-11-01' AND '1996-12-31'
  AND o.ShipCountry IN ('USA','Canada','Mexico')
GROUP BY e.FirstName, e.LastName, e.Title, e.HomePhone;

-- 4. รหัสสินค้า + จำนวนขายทั้งหมด มิ.ย.1997
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQty
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1997-06-01' AND '1997-06-30'
GROUP BY p.ProductID, p.ProductName, p.UnitPrice;

-- 5. รหัสสินค้า + ยอดเงินรวม ม.ค.1997 (2 ตำแหน่ง)
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS TotalAmount
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-01-31'
GROUP BY p.ProductID, p.ProductName, p.UnitPrice;

-- 6. Supplier + Product + จำนวนรวม ปี1996
SELECT 
    sup.CompanyName,
    sup.ContactName,
    sup.Phone,
    sup.Fax,
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQty
FROM Suppliers sup
JOIN Products p ON sup.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY sup.CompanyName, sup.ContactName, sup.Phone, sup.Fax,
         p.ProductID, p.ProductName, p.UnitPrice;

-- 7. Seafood + USA ปี1997
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQty
FROM Products p
JOIN Categories cat ON p.CategoryID = cat.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE cat.CategoryName = 'Seafood'
  AND o.ShipCountry = 'USA'
  AND YEAR(o.OrderDate) = 1997
GROUP BY p.ProductID, p.ProductName, p.UnitPrice;

-- 8. Sale Rep + อายุงาน + จำนวน Order ปี1998
SELECT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    DATEDIFF(YEAR, e.HireDate, GETDATE()) AS YearsOfService,
    COUNT(DISTINCT o.OrderID) AS OrderCount
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID AND YEAR(o.OrderDate) = 1998
WHERE e.Title = 'Sales Representative'
GROUP BY e.FirstName, e.LastName, e.HireDate;

-- 9. พนักงานที่ขายให้ Frankenversand ปี1996
SELECT DISTINCT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    e.Title
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CompanyName = 'Frankenversand'
  AND YEAR(o.OrderDate) = 1996;

-- 10. ยอดขาย Beverage ปี1996 (ตามพนักงาน)
SELECT 
    e.LastName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS BeverageSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE YEAR(o.OrderDate) = 1996
  AND cat.CategoryName = 'Beverages'
GROUP BY e.LastName;

-- 11. Nancy + Beverage Sales ม.ค.-มี.ค.1997
SELECT 
    cat.CategoryName,
    p.ProductID,
    p.ProductName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE (e.FirstName = 'Nancy')
  AND (o.OrderDate BETWEEN '1997-01-01' AND '1997-03-31')
GROUP BY cat.CategoryName, p.ProductID, p.ProductName;

-- 12. ลูกค้าที่ซื้อ Seafood ปี1997
SELECT DISTINCT 
    c.CompanyName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Seafood'
  AND YEAR(o.OrderDate) = 1997;

-- 13. บริษัทขนส่ง + ลูกค้าที่อยู่ Johnstown Road
SELECT DISTINCT 
    s.CompanyName,
    o.ShippedDate,
    CONVERT(varchar, o.ShippedDate, 106) AS ShipDateFormat
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Address LIKE '%Johnstown Road%';

-- 14. ยอดขายตามประเภทสินค้า ปีรวม (ทศนิยม4)
SELECT 
    cat.CategoryID,
    cat.CategoryName,
    COUNT(p.ProductID) AS ProductCount,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),4) AS TotalSales
FROM Categories cat
JOIN Products p ON cat.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY cat.CategoryID, cat.CategoryName;

-- 15. ลูกค้า London, Cowes ซื้อ Seafood จาก Supplier ญี่ปุ่น
SELECT 
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
JOIN Suppliers sup ON p.SupplierID = sup.SupplierID
WHERE c.City IN ('London','Cowes')
  AND cat.CategoryName = 'Seafood'
  AND sup.Country = 'Japan'
GROUP BY c.CompanyName;

-- 16. Shipper + จำนวน Orders + ค่าขนส่ง (USA)
SELECT 
    s.ShipperID,
    s.CompanyName,
    COUNT(o.OrderID) AS OrderCount,
    SUM(o.Freight) AS TotalFreight
FROM Shippers s
JOIN Orders o ON s.ShipperID = o.ShipVia
WHERE o.ShipCountry = 'USA'
GROUP BY s.ShipperID, s.CompanyName;

-- 17. พนักงานอายุมากกว่า 60 + ลูกค้า + Condiment Sales
SELECT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    c.CompanyName,
    c.ContactName,
    c.Phone,
    c.Fax,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),4) AS CondimentSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories cat ON p.CategoryID = cat.CategoryID
WHERE cat.CategoryName = 'Condiments'
  AND DATEDIFF(YEAR, e.BirthDate, GETDATE()) > 60
  AND c.Fax IS NOT NULL
GROUP BY e.FirstName, e.LastName, c.CompanyName, c.ContactName, c.Phone, c.Fax;

-- 18. ยอดขายต่อพนักงาน วันที่ 3 มิ.ย.1998 (รวมคนที่ขายไม่ได้)
SELECT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),0) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID AND o.OrderDate = '1998-06-03'
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.FirstName, e.LastName;

-- 19. Order ที่รับผิดชอบโดย Margaret + ยอดรวม (2 ตำแหน่ง)
SELECT 
    o.OrderID,
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    c.CompanyName,
    c.Phone,
    o.RequiredDate,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS TotalAmount
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE e.FirstName = 'Margaret'
GROUP BY o.OrderID, e.FirstName, e.LastName, c.CompanyName, c.Phone, o.RequiredDate;

-- 20. พนักงาน + อายุงาน + ยอดขาย (Q1 ปี1998 + USA/Canada/Mexico)
SELECT 
    (e.FirstName + ' ' + e.LastName) AS EmployeeName,
    DATEDIFF(YEAR, e.HireDate, '1998-03-31') AS YearsOfService,
    DATEDIFF(MONTH, e.HireDate, '1998-03-31') AS MonthsOfService,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 1998
  AND MONTH(o.OrderDate) BETWEEN 1 AND 3
  AND c.Country IN ('USA','Canada','Mexico')
GROUP BY e.FirstName, e.LastName, e.HireDate;
