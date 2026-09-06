# Supply Chain Performance Analysis

## Project Overview

### Vertex Supply Chain Ltd. imports and distributes consumer goods to warehouses across the country. The objective of this project is to generate business insights by querying a cleaned dataset prepared by the data engineering team.

## Key Business Questions

Management wants to understand:

* Which suppliers contribute the most value to the business?
* Which products generate the highest profits?
* Which product categories perform best?
* Which warehouses handle the largest inventory volumes?
* How do transportation costs affect profitability?
* Which suppliers consistently perform well?
* How does shipment performance change throughout the year?

## Dataset

* [Suppliers](suppliers.csv)
* [Products](products.csv)
* [Shipments](shipments.csv)

## SQL Analysis

The analysis was divided into four main areas:

### 1. Business KPIs

The business KPI analysis measures overall supply chain performance, including:

* Total inventory received

* Total damaged products

* Potential revenue

* Net revenue

* Gross profit

* Net profit

* Total inventory cost

* Profit margin

* Revenue lost due to damaged products

* Transportation cost

* Damage rate

* [Business KPIs](Business_kpis.sql)

### 2. Product Analysis

Analysis of product profitability, loss-making products, category performance, and product damage rates.

* [Product Analysis](product_sql.sql)

### 3. Supplier Analysis

Analysis of supplier profitability, supplier performance, damage rates, lead times, and transportation costs.

* [Supplier Analysis](suppliers_analysis.sql)

### 4. Warehouse & Shipment Analysis

Analysis of inventory volumes, warehouse performance, transportation costs, and shipment trends over time.

* [Warehouse and Shipment Analysis](warehouse_analysis.sql)

# Key Findings

## Company KPIs

* Potential sales revenue from all units received was **$15.44M**.
* Revenue from sellable inventory was **$15.05M**, after excluding damaged goods.
* Approximately **$390.7K** in potential sales revenue was associated with damaged goods.
* A total of **297,072 units** were received, of which **289,580 units** were sellable.
* **7,492 units** were damaged, representing an overall damage rate of **2.52%**.
* Gross profit from sellable inventory was approximately **$6.47M**.
* After deducting **$1.88M** in transportation costs, net profit was approximately **$4.59M**.
* The overall **net profit margin was 30.48%**.

## Product Analysis

* **Office Item 58** generated the highest revenue among individual products at **$316,620**, followed by **Kitchen Item 99** at approximately **$302,000**.
* Office Item 58 and Kitchen Item 99 also generated the highest individual profits, at approximately **$123,411** and **$117,244**, respectively.
* **Office Item 58 had the lowest unit logistics cost** among the highlighted products at **$4.80**, while Kitchen Item 99 had a unit logistics cost of **$5.22**.
* **Accessory Item 75** had a relatively high unit logistics cost of **$8.03** and generated approximately **$59,139** in profit, indicating an opportunity to review its transportation efficiency and overall profitability.
* Several products generated **negative profits**, with **Accessory Item 60 (-$6,545)** recording the largest loss, followed by **Accessory Item 20 (-$6,527)** and **Accessory Item 80 (-$5,989)**.
* Loss-making products were concentrated primarily among **Accessories**, although **Electronic Items 21, 61, and 81** also recorded negative profits.
* **Accessory Item 20** had the lowest revenue among the listed products at approximately **$22,338**, reinforcing the need to assess whether continued inventory allocation is justified.

## Category Analysis

* **Kitchen products generated the highest category revenue** at approximately **$3.52M**, followed by Office Supplies at **$3.27M** and Home Appliances at **$3.02M**.
* **Accessories generated the lowest category revenue** at approximately **$2.50M**.
* Kitchen products also generated the highest category profit at approximately **$1.19M**, with a **33.73% profit margin**.
* Office Supplies generated approximately **$1.07M** in profit with a **32.85% margin**, while Home Appliances generated **$964.9K** at a **31.94% margin**.
* Electronics generated approximately **$846.2K** in profit with a **30.80% margin**, while Accessories recorded the lowest profit at approximately **$733.8K** and the lowest margin at **29.39%**.
* The **Kitchen category is the strongest overall category**, leading in revenue, profit, and profit margin.
* **Accessories are the weakest-performing category**, ranking last in revenue, profit, and profit margin.
* Electronics recorded the **highest number of damaged units (1,524)**, followed by Accessories (**1,508**) and Home Appliances (**1,500**).
* Office Supplies had the **lowest damage count (1,476)** among the five categories.

## Supplier Analysis

* **Metro Components** generated the highest inventory value at approximately **$1.36M**, followed by **Atlas Supply Group ($1.29M)** and **Sterling Manufacturing ($1.25M)**.
* The same three suppliers also made the largest contributions to profit, generating approximately **$604K**, **$575K**, and **$554K**, respectively.
* **Infinity Sourcing** had the lowest inventory value at approximately **$129.4K** and the lowest profit contribution at approximately **$57.5K**.
* **Frontline Distributors** shipped the highest number of units at **15,240**, followed by **Pacific Source Ltd. (15,189)** and **Vertex Global Supply (15,138)**.
* **Global Supply Ltd.** recorded the lowest shipment volume among the suppliers at **14,394 units**.
* **Continental Traders** had the lowest damage rate at **1.94%**, followed by **Zenith Imports (2.01%)** and **Sterling Manufacturing (2.02%)**.
* **Prime Components** recorded the highest damage rate at **3.12%**, making it a potential area for supplier performance review.
* **Alpha Manufacturing** had the lowest total transportation cost at approximately **$83.7K**, followed by **Prime Components ($85.6K)** and **Infinity Sourcing ($85.8K)**.
* **Vertex Global Supply** incurred the highest logistics cost at approximately **$104.1K**, suggesting an opportunity to investigate transportation efficiency.
* **Zenith Imports** had the shortest average lead time at **8 days**, while **EverBright Manufacturing** had the longest at **16 days**.

## Warehouse / Logistics Analysis

* **Ibadan** received the highest volume of goods, with **59,648 units**, while **Port Harcourt** received the lowest at **59,254 units**.
* **Kano** held the highest inventory value at approximately **$3.52M**, followed by **Port Harcourt at $3.26M**.
* Despite receiving the highest number of units, **Ibadan had the lowest inventory value at approximately $2.50M**, indicating that its inventory consisted of relatively lower-value products.
* **Lagos** recorded the highest number of damaged goods at **1,524 units**, followed by **Ibadan (1,508)** and **Port Harcourt (1,476)**.
* Kano generated the highest profit at approximately **$1.19M**, while Ibadan generated the lowest at approximately **$733.8K**.
* Ibadan's lower profitability can be attributed to its concentration of **Accessory products**, which recorded the lowest revenue, profit, and profit margin among the categories.
* **Office Supplies** incurred the highest total logistics cost at approximately **$378.7K**, representing **11.6% of revenue**.
* **Accessories** had logistics costs consuming the largest proportion of revenue, at approximately **15.05%**.

## Time-Based Analysis

* Transportation costs reached their **highest level in April**, at approximately **$189K**, while the lowest was recorded in **October**, at approximately **$130K**.
* The company received its highest volume of imports in **August**, with **28,980 units**, while **October** recorded the lowest import volume at **17,115 units**.
* Despite August having the highest overall import volume, **April had the highest transportation cost**, suggesting that shipment volume alone did not determine logistics expenditure.
* The **Kitchen category** had its highest import volume in **April**, with **5,745 units**, and its lowest in **October**, with **3,800 units**.
* **May** recorded the highest revenue turnover at approximately **$1.50M**, making it the company's strongest month for sales.
* **December** recorded the lowest revenue turnover at approximately **$796.5K**.
* **May was also the most profitable month**, while **December was the least profitable**.
* The difference between peak import volume and peak logistics cost indicates that the **timing and composition of imports may have a greater effect on transportation costs than shipment volume alone**.

# Recommendations

## Supplier Management

* Prioritize high-performing suppliers such as Metro Components, Atlas Supply Group, and Sterling Manufacturing.
* Review Prime Components due to its highest damage rate and investigate quality-control issues.
* Negotiate better transportation rates with high-cost suppliers, particularly Vertex Global Supply.
* Review EverBright Manufacturing's long lead time and assess alternative sourcing options.

## Product & Category Strategy

* Prioritize high-performing products such as Office Item 58 and Kitchen Item 99 due to their strong revenue, profit, and low logistics costs.
* Review or discontinue consistently loss-making products, particularly Accessory Items 60 and 20.
* Review Accessory Item 75 due to its relatively high logistics cost and lower profit contribution.
* Increase focus on the Kitchen category while improving the profitability of the weaker Accessories category.

## Logistics & Operations

* Investigate the factors behind April's unusually high transportation cost and identify opportunities to reduce shipping expenses.
* Reduce logistics costs within the Accessories category, where transportation consumes the highest share of revenue.
* Review Office Supplies' high total logistics expenditure for potential cost savings.
* Improve warehouse handling and storage processes to reduce product damage, particularly at Lagos.

## Inventory Management

* Allocate inventory based on profitability and demand rather than shipment volume alone.
* Increase inventory emphasis on high-performing categories, particularly Kitchen products.
* Use historical sales patterns to improve import timing and stock availability during stronger sales periods.
* Monitor damaged inventory closely to avoid overestimating sellable stock.

## Overall Strategy

* Focus on profitable growth by protecting the company's **30.48% profit margin** while increasing revenue.
* Establish a supplier and product performance scorecard using profitability, damage rates, logistics costs, and lead times.
* Reduce avoidable logistics and damage costs, particularly within weaker-performing categories.
* Continuously use sales, inventory, supplier, and logistics data to guide purchasing and operational decisions.

# Conclusion

The analysis shows that Vertex Supply Chain Ltd. is operating profitably, generating approximately **$15.05M in sellable revenue**, **$4.59M in net profit**, and an overall **30.48% profit margin**. However, performance varies across products, categories, suppliers, warehouses, and periods.

**Kitchen products** emerged as the strongest category, while **Accessories** consistently underperformed in revenue, profit, and logistics efficiency. At the product level, several items generated losses and should be reviewed for discontinuation or restructuring. Supplier performance also varied significantly in terms of damage rates, transportation costs, and lead times.

Overall, the company has a strong foundation for profitable growth. By **optimizing supplier selection, reducing logistics and damage costs, focusing inventory on high-performing products and categories, and addressing consistently unprofitable products**, the company can improve profitability while maintaining efficient supply chain operations.

# SQL Techniques Used

* Multi-table JOINs
* CTEs
* Subqueries
* Aggregation
* Conditional logic (CASE)
* Data cleaning
* Date/string manipulation
* NULL handling
* Filtering
* Calculated business metrics

# Screenshots

* [Profitability Table](profitability_table.png)
* [Suppliers Logistics Cost](Suppliers_logistics_cost.png)
* [Gross Profit](gross_profit.png)
* [Products Profit Rank](products_profit_rank.png)
* [Revenue Potential](revenue_potential.png)
* [Gross Revenue](Gross_revenue.png)
