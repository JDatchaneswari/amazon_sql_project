# Amazon-sales-analysis-with-SQL


![image](https://github.com/JDatchaneswari/amazon_sql_project/blob/main/amazon.jpg)

# OBJECTIVE
In today's competitive business landscape, effective sales management is crucial for reducing costs and maximizing profits. The project aims to analyze sales data from Amazon to identify areas for improvement and strategic changes. By examining this data, businesses can pinpoint inefficiencies in their operations, identify areas of loss, and develop strategies to mitigate these losses. Ultimately, this project will provide valuable insights to help businesses optimize their sales performance and achieve greater success in the marketplace.

# ABOUT DATA
The document contains sales data for various branches in Yangon, Naypyitaw, and Mandalay including information on customer types, products, prices, quantities and payment methods. The sales data shows a variety of product lines such as health and beauty, electronic accessories, home and lifestyle, foodand beverages, fashion accessories and sports and travel. The total sales amount for each transaction includes a 5% tax, cost of goodssold (COGS), gross margin percentage, and gross income. The ratings provided for each transaction range from 4.1 to 9.6 indicating the level of customer satisfaction with their purchases. The data contains 17 columns and 1000 rows.

![image](https://github.com/JDatchaneswari/amazon_sql_project/blob/main/Table.jpg)

# ANALYSIS LIST
## Product Analysis:
This analysis aims to understand the different product lines, the products lines performing best and the product lines that need to be improved.

## Sales Analysis:
This analysis aims to answer the question of the sales trends of product. The result of this can help us measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

## Customer Analysis:
This analysis aims to uncover the different customer segments, purchase trends and the profitability of each customer segment.

# APPROACH USED
## Data Wrangling:
This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace missing or NULL values.
1. Build a database
2. Create a table and insert the data.
3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT  NULL for each field, hence null values are filtered out.

## Feature Engineering:
This will help us generate some new columns from existing ones.
1. Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
2. Add a new column named dayname that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
3. Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

## Exploratory Data Analysis (EDA):
Exploratory data analysis is done to answer the business questions and aims of this project.

# KEY INSIGHTS
1. The product line that is the top-performing based on total sales is "Food and beverages" with the highest average customer rating 7.11.
2. The product line that needs improvement as it has the lowest total sales is "Health and beauty."
3. "Electronic accessories" has the highest total quantity sold (971 units) with an average unit price of approximately $53.55 and an average customer rating of 6.92.
4. "Health and beauty" has the lowest total quantity sold (854 units) with  an average unit price of approximately $54.85, and an average customer rating of 7.00.
5. Female customers who are members have the highest total sales, followed by male members. Non-member females and males have similar total sales.

# RECOMMENDATIONS
1. Increasing membership benefits could boost even more loyalty and sales. This can be done through personalized discounts, member-only sales events or reward points systems.
2. Invest more in the marketing and stock of the 'Food and beverages' as it is the top performer. This could include themed promotions.
3. Examine the non-member customers through marketing campaigns or incentive programs.
4. Encourage more customers to leave ratings and reviews. This can improve customer trust and increase sales.
5. In categories that are lagging in sales utilize customer feedback and sales data to inform the development of new products.

# REQUIREMENTS
### PGADMIN 4
For Data Analysis
