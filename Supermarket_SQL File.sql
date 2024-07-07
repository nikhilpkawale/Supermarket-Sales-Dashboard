USE imdb;

-- Q1 Query to retrieve all columns in a single-view format

CREATE VIEW OrderDetailsView AS
SELECT 
    o.OrderID, 
    o.OrderDate, 
    s.ShipDate, 
    s.ShipMode, 
    c.CustomerID, 
    c.CustomerName, 
    c.Segment, 
    c.Country, 
    c.City, 
    c.State, 
    c.Region, 
    p.ProductID, 
    p.Category, 
    p.SubCategory, 
    p.ProductName, 
    o.Sales, 
    o.Quantity, 
    o.Profit, 
    o.Returns, 
    o.PaymentMode, 
    oi.ind1, 
    oi.ind2
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Products p ON p.ProductID = o.ProductID
JOIN 
    Shipments s ON o.OrderID = s.OrderID
JOIN 
    OrderIndicators oi ON o.OrderID = oi.OrderID;


-- Q2. Query to retrieve Total Sales by Customer Segment:

SELECT 
    Segment, 
    SUM(Sales) AS TotalSales
FROM 
    OrderDetailsView
GROUP BY 
    Segment;

-- Q3: Query to  retrieve Products by Sales

SELECT 
    ProductName, 
    SUM(Sales) AS TotalSales
FROM 
    OrderDetailsView
GROUP BY 
    ProductName
ORDER BY 
    TotalSales DESC
LIMIT 5;

-- Q4. Query to  retrieve Average Profit by Region:

SELECT 
    Region, 
    AVG(Profit) AS AverageProfit
FROM 
    OrderDetailsView
GROUP BY 
    Region;

-- Q5 Query to Orders Count by Payment Mode:

SELECT 
    PaymentMode, 
    COUNT(OrderID) AS OrdersCount
FROM 
    OrderDetailsView
GROUP BY 
    PaymentMode;
