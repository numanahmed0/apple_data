# 🍎 Apple Sales Analysis — SQL Project (PostgreSQL)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16%2B-336791?logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange)
![Rows](https://img.shields.io/badge/Sales%20Rows-1.04M-brightgreen)
![Level](https://img.shields.io/badge/Level-Beginner%20to%20Advanced-blue)

# ![Apple Logo](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/Apple_Changsha_RetailTeamMembers_09012021_big.jpg.slideshow-xlarge_2x.jpg) Apple Retail Sales SQL Project - Analyzing Millions of Sales Rows

## Project Overview

This project is designed to showcase advanced SQL querying techniques through the analysis of over 1 million rows of Apple retail sales data. The dataset includes information about products, stores, sales transactions, and warranty claims across various Apple retail locations globally. By tackling a variety of questions, from basic to complex, you'll demonstrate your ability to write sophisticated SQL queries that extract valuable insights from large datasets.

The project is ideal for data analysts looking to enhance their SQL skills by working with a large-scale dataset and solving real-world business questions.

## Entity Relationship Diagram (ERD)

![ERD](https://github.com/najirh/Apple-Retail-Sales-SQL-Project---Analyzing-Millions-of-Sales-Rows/blob/main/erd.png)

## Database Schema

The project uses five main tables:

1. **stores**: Contains information about Apple retail stores.
   - `store_id`: Unique identifier for each store.
   - `store_name`: Name of the store.
   - `city`: City where the store is located.
   - `country`: Country of the store.

2. **category**: Holds product category information.
   - `category_id`: Unique identifier for each product category.
   - `category_name`: Name of the category.

3. **products**: Details about Apple products.
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.
   - `category_id`: References the category table.
   - `launch_date`: Date when the product was launched.
   - `price`: Price of the product.

4. **sales**: Stores sales transactions.
   - `sale_id`: Unique identifier for each sale.
   - `sale_date`: Date of the sale.
   - `store_id`: References the store table.
   - `product_id`: References the product table.
   - `quantity`: Number of units sold.

5. **warranty**: Contains information about warranty claims.
   - `claim_id`: Unique identifier for each warranty claim.
   - `claim_date`: Date the claim was made.
   - `sale_id`: References the sales table.
   - `repair_status`: Status of the warranty claim (e.g., Paid Repaired, Warranty Void).

## Objectives

The project is split into three tiers of questions to test SQL skills of increasing complexity:

### Easy to Medium (10 Questions)

1. Find the number of stores in each country.
2. Calculate the total number of units sold by each store.
3. Identify how many sales occurred in December 2023.
4. Determine how many stores have never had a warranty claim filed.
5. Calculate the percentage of warranty claims marked as "Warranty Void".
6. Identify which store had the highest total units sold in the last year.
7. Count the number of unique products sold in the last year.
8. Find the average price of products in each category.
9. How many warranty claims were filed in 2020?
10. For each store, identify the best-selling day based on highest quantity sold.

### Medium to Hard (5 Questions)

11. Identify the least selling product in each country for each year based on total units sold.
12. Calculate how many warranty claims were filed within 180 days of a product sale.
13. Determine how many warranty claims were filed for products launched in the last two years.
14. List the months in the last three years where sales exceeded 5,000 units in the USA.
15. Identify the product category with the most warranty claims filed in the last two years.

### Complex (5 Questions)

16. Determine the percentage chance of receiving warranty claims after each purchase for each country.
17. Analyze the year-by-year growth ratio for each store.
18. Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
19. Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.
20. Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.

### Bonus Question

- Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6-12 months, 12-18 months, and beyond 18 months.

## Project Focus

This project primarily focuses on developing and showcasing the following SQL skills:

- **Complex Joins and Aggregations**: Demonstrating the ability to perform complex SQL joins and aggregate data meaningfully.
- **Window Functions**: Using advanced window functions for running totals, growth analysis, and time-based queries.
- **Data Segmentation**: Analyzing data across different time frames to gain insights into product performance.
- **Correlation Analysis**: Applying SQL functions to determine relationships between variables, such as product price and warranty claims.
- **Real-World Problem Solving**: Answering business-related questions that reflect real-world scenarios faced by data analysts.


## Dataset

- **Size**: 1 million+ rows of sales data.
- **Period Covered**: The data spans multiple years, allowing for long-term trend analysis.
- **Geographical Coverage**: Sales data from Apple stores across various countries.



Easy to Medium (10 Questions)
1. Find the number of stores in each country.
```sql
SELECT 
	country,
	count(*) AS total_store
FROM stores
GROUP BY 1
ORDER BY 1;
```
2. Calculate the total number of units sold by each store.
```sql
SELECT
  	st.store_id,
    st.store_name,
	SUM(s.quantity)
FROM sales AS s
JOIN stores AS st ON s.store_id=st.store_id
GROUP BY 1, 2;
```
3. Identify how many sales occurred in December 2023.
```sql
SELECT 
    to_char(sale_date,'dd-yyyy'),
	count(*) as total_sale
FROM sales
WHERE to_char(sale_date,'dd-yyyy')='12-2023'
GROUP BY 1;
```
4. Determine how many stores have never had a warranty claim filed.
```sql
SELECT 
COUNT(*)
FROM stores
WHERE store_id NOT IN(
	SELECT 
		DISTINCT s.store_id
	FROM sales as s
	RIGHT JOIN 
	warranty as w ON w.sale_id = s.sale_id
);

```
5. Calculate the percentage of warranty claims marked as "Warranty Void".
```sql
SELECT
     ROUND(COUNT(*)/(SELECT COUNT(*) FROM warranty)::numeric * 100,2)
FROM warranty
WHERE repair_status='Warranty Void';
```
6. Identify which store had the highest total units sold in the last year.
```sql
SELECT
	st.store_id,
	SUM(s.quantity) as total_units
FROM sales as s
JOIN 
stores as st on s.store_id=st.store_id
WHERE s.sale_date >= current_date - INTERVAL '1 year'
GROUP BY 1;
```
7. Count the number of unique products sold in the last year.
```sql
SELECT
    p.product_id,
	p.product_name,
	COUNT(s.product_id)
FROM sales AS s
JOIN 
products AS p ON p.product_id = s.product_id
WHERE s.sale_date >= current_date - INTERVAL '1 year'
GROUP BY 1;
```
8. Find the average price of products in each category.
```sql
SELECT 
    category_id,
	AVG(price) as average_price
FROM products
GROUP BY 1
ORDER BY 1;
```
9. How many warranty claims were filed in 2020?
```sql
SELECT 
	COUNT(*)
FROM warranty
WHERE EXTRACT(YEAR FROM claim_date) = 2020;
```
10. For each store, identify the best-selling day based on highest quantity sold.
```sql
SELECT 
	*
FROM
(
	SELECT   
		store_id,
		to_char(sale_date, 'DAY') AS best_day,
		SUM(quantity) AS total_sale,
		RANK() OVER(PARTITION BY store_id ORDER BY SUM(quantity) DESC ) as rank
	FROM sales
	GROUP BY 1,2
) as t1
WHERE rank=1
```
11. Identify the least selling product in each country for each year based on total units sold.
```sql
SELECT 
* FROM
(
	SELECT 
		st.country,
		p.product_name,
		SUM(s.quantity),
			RANK() OVER(PARTITION BY st.country ORDER BY SUM(quantity)) as rank
	FROM sales AS s
	JOIN products AS p ON s.product_id=p.product_id
	JOIN 
	stores AS st ON s.store_id=st.store_id
	GROUP BY 1,2
)
WHERE rank =1
```
12. Calculate how many warranty claims were filed within 180 days of a product sale.
```sql
SELECT 
	COUNT(*)
FROM warranty AS w 
RIGHT JOIN
sales AS s ON w.sale_id=s.sale_id
WHERE w.claim_date -s.sale_date <=180
```
13. Determine how many warranty claims were filed for products launched in the last two years.
```sql
SELECT 
	p.product_name,
	COUNT(w.claim_id) as no_claim,
	COUNT(s.sale_id)
FROM warranty AS w 
RIGHT JOIN
sales AS s ON w.sale_id=s.sale_id
JOIN
products AS p ON s.product_id=p.product_id
WHERE p.launch_date >=  CURRENT_DATE - INTERVAL '2 YEAR'
GROUP BY 1
```
14. List the months in the last three years where sales exceeded 500 units in the USA.
```sql
SELECT 
	TO_CHAR(s.sale_date,'DD-YYYY'),
	SUM(s.quantity) as total_unit_sold
FROM sales AS s 
JOIN 
stores AS st ON s.store_id = st.store_id
WHERE
	st.country='USA'
	AND
	s.sale_date >= CURRENT_DATE - INTERVAL '3 YEAR'
GROUP BY 1
HAVING SUM(s.quantity)>500
```
15. Identify the product category with the most warranty claims filed in the last two years.
```sql
SELECT 
	c.category_name,
	count(w.claim_id)
FROM warranty AS w 
RIGHT JOIN
sales AS s ON w.sale_id=s.sale_id
JOIN
products AS p ON s.product_id=p.product_id
JOIN category AS c ON p.category_id = c.category_id
WHERE w.claim_date >=  CURRENT_DATE - INTERVAL '2 YEAR'
GROUP BY 1;
```
16. Determine the percentage chance of receiving warranty claims after each purchase for each country.
```sql
SELECT 
  	country,
	total_unit_sold,  
	total_claim,
	COALESCE(total_claim::numeric / total_unit_sold::numeric * 100,0)
	AS risk
FROM
(
	SELECT 
		st.country,
		SUM(s.quantity) AS total_unit_sold,
		COUNT(w.claim_id) as total_claim
	FROM sales as s
	JOIN
	stores as st ON s.store_id = st.store_id
	LEFT JOIN
	warranty as w ON w.sale_id = s.sale_id
	GROUP BY 1
	ORDER BY 3 DESC
) t1
```
-- 17. Analyze the year-by-year growth ratio for each store.
```sql
WITH yearly_sales
AS
(
	SELECT
		s.store_id,
		st.store_name,
		EXTRACT(YEAR FROM sale_date) AS year,
		SUM(s.quantity * p.price) as total_sale
	FROM sales AS s
	JOIN
	products as p
	ON s.product_id = p.product_id
	JOIN stores as st
	ON st.store_id = s.store_id
	GROUP BY 1,2,3
	ORDER BY 2,3
),
growth_ratio
AS
(
SELECT
	store_name,
	year,
	LAG(total_sale,1) OVER(PARTITION BY store_name ORDER BY year) as last_year_sale,
	total_sale as current_year_sale
FROM yearly_sales
)
SELECT
	store_name,
	year,
	last_year_sale,
    current_year_sale,
   ROUND((current_year_sale - last_year_sale)::numeric/last_year_sale::numeric *100,3) as growth_ratio
FROM growth_ratio
WHERE 
	last_year_sale IS NOT NULL
	AND
	YEAR <> EXTRACT(YEAR FROM CURRENT_DATE);
  ```
18. Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
```sql
SELECT 
	CASE
	 	WHEN p.price < 500 THEN 'Less Expensive Product'
		WHEN p.price BETWEEN 500 AND 1000 THEN 'Mid Range Product'
		ELSE 'Expensive Product'
		END AS product_segment,
	COUNT(w.claim_id) as total_claim
FROM warranty as w
LEFT JOIN
sales as s
ON w.sale_id=s.sale_id
JOIN
products as p
ON p.product_id=s.product_id
WHERE claim_date >= CURRENT_DATE - INTERVAL '5 year'
GROUP BY 1;
```


## 🛠 SQL Concepts Used

- `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`
- Multi-table `JOIN`s (4 tables)
- Subqueries and `NOT EXISTS`
- CTEs (`WITH`)
- Window functions — `RANK() OVER (PARTITION BY …)`
- Conditional aggregation — `COUNT(*) FILTER (WHERE …)`
- Date functions — `EXTRACT`, `DATE_TRUNC`, `TO_CHAR`, `INTERVAL`, date arithmetic

---

## 👤 Author

**Muhammad Numan Ahmed**

- GitHub: [@numanahmed0](https://github.com/numanahmed0)
- LinkedIn: [Numan Ahmed](https://www.linkedin.com/in/numan-ahmed-309819283)

⭐ If you found this project useful, consider giving it a star!
