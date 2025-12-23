--Month-on-month growth
with monthly_revenue
as
(
select trunc(o.order_date,'MM') as month_start,
sum(ot.line_amount) as revenue
from order_items ot
join orders o
on ot.order_id=o.order_id
where o.order_status not in ('Cancelled')
group by trunc(o.order_date,'MM') ),
prev_monthly_rev as
(select to_char(month_start,'MM-YY') as order_month ,revenue,
lag(revenue) over(order by month_start) as prev_revenue
from monthly_revenue)
select order_month,revenue,
round((revenue - prev_revenue )/ nullif(prev_revenue,0) * 100,2) as growthpct
from prev_monthly_rev ;

alter session set nls_date_format='DD-mON-YY HH24:MI:SS';

--products whose total sales are above the overall average product revenue
with product_revenue as
(select p.name,sum(ot.line_amount) as revenue
from order_items ot join
products p
on ot.product_id=p.product_id
join orders o
on ot.order_id=o.order_id
where o.order_status not in ('Cancelled')
group by p.name)
select name,revenue from product_revenue
where revenue > (select avg(revenue) from product_revenue) ;
