Create Database Superstore
USE Superstore

CREATE TABLE superstore (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(255),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

INSERT INTO superstore VALUES 
('ORD101', '2024-01-05', 'C101', 'Rahul Sharma', 'Consumer', 'Mumbai', 'Maharashtra', 'West', 'P101', 'Samsung Galaxy S23', 'Electronics', 'Smartphones', 69999.00, 1, 0.05, 10000.00),
('ORD102', '2024-02-10', 'C102', 'Priya Singh', 'Corporate', 'Delhi', 'Delhi', 'North', 'P102', 'Office Chair', 'Furniture', 'Chairs', 4999.00, 2, 0.1, 800.00),
('ORD103', '2024-03-15', 'C103', 'Amit Verma', 'Home Office', 'Bengaluru', 'Karnataka', 'South', 'P103', 'HP Laptop', 'Electronics', 'Laptops', 56990.00, 1, 0.08, 8500.00),
('ORD104', '2024-04-20', 'C104', 'Sneha Patil', 'Consumer', 'Pune', 'Maharashtra', 'West', 'P104', 'Wooden Study Table', 'Furniture', 'Tables', 8999.00, 1, 0.15, 1200.00),
('ORD105', '2024-05-25', 'C105', 'Vikas Yadav', 'Corporate', 'Hyderabad', 'Telangana', 'South', 'P105', 'Sony Wireless Headphones', 'Electronics', 'Audio Devices', 2499.00, 1, 0.05, 500.00),
('ORD106', '2024-06-10', 'C106', 'Neha Gupta', 'Consumer', 'Kolkata', 'West Bengal', 'East', 'P106', 'Dell Monitor', 'Electronics', 'Computers', 12999.00, 1, 0.12, 1800.00),
('ORD107', '2024-07-15', 'C107', 'Arjun Mehta', 'Home Office', 'Chennai', 'Tamil Nadu', 'South', 'P107', 'Executive Office Chair', 'Furniture', 'Chairs', 5999.00, 1, 0.1, 1000.00),
('ORD108', '2024-08-20', 'C108', 'Meera Reddy', 'Corporate', 'Ahmedabad', 'Gujarat', 'West', 'P108', 'Canon Laser Printer', 'Electronics', 'Printers', 14999.00, 1, 0.1, 2500.00),
('ORD109', '2024-09-25', 'C109', 'Suresh Nair', 'Consumer', 'Thiruvananthapuram', 'Kerala', 'South', 'P109', 'Sony Smart TV', 'Electronics', 'Television', 45999.00, 1, 0.07, 7000.00),
('ORD110', '2024-10-30', 'C110', 'Kavita Malhotra', 'Corporate', 'Jaipur', 'Rajasthan', 'North', 'P110', 'Bose Bluetooth Speaker', 'Electronics', 'Audio Devices', 11999.00, 1, 0.08, 2000.00);



-- 🔹 1. Basic Queries
-- Q1: Retrieve all columns from the dataset.
Select * From superstore

-- Q2: Fetch the distinct customer segments available.
Select Distinct(Segment) From superstore

-- Q3: Get all orders where the sales amount is greater than ₹500.
SELECT * From superstore
WHERE sales > 500

-- Q4: Retrieve the top 5 highest-selling products.

SELECT  Product_Name , MAX(Sales) FROM superstore
GROUP BY Product_Name
LIMIT 5

-- 🔹 2. Filtering & Sorting Data
-- Q5: Find all orders placed in the year 2024.

SELECT * FROM superstore
Where YEAR(Order_Date) = 2024

 -- Q6: Retrieve orders where discount is greater than 10% and profit is negative.
 
 SELECT Order_ID, Product_Name, Discount, Profit From superstore
 WHERE Discount > 0.10 OR Profit < 0;
 
 -- Q7: Get all customers from ‘Maharashtra’ who have placed an order.
 
 SELECT DISTINCT Customer_Name FROM superstore
 WHERE State = "Maharashtra";
 
 -- 🔹 3. Aggregations & Grouping
 -- Q8: Find the total sales & average profit for each category
 
 SELECT Category, SUM(Sales) as Total_Sales, AVG(Profit) as Avg_profit 
 From superstore
 group by Category
 
 -- Q9: Count how many orders were placed in each region.
 
SELECT Region , COUNT(Order_Id) as count_of_orders 
From superstore
GROUP BY Region

-- Q10: Find the month that generated the highest revenue.

SELECT MONTH(Order_Date) , SUM(Sales) as High_Sales From superstore
GROUP BY Order_Date
Order by High_Sales DESC
Limit 1;

-- 🔹 4. Joins & Subqueries
-- Q11: Get all customers who have spent less than ₹20000 in total.

SELECT Customer_Name, Sum(Sales) FROM superstore
GROUP BY Customer_Name
HAVING Sum(Sales) < 20000;

--  Q12: Retrieve customers who have purchased Furniture .

SELECT Customer_Name From superstore
WHERE Category = 'Furniture';

--  Q13: Find the customer who has placed the most orders.

SELECT Customer_Name, COUNT(Order_ID) as Order_Count
From superstore
GROUP BY Customer_Name
ORDER BY Order_Count DESC

-- Q14: Get the top 3 most profitable states.

SELECT State , MAX(Profit) as High_Profit FROM superstore
GROUP BY State
ORDER BY High_Profit DESC
LIMIT 3

-- 🔹 5. Window Functions
-- Q15: Rank products by total sales in each category.

SELECT Category, Product_Name, SUM(Sales) AS Total_Sales,
RANK() OVER (PARTITION BY Category ORDER BY SUM(Sales) DESC) AS Rank_Row
FROM superstore
GROUP BY Category, Product_Name;

--  Q16: Get the previous month's profit for each order using LAG().

SELECT Order_ID, Order_Date, Profit, 
       LAG(Profit) OVER (ORDER BY Order_Date) AS Previous_Profit
FROM superstore;

-- 🔹 6. Advanced Queries
-- Q17: Find the profit percentage for each order.

SELECT SUM(PROFIT) FROM superstore

SELECT Product_Name, SUM(Profit), SUM(Profit)/ (SELECT SUM(PROFIT) FROM superstore) *100  As Percentage_Profit
FROM superstore
GROUP BY Product_Name

-- Q18: Get the cumulative sales for each region.

SELECT region, order_date, sales,
SUM(Sales) OVER (PARTITION BY Region ORDER BY order_date) AS cumulative_sales 
FROM superstore

-- Q19: Retrieve orders where the profit is more than the average profit.

SELECT * FROM Superstore
WHERE Profit > (SELECT AVG(Profit) From superstore)

-- Q20: Top 5 Best-Selling Products

SELECT Product_Name , MAX(Sales) AS Top_Product FROM Superstore
GROUP BY Product_Name
ORDER BY Top_Product DESC
LIMIT 5

-- Q21 Profit by Region

SELECT Region, SUM(Profit) AS Total_profit FROM superstore
GROUP BY Region
ORDER BY Total_profit DESC

-- Q21 Most Profitable Customer Segments

SELECT Segment , SUM(Profit) As Profit_Generate FROM superstore
Group by Segment
ORDER BY Profit_Generate DESC

