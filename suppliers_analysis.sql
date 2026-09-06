
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
order by transport_cost asc;

 

-- Company with the highest avg. lead times


select supplier_name, round(avg(lead_time_days),2) as avg_lead_time_in_days
 from suppliers
 group by supplier_name
 order by avg_lead_time_in_days asc;
 