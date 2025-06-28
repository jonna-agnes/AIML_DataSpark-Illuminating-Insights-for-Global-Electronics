select * from customers;
select * from exchange_rates;
select * from products;
select * from sales;
select * from stores;

-- Queries for insights

-- 1. Overall female count
SELECT COUNT(Gender) AS Female_count 
FROM customers 
WHERE Gender = "Female";

--  Overall male count
SELECT COUNT(Gender) AS Male_count 
FROM customers 
WHERE Gender = "Male";

-- 2. Count of customers by country
SELECT sd.Country, COUNT(DISTINCT c.CustomerKey) AS customer_count 
FROM sales c 
JOIN stores sd ON c.StoreKey = sd.StoreKey
GROUP BY sd.Country 
ORDER BY customer_count DESC;

--overall count of customers by country
SELECT sd.Country, COUNT(DISTINCT c.CustomerKey) AS customer_count 
FROM sales c 
JOIN stores sd ON c.StoreKey = sd.StoreKey
GROUP BY sd.Country 
ORDER BY customer_count DESC;   

-- 3. Overall count of customers
SELECT COUNT(DISTINCT s.CustomerKey) AS customer_count 
FROM sales s;

-- Overall count of customers by country
SELECT sd.Country, COUNT(DISTINCT s.CustomerKey) AS customer_count 
FROM sales s
JOIN stores sd ON s.StoreKey = sd.StoreKey    
GROUP BY sd.Country 
ORDER BY customer_count DESC;   

--  Count of products by brand
SELECT Brand, COUNT(ProductKey) AS product_count 
FROM products           
GROUP BY Brand 
ORDER BY product_count DESC;

-- 4. Count of stores by country
SELECT Country, COUNT(StoreKey) 
FROM stores
GROUP BY Country 
ORDER BY COUNT(StoreKey) DESC;

-- 5. Store-wise sales
SELECT s.StoreKey, sd.Country, SUM(pd.Unit_Price_USD * s.Quantity) AS total_sales_amount 
FROM products pd
JOIN sales s ON pd.ProductKey = s.ProductKey 
JOIN stores sd ON s.StoreKey = sd.StoreKey 
GROUP BY s.StoreKey, sd.Country;

--  6 Brand count
SELECT Brand, COUNT(Brand) AS brand_count 
FROM products 
GROUP BY Brand;

-- 7. Brand-wise selling amount
SELECT Brand, ROUND(SUM(pd.Unit_price_USD * sd.Quantity), 2) AS sales_amount
FROM products pd 
JOIN sales sd ON pd.ProductKey = sd.ProductKey 
GROUP BY Brand;

-- 8 Country overall sales
SELECT s.Country, SUM(pd.Unit_price_USD * sd.Quantity) AS total_sales 
FROM products pd
JOIN sales sd ON pd.ProductKey = sd.ProductKey 
JOIN stores s ON sd.StoreKey = s.StoreKey 
GROUP BY s.Country;

-- 9 Month-wise sales
SELECT MONTH(Order_Date), SUM(pd.Unit_price_USD * sd.Quantity) AS sp_month 
FROM sales sd 
JOIN products pd ON sd.ProductKey = pd.ProductKey 
GROUP BY MONTH(Order_Date);

-- 10 Year-wise sales
SELECT YEAR(Order_Date), SUM(pd.Unit_price_USD * sd.Quantity) AS sp_month 
FROM sales sd 
JOIN products pd ON sd.ProductKey = pd.ProductKey 
GROUP BY YEAR(Order_Date);
