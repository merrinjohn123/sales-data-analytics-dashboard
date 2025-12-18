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


--Revenue + order count + average order value per month.
Select to_char(o.order_date,'MM-YY') as month,sum(ot.line_amount) as revenue,
count(distinct o.order_id) as order_count,round(SUM(ot.line_amount) / COUNT(DISTINCT o.order_id),2) as avg_order_value
from order_items ot
join orders o
on ot.order_id=o.ORDER_ID
where o.order_status not in ('Cancelled')
group by to_char(o.order_date,'MM-YY');


--Top 10 products by revenue and quantitiy
with cte as
(
select p.name,sum(ot.line_amount) as tot_revenue,sum(ot.quantity) as tot_quantity
from order_items ot
join PRODUCTS p
on p.product_id=ot.PRODUCT_ID
join orders o
on ot.order_id=o.ORDER_ID
where o.order_status not in ('Cancelled')
group by p.name )
select * from cte
order by tot_revenue desc,tot_quantity DESC
fetch first 10 rows only;

--Alternative (row_number window function for ranking)
with cte as
(
select p.name,sum(ot.line_amount) as tot_revenue,
sum(ot.quantity) as tot_quantity,
row_number() over (order by sum(ot.quantity) desc,sum(ot.line_amount) desc) as rnk
from order_items ot
join orders o
on ot.order_id=o.order_id
join products p
on ot.product_id=p.product_id
where o.order_status not in ('Cancelled')
group by p.name)
select name,tot_revenue,tot_quantity from cte
where rnk <=10 ;


--Top 10 customers with their total revenue and no: of orders
with cte as
(select c.name,sum(ot.line_amount) as tot_revenue,
count(distinct o.order_id) as tot_orders,
row_number() over (order by sum(ot.line_amount) desc,count(distinct o.order_id) desc) as rnk
from order_items ot
join orders o 
on ot.order_id=o.order_id
join customers c
on o.customer_id=c.customer_id
group by c.name )
select name,tot_revenue,tot_orders 
from cte
where rnk <=10;

--Orders having no items
select o.order_id from orders o
left JOIN ORDER_ITEMS ot
on o.order_id=ot.order_id
where ot.order_item_id is NULL;

--Products that never sold
select p.product_id from products p
left JOIN order_items ot
on ot.product_id=p.product_id
where ot.order_id is NULL;
