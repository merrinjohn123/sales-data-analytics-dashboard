--Total revenue
select sum(ot.line_amount) as total_revenue
from order_items ot
join ORDERS o
on ot.order_id = o.order_id
where o.order_status not in ('Cancelled');

--Number of orders
select count(*) as total_orders
from orders 
where order_status not in ('Cancelled');

--Number of customers
SELECT COUNT(DISTINCT o.customer_id) AS total_customers
FROM orders o
WHERE o.order_status NOT IN ('Cancelled');

--Average order value
with total_amounts as
(
select ot.order_id, sum(ot.line_amount) as tot_amount
from order_items ot
join orders o
on ot.order_id=o.order_id
where o.order_status not in ('Cancelled')
group by ot.order_id
)
select round(avg(tot_amount),2) as average_order_value from total_amounts;


