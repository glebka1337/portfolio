-- Calculate total orders 
SELECT 
    COUNT(*) AS total_orders
FROM 
    order_details;

-- Calculate total revenue
SELECT  
    SUM(total_price) AS total_revenue
FROM 
    order_details;

-- Calculate average revenue
SELECT 
    AVG(total_price) AS avg_revenue
FROM 
    order_details;


-- Total quantity sold
SELECT  
    SUM(quantity) AS total_quantity
FROM 
    order_details;

-- How many pizzas in each category?
SELECT  
    c.category_name,
    COUNT(p.pizza_id) AS total_pizzas
FROM 
    categories c
JOIN 
    pizzas p ON c.category_id = p.category_id
GROUP BY  
    c.category_name;

-- How many orders in each category?
SELECT  
    c.category_name,
    COUNT(od.order_id) AS total_orders
FROM 
    categories c
JOIN 
    pizzas p ON c.category_id = p.category_id
JOIN 
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY  
    c.category_name;

-- How much revenue in each category? Rank the categories by revenue
SELECT  
    c.category_name,
    ROUND(CAST(SUM(od.total_price) AS numeric), 2) AS total_revenue,
    RANK() OVER (ORDER BY SUM(od.total_price) DESC) AS rank
FROM 
    categories c
JOIN 
    pizzas p ON c.category_id = p.category_id
JOIN 
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY  
    c.category_name
ORDER BY  
    total_revenue DESC;

-- Best selling size of a pizza
SELECT  
    p.pizza_size,
    COUNT(od.order_id) AS total_orders,
    ROUND(CAST(SUM(od.total_price) AS numeric), 2) AS total_revenue
FROM 
    pizzas p
JOIN 
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY  
    p.pizza_size
ORDER BY  
    total_orders DESC;

-- Best pizza 
SELECT  p.pizza_name
       ,COUNT(od.order_id)                            AS total_orders
       ,ROUND(CAST(SUM(od.total_price) AS numeric),2) AS total_revenue
FROM pizzas p
JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY  p.pizza_name
ORDER BY  total_revenue DESC

-- Define how month impacts sales of pizza

SELECT
    CASE EXTRACT(MONTH FROM o.order_date)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month_name
    ,COUNT(od.order_id) AS total_orders
    ,ROUND(CAST(SUM(od.total_price) AS numeric), 2) AS total_revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY month_name
ORDER BY total_revenue DESC

--  Most popular quntity sold

SELECT od.quantity
       ,COUNT(od.order_id) AS total_orders
FROM order_details od
GROUP BY od.quantity
ORDER BY total_orders DESC

-- what is the "hotest" hour of the day?
SELECT  CASE WHEN EXTRACT(HOUR
FROM o.order_time) >= 12 THEN CONCAT(EXTRACT(HOUR
FROM o.order_time) - 12, ':00 PM') ELSE CONCAT(EXTRACT(HOUR
FROM o.order_time), ':00 AM') END AS hour, COUNT(od.order_id) AS total_orders
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY  hour
ORDER BY  total_orders DESC;


-- Is there any difference in sales between weekdays and weekends?
SELECT
    CASE EXTRACT(DOW FROM o.order_date)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,
    COUNT(od.order_id) AS total_orders
FROM
    orders o
JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY
    day_of_week
ORDER BY
    total_orders DESC;
