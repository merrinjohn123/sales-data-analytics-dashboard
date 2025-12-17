-- Total non-cancelled orders and total revenue

select count(distinct o.order_id) as Tot_orders,sum(line_amount) as Tot_revenue from order_items ot
join orders o
on ot.order_id=o.order_id
where o.order_status not in ('Cancelled');

--Total quantity sold and total revenue per product.
select p.name,sum(ot.quantity) as tot_quantity,sum(ot.line_amount) as tot_revenue
from ORDER_ITEMS ot
join products p
on p.product_id=ot.product_id
group by p.name;

--total revenue per product category.
select p.category,sum(ot.line_amount) as tot_revenue
from ORDER_ITEMS ot
join products p
on p.product_id=ot.product_id
group by p.category
order by tot_revenue desc ;

--Total sales per month for non-cancelled orders
Select to_char(o.order_date,'MM-YY') as month,sum(ot.line_amount) as revenue
from order_items ot
join orders o
on ot.order_id=o.ORDER_ID
where o.order_status not in ('Cancelled')
group by to_char(o.order_date,'MM-YY');
