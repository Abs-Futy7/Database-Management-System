-- SET Operations in SQL

-- SQL provides several set operations to combine the results of two or more SELECT queries.
-- The main set operations are UNION, UNION ALL, INTERSECT, and MINUS (or EXCEPT in some databases).

-- 1. UNION
-- Combines the results of two SELECT statements and removes duplicate rows.
SELECT column1, column2
FROM table1
UNION
SELECT column1, column2
FROM table2;

-- 2. UNION ALL
-- Combines the results of two SELECT statements but includes duplicate rows.
SELECT column1, column2
FROM table1
UNION ALL
SELECT column1, column2
FROM table2;

-- 3. INTERSECT
-- Returns only the rows that are common between two SELECT statements.
SELECT column1, column2
FROM table1
INTERSECT
SELECT column1, column2
FROM table2;

-- 4. MINUS (or EXCEPT)
-- Returns the rows from the first SELECT statement that are not present in the second SELECT statement.
SELECT column1, column2
FROM table1
MINUS
SELECT column1, column2
FROM table2;

-- Notes:
-- - The number and order of columns in both SELECT statements must match.
-- - The data types of corresponding columns must be compatible.
-- - Some databases may use EXCEPT instead of MINUS (e.g., PostgreSQL).

-- Nested SET Operations
-- You can nest set operations to combine multiple queries.

-- Example: UNION of INTERSECT and MINUS
SELECT column1, column2
FROM table1
INTERSECT
SELECT column1, column2
FROM table2
UNION
SELECT column1, column2
FROM table1
MINUS
SELECT column1, column2
FROM table3;

-- Example: UNION ALL of two INTERSECT results
SELECT column1, column2
FROM table1
INTERSECT
SELECT column1, column2
FROM table2
UNION ALL
SELECT column1, column2
FROM table3
INTERSECT
SELECT column1, column2
FROM table4;

-- Notes:
-- - Parentheses can be used to explicitly define the order of operations.
-- - The same rules for column count, order, and data type compatibility apply.

/*Find courses that ran in Fall 2009 or in Spring 2010 */

select course_id from section where sem - 'Fall' and year = 2009
UNION
select course_id from section where sem = 'Spring' and year = 2010;



--Find courses that ran in Fall 2009 and in Spring 2010

select course_id from section where sem = 'Fall' and year = 2009
INTERSECT
select course_id from section where sem = 'Spring' and year = 2010;



-- Find courses that ran in Fall 2009 but not in Spring 2010

select course_id from section where sem = 'Fall' and year = 2009
MINUS
select course_id from section where sem = 'Spring' and year = 2010;