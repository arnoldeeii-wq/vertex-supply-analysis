# Supply Chain Performance Analysis

## Project Overview
### Vertex Supply Chain Ltd. imports and distributes consumer goods to warehouses across the country. The task is to generate business insights by querying the data that had been cleaned beforehand by the data engineering team. 

## Objectives
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

## Database Schema
- [Script](vertex_company_main_script.sql)

  
## Key Business Questions
Which suppliers are contributing the most to overall profitability?
Which suppliers have the highest shipment damage rates?
Which suppliers provide the best balance of profitability, reliability, and lead time?
Which products generate the highest gross profit and revenue potential?
Which product categories are the most profitable?
Which warehouses handle the highest shipment volumes?
Which warehouses have the highest transportation costs?
How significant are damaged units across the supply chain, and which areas have the highest damage rates?
How does transportation cost affect overall profitability?
Which suppliers or products should management prioritize for improvement or expansion?


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
* [Profitability Table](Profitability_table.png)
* [Suppliers Logistics Cost](Suppliers_logistics_cost.png)
* [Gross Profit](gross_profit.png)
* [Products Profit Rank](products_profit_rank.png)
* [Revenue Potential](revenue_potential.png)
