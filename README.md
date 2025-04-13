# Bookstore Database Project

## Overview
This project is a relational database system for managing the operations of a bookstore, built using MySQL and visualized with Draw.io. It covers book inventory, customer management, order tracking, and shipping logistics.

## Technologies Used
- **MySQL** – Relational database management
- **Draw.io** – For designing the ERD
- **SQL** – For writing schema and queries

## Features
- Full database schema with 15 interrelated tables
- Support for multiple authors per book
- Tracks customer orders, addresses, and shipping methods
- Secure access with user roles and permissions
- Sample data included for testing and demonstration

## Entity-Relationship Diagram (ERD)
![ERD](./A_Entity-Relationship_Diagram_(ERD)_for_a_bookstor.png)

## Database Tables
- `book`, `author`, `publisher`, `book_language`
- `customer`, `customer_address`, `address`, `country`, `address_status`
- `cust_order`, `order_line`, `order_status`, `order_history`
- `book_author`, `shipping_method`

## Recent Modifications
- `book` table: Added `genre`, `publishing_date`
- `author` table: Added `nationality`

## How to Use
1. Clone the repository
2. Import the SQL file:
   ```bash
   mysql -u your_user -p bookstore < bookstore.sql

## Review and customize the sample data if needed

- Test with custom queries or connect with an application

## User Roles & Permissions
- admin_user – Full access to all database objects

- editor_user – Can read and modify data, but not drop tables

- readonly_user – Can only perform SELECT queries

- SQL script to create these users and assign permissions is provided in user_roles.sql.

## Contributors
1. Charles Mori – Project Lead, ERD Design, SQL Development

2. Tamara Ajaluwa – Sample Data Entry, Documentation

3. Siwaphiwe Hlazo – SQL Scripting, Testing
