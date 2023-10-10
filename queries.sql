-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select 
productname,
categoryname
from categories as c 
join products as p
on p.categoryid=c.categoryid;
-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
select 
o.id,
o.orderdate,
s.companyname
from shipper as s
join orders as o
on s.id=o.shipvia
where orderdate < '2012-08-09';
-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
select 
p.productname,
o.quantity
from product as p
join orderdetail as o
on p.id=o.productid
where o.orderid=10251;
-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select
o.id as orderid,
o.ShipName as companyname,
e.lastname as employeeLastName
from employee as e
 join orders as o
on e.id=o.employeeid; 

-- Find the number of shipments by each shipper.
select 
s.id,
s.companyname,
count(o.shipvia) as shipmentCount
from orders as o
join shipper as s
on o.shipvia=s.id
group by s.id;

--Find the top 5 best performing employees measured in number of orders.
select 
e.id,
e.firstname || ' ' || e.lastname as EmployeeName,
count(o.employeeid) as NumberOfOrders
from employee as e join 
orders as o
on e.id=o.employeeid
group by (e.id)
order by (NumberOfOrders) desc limit 5;

-- Find the top 5 best performing employees measured in revenue.
select 
e.id,
e.firstname || ' ' || e.lastname as EmployeeName,
orderdetail.Quantity,
sum(orderdetail.quantity * orderdetail.UnitPrice) as revenue,
o.id as orderId
from employee as e 
join orders as o
on e.id=o.employeeid
join orderdetail on o.id=orderdetail.orderid
group by e.id order by (revenue) desc limit 5;


--Find the category that brings in the least revenue.
select 
c.id as categoryid,
sum(o.quantity * o.UnitPrice) as revenue
from category as c
join product as p
on c.id=p.CategoryId
join orderdetail as o
on o.productid=p.id
group by c.id limit 1;