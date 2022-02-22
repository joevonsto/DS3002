# ---- EXERCISE 1.0 ----
# DROP DATABASE `northwind_dw`;
CREATE DATABASE `northwind_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `northwind_dw`;

# ---- EXERCISE 1.1 -----
DROP TABLE `dim_customers`;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

DROP TABLE `dim_products`;
CREATE TABLE `dim_products` (
  `supplier_ids` longtext,
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;

DROP TABLE `dim_employees`;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

DROP TABLE `dim_shippers`;
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

# ---- EXERCISE 1.2 ----
DROP TABLE `fact_orders`;
CREATE TABLE `fact_orders` (
  `order_id` int DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `shipped_date` datetime DEFAULT NULL,
  `shipper_id` int DEFAULT NULL,
  `ship_name` varchar(50) DEFAULT NULL,
  `ship_address` longtext,
  `ship_city` varchar(50) DEFAULT NULL,
  `ship_state_province` varchar(50) DEFAULT NULL,
  `ship_zip_postal_code` varchar(50) DEFAULT NULL,
  `ship_country_region` varchar(50) DEFAULT NULL,
  `shipping_fee` decimal(19,4) DEFAULT '0.0000',
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `discount` double NOT NULL DEFAULT '0',
  `taxes` decimal(19,4) DEFAULT '0.0000',
  `payment_type` varchar(50) DEFAULT NULL,
  `paid_date` datetime DEFAULT NULL,
  `tax_rate` double DEFAULT '0',
  `unit_price` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `order_status_name` varchar(50) DEFAULT NULL,
  `order_details_status_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;


# ---- EXERCISE 2.1 ----
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `customers`.`id`,
    `customers`.`company`,
    `customers`.`last_name`,
    `customers`.`first_name`,
    `customers`.`job_title`,
    `customers`.`business_phone`,
    `customers`.`fax_number`,
    `customers`.`address`,
    `customers`.`city`,
    `customers`.`state_province`,
    `customers`.`zip_postal_code`,
    `customers`.`country_region`
FROM `northwind`.`customers`;
INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`mobile_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`
FROM `northwind`.`employees`;

INSERT INTO `northwind_dw`.`dim_products`
(`supplier_ids`,
`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT `products`.`supplier_ids`,
    `products`.`id`,
    `products`.`product_code`,
    `products`.`product_name`,
    `products`.`standard_cost`,
    `products`.`list_price`,
    `products`.`reorder_level`,
    `products`.`target_level`,
    `products`.`quantity_per_unit`,
    `products`.`discontinued`,
    `products`.`minimum_reorder_quantity`,
    `products`.`category`
FROM `northwind`.`products`;

INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `shippers`.`id`,
    `shippers`.`company`,
    `shippers`.`address`,
    `shippers`.`city`,
    `shippers`.`state_province`,
    `shippers`.`zip_postal_code`,
    `shippers`.`country_region`
FROM `northwind`.`shippers`;


# ---- EXERCISE 2.2 ----
INSERT INTO `northwind_dw`.`fact_orders`
(`order_id`,
`employee_id`,
`customer_id`,
`product_id`,
`order_date`,
`shipped_date`,
`shipper_id`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`shipping_fee`,
`quantity`,
`discount`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`unit_price`,
`order_status_name`,
`order_details_status_name`)
SELECT `orders`.`id`,
    `orders`.`employee_id`,
    `orders`.`customer_id`,
    `order_details`.`product_id`,
    `orders`.`order_date`,
    `orders`.`shipped_date`,
    `orders`.`shipper_id`,
    `orders`.`ship_name`,
    `orders`.`ship_address`,
    `orders`.`ship_city`,
    `orders`.`ship_state_province`,
    `orders`.`ship_zip_postal_code`,
    `orders`.`ship_country_region`,
    `orders`.`shipping_fee`,
    `order_details`.`quantity`,
    `order_details`.`discount`,
    `orders`.`taxes`,
    `orders`.`payment_type`,
    `orders`.`paid_date`,
    `orders`.`tax_rate`,
    `order_details`.`unit_price`,
    `orders_status`.`status_name`,
    `order_details_status`.`status_name`
FROM northwind.orders
INNER JOIN northwind.orders_status
ON orders.status_id = orders_status.id
RIGHT OUTER JOIN northwind.order_details
ON orders.id = order_details.order_id
INNER JOIN northwind.order_details_status
ON order_details.status_id = order_details_status.id;

# ---- EXERCISE 3.0 ----
SELECT dim_customers.last_name, sum(fact_orders.quantity) as total_quantity, 
	sum(fact_orders.unit_price) as total_unit_price
FROM northwind_dw.dim_customers
INNER JOIN northwind_dw.fact_orders ON fact_orders.customer_id = dim_customers.customer_key
GROUP BY dim_customers.last_name
ORDER BY total_unit_price DESC;
