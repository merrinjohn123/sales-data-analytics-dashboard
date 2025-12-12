-- Total non-cancelled orders and total revenue

select count(distinct o.order_id) as Tot_orders,sum(line_amount) as Tot_revenue from order_items ot
join orders o
on ot.order_id=o.order_id
where o.order_status not in ('Cancelled');
