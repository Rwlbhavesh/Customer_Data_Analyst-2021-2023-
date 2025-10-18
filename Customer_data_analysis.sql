-- Dataset Overview:
-- This dataset contains data from 10 different shopping malls covering the period from 2021 to 2023. 
-- It includes the shopping behavior of customers across various age groups and genders, providing a complete overview of shopping trends in Istanbul.
-- The dataset includes the following important columns:

-- invoice_no: Unique ID for each transaction.
-- customer_id: Unique ID for each customer.
-- gender: Gender of the customer (Male/Female).
-- age: Age of the customer.
-- category: Product category (e.g., fashion, electronics, groceries, etc.)
-- quantity: Quantity of the product purchased in each transaction.
-- price: Price per unit of the product (in Turkish Lira).
-- payment_method: Mode of payment (Cash, Credit Card, Debit Card).
-- invoice_date: Date of the transaction.
-- shopping_mall: Name of the mall where the transaction took place


use project_customer_segmentation;
select * from customer;
SELECT COUNT(*) from customer;

-- Q.1 How is the shopping distribution according to gender?
select * from customer;
select 
		category, 
        gender, 
        sum(quantity) as Total_item 
        from customer group by category,gender order by Total_item desc ;

-- Q.2 Which gender did we sell more products to?
select * from customer;
select 
		gender, 
        sum(quantity) as Highest_Purchase 
        from customer group by gender order by Highest_Purchase desc;

-- Q.3 Which gender generated more revenue?
select * from customer;
select 
		gender, 
        sum(quantity) as Total_Sold_Item , 
        sum(quantity * price) as Total_Revenue from 
        customer group by gender order by Total_Revenue;

-- Q.4 Distribution of purchase categories relative to other columns:
select * from customer;
SELECT 
    category,
    gender,
    payment_method,
    shopping_mall,
    SUM(quantity) AS total_items_sold,
    SUM(quantity * price) AS total_revenue,
    COUNT(DISTINCT customer_id) AS unique_customers
	FROM customer
	GROUP BY category, gender, payment_method, shopping_mall
	ORDER BY category, total_revenue DESC;

-- Q.5 How is the shopping distribution according to age?
select * from customer;
select 
		case
			when age between 0 and 20 then "0-20"
			when age between 21 and 40 then "21-40"
            when age between 41 and 60 then "41-60"
            else "61+"
            end as Age_Group,
            sum(quantity) as Total_Item,
            sum(quantity * price) as Total_Earning 
            from customer group by Age_group order by total_earning desc;
            
-- Q.6 Which age category did we sell more products to?
select * from customer;
select 
		age, 
        sum(quantity) as Total_Sold_Item 
        from customer group by age order by Total_Sold_Item desc;

-- Q.7 Which age category generated more revenue?
select * from customer ;
select 
		Age, 
        sum(quantity) as Total_Item, 
        sum(quantity * price) as Total_Earning 
        from customer group by age order by Total_Earning desc;

-- Q.8 Distribution of purchase categories relative to other columns:
select * from customer;
SELECT 
    category,
    gender,
    CASE
        WHEN age BETWEEN 0 AND 17 THEN '0-20'
        WHEN age BETWEEN 18 AND 25 THEN '21-40'
        WHEN age BETWEEN 26 AND 35 THEN '41-60'
        ELSE '61+'
		END AS age_group,
		SUM(quantity) AS total_items,
		SUM(quantity * price) AS total_revenue
		FROM customer
		GROUP BY category, gender, age_group
		ORDER BY category, total_revenue DESC;


-- Q.9 Does the payment method have a relation with other columns?
select * from customer;
SELECT 
    payment_method,
    gender,
    CASE
        WHEN age BETWEEN 0 AND 17 THEN '0-20'
        WHEN age BETWEEN 18 AND 25 THEN '21-40'
        WHEN age BETWEEN 26 AND 35 THEN '41-60'
        ELSE '61+'
		END AS age_group,
		category,
		COUNT(*) AS total_transactions,
		SUM(quantity * price) AS total_revenue
		FROM customer
		GROUP BY payment_method, gender, age_group, category
		ORDER BY payment_method, total_revenue DESC;


-- Q.10 How is the distribution of the payment method?
select* from customer ;
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold,
    SUM(quantity * price) AS total_revenue,
    ROUND( (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer)), 2 ) AS percentage_of_transactions
	FROM customer
	GROUP BY payment_method
	ORDER BY total_transactions DESC;
