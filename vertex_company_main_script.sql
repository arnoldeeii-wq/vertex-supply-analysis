-- KPIs
-- Inventory Count

select sum(quantity_received)-sum(quantity_damaged) as total_inventory
from shipments;

-- Total Revenue Potential

select sum(selling_price * quantity_received) as revenue_potential
from productskl
join shipments
on
productskl.product_id = shipments.product_id;

-- Total Gross Profit
with net as
( select  product_name,
sum(quantity_received-quantity_damaged) * selling_price as net_rev,
		sum((quantity_received) * unit_cost) as inventory_cost, 
		sum(transport_cost) as total_trans_cost
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by product_name, selling_price)
select sum(net_rev) -sum(inventory_cost) as gross_profit
from net;

-- Total Net Profit after Transportation Cost

with net as
( select  product_name,
sum(quantity_received-quantity_damaged) * selling_price as net_rev,
		sum((quantity_received) * unit_cost) as inventory_cost, 
		sum(transport_cost) as total_trans_cost
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by product_name, selling_price)
select  sum(net_rev)- sum(inventory_cost) - sum(total_trans_cost) as total_net_profit
from net;



-- Overall Profit Margin
with net as
( select  product_name,
sum(quantity_received-quantity_damaged) * selling_price as net_rev,
		sum((quantity_received) * unit_cost) as inventory_cost, 
		sum(transport_cost) as total_trans_cost
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by product_name, selling_price),
net_profit as (
select sum(net_rev) as sum_net_rev,
 sum(net_rev)- sum(inventory_cost) - sum(total_trans_cost) as total_net_profit
from net)
select round((total_net_profit / sum_net_rev) * 100,2) as profit_margin
from net_profit;


select sum((selling_price-unit_cost) * quantity_received) / sum(selling_price * quantity_received) * 100  as profit_margin
from productskl p 
join shipments sh on
p.product_id = sh.product_id;


-- Total Transport cost Incurred

select sum(transport_cost) total_transport_cost
from shipments;

-- Percentage of Damaged Goods

select round(sum(quantity_damaged)/sum(quantity_received) * 100,2) as damage_percent
from shipments;



-- Suppliers with the highest revenue

WITH supplier_returns AS (
    SELECT
        s.supplier_name,
        SUM((p.selling_price) * (sh.quantity_received-sh.quantity_damaged)) AS total_revenue
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY s.supplier_name
)
SELECT
    supplier_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS supplier_rank
FROM supplier_returns
;

-- Suppliers with the highest net profit

WITH supplier_returns AS (
    SELECT
        s.supplier_name,
        SUM((p.selling_price - p.unit_cost) * (sh.quantity_received-sh.quantity_damaged)) AS total_profit
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY s.supplier_name
)
SELECT
    supplier_name,
    total_profit,
    RANK() OVER (ORDER BY total_profit DESC) AS supplier_rank
FROM supplier_returns
;


-- Metro Components come in first as top suppliers in terms of profit, as they generate $620k in profit from sales of their products.
-- Atlas Supply comesin second with Sterling Manufacturing in third place.
-- Infinity Sourcing came in last with just over $58k in profits.





-- Supplier with the highest inventory value


WITH inventory_table AS (
    SELECT 
        supplier_name,
        SUM((quantity_received - quantity_damaged) * selling_price) AS inventory_value
    FROM shipments sh
    JOIN productskl p 
        ON sh.product_id = p.product_id
    JOIN suppliers s 
        ON p.supplier_id = s.supplier_id
    GROUP BY supplier_name
)

SELECT 
    supplier_name,
    inventory_value,
        RANK() OVER (ORDER BY inventory_value DESC) AS inventory_value_rank 
        FROM inventory_table
ORDER BY inventory_value DESC;


-- Supplier with the highest number of shipped goods


select supplier_name, sum(quantity_received) as inventory_count
from suppliers s
    JOIN productskl p
        ON p.supplier_id = s.supplier_id
    
     JOIN shipments sh 
        ON sh.product_id = p.product_id
        GROUP BY supplier_name
        order by inventory_count desc;
        
	-- Lowest Average Damage Rate
    
    select * from suppliers;
select * from shipments;
select * from productskl;



with damaged_table as
(
select supplier_name, sum(quantity_damaged) damaged_sum, sum(quantity_received) qty_rec
from suppliers s
join productskl p on
s.supplier_id = p.supplier_id
join shipments sh on
sh.product_id = p.product_id
group by supplier_name)

select supplier_name, damaged_sum/ qty_rec as avg_damage_rate
from damaged_table
group by supplier_name
order by avg_damage_rate asc;


-- Supplier with the highest transportation cost

select supplier_name, sum(transport_cost) as transport_cost
from suppliers s
join productskl p on
s.supplier_id = p.supplier_id
join shipments sh on
sh.product_id = p.product_id
group by supplier_name
order by transport_cost desc;

-- Company with the highest avg. lead times


select supplier_name, avg(lead_time_days) as avg_lead_time_in_days
 from suppliers
 group by supplier_name
 order by avg_lead_time_in_days desc;
 
 
 -- Relationship between lead times and profitability
 
 -- rank suppliers based on overrall business performance
 
 
 -- products with the highest revenue
 
 with revenue_table as (
 select product_name, sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as revenue
 from productskl p
 join shipments sh on
 p.product_id = sh.product_id
 group by product_name)
 
 select product_name, 
 revenue
 from revenue_table
 group by product_name
 order by revenue desc;
 
 
 -- products with highest net profit
 WITH top_3_products AS (
    SELECT
         p.product_name,
        SUM((p.selling_price - p.unit_cost) * (sh.quantity_received-sh.quantity_damaged)) AS total_profit,
        sum(transport_cost) as total_trans
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY product_name
)

SELECT
    product_name,
    total_profit - total_trans as net_profit
FROM top_3_products
order by net_profit desc
limit 10;


-- products with the highest damaged units

select product_name, sum(quantity_damaged) damaged_count
from productskl p
join shipments s on
p.product_id = s.product_id
group by product_name
order by damaged_count desc;


-- products with high transport cost per unit

select * from productskl;
select * from shipments;

select product_name, round(sum(transport_cost/quantity_received),2) as unit_trans_cost
from productskl p
join shipments s on
p.product_id = s.product_id
group by product_name
order by unit_trans_cost desc ;

-- product contributing most to company revenue

WITH supplier_returns AS (
    SELECT
        p.product_name,
        SUM((p.selling_price) * (sh.quantity_received-sh.quantity_damaged)) AS total_revenue
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY p.product_name
)
SELECT
   product_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS peoduct_rank
FROM supplier_returns
;

-- Suppliers with the highest net profit

WITH product_returns AS (
    SELECT
        p.product_name,
        SUM(((p.selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged))- transport_cost) AS total_profit
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    total_profit,
    RANK() OVER (ORDER BY total_profit DESC) AS product_rank
FROM product_returns
;


-- what should be discounted as a result of poor profits?

WITH top_3_products AS (
    SELECT
        p.product_name,
		
        SUM(((p.selling_price - p.unit_cost) * (sh.quantity_received-sh.quantity_damaged))- transport_cost) AS total_profit
    FROM suppliers s
    JOIN productskl p
        ON s.supplier_id = p.supplier_id
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY product_name
)

SELECT
    product_name,
    total_profit,

    RANK() OVER (ORDER BY total_profit aSC) AS products_rank
FROM top_3_products
limit 30;


select product_name, total_profit, dense_RANK() OVER (ORDER BY total_profit DESC) AS products_rank
from shipments s
join productskl p
on p.product_id = s.product_id
group by product_name 
 
limit 10;

-- Office Supplie Item 58 is our highest performing product in terms of profit, as well as order quantity.
-- Kitchen Item 59 drives the secind spot for profit follwoed by Kitchen Item 99 at third place.
-- the second and third places as regards order quantity are Home Appliance Item 57 and Electronic Item 56.


-- product categories generating highest revenue

select * from productskl;
select * from suppliers;
select * from shipments;


select category,
sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as revenue
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by category
order by revenue desc;

-- product category with the highest profit

select category, sum(((selling_price-unit_cost) * (sh.quantity_received-sh.quantity_damaged))- transport_cost) as profit
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by category
order by profit desc;



-- category with the highest profit margin

with prof_tab as
( select category, sum((selling_price-unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit, sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as revenue
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by category
)

SELECT 
    category,
    profit,
   revenue,
    round((profit /revenue) * 100,2) AS profit_margin
FROM prof_tab
ORDER BY profit_margin DESC;


-- category that accounts for the highest percentage of comapany revenue

WITH revenue_tab AS (
    SELECT
        category,
        SUM(selling_price * quantity_received) AS revenue
    FROM productskl p
    JOIN shipments sh
        ON p.product_id = sh.product_id
    GROUP BY category
)

SELECT
    category,
    revenue,
  round(  revenue / SUM(revenue) OVER () * 100,2) AS revenue_percentage
FROM revenue_tab
ORDER BY revenue_percentage DESC;

-- rank categories based off of performance, im gonna use damage quantity to rank

select category, sum(quantity_damaged)damaged_count
from productskl p
join shipments s on
p.product_id = s.product_id
group by category
order by damaged_count desc;


-- the dashboard would make it easier to compare though.
-- category performance dashbaord, to be built

-- warehouses and their shipment volume

select warehouse, sum(quantity_received) as total_units_received
from shipments
group by warehouse
order by total_units_received desc;

-- warehouses and their inventory values

select 
    warehouse,
    sum(quantity_received * selling_price) as inventory_value
from shipments sh
join productskl p
    on sh.product_id = p.product_id
group by warehouse
order by inventory_value desc;


-- damged goods count per warehouse

select 
    warehouse,
    sum(quantity_received) as qty_received,
    sum(quantity_damaged) as damage_count,
    sum(quantity_damaged) * 100.0 / sum(quantity_received) as damage_rate
from shipments
group by warehouse
order by damage_rate desc;

-- logistics implication per warehouse

select warehouse, sum(transport_cost) as logistics
from shipments
group by warehouse
order by logistics desc ;


-- lowest cost of goods per unit 

select 
    warehouse,
    round(sum(unit_cost * quantity_received) / sum(quantity_received),2) as avg_cost_per_unit
from shipments sh
join productskl p
    on sh.product_id = p.product_id
group by warehouse
order by avg_cost_per_unit;


-- warehouse performance based on profitability

select warehouse, sum((selling_price-unit_cost) * (sh.quantity_received-sh.quantity_damaged))- sum(transport_cost) as profit
from shipments sh
join productskl p on
sh.product_id = p.product_id
group by warehouse
order by profit desc;


-- how much transportation is incurred each month?
select * from shipments;

select 
    year(shipment_date) as year,
    month(shipment_date) as month,
    sum(transport_cost) as transport_cost
from shipments
group by year(shipment_date), month(shipment_date)
order by year(shipment_date), month(shipment_date);


-- which products have the highest transportation cost?

select product_name,
	sum(transport_cost * quantity_received) as total_transport_cost,
	sum(quantity_received) as total_units_recieved,
    sum(transport_cost / quantity_received) as transport_per_unit_cost
 from shipments sh
 join productskl p on
	sh.product_id = p.product_id
 group by product_name
 order by transport_per_unit_cost asc;

-- suppliers with the highest logistics cost

select supplier_name, sum(transport_cost) as total_logistics
from shipments sh
join productskl p on
sh.product_id = p.product_id
join suppliers s on
p.supplier_id = s.supplier_id
group by supplier_name
order by total_logistics desc;

-- percentage of revenue consumed by transportation

select 
    category,
    sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as tot_rev,
    sum(transport_cost) as transport_cost,
   round(sum(transport_cost) / sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) * 100,2) as transport_percent
from suppliers s
join productskl p
    on s.supplier_id = p.supplier_id
join shipments sh
    on p.product_id = sh.product_id
group by category;

select category,
 sum(transport_cost) as total_logistics
from shipments sh
join productskl p on
sh.product_id = p.product_id
join suppliers s on
p.supplier_id = s.supplier_id
group by category
order by total_logistics desc;


-- how monthly shipments quantity changes
WITH monthly_shipments AS (
    SELECT
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        SUM(quantity_received) AS shipment_qty
    FROM shipments
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)

SELECT
    month,
    shipment_qty,
    LAG(shipment_qty) OVER (ORDER BY month) AS previous_month_qty,
    shipment_qty - LAG(shipment_qty) OVER (ORDER BY month) AS quantity_change
FROM monthly_shipments
ORDER BY month;


-- how monthly revenue changes
WITH monthly_shipments AS (
    SELECT
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        SUM(selling_price * (sh.quantity_received-sh.quantity_damaged)) AS monthly_rev
    FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)
select month,
monthly_rev,
lag(monthly_rev) over(order by month) as prev_month_rev,
monthly_rev - lag(monthly_rev) over(order by month) as rev_change
from monthly_shipments
order by month;

-- how profit changes monthly

with monthly_shipments as
(select  DATE_FORMAT(shipment_date, '%Y-%m') AS month,
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit
FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)
select month,
profit,
lag(profit) over(order by month) as prev_month_profit,
profit - lag(profit) over(order by month) as profit_change
from monthly_shipments
order by month;


-- month to month revenue growth

WITH monthly_shipments AS (
    SELECT
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        SUM(selling_price * (sh.quantity_received-sh.quantity_damaged)) AS monthly_qty
    FROM shipments sh
    join productskl p on
    sh.product_id = p.product_id
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)

SELECT
    month,
    monthly_qty,
    SUM(monthly_qty) OVER (ORDER BY month) AS rolling_total
FROM monthly_shipments
ORDER BY month;


-- month to month profit increase
WITH monthly_shipments AS (
    SELECT
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        SUM((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) AS profit
   
    FROM shipments sh
    join productskl p on
    sh.product_id = p.product_id
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m')
)

SELECT 
    month,

    profit,
    SUM(profit) OVER (ORDER BY month) AS rolling_total
FROM monthly_shipments
ORDER BY month;


-- top 10 products by profits

select product_name, 
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit
FROM shipments sh
    join productskl p on
    sh.product_id = p.product_id
    group by product_name
    order by profit desc
    limit 10;
    
    
    -- top 5 suppliers by revenue
    
    select supplier_name, 
    sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as tot_rev
    from suppliers s
    join productskl p on
    s.supplier_id = p.supplier_id
    join shipments sh on
    p.product_id = sh.product_id
    group by supplier_name
    order by tot_rev desc
    limit 5;
    
    -- top warehouse by inventory value
    
    select warehouse, 
    sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as inventory_value
    from suppliers s
    join productskl p on
    s.supplier_id = p.supplier_id
    join shipments sh on
    p.product_id = sh.product_id
    group by warehouse
    order by inventory_value desc
    ;
    
    
    
    
  -- products rank within category... id use profit to rank them
  
  with faji as
  ( select product_name, category, sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit
  from productskl p
  join shipments s on
  p.product_id = s.product_id
    group by product_name, category
  )
  select product_name, category, profit, rank () over (
  partition by category
  order by profit desc) as ranking
  from faji
  group by product_name, category;
  
  
  select * from suppliers;
  -- rank suppliers within each country
   select supplier_name, 
   supplier_country,
   sum(quantity_received) as qty_received,
    sum(quantity_damaged) as damage_count,
    sum(quantity_damaged) * 100.0 / sum(quantity_received) as damage_rate,
    RANK() OVER (
    PARTITION BY supplier_country
    ORDER BY sum(quantity_damaged) * 100.0 / sum(quantity_received)
) as ranking
    from suppliers s
    join productskl p on
    s.supplier_id = p.supplier_id
    join shipments sh on
    p.product_id = sh.product_id
   group by supplier_country, supplier_name;
   
   -- there is only one supplier per country; there's nothing to rank them against.
   
   -- inventory rank by goods received

 WITH monthly_shipments AS (
    SELECT
        DATE_FORMAT(shipment_date, '%Y-%m') AS month,
        SUM(quantity_received) AS shipment_qty,
        warehouse
    FROM shipments
    GROUP BY DATE_FORMAT(shipment_date, '%Y-%m'), warehouse
)

SELECT
    month,
    shipment_qty,
    warehouse,
        rank() over (
  partition by month
   order by shipment_qty desc) as ranking
FROM monthly_shipments
ORDER BY month, ranking;
 
 
 -- shipments with negative profits
 
 with monthly_shipments as
(select  product_name, 
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged))-sum(transport_cost) as profit
FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
    GROUP BY product_name
)
select product_name,
profit
from monthly_shipments
order by profit asc
limit 20;



-- suppliers with above average profit


with gauge as
( select supplier_name, 
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit
FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
join suppliers s on
p.supplier_id = s.supplier_id
    GROUP BY supplier_name), 
    
    avg_profit AS (
    SELECT AVG(profit) AS average_profit
    FROM gauge
)
     select supplier_name,
     profit,
     average_profit,
     case
		when profit >= average_profit
        then 'profitable'
        else 'below_avg'
	end as profit_gauge
    from gauge
    cross join avg_profit;

-- warehouses operating above the company average profit

with gauge as
( select warehouse,
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit
FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
join suppliers s on
p.supplier_id = s.supplier_id
group by warehouse),

	avg_profit as
    (select avg(profit) as average_profit from gauge )

select warehouse, 
profit,

case
	when profit >= average_profit
		then 'good_operarion_cost'
        else 'review_op_cost'
        end as operational_cost_check
from gauge
cross join avg_profit;


-- comparing gross profit vs net profit(revenue) from each supplier

with comp as
( select supplier_name,
sum((selling_price - unit_cost) * (sh.quantity_received-sh.quantity_damaged)) as profit,
sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as revenue
from shipments sh
join productskl p on
sh.product_id = p.product_id 
join suppliers s on
p.supplier_id = s.supplier_id
group by supplier_name),

avg_profit as (select avg(profit) as average_profit from comp)

select supplier_name,
revenue,
profit,
revenue-profit as prod_cost, 
case when profit >= average_profit
then 'profitable'
else 'non-profitable' end as true_comp_against_avg_profit
from comp
cross join avg_profit;

-- if we had to reduce our supplier base to the top 5 suppliers...
with cte as (
	select supplier_name, 
sum((selling_price - unit_cost) * quantity_received) as profit,
sum(selling_price * (sh.quantity_received-sh.quantity_damaged)) as inventory_value,
sum(quantity_damaged) as damage_rate,
sum(transport_cost) as transport_implication,
sum(quantity_received) as shipment_volume
 FROM shipments sh
join productskl p on
sh.product_id = p.product_id 
join suppliers s on
p.supplier_id = s.supplier_id
group by supplier_name),

avg_profit as (select avg(profit) as average_profit from cte),

scorecard as (select cte.*,
 case when profit >= average_profit
then 'profitable'
else 'non-profitable' end as true_comp_against_avg_profit
from cte
cross join avg_profit)

	select supplier_name,
 profit,
 inventory_value,
   round(profit * 100.0 / inventory_value,2) AS profit_margin,
 damage_rate,

 transport_implication,
 shipment_volume,
   true_comp_against_avg_profit,
rank () over (
order by profit desc) as supp_rank
from scorecard
order by supp_rank
limit 7;

-- limit 7 so we can see what the margin is betweeen the 6th and 7th suppliers

