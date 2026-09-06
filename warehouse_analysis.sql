
-- warehouses and their shipment volume

select warehouse, sum(quantity_received) as total_units_received
from shipments
group by warehouse
order by total_units_received desc;


-- warehouses and their inventory values

select 
    warehouse,
    sum((quantity_received - quantity_damaged) * selling_price) as inventory_value
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
    round(sum(quantity_damaged) * 100.0 / sum(quantity_received),2) as damage_rate
from shipments
group by warehouse
order by damage_rate desc;


-- logistics implication per warehouse

select warehouse, sum(transport_cost) as logistics
from shipments
group by warehouse
order by logistics desc ;



-- warehouse performance based on profitability

select sum(quantity_received) inventory_count,
category, warehouse, sum((selling_price-unit_cost) * (sh.quantity_received-sh.quantity_damaged))- sum(transport_cost) as profit
from shipments sh
join productskl p on
sh.product_id = p.product_id
group by warehouse, category
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
group by category
order by transport_percent desc;

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
        SUM(quantity_received) AS shipment_qty,
        category
    FROM shipments sh
    join productskl p
 on
 sh.product_id = p.product_id 
 GROUP BY DATE_FORMAT(shipment_date, '%Y-%m'), category
)

SELECT
    month,
    shipment_qty,category,
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


