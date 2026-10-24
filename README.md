# 🍎 Apple Sales Analysis — SQL Project (PostgreSQL)

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16%2B-336791?logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange)
![Rows](https://img.shields.io/badge/Sales%20Rows-1.04M-brightgreen)
![Level](https://img.shields.io/badge/Level-Beginner%20to%20Advanced-blue)

A SQL project built on a **1M+ row Apple retail dataset** (stores, categories, products, sales and warranty claims). It answers **15 business questions** — from simple aggregations to window functions, CTEs and multi-table joins — covering store performance, product trends and warranty behaviour.
Apple Sales Analysis
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
Medium to Hard (5 Questions)
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
