#1. Write a query to get Product name and quantity/unit.
SELECT northwind.products.product_name, northwind.products.quantity_per_unit 
FROM northwind.products;
#2. Write a query to get current Product list (Product ID and name).
SELECT northwind.products.id, northwind.products.product_name FROM northwind.products 
WHERE northwind.products.discontinued = 0;
#3. Write a query to get discontinued Product list (Product ID and name).
SELECT northwind.products.id, northwind.products.product_name FROM northwind.products 
WHERE northwind.products.discontinued = 1;
#4. Write a query to get most expensive and least expensive Product list (name and unit price).
SELECT northwind.products.product_name, northwind.products.list_price FROM northwind.products
ORDER BY northwind.products.list_price desc;
#5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.
SELECT northwind.products.id, northwind.products.product_name, northwind.products.list_price
FROM northwind.products WHERE northwind.products.discontinued = 0 
and northwind.products.list_price < 20;
#6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.
SELECT northwind.products.id, northwind.products.product_name, northwind.products.list_price
FROM northwind.products WHERE northwind.products.list_price > 15 
and northwind.products.list_price < 25;
#7. Write a query to get Product list (name, unit price) of above average price.
SELECT northwind.products.product_name, northwind.products.list_price
FROM northwind.products WHERE northwind.products.list_price > 
(SELECT avg(northwind.products.list_price) FROM northwind.products);
#8. Write a query to get Product list (name, unit price) of ten most expensive products.
SELECT northwind.products.product_name, northwind.products.list_price
FROM northwind.products ORDER BY northwind.products.list_price DESC LIMIT 10;
#9. Write a query to count current and discontinued products.
SELECT products.discontinued, COUNT(products.discontinued) 
FROM products 
GROUP BY products.discontinued;
#10. Write a query to get Product list (name, units on order, units in stock) of 
# stock is less than the quantity on order.
CREATE TABLE units_in_stock
Select northwind.inventory_transactions.product_id, 
sum(northwind.inventory_transactions.quantity) as quantity
from northwind.inventory_transactions
group by northwind.inventory_transactions.product_id;
CREATE TABLE units_on_order
Select northwind.order_details.product_id, 
sum(northwind.order_details.quantity) as quantity1
from northwind.order_details
group by northwind.order_details.product_id;
Select distinct products.product_name, units_in_stock.product_id,
units_in_stock.quantity, units_on_order.quantity1
from northwind.products
   Inner join units_in_stock
      On products.id = units_in_stock.product_id
	Inner join units_on_order
		On products.id = units_on_order.product_id
where quantity < quantity1;