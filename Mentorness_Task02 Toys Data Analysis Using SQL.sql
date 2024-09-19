create database Toy_Store ;
use toy_store;

/*What is the total sales revenue
 generated by each store?*/
SELECT s.Store_ID, SUM(p.Product_Price * sl.Units) AS Total_Revenue
FROM Sales sl
JOIN products_products p ON sl.Product_ID = p.Product_ID
JOIN stores_stores s ON sl.Store_ID = s.Store_ID
GROUP BY s.Store_ID
order by s.Store_ID asc;

/*Which products are the top-selling
 in terms of units sold?*/
SELECT p.Product_Name, SUM(sl.Units) AS Total_Units_Sold
FROM Sales sl
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Total_Units_Sold DESC
LIMIT 10;

/* What is the sales performance 
by product category?*/
SELECT p.Product_Category, SUM(p.Product_Price * sl.Units) AS Total_Revenue
FROM Sales sl
JOIN  products_products p ON sl.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Revenue DESC;

/* What are the current inventory levels for
 each product at each store?*/
 SELECT s.Store_Name, p.Product_Name, i.Stock_On_Hand
FROM inventory_inventory i
JOIN stores_stores s ON i.Store_ID = s.Store_ID
JOIN products_products p ON i.Product_ID = p.Product_ID;

/*.How do monthly sales trends vary 
across different stores?*/
SELECT s.Store_Name, MONTH(sl.Date) AS Sale_Month, SUM(p.Product_Price * sl.Units) AS Monthly_Sales
FROM Sales sl
JOIN stores_stores s ON sl.Store_ID = s.Store_ID
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY s.Store_Name, Sale_Month
ORDER BY Sale_Month;

/*Which stores have the highest and 
lowest sales performance?*/
SELECT s.Store_Name, SUM(p.Product_Price * sl.Units) AS Total_Revenue
FROM Sales sl
JOIN stores_stores s ON sl.Store_ID = s.Store_ID
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY s.Store_Name
ORDER BY Total_Revenue DESC;

/* What is the profit margin for 
each product?*/
SELECT p.Product_Name, (p.Product_Price - p.Product_Cost) AS Profit_Margin
FROM products_products p;

/*How are sales distributed across 
different cities?*/
SELECT st.Store_City, SUM(p.Product_Price * sl.Units) AS Total_Revenue
FROM Sales sl
JOIN stores_stores st ON sl.Store_ID = st.Store_ID
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY st.Store_City;

/*Which products are out of stock 
in each store?*/
SELECT s.Store_Name, p.Product_Name
FROM inventory_inventory i
JOIN stores_stores s ON i.Store_ID = s.Store_ID
JOIN products_products p ON i.Product_ID = p.Product_ID
WHERE i.Stock_On_Hand = 0;

/*How do sales vary by 
specific dates?*/
SELECT sl.Date, SUM(p.Product_Price * sl.Units) AS Daily_Sales
FROM Sales sl
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY sl.Date;

/*.What is the average cost of products
 in each category?*/
 SELECT p.Product_Category, AVG(p.Product_Cost) AS Avg_Cost
FROM products_products p
GROUP BY p.Product_Category;

/*.What is the sales growth over time 
for the entire company?*/
SELECT YEAR(sl.Date) AS Sale_Year, SUM(p.Product_Price * sl.Units) AS Annual_Sales
FROM Sales sl
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY Sale_Year
ORDER BY Sale_Year;

/*.How does the store open date affect 
sales performance?*/
SELECT s.Store_Name, s.Store_Open_Date, SUM(p.Product_Price * sl.Units) AS Total_Sales
FROM Sales sl
JOIN stores_stores s ON sl.Store_ID = s.Store_ID
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY s.Store_Name, s.Store_Open_Date
ORDER BY s.Store_Open_Date;

/*What percentage of total sales does 
each store contribute?*/
SELECT s.Store_Name, (SUM(p.Product_Price * sl.Units) / (SELECT SUM(p.Product_Price * sl.Units) FROM Sales sl JOIN products_products p ON sl.Product_ID = p.Product_ID)) * 100 AS Sales_Percentage
FROM Sales sl
JOIN stores_stores  s ON sl.Store_ID = s.Store_ID
JOIN products_products p ON sl.Product_ID = p.Product_ID
GROUP BY s.Store_Name;

/*How do sales compare to current stock 
levels for each product?*/
SELECT p.Product_Name, SUM(sl.Units) AS Units_Sold, i.Stock_On_Hand
FROM Sales sl
JOIN products_products p ON sl.Product_ID = p.Product_ID
JOIN inventory_inventory i ON p.Product_ID = i.Product_ID
GROUP BY p.Product_Name, i.Stock_On_Hand;





