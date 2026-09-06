# Maven Fuzzy Factory — SQL Business Analysis

## Project Overview

This project analyzes the Maven Fuzzy Factory e-commerce business using SQL to understand sales performance, product performance, website traffic, conversion behavior, customer purchasing patterns, and refunds.

The analysis combines transactional, product, website session, pageview, and refund data to identify business trends and provide actionable recommendations for improving revenue, customer retention, marketing performance, and product performance.

The project demonstrates practical SQL skills including data quality validation, exploratory data analysis, joins, aggregations, subqueries, Common Table Expressions (CTEs), and window functions.

---

## Business Problem

The business needs to understand how sales, products, website traffic, customer behavior, marketing sources, and refunds are performing over time.

The analysis focuses on identifying the strongest revenue drivers, understanding conversion and repeat-session behavior, evaluating product and marketing performance, and identifying areas where the business can improve revenue and customer retention.

---

## Dataset

The Maven Fuzzy Factory dataset contains e-commerce transaction and website activity data across six tables:

* `orders` — order-level sales information
* `order_items` — individual products purchased within orders
* `order_item_refunds` — refunded order items and refund amounts
* `products` — product information
* `website_sessions` — website session and marketing information
* `website_pageviews` — website pageview activity

The analysis covers data from March 2012 to March 2015.

---

## Tools & Technologies

* **MySQL** — data analysis and SQL querying
* **GitHub** — project documentation and version control

---

## SQL Skills Demonstrated

* Data quality checks
* Exploratory Data Analysis (EDA)
* Joins
* Aggregations
* `GROUP BY` and `HAVING`
* Subqueries
* Common Table Expressions (CTEs)
* Window functions
* Ranking
* Business KPI analysis

---

## Business Questions

The analysis answers 10 key business questions:

1. **Overall Sales Performance**
   What are the total orders, total revenue, total items sold, and average order value?

2. **Sales Trend Over Time**
   How have orders and revenue changed over time?

3. **Product Performance**
   Which products generated the most orders and revenue?

4. **Product Revenue Contribution**
   What percentage of total product revenue does each product contribute?

5. **Marketing Source Performance**
   Which marketing sources generate the highest number of sessions and orders?

6. **Website Conversion Performance**
   Which marketing sources have the highest conversion rates?

7. **New vs Repeat Sessions**
   How do new and repeat visitors differ in sessions, orders, and conversion rate?

8. **Customer Order Behavior**
   Which customers have the highest total spending, and how does their order behavior differ?

9. **Refund Analysis**
   Which products have the highest refund amounts and refund rates?

10. **Advanced Business Analysis**
    Which products generate revenue above the average product revenue benchmark?

---

## Key Findings

### Overall Business Performance

* **32,313 total orders**
* **$1.94M total revenue**
* **40,025 items sold**
* **$59.99 average order value**
* **472,871 website sessions**
* **394,318 unique users**
* **6.83% overall conversion rate**
* **1,731 refunded items**
* **$85,338.69 total refunded amount**

Sales showed a strong upward trend across the analysis period.

**December 2014** was the strongest full month, generating **2,314 orders** and **$144,823.02 in revenue**.

> Note: March 2015 is a partial month and is therefore not treated as a comparable full-month decline.

---

### Product Performance

| Product                    | Orders |       Revenue | Revenue Contribution |
| -------------------------- | -----: | ------------: | -------------------: |
| The Original Mr. Fuzzy     | 24,226 | $1,211,057.74 |           **62.47%** |
| The Forever Love Bear      |  5,796 |   $347,702.04 |               17.94% |
| The Birthday Sugar Panda   |  4,985 |   $229,260.15 |               11.83% |
| The Hudson River Mini bear |  5,018 |   $150,489.82 |                7.76% |

**Key finding:** The Original Mr. Fuzzy was the dominant product, generating **$1.21M** in revenue and contributing **62.47% of total product revenue**.

It was also the **only product above the average product-revenue benchmark**.

---

### Marketing & Conversion Performance

| Marketing Source | Sessions | Orders | Conversion Rate |
| ---------------- | -------: | -----: | --------------: |
| gsearch          |  316,035 | 21,333 |           6.75% |
| Direct           |   83,328 |  6,118 |       **7.34%** |
| bsearch          |   62,823 |  4,519 |           7.19% |
| socialbook       |   10,685 |    343 |       **3.21%** |

**Key findings:**

* **gsearch** generated the highest traffic and order volume.
* **Direct** achieved the highest conversion rate at **7.34%**.
* **socialbook** had the lowest conversion rate at **3.21%**.

This demonstrates that traffic volume and conversion efficiency are not necessarily the same.

---

### New vs Repeat Visitors

| Session Type | Sessions | Orders | Conversion Rate |
| ------------ | -------: | -----: | --------------: |
| Repeat       |   78,553 |  6,149 |       **7.83%** |
| New          |  394,318 | 26,164 |           6.64% |

**Key finding:** Repeat visitors converted at a higher rate than new visitors, highlighting the importance of customer retention and repeat purchases.

---

### Customer Behavior

Customer value varies based on:

* Order frequency
* Total spending
* Average order value

The highest-value customers were identified using total spending and order behavior to help understand customer purchasing patterns.

---

### Refund Performance

| Product                    | Refunded Items | Refund Amount | Refund Rate |
| -------------------------- | -------------: | ------------: | ----------: |
| The Original Mr. Fuzzy     |          1,237 |    $61,837.63 |       5.11% |
| The Birthday Sugar Panda   |            301 |    $13,842.99 |   **6.04%** |
| The Forever Love Bear      |            129 |     $7,738.71 |       2.23% |
| The Hudson River Mini bear |             64 |     $1,919.36 |       1.28% |

**Key findings:**

* Mr. Fuzzy had the highest total refund amount at **$61,837.63**, largely reflecting its much higher sales volume.
* Birthday Sugar Panda had the highest refund rate at **6.04%**, indicating a potential product or customer-experience issue.
* Total refunds across the dataset amounted to **$85,338.69**.

---

## Business Insights

### 1. Revenue is highly concentrated around Mr. Fuzzy

The Original Mr. Fuzzy contributes **62.47% of product revenue**, making it the primary revenue driver while also creating dependency on one product.

### 2. Customer retention is valuable

Repeat sessions have a higher conversion rate than new sessions, indicating that returning visitors are more likely to purchase.

### 3. Marketing efficiency differs from traffic volume

gsearch generates the highest order volume, while Direct traffic achieves the highest conversion rate.

Marketing decisions should therefore consider conversion quality rather than traffic volume alone.

### 4. Refund performance requires product-level attention

Birthday Sugar Panda has the highest refund rate, while Mr. Fuzzy has the highest total refund amount because of its much larger sales volume.

### 5. There is an opportunity to increase average order value

Cross-selling, bundles, and complementary product offers could help increase revenue per order.

---

## Stakeholder Recommendations

1. **Protect the leading revenue driver**
   Prioritize inventory availability and operational reliability for The Original Mr. Fuzzy.

2. **Diversify product revenue**
   Develop strategies to increase sales of the other products and reduce dependence on a single product.

3. **Strengthen customer retention**
   Use repeat-purchase campaigns, personalized offers, and customer re-engagement strategies to encourage returning customers.

4. **Optimize marketing based on conversion efficiency**
   Continue evaluating gsearch for volume while investigating why Direct converts better and why socialbook has a substantially lower conversion rate.

5. **Investigate Birthday Sugar Panda refunds**
   Analyze customer feedback, product quality, fulfillment, and return reasons to understand the high refund rate.

6. **Increase average order value**
   Test product bundles, cross-sells, and complementary product recommendations.

7. **Monitor product-level profitability and refunds together**
   Revenue alone should not determine product priorities; future analysis should consider revenue, COGS, profit, and refunds together.

---

## Advanced SQL Analysis

The project also demonstrates advanced SQL techniques to move beyond basic aggregations.

### Common Table Expression (CTE)

A CTE was used to calculate revenue by product and compare each product's revenue against the average product revenue.

This improves query organization and makes multi-step analysis easier to read and maintain.

### Window Functions

Window functions were used to calculate the average product revenue across the result set and measure each product's difference from that benchmark.

### Revenue Ranking

The `RANK()` window function was used to rank products based on revenue performance.

Revenue ranking:

1. **The Original Mr. Fuzzy**
2. **The Forever Love Bear**
3. **The Birthday Sugar Panda**
4. **The Hudson River Mini bear**

### Subqueries

Subqueries were used within the business analysis to calculate revenue contribution and identify products generating revenue above the average product revenue benchmark.

These techniques demonstrate the ability to apply SQL beyond basic filtering and aggregation for practical business analysis.

---

## Project Structure

```text
Maven-Fuzzy-Factory-SQL-Business-Analysis/
│
├── README.md
│
├── sql/
│   ├── 01_Database_Setup.sql
│   ├── 02_Data_Quality_and_EDA.sql
│   ├── 03_Business_Questions.sql
│   └── 04_Advanced_SQL.sql
│
└── data/
    └── README.md
```

---

## Project Conclusion

The analysis provides a comprehensive view of Maven Fuzzy Factory's sales, products, website traffic, marketing performance, customer behavior, and refunds.

The business generated **$1.94M in revenue from 32,313 orders**, with The Original Mr. Fuzzy serving as the primary revenue driver. The analysis also identified stronger conversion among repeat visitors, differences between marketing traffic volume and conversion efficiency, and product-level refund opportunities.

The findings and recommendations provide a data-driven foundation for improving customer retention, marketing effectiveness, product performance, revenue diversification, and overall business growth.

This project demonstrates how SQL can be used to transform raw e-commerce data into actionable business insights for stakeholders.

