# College Database Management System

A relational **College Database Management System** built using **MySQL
and SQL**. The project demonstrates database design, data management,
analytical queries, views, stored procedures, stored functions,
triggers, indexes, and transaction handling.

## 🛠️ Technologies Used

-   MySQL
-   MySQL Workbench 8.0
-   SQL

## 📌 Project Features

The database is designed to manage common college-related information,
including:

-   Departments
-   Faculty
-   Students
-   Subjects
-   Student enrollments
-   Student marks
-   Student fees

### Database Concepts Implemented

-   Relational database design
-   Primary and foreign keys
-   Constraints and data validation
-   JOIN operations
-   Aggregate functions
-   Subqueries
-   `CASE` statements
-   `GROUP BY` and `HAVING`
-   Views
-   Stored procedures
-   Stored functions
-   Triggers
-   Indexes
-   Transactions
-   `COMMIT`, `ROLLBACK`, and `SAVEPOINT`
-   Audit logging

## 🗂️ Database Structure

The project uses the following main tables:

  Table           Purpose
  --------------- -------------------------------------------
  `departments`   Stores department information
  `faculty`       Stores faculty details
  `students`      Stores student information
  `subjects`      Stores subject information
  `enrollments`   Stores student-subject enrollment records
  `marks`         Stores student marks
  `fees`          Stores student fee information

## 👁️ Views

The project includes views for commonly required reports, including:

-   Student academic performance
-   Student fee summary
-   Faculty subject load

Views allow frequently used queries to be accessed as virtual tables.

## ⚙️ Stored Procedures

The project includes stored procedures for tasks such as:

-   Adding a new student along with fee information
-   Generating a student academic report
-   Generating department summaries
-   Updating or saving student marks
-   Finding students within a CGPA range
-   Processing fee payments safely

## 🧮 Stored Functions

Custom SQL functions are used for reusable calculations and
classifications, including:

-   Converting marks into grades
-   Categorizing CGPA
-   Calculating outstanding fees
-   Calculating a student's average marks
-   Counting failed subjects

## 🔔 Triggers

Triggers are used to automate database actions such as:

-   Validating fee records
-   Updating fee status
-   Validating marks
-   Maintaining audit information

The project also includes marks audit functionality.

## 🚀 Indexing

Indexes are created on frequently queried columns to demonstrate query
optimization and improve lookup performance.

The project also includes `EXPLAIN` queries to inspect query execution
plans.

## 🔄 Transactions

Transaction concepts demonstrated in the project include:

``` sql
START TRANSACTION;
COMMIT;
ROLLBACK;
SAVEPOINT;
ROLLBACK TO SAVEPOINT;
```

These are used to demonstrate safe database updates and recovery from
unwanted changes.

## 💻 How to Run

### 1. Install MySQL

Install:

-   MySQL Server
-   MySQL Workbench

### 2. Open the Project

Open `Project.sql` in MySQL Workbench.

### 3. Select the Database

The script creates and uses:

``` sql
college_db
```

### 4. Execute the Script

Run the SQL sections in order.

The script creates the database, tables, sample data, queries, views,
procedures, functions, triggers, indexes, and transaction examples.

> If you are rerunning the complete script, pay attention to the index
> section because indexes should not be recreated if they already exist.

## 🧪 Testing

After creating the database objects, stored routines can be tested with
examples such as:

``` sql
CALL sp_student_report(1);
```

Example function tests:

``` sql
SELECT fn_get_grade(95);
SELECT fn_cgpa_category(8.5);
SELECT fn_outstanding_fees(1);
SELECT fn_student_avg_marks(1);
SELECT fn_failed_subjects(1);
```

## 📁 Repository Structure

``` text
College-Database-Management-System/
│
└── College_Database.sql
```

## 🎯 Learning Objectives

This project was created to practice and demonstrate practical SQL and
relational database concepts, including database design, querying,
reporting, automation, optimization, and transaction management.

## 👤 Project

**College Database Management System**

**Technology:** MySQL / SQL
