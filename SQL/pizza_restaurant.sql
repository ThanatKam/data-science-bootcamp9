--CREATE TABLE customers
CREATE TABLE customers (
  cust_ID INT UNIQUE,
  firstname TEXT,
  lastname TEXT
);

insert into customers values
(1,"Thanat","Kamolsiri"),
(2,"Nunnapin","Chinpat"),
(3,"Thiago","Silva"),
(4,"Eden","Hazard");

--create table menus
CREATE TABLE menus (
  menu_ID INT UNIQUE,
  pizza text
);

insert into menus values
  (1 ,"Seafood Cocktail"),
  (2,"Hawaiian"),
  (3,"Double Cheese");

--create table orders
create table orders (
  order_ID INT UNIQUE,
  cust_ID INT,
  menu_ID INT,
  quantity INT
);

insert into orders values
(1,1,2,2),
(2,2,1,1),
(3,1,3,3),
(4,3,3,1),
(5,4,2,1);

--Q1 use join
--1.1 where
select 
  orders.order_ID, 
  orders.cust_ID, 
  customers.firstname
  from orders,customers
where orders.cust_ID = customers.cust_ID;
--1.2 join
select
  orders.order_ID,
  orders.quantity,
  menus.pizza
from orders
join menus on orders.menu_ID = menus.menu_ID;

--Q.2 use Agg fn : most selling menu
select
  max(orders.quantity),
  menus.pizza
from orders
join menus on orders.menu_ID = menus.menu_ID;

select
  orders.quantity,
  menus.pizza
from orders
join menus on orders.menu_ID = menus.menu_ID
group by menus.pizza;

--Q.3.1 subqueries
select 
  firstname ||" "|| lastname,
  quantity,
  pizza
  from
(select * from menus where pizza = "Double Cheese") as T1
join orders as T2 on T1.menu_ID = T2.menu_ID
join customers as T3 on T2.cust_ID = T3.cust_ID;

--Q.3.2 With
with doublecheese as (select * from menus where pizza = "Double Cheese")

select 
  firstname ||" "|| lastname,
  quantity,
  pizza
  from
doublecheese as T1
join orders as T2 on T1.menu_ID = T2.menu_ID
join customers as T3 on T2.cust_ID = T3.cust_ID;
