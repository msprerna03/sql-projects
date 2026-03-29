#CREATE DATABASE
create database project;

#CREATE TABLE
create table Customers(
	CustomerID int Primary key,
	CustomerName varchar(20),
    City varchar(20),
    Email varchar(20),
    RegistrationDate date
);

create table Orders(
	OrderID int Primary key,
	CustomerID int,
	OrderDate date,
    Amount decimal(10,2),
    Status enum("COMPLETED","PENDING","CANCELLED"),
    foreign key(customerID) references customers(customerID)
);

#ENTER DATA
Insert into Customers Values
(1, 'Alice Johnson', 'New York','alice@example.com', "2023-01-15"),
(2, 'Bob Smith', 'Los Angeles','bob@example.com',"2023-03-20") ,
(3, 'Charlie Brown','Chicago','charlie@example.com ',"2023-06-10") ,
(4, 'David Lee','Houston','david@example.com',"2023-09-05" ),
(5, 'Eve Adams','Phoenix','eve@example.com',"2024-01-10");

Insert into Orders Values
(1,1,'2024-02-10',150.75,'Completed'), 
(2,2,'2024-02-12',220.00,'Completed'),
(3,3,'2024-02-15',320.50,'Pending'),
(4,1,'2024-02-20',100.00,'Cancelled'), 
(5,2,'2024-02-22',50.00,'Completed'), 
(6,3,'2024-02-25',75.00 ,'Completed'), 
(7,4,'2024-02-28',200.00,'Pending'),
(8,5,'2024-03-01',90.00,'Completed');

#CHECKING DATA 
select * from customers;
select * from orders;

#1. Retrieve all customer details who live in 'Chicago'. 
select * from Customers 
where City= 'Chicago' ;

#2. List all orders with an amount greater than 200. 
select * from orders
where amount > 200;

#3. Find the total number of orders placed by each customer.
select CustomerID ,count(orderid) as TOTAL_ORDERS from orders
group by customerid;

#4. Calculate the total revenue (sum of all completed orders).
select status, sum(amount) as TOTAL_REVENU from orders
where status="completed";

#5. Retrieve the details of all orders placed in February 2024.
select * from orders 
where OrderDate between "2024-02-01" and "2024-02-29";

#6. Find the highest order amount and the corresponding customer name.
select c.customername, o.amount
from orders o
join customers c 
on o.customerid = c.customerid
order by o.amount desc
limit 1;

#7. List customers who have placed more than one order.
select c.CustomerID , c.customername
from customers c
join orders o
on c.customerid= o.customerid
group by c.customerid, c.customername
having count(o.orderid)>1;

#8. Find the average order amount of all orders
SELECT AVG(AMOUNT) AS AVERAGE
FROM ORDERS;

#9Retrieve the details of the most recent order.
SELECT * FROM ORDERS
ORDER BY ORDERDATE DESC
LIMIT 1;

#10. Find the total number of customers who registered in 2023. 
SELECT COUNT(CUSTOMERID) AS total_customers FROM CUSTOMERS
WHERE YEAR(REGISTRATIONDATE)= 2023;

#11. List customers who have never placed an order
select CustomerName from customers c
join orders o on
c.customerid= o.customerid
where c.customerid is null;

#12. Count the number of completed, pending, and cancelled orders.
select status,count(orderid) as number_of_orders from orders
group by status;

#13. Retrieve the name and email of customers who have at least one completed order.
select distinct CustomerName,email from customers c
join orders o on
c.CustomerID=o.CustomerID
where Status="Completed";

#14. Find the customer who has spent the most money in total.
select customername,SUM(amount) AS TOTAL_AMOUNT from customers c
join orders o on
c.CustomerID=o.CustomerID
GROUP BY CustomerName
ORDER BY SUM(AMOUNT) DESC
LIMIT 1;

#15. Retrieve the details of the first order placed by each customer.
SELECT O.* FROM ORDERS O
JOIN(
	SELECT CUSTOMERID,
    MIN(ORDERDATE) AS FIRST_ORDER
    FROM ORDERS
    GROUP BY CUSTOMERID
) FIRST_ORDERS
 ON O.CUSTOMERID=FIRST_ORDERS.CUSTOMERID
 AND O.ORDERDATE =FIRST_ORDERS.FIRST_ORDER;