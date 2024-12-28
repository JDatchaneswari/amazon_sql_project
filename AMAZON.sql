--ADVANCE DATA ANALYSIS PROJECT -- AMAZON DATASET

--CREATING TABLE

DROP TABLE IF EXISTS amazon;
CREATE TABLE amazon (
InvoiceID VARCHAR(30),
Branch VARCHAR(5),
City VARCHAR(30),
Customer_type VARCHAR(10),
Gender VARCHAR(10),
Product_line VARCHAR(100),
Unit_price DECIMAL(10,2),
Quantity INT,
Tax DECIMAL(6,4),
Total DECIMAL(10,2),
Date Date,
Time Time,
Payment VARCHAR(20),
cogs DECIMAL(10,2),
gross_margin_percentage DECIMAL(11,9),
gross_income DECIMAL(10,2),
Rating DECIMAL(2,1)
);

--ALTERING TABLE

ALTER TABLE amazon ALTER COLUMN rating TYPE NUMERIC(3, 1);

--ADDING DAYNAME COLUMN

ALTER TABLE AMAZON 
ADD COLUMN DAYNAME VARCHAR(20);

UPDATE AMAZON
SET DAYNAME=TO_CHAR(DATE,'DAY');

--ADD MONTHNAME COLUMN

ALTER TABLE AMAZON
ADD COLUMN MONTHNAME VARCHAR(20);

UPDATE AMAZON
SET MONTHNAME=TO_CHAR(DATE,'MONTH');

--ADD TIMEOFDAY COLUMN

ALTER TABLE AMAZON
ADD COLUMN TIMEOFDAY VARCHAR(20);

UPDATE AMAZON
SET TIMEOFDAY =
CASE WHEN EXTRACT(HOUR FROM TIME)>=0 AND EXTRACT(HOUR FROM TIME)<6 THEN 'NIGHT'
     WHEN EXTRACT(HOUR FROM TIME)>=6 AND EXTRACT(HOUR FROM TIME)<12 THEN 'MORNING'
     WHEN EXTRACT(HOUR FROM TIME)>=12 AND EXTRACT(HOUR FROM TIME)>18 THEN 'AFTERNOON'
ELSE 'EVENING'
END;


--COPYING 

COPY amazon FROM 'C:\Users\Admin\Desktop\SQL\AMAZON_DATA_ANALYSIS\Amazon Dataset (1).csv' with csv header;

--EDA

SELECT * FROM AMAZON;
select count(*) from amazon;

--28 BUISNESS PROBLEMS --

--Q1.	What is the count of distinct cities in the dataset?

SELECT COUNT(DISTINCT CITY) AS CITY_COUNT FROM AMAZON;

--Q2.	For each branch, what is the corresponding city?

SELECT BRANCH,CITY FROM AMAZON
GROUP BY BRANCH,CITY
ORDER BY BRANCH;

--Q3.	What is the count of distinct product lines in the dataset?

SELECT COUNT(DISTINCT PRODUCT_LINE) FROM AMAZON;
SELECT DISTINCT PRODUCT_LINE,COUNT(PRODUCT_LINE)AS NO_OF_ORDERS
FROM AMAZON
GROUP BY PRODUCT_LINE;

--Q4.	Which payment method occurs most frequently?

SELECT PAYMENT,COUNT(PAYMENT)AS COUNT_OF_PAYMENT FROM AMAZON
GROUP BY PAYMENT
ORDER BY COUNT_OF_PAYMENT DESC LIMIT 1;

--Q5.	Which product line has the highest sales?

SELECT PRODUCT_LINE,SUM(TOTAL) AS TOTAL_SALES
FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY TOTAL_SALES DESC LIMIT 1;

--Q6.	How much revenue is generated each month?

SELECT EXTRACT(MONTH FROM DATE)AS MONTH,
EXTRACT(YEAR FROM DATE)AS YEAR,SUM(TOTAL)AS REVENUE FROM AMAZON
GROUP BY MONTH,YEAR
ORDER BY MONTH;

--Q7.	In which month did the cost of goods sold reach its peak?

SELECT EXTRACT(MONTH FROM DATE)AS MONTH,SUM(COGS) AS COGS_TOTAL FROM AMAZON
GROUP BY MONTH
ORDER BY COGS_TOTAL DESC LIMIT 1;

--Q8.	Which product line generated the highest revenue?

SELECT PRODUCT_LINE , SUM(TOTAL) AS REVENUE FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY REVENUE DESC LIMIT 1;

--Q9.	In which city was the highest revenue recorded?

SELECT CITY,SUM(TOTAL) AS REVENUE FROM AMAZON
GROUP BY CITY
ORDER BY REVENUE DESC LIMIT 1;

--Q10.	Which product line incurred the highest Value Added Tax?

SELECT PRODUCT_LINE,SUM(TAX) AS VALUE_ADDED_TAX
FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY VALUE_ADDED_TAX DESC LIMIT 1;

--Q11.	For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT PRODUCT_LINE,
CASE WHEN SUM(TOTAL)>AVG(TOTAL) THEN 'GOOD' ELSE 'BAD' END AS CATEGORY
FROM AMAZON
GROUP BY PRODUCT_LINE;

--Q12.	Identify the branch that exceeded the average number of products sold.

SELECT BRANCH,SUM(QUANTITY) AS TOTAL_PRODUCTS_SOLD FROM AMAZON
GROUP BY BRANCH
HAVING SUM(QUANTITY)>(SELECT AVG(QUANTITY) FROM AMAZON)
ORDER BY TOTAL_PRODUCTS_SOLD DESC LIMIT 1;

--Q13.	Which product line is most frequently associated with each gender?

WITH CTE AS( 
SELECT GENDER,PRODUCT_LINE,
COUNT(PRODUCT_LINE)AS COUNT_OF_PRODUCT,
ROW_NUMBER() OVER (PARTITION BY GENDER ORDER BY COUNT(*)DESC)AS ROW_NUM
FROM AMAZON
GROUP BY PRODUCT_LINE,GENDER)
SELECT 
PRODUCT_LINE,GENDER,COUNT_OF_PRODUCT
FROM CTE WHERE ROW_NUM=1;

--Q14.	Calculate the average rating for each product line.

select product_line,round(avg(rating),3) as avg_rating from amazon
group by product_line;

--Q15.	Count the sales occurrences for each time of day on every weekday.

SELECT TIMEOFDAY,DAYNAME,COUNT(*) AS SALES_OCCURRENCE
FROM AMAZON
GROUP BY TIMEOFDAY,DAYNAME
ORDER BY SALES_OCCURRENCE DESC;

--Q16.  Identify the customer type contributing the highest revenue.

SELECT CUSTOMER_TYPE,SUM(TOTAL)AS REVENUE
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY REVENUE DESC LIMIT 1;

--Q17.	Determine the city with the highest VAT percentage.

SELECT CITY,MAX(TAX) AS HIGH_VAT
FROM AMAZON
GROUP BY CITY
ORDER BY HIGH_VAT DESC LIMIT 1;

--Q18.	Identify the customer type with the highest VAT payments.

SELECT CUSTOMER_TYPE,SUM(TAX) AS HIGH_VAT
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY HIGH_VAT DESC LIMIT 1;

--Q19.	What is the count of distinct customer types in the dataset?

SELECT CUSTOMER_TYPE,COUNT(DISTINCT CUSTOMER_TYPE)FROM AMAZON
GROUP BY CUSTOMER_TYPE;

--Q20.	What is the count of distinct payment methods in the dataset?

SELECT PAYMENT,COUNT(DISTINCT PAYMENT)FROM AMAZON 
GROUP BY PAYMENT;

--Q21.	Which customer type occurs most frequently?

SELECT CUSTOMER_TYPE AS MOST_FREQUENTLY_OCCUR,COUNT(*) AS FREQUENCY
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY COUNT(*) DESC LIMIT 1;

--Q22.	Identify the customer type with the highest purchase frequency.

SELECT CUSTOMER_TYPE AS HIGHEST_PURCHASE_FREQUENCY,COUNT(*)  AS FREQUENCY
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY COUNT(*) DESC LIMIT 1;

--Q23.	Determine the predominant gender among customers.

SELECT GENDER,COUNT(*) AS NO_OF_MEMBERS FROM AMAZON
GROUP BY GENDER
ORDER BY NO_OF_MEMBERS DESC LIMIT 1;

--Q24.	Examine the distribution of genders within each branch.

SELECT BRANCH,GENDER,COUNT(*) AS NUMBER_OF_MEMBERS
FROM AMAZON
GROUP BY BRANCH,GENDER
ORDER BY NUMBER_OF_MEMBERS DESC;

--Q25.	Identify the time of day when customers provide the most ratings.

SELECT TIMEOFDAY,COUNT(RATING) AS MOST_RATING
FROM AMAZON
GROUP BY TIMEOFDAY
ORDER BY MOST_RATING DESC LIMIT 1;

--Q26.	Determine the time of day with the highest customer ratings for each branch.

SELECT TIMEOFDAY,MAX(RATING)AS HIGH_RATING
FROM AMAZON
GROUP BY TIMEOFDAY
ORDER BY HIGH_RATING DESC LIMIT 5;

--Q27.	Identify the day of the week with the highest average ratings.

SELECT dayname, ROUND(AVG(Rating), 3) AS Highest_Average_Rating
FROM amazon
GROUP BY dayname
ORDER BY Highest_Average_Rating DESC
LIMIT 1;

--Q28.	Determine the day of the week with the highest average ratings for each branch.

SELECT Branch, DayOfWeek, AvgRating
FROM (
    SELECT 
        Branch, 
        TO_CHAR(Date, 'Day') AS DayOfWeek, 
        ROUND(AVG(Rating), 3) AS AvgRating,
        ROW_NUMBER() OVER (PARTITION BY Branch ORDER BY AVG(Rating) DESC) AS rn
    FROM amazon
    GROUP BY Branch, TO_CHAR(Date, 'Day')
) AS ranked
WHERE rn = 1;


