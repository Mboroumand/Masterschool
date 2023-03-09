--1. How many customers do we have in the data?

SELECT (count(customer_id) )
FROM "customers";



--2. What was the city with the most profit for the company in 2015? 

SELECT orders.Shipping_city ,Sum(order_profits) AS total_profit
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
Where EXTRACT (year from orders.order_date) = 2015
GROUP BY orders.shipping_city
ORDER BY total_profit DESC
Limit 1 ;



--3. In 2015, what was the most profitable city's profit?

SELECT orders.shipping_city, SUM(order_profits) AS total_profit
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id
WHERE orders.order_date >= '2015-01-01' AND orders.order_date < '2016-01-01'
GROUP BY orders.shipping_city
ORDER BY total_profit DESC
LIMIT 1;
 


--4.How many different cities do we have in the data?

Select count( Distinct shipping_city)
from orders ;


--5. Show the total spent by customers from low to high.

SELECT   o.customer_id ,sum(od.order_sales) AS order_total
From orders o
JOIN order_details od  ON o.order_id = od.order_id
Group BY o.customer_id
ORDER BY order_total ASC

;

--6. What is the most profitable city in the State of Tennessee?

SELECT  o.shipping_city , sum(od.order_profits) AS total_profit
From orders o
JOIN order_details od ON o.order_id=od.order_id
WHERE o.shipping_state ='Tennessee'
Group BY o.shipping_city
ORDER BY Total_profit DESC
LIMIT 1 ;



--7. What’s the average annual profit for that city across all years?

SELECT  AVG (od.order_profits) AS avg_profit , EXTRACT (year from o.order_date) AS order_year
FROM orders o
JOIN order_details od ON o.order_id=od.order_id
WHERE o.shipping_city= 'Lebanon'
GROUP BY order_year;

--8. What is the distribution of customer types in the data?

SELECT  Customer_segment ,Count(*) AS num_customer
FROM Customers
Group by Customer_segment ;

--SELECT   p.product_category , AVG (od.order_profits) AS most_profit
FROM orders o
JOIN order_details od on o.order_id=od.order_id
JOIN product p ON p.product_id=od.product_id
WHERE o.shipping_state='Iowa'
Group by product_category
order by  most_profit DESC
Limit 1;

--10. What is the most popular product in that category across all states in 2016?

SELECT p.product_name ,SUM(od.quantity) AS most_popular
FROM orders o
JOIN order_details od on o.order_id=od.order_id
JOIN product p ON p.product_id=od.product_id
WHERE p.product_category='Furniture' and o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
Group by p.product_name
order by  most_popular DESC
Limit 1;
 
--11. Which customer got the most discount in the data? (in total amount)

SELECT o.customer_id ,SUM(od.order_discount) AS most_discount
FROM orders o
JOIN order_details od ON o.order_id=od.order_id
--JOIN Customer c ON o.customer_id=c.customer_id
--WHERE p.product_category='Furniture' and o.order_date >= '2016-01-01' AND o.order_date < '2017-01-01'
Group By o.customer_id
Order by  most_discount DESC
Limit 1;


--12. How widely did monthly profits vary in 2018?

SELECT   EXTRACT(month from o.order_date) AS month ,
sum(od.order_profits) AS monthly_profit
FROM orders o
join order_details od ON o.order_id=od.order_id
Where EXTRACT (YEAR from o.order_date)=2018
Group by month
order by monthly_profit ;
 
--13. Which order was the highest in 2015?

SELECT  od.order_id ,sum(od.order_sales) as total_sale
From order_details od
join orders o on o.order_id=od.order_id
Where extract (year from o.order_date )=2015
Group by od.order_id
order by total_sale DESC ;

--14.What was the rank of each city in the East region in 2015?

SELECT Shipping_city ,sum(order_profits) as total_prof,
Rank () over (order by sum(order_profits) DESC) as city_rank
FROM orders o
Join order_details od ON o.order_id=od.order_id
WHERE EXTRACT (year from o.order_date )=2015
AND shipping_state IN ('Maine' ,'Maine','New Hampshire','Massachusetts','Rhode Island',
'Connecticut','New York', 'Pennsylvania', 'New Jersey', 'Delaware', 'Maryland',
'District of Columbia', 'Virginia', 'West Virginia', 'North Carolina', 'South Carolina', 'Georgia', 'Florida'
)
Group by o.shipping_city
order by city_rank ;

--15. Display customer names for customers who are in the segment ‘Consumer’ or ‘Corporate.’ How many customers are there in total ?

SELECT customer_name
FROM customers
WHERE customer_segment IN ('Consumer', 'Corporate');

SELECT COUNT(*)
FROM customers
WHERE customer_segment IN ('Consumer', 'Corporate');


  
--16.Calculate the difference between the largest and smallest order quantities for product id ‘100.

SELECT MAX(quantity) - MIN(quantity) AS diff
FROM order_details
WHERE product_id = '100';
 
--17. Calculate the percent of products that are within the category ‘Furniture.’

SELECT COUNT(*) AS total_products,
      SUM(CASE WHEN product_category = 'Furniture' THEN 1 ELSE 0 END) AS furniture_products,
      ROUND((SUM(CASE WHEN product_category = 'Furniture' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS percent_furniture
FROM product;

 --18.Display the number of duplicate products based on their product manufacturer.          
--Example: A product with an identical product manufacturer can be considered a duplicate.

SELECT product_manufacturer, COUNT(*) AS num_duplicates
FROM product
GROUP BY product_manufacturer
HAVING COUNT(*) > 1;
     
--19.Show the product_subcategory and the total number of products in the subcategory.

--Show the order from most to least products and then by product_subcategory name ascending.

SELECT product_subcategory, COUNT(*) AS total_products
FROM product
GROUP BY product_subcategory
ORDER BY total_products DESC, product_subcategory ASC;


--20.Show the product_id(s), the sum of quantities, where the total sum of its product quantities is greater than or equal to 100

SELECT product_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) >= 100;









