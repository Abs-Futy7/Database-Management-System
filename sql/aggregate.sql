--Aggregate functions are functions that take a collection (a set or multiset) of values as input and return a single value.
-- They are used to perform calculations on multiple rows of a table and return a single value.
-- The most common aggregate functions are:
-- COUNT, SUM, AVG, MIN, MAX, GROUP_CONCAT, GROUP BY
-- COUNT: Returns the number of rows that match a specified criterion. 
-- SUM: Returns the total sum of a numeric column.
-- AVG: Returns the average value of a numeric column.
-- MIN: Returns the smallest value of the selected column.
-- MAX: Returns the largest value of the selected column.
-- GROUP_CONCAT: Returns a concatenated string of non-NULL values from a group.
-- GROUP BY: Groups rows that have the same values in specified columns into summary rows.

-- Q1: Find the average salary of instructors in the Computer Science department

select avg(salary) from instructor
where dept_name = 'Comp. Sci.';


-- Q2: Find the total number of instructors who teach a course in the Spring 2010 semester

select count(distinct ID) from teaches
where semester = 'Spring' and year = 2010; -- count distinct ID to avoid double counting instructors who teach multiple courses in the same semester


-- Q3: Find the number of tuples in the course relation

select count(*) from course;


-- Q4: Find the average salary of instructors in each department

select dept_name, avg(salary) as avg_salary from INSTRUCTOR
group by dept_name;


-- Q5: Find the number of instructors in each department who teach a course in the Spring 2010 semester.

select dept_name, count(distinct ID) as inst_num
from INSTRUCTOR natural join TEACHES
where semester = 'Spring' and year = 2010
group by dept_name;


-- HAVING: at times, you may want to filter the results of a GROUP BY query based on the result of an aggregate function.
-- The HAVING clause is used to filter records that work on summarized GROUP BY results.

-- Q6: Find the names and average salaries of all departments whose average salary is greater than 42000

select dept_name, avg(salary) as avg_salary
from instructor 
group by DEPT_NAME
having avg(salary) > 42000;

/* Q7: For each course section offered in 2009, find the average total
credits (tot_cred) of all students enrolled in the section, if the
section had at least 2 students */

select course_id, semester, year, sec_id, avg(tot_cred)
from takes natural join students
where year = 2009
GROUP BY course_id, semester, year, sec_id
having count(distinct ID) >= 2;
