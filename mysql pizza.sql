create database Pizza;
use Pizza;
select * from pizza_sales;

-- 1 Total Revenue:
select sum(total_price) as 'Total Revenue' from pizza_sales;

-- 2 Avrg Order Value:
select sum(total_price) / count(distinct order_id) as Avrg_order_val from pizza_sales;

-- 3 Total Pizza Sold:
select sum(quantity) as pizza_sold from pizza_sales;

-- 4 Total Orders:
select count(distinct order_id) as total_orders from pizza_sales;

-- 5 Avrg Pizza per Order:
select cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2))
 as decimal(10,2)) as 'Avrg pizza per order' from pizza_sales;
 
-- Chart:
-- 1 Daily trend for total Orders
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- Trend by month:
SELECT MONTHNAME(order_date) AS month_name, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY MONTHNAME(order_date)
order by total_orders desc ; 

-- %age by pizza category :
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- %age by pizza size :
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- top 5 pizzas by revenue:
select pizza_name, sum(total_price) as revenue from pizza_sales
group by pizza_name
order by revenue desc
limit 5;

-- top 5 pizzas by quantity:
select pizza_name, sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5;

-- top 5 pizzas by orders:
select pizza_name, count(distinct order_id) as total_orders from pizza_sales
group by pizza_name
order by total_orders desc
limit 5;

-- For pizza size or category filters:
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
limit 5;



