-- CREATE SUPERSTORE DATA TABLE

DROP TABLE IF EXISTS superstore_data;
CREATE TABLE IF NOT EXISTS superstore_data(

	Row_ID			INT,
	Order_ID		CHAR(15),
	Order_Date		DATE,
	Ship_Date		DATE,
	Ship_Mode		VARCHAR(15),
	Customer_ID		VARCHAR(15),
	Customer_Name	VARCHAR(40),
	Segment			VARCHAR(20),
	Country			VARCHAR(30),
	City			VARCHAR(30),
	State			VARCHAR(30),
	Postal_Code		INT,
	Region			VARCHAR(10),
	Product_ID		VARCHAR(20),
	Category		VARCHAR(20),
	Sub_Category	VARCHAR(20),
	Product_Name	VARCHAR(150),
	Sales			NUMERIC(10,2),
	Quantity		INT,
	Discount		NUMERIC(10,2),
	Profit			NUMERIC(10,2)

);

SELECT
	*
FROM superstore_data;


--  IMPORT SUPERSTORE DATA

COPY
superstore_data(Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region, Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit)
FROM
'C:\CSV Files\Superstore_Data1.csv'
DELIMITER ','
CSV HEADER;


-- KPI 

--  1 ) Total Sales 

SELECT
	SUM(sales) AS total_sales
FROM superstore_data;


-- 2. Total Profit 

SELECT 
	SUM(profit)
FROM superstore_data;



-- 3. Total QUantity

SELECT
	SUM(quantity) AS Quantity
FROM superstore_data;



-- 4. Total Discount

SELECT
	(AVG(discount)*100)::NUMERIC(10,2)
FROM superstore_data;




-- 1) Top 10 Customers Wise Sales 

SELECT
	customer_name,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- 2) REPETED ORDERS COUNT

SELECT
	order_id,
	count(order_id) AS total_orders
FROM superstore_data
GROUP BY order_id
ORDER BY total_orders DESC;



-- 3) TOP 5 STATE WISE TOTAL SALES

SELECT
	state,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY state
ORDER BY  total_sales DESC
LIMIT 5;


--  4) TOP 10 CITIES WISE TOTAL SALES 

SELECT
	city,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY city
ORDER BY  total_sales DESC
LIMIT 10;



-- 5) REGION WISE TOTAL SALES

SELECT
	region,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY region
ORDER BY  total_sales DESC



-- 6) SHIP MODE WISE TOTAL SALES

SELECT
	ship_mode,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY ship_mode;


-- 7) TOP 10 PRODUCT WISE SALES

SELECT
	SUBSTRING(product_name,1,25) AS product_name,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY product_name
ORDER BY  total_sales DESC
LIMIT 10;



-- 8) Category Wise Sales

SELECT 
	category,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY category;



-- 9) TOP 10 Subcategory Wise Sales 

SELECT
	sub_category,
	SUM(sales) AS total_Sales
FROM superstore_data
GROUP BY sub_Category
ORDER BY total_sales DESC
LIMIT 10;


--  10) YOY Wise Sales

SELECT
	DATE_PART('Year',order_date) AS years,
	LAG(SUM(sales)) OVER(ORDER BY DATE_PART('Year',order_date)) AS Previous_year,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY years


-- 11) MOM Wise Sales

SELECT
	TO_CHAR(ORDER_DATE, 'Month') AS Month,
	LAG(SUM(sales)) OVER(ORDER BY EXTRACT('Month' FROM order_date))  AS Previous_month,
	SUM(sales) AS total_sales
FROM superstore_data
GROUP BY EXTRACT('Month' FROM order_date), Month;





