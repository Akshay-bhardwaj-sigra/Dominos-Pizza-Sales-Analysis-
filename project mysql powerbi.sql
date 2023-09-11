use pizza;
select * from pizza_sales;
# We need to analyze key indicator for our pizza sales data to gain insights into our business performance. specifically ,we want to calculate following metrices:
# 1 Total revenue = The sum of the total price of all pizza orders
# 2 Average order value = The average amount spent per order, calculating by dividing the total revenue by total number of orders
# 3 Total pizza sold = The sum of quantities of total pizza sold
# 4 Total order = total number of order placed
# 5 Average pizza per order = The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders;

# 1 Total revenue = The sum of the total price of all pizza orders
select sum(TOTAL_PRICE) AS TOTAL_REVENUE FROM PIZZA_SALES;
SELECT * FROM pizza_sales;

#2 Average order value = The average amount spent per order, calculating by dividing the total revenue by total number of orders
SELECT COUNT(DISTINCT ORDER_ID) AS TOTAL_NUMBER_OF_ORDERS FROM PIZZA_SALES;
SELECT SUM(TOTAL_PRICE)/COUNT(DISTINCT ORDER_ID) AS AVERAGE_ORDER_VALUE FROM PIZZA_SALES;

# 3 Total pizza sold = The sum of quantities of total pizza sold
SELECT SUM(QUANTITY) AS TOTAL_PIZZA_SOLD FROM PIZZA_SALES;

# 4 Total order = total number of order placed
SELECT COUNT(DISTINCT ORDER_ID) AS TOTAL_NUMBER_OF_ORDERS FROM PIZZA_SALES;

# 5 Average pizza per order = The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders;
SELECT SUM(QUANTITY)/COUNT(DISTINCT ORDER_ID)AS AVERAGE_PIZZA_PER_ORDER FROM PIZZA_SALES;

#CHARTS REQUIREMENTS
#WE WOULD LIKE TO VISUALIZE VARIOUS ASPECTS OF OUR PIZZA SALES DATA TO GAIN INSIGHTS AND UNDERSTAND KEY TRENDS. 
#WE HAVE IDENTIFIED THE FOLLOWING REQURIREMENTS FOR CREATING CHARTS.

#1 DAILY TRENDS FOR TOTAL ORDERS:
#Create a bar chart that displays the daily trend of total orders over a specific time period. This chart will help us identify any patterns or flactuations in order volumes on daily basis.

#2 HOURLY TRENDS FOR TOTAL ORDERS
#Create a line chart that illustrates the hourly trend of total orders throughout the day. This chart will allow us to identify peak hours or periods of high order activity.

#3 PERCENTAGE OF SALES BY PIZZA CATEGORY
#Create a pie chart that shows the distribution of Sales accross different pizza categories. This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.

SELECT order_id, DATE_FORMAT(STR_TO_DATE(order_date, '%Y-%m-%d'), '%Y-%m-%d') AS formatted_date
FROM pizza_sales
WHERE order_date IS NOT NULL;

SELECT DAYNAME(ORDER_DATE) AS ORDER_DAY, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY DAYNAME(ORDER_DATE)
ORDER BY TOTAL_ORDERS DESC; 

SELECT MONTHNAME(ORDER_DATE) AS ORDER_MONTH, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES 
GROUP BY MONTHNAME(ORDER_DATE)
ORDER BY TOTAL_ORDERS DESC; 


SELECT HOUR(ORDER_TIME) AS SALE_HOUR,(PIZZA_CATEGORY),
    COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM
    PIZZA_SALES
GROUP BY
    SALE_HOUR,PIZZA_CATEGORY
ORDER BY
    SALE_HOUR;


SELECT PIZZA_CATEGORY ,SUM(TOTAL_PRICE) AS TOTAL_SALES,
SUM(TOTAL_PRICE)*100 /( SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES ) AS PCT
FROM PIZZA_SALES 
GROUP BY PIZZA_CATEGORY;

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE MONTH(ORDER_DATE)=1
GROUP BY pizza_category;


#4 Percentage of sales by pizza size
#Generate a pie chart that represents the percentage of sales attributed to different pizza size. This chart  will help us understand customer prefrences for pizza sizes and their impact on sales.

#5 Total pizza sold by pizza category
#create a funnel chart that represents the total number of pizzas sold for each pizza category. This chart will allow us to compare the sales performance for different pizza categories

#6 Top 5 best sellers by total pizza sold
#create a bar chart highlighting the top -5 best selling pizzas based on the total number of pizzas sold. This chart will help us to identify the most popular pizza options.

#7 Bottom 5 rows sellers by totol pizzas sold 
#create a bar chart showcasing the bottom 5 wrost selling pizzas based on the total number of pizzas sold. This chart enable us to identify underperforming or less popular pizza options.

#Percentage of sales by pizza size
SELECT PIZZA_size ,SUM(TOTAL_PRICE) AS TOTAL_SALES,SUM(TOTAL_PRICE)*100 /( SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES) AS PCT
FROM PIZZA_SALES 
GROUP BY PIZZA_size
order by pct desc;

#Percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
order by pct desc;

#top 5 pizzas by revenue
select pizza_name, SUM(TOTAL_PRICE) AS TOTAL_REVENUE FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

#bottom 5 pizzas by revenue
select pizza_name, SUM(TOTAL_PRICE) AS TOTAL_REVENUE FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE ASC
LIMIT 5;

#total pizzas sold by name
select PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY DESC
LIMIT 5;

#total pizza order by name
SELECT PIZZA_NAME, COUNT(ORDER_ID) AS TOTAL_ORDERS FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS DESC
LIMIT 5;

#total maximum revenue by pizza name
SELECT PIZZA_NAME, SUM(TOTAL_PRICE) AS TOTAL_REVENUE FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE DESC
LIMIT 5;

#total minimum revenue by pizza name
SELECT PIZZA_NAME, SUM(TOTAL_PRICE) AS TOTAL_REVENUE FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY TOTAL_REVENUE ASC
LIMIT 5;

#revenue in month of august
select PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY FROM PIZZA_SALES 
WHERE MONTH(ORDER_DATE) =8
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY ASC
LIMIT 5;

#TOTAL REVENUE BY MONTH

SELECT MONTHNAME(ORDER_DATE) AS ORDER_MONTH, CAST(SUM(TOTAL_PRICE) AS DECIMAL(10,2)) AS TOTAL_REVENUE
FROM PIZZA_SALES 
GROUP BY MONTHNAME(ORDER_DATE)
; 
#Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

#9.	bottom 5 best sellers by total pizza sold
select PIZZA_NAME, SUM(QUANTITY) AS TOTAL_QUANTITY FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_QUANTITY ASC
LIMIT 5;

#	Bottom  5 PIZZAS BY TOTAL ORDERS
SELECT PIZZA_NAME, COUNT(ORDER_ID) AS TOTAL_ORDERS FROM PIZZA_SALES 
GROUP BY PIZZA_NAME
ORDER BY TOTAL_ORDERS ASC
LIMIT 5;