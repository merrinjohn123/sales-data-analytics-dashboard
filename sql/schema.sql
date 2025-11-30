create table customers
( customer_id number(5) primary key,
  name varchar2(15),
  city varchar2(15),
  state varchar2(15),
  country varchar2(15),
  signup_date date
)

create table products
( product_id number(10) primary key,
name varchar2(15),
category varchar2(15),
unit_price number(5,2)
);

create table orders
(   order_id number(5) primary key,
customer_id number(5) ,
order_date date,
order_status varchar2(15),
constraint fk_customer foreign key(customer_id) references customers(customer_id)
)

create table order_items
( order_item_id number(5) primary key,
order_id number(5) ,
product_id number(10) ,
quantity number(5),
unti_price number(5,2),
line_amount number(5,2),
constraint fk_order foreign key(order_id) references orders(order_id),
constraint fk_products foreign key(product_id) references products(product_id)
)