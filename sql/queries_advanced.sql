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
