-- KPIs
-- Inventory Count

select sum(quantity_received) as total_inventory
from shipments;


-- Damaged Goods Count
select sum(quantity_damaged) as damaged_goods
from shipments; 



-- Total Revenue Potential

select 
sum(selling_price * quantity_received) as revenue_potential
from productskl
join shipments
on
productskl.product_id = shipments.product_id;

-- Net Revenue
select sum(selling_price * (quantity_received - quantity_damaged)) as net_revenue
from productskl p
join shipments sh
on p.product_id = sh.product_id;



-- Total Gross Profit
with net as
( select  product_name,
sum(selling_price * (quantity_received-quantity_damaged))  as net_rev,
		sum((quantity_received) * unit_cost) as inventory_cost
from productskl p
join shipments sh on
p.product_id = sh.product_id
group by product_name)

select
sum(net_rev) -sum(inventory_cost) as gross_profit
from net
order by gross_profit desc;

-- Total Net Profit after Transportation Cost

with net as
( select  product_name,
sum((quantity_received-quantity_damaged) * selling_price) as net_rev,
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


-- Total Revenue Lost
with rev as (
select 
sum(selling_price * quantity_received) as revenue_potential,
sum(selling_price * (quantity_received - quantity_damaged)) as gross_revenue
from productskl
join shipments
on
productskl.product_id = shipments.product_id
)
select revenue_potential - gross_revenue  as revenue_lost
from rev;



-- Total Transport cost Incurred

select sum(transport_cost) total_transport_cost
from shipments;

-- Percentage of Damaged Goods

select round(sum(quantity_damaged)/sum(quantity_received) * 100,2) as damage_percent
from shipments;

