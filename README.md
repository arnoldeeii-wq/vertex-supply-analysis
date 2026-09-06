# Supply Chain Performance Analysis

## Project Overview
### Vertex Supply Chain Ltd. imports and distributes consumer goods to warehouses across the country. The task is to generate business insights by querying the data that had been cleaned beforehand by the data engineering team. 


## Key Business Questions
Management wants to understand:
* Which suppliers contribute the most value to the business.
* Which products generate the highest profits.
* Which product categories perform best.
* Which warehouses handle the largest inventory volumes.
* How transportation costs affect profitability.
* Which suppliers consistently perform well over time.
* How shipment performance changes throughout the year.

## Dataset
- [Suppliers](suppliers.csv)
- [Products](products.csv)
- [Shipments](shipments.csv)

## SQL Analysis
The analysis was divided into 6 main areas:

### 1. Business KPIs
The business KPI analysis measures overall supply chain performance, including:

- Total inventory received
- Total damaged products
- Potential revenue
- Net revenue
- Gross profit
- Net profit
- Total inventory cost
- Profit margin
- Revenue lost due to damaged products
- Transportation cost
- Damage rate

- [Business KPIs](Business_kpis.sql)


### 2. Product Analysis
Analysis of product profitability, loss-making products, category performance and product damage rates.
-  [Product Analysis](product_sql.sql)


### 3. Supplier Analysis
Analysis of supplier profitability, loss-making suppliers, supplier performance and transportation costs.
-  [Supplier Analysis](supplier_analysis.sql)


### 4. Warehouse & Shipment Analysis
Analysis of inventory volumes, warehouse performance and shipment trends over time.
- [Warehouse and Shipment Analysis](warehouse_analysis.sql)




## Key Findings

### Company KPIs

* Potential sales revenue from all units received was **$15.44M**.
* Revenue from sellable inventory was **$15.05M**, after excluding damaged goods.
* Approximately **$390.7K** in potential sales revenue was associated with damaged goods.
* A total of **297,072 units** were received, of which **289,580 units** were sellable.
* **7,492 units** were damaged, representing an overall damage rate of **2.52%**.
* Gross profit from sellable inventory was approximately **$6.47M**.
* After deducting **$1.88M** in transportation costs, net profit was approximately **$4.59M**.
* The overall **net profit margin was 30.48%**.


### Product Analysis

* **Office Item 58** generated the highest revenue among individual products at **$316,620**, followed by **Kitchen Item 99** at approximately **$302,000**.
* Office Item 58 and Kitchen Item 99 also generated the highest individual profits, at approximately **$123,411** and **$117,244**, respectively.
* **Office Item 58 had the lowest unit logistics cost** among the highlighted products at **$4.80**, while Kitchen Item 99 had a unit logistics cost of **$5.22**. Their strong financial performance combined with relatively low logistics costs contributes positively to their profitability.
* **Accessory Item 75** had a relatively high unit logistics cost of **$8.03** and generated approximately **$59,139** in profit. Its logistics cost is substantially higher than that of the top-performing products, indicating a potential opportunity to review its transportation efficiency and overall profitability.
* Several products generated **negative profits**, with **Accessory Item 60 (-$6,545)** recording the largest loss, followed by **Accessory Item 20 (-$6,527)** and **Accessory Item 80 (-$5,989)**.
* The loss-making products were concentrated primarily among **Accessories**, although **Electronic Items 21, 61, and 81** also recorded negative profits.
* **Accessory Item 60 and Accessory Item 20** represent the weakest individual products by profit and should be reviewed for potential discontinuation, repricing, cost reduction, or supplier renegotiation.
* Among the products listed, **Accessory Item 20** also had the lowest revenue at approximately **$22,338**, reinforcing the need to assess whether continued inventory allocation is justified.

### Category Analysis

* **Kitchen products generated the highest category revenue** at approximately **$3.52M**, followed by Office Supplies at **$3.27M** and Home Appliances at **$3.02M**.
* **Accessories generated the lowest category revenue** at approximately **$2.50M**.
* Kitchen products also generated the highest category profit at approximately **$1.19M**, with a **33.73% profit margin**.
* Office Supplies generated approximately **$1.07M** in profit with a **32.85% margin**, while Home Appliances generated **$964.9K** at a **31.94% margin**.
* Electronics generated approximately **$846.2K** in profit with a **30.80% margin**, while Accessories recorded the lowest profit at approximately **$733.8K** and the lowest margin at **29.39%**.
* The **Kitchen category is the strongest overall category**, leading in both revenue and profit while also maintaining the highest profit margin.
* **Accessories are the weakest-performing category**, ranking last in revenue, profit, and profit margin.
* Electronics recorded the **highest number of damaged units (1,524)**, followed by Accessories (**1,508**) and Home Appliances (**1,500**).
* Office Supplies had the **lowest damage count (1,476)** among the five categories, while Kitchen products recorded **1,484 damaged units** despite being the highest-revenue category.








## SQL Techniques Used
*  Multi-table JOINs
*  CTEs
*  Subqueries
*  Aggregation
*  Conditional logic (CASE)
*  Data cleaning
*  Date/string manipulation
*  NULL handling
*  Filtering
*  Calculated business metrics

## Key Findings
* Metro Components leads in profit contribution with a profit margin of 36.43%
* PeakBlue Suppliers have the highest damaged goods count
* Infinity Sourcing and Alpha Manufacturing close the year in negative profits. 
* Office Supply Item 58 had the highest revenue potential at 324720, with a gross profit of 136220
* Kitchen products led the profitability line with a figure of 1187738
* Ibadan warehouse had the highest shipping volume with 59648 goods received
* Port-Harcourt warehouse incurred the highest transportation cost with 378720
* Average damage percentage is 2.56%. Electronics have the highest count: 1,524

## Recommendations
* Transportation accounts for about 50% of the production cost. It's fair, with room for improvement.
* When compared against the average profit, Metro Components leads the suppliers with a decent profit margin and a good return above average. 
* Horizon Industrial Co., Excel Procurement Ltd., Sterling Manufacturing, Atlas Supply Group, & Metro Components are the top five suppliers, each with above $380k in profits.
* While Alpha Manufacturing's profit could be preserved with better transportation handling, Infinity Sourcing still isn't profitable, even with projected revenue without damaged goods. 

## Screenshots
* [Profitability Table](profitability_table.png)
* [Suppliers Logistics Cost](Suppliers_logistics_cost.png)
* [Gross Profit](gross_profit.png)
* [Products Profit Rank](products_profit_rank.png)
* [Revenue Potential](revenue_potential.png)
* [Gross Revenue](Gross_revenue.png)
