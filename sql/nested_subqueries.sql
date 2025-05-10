-- Nested Subqueries in SQL

-- A nested subquery is a query within another SQL query. 
-- The inner query is executed first, and its result is used by the outer query.

-- Example 1: Using a nested subquery in the WHERE clause
-- Find employees who earn more than the average salary in their department.
select employee_id,
       employee_name,
       salary
  from employees
 where salary > (
   select avg(salary)
     from employees
    where department_id = employees.department_id
);

-- Example 2: Using a nested subquery in the FROM clause
-- Find the average salary of each department and list departments with an average salary above 5000.
select department_id,
       avg_salary
  from (
   select department_id,
          avg(salary) as avg_salary
     from employees
    group by department_id
) dept_avg
 where avg_salary > 5000;

-- Example 3: Using a nested subquery in the SELECT clause
-- List employees and their department's average salary.
select employee_id,
       employee_name,
       salary,
       (
          select avg(salary)
            from employees
           where department_id = e.department_id
       ) as dept_avg_salary
  from employees e;

-- Notes:
-- 1. Nested subqueries can be used in SELECT, FROM, and WHERE clauses.
-- 2. They can return a single value (scalar), a row, or a table.
-- 3. Proper indexing and query optimization are important for performance.

--Q1: Find courses offered in Fall 2009 and in Spring 2010

select distinct course_id
  from section
 where semester = 'Fall'
   and year = 2009
   and course_id in (
   select course_id
     from section
    where semester = 'Spring'
      and year = 2010
);


-- Q2: Find courses offered in Fall 2009 but not in Spring 2010

select distinct course_id
  from section
 where semester = 'Fall'
   and year = 2009
   and course_id not in (
   select course_id
     from section
    where semester = 'Spring'
      and year = 2010
);


-- Q3: Find the names of instructors whose names are neither “Mozart” nor “Einstein”.

select distinct name
  from instructor
 where name not in ( 'Mozart',
                     'Einstein' );


-- Q4: Find the total number of (distinct) students who have taken course sections taught by the instructor with ID 10101

select count(distinct id)
  from takes
 where ( course_id,
         sec_id,
         semester,
         year ) in (
   select course_id,
          sec_id,
          semester,
          year
     from teaches
    where teaches.id = 10101
);


-- Q5: Find names of instructors with salary greater than that of some
--(at least one) instructor in the Biology department.

select distinct t.name
  from instructor t,
       instructor s
 where t.salary > s.salary
   and s.dept_name = 'Biology';

select name
  from instructor
 where salary > some (
   select salary
     from instructor
    where dept_name = 'Biology'
);


-- Q6: Find the names of all instructors whose salary is greater than
-- the salary of all instructors in the Biology department.

select name
  from instructor
 where salary > all (
   select salary
     from instructor
    where dept_name = 'Biology'
);


-- Q7: Find the departments that have the highest average salary

select dept_name
  from instructor
 group by dept_name
having avg(salary) >= all (
   select avg(salary)
     from instructor
    group by dept_name
);



-- Exists: The EXISTS operator is used to check if a subquery returns any rows.
-- It returns TRUE if the subquery returns one or more rows, and FALSE if it returns no rows.
-- It is often used in correlated subqueries, where the inner query references columns from the outer query.



-- Q8: Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester

select course_id
  from section s
 where semester = 'Fall'
   and year = 2009
   and exists (
   select *
     from section t
    where semester = 'Spring'
      and year = 2010
      and s.course_id = t.course_id
);

-- Q9: Find all students who have taken all courses offered in the Biology department

select distinct s.id,
                s.name
  from student s
 where not exists (
   (
      select course_id
        from course
       where dept_name = 'Biology'
   )
   except
   (
      select t.course_id
        from takes t
       where s.id = t.id
   )
);


select distinct s.id,
                s.name
  from student s
 where not exists (
   select *
     from course c
    where c.dept_name = 'Biology'
      and not exists (
      select *
        from takes t
       where t.id = s.id
         and t.course_id = c.course_id
   )
);

/* UNIQUE:
The unique construct tests whether a subquery has any
duplicate tuples in its result. The unique construct returns the
value true if the argument subquery contains no duplicate tuples.*/


-- Q10: Find all courses that were offered at most once in 2009

select t.course id
  from course t
 where 1 = (
   select count(r.course_id)
     from section r
    where t.course_id = r.course_id
      and r.year = 2009
);


-- Q11: Find all courses that were offered at least twice in 2009

select t.course_id
  from course t
 where t.course_id in (
   select r.course_id
     from section r
    where r.year = 2009
    group by r.course_id
   having count(r.course_id) >= 2
);


-- Q12:Find the average instructors’ salaries of those departments where the average salary is greater than $42,000.

select dept_name,
       avg(salary)
  from (
   select dept_name,
          avg(salary) as avg_salary
     from instructor
    group by dept_name
)
 where avg_salary > 42000;


-- Q13: find the maximum across all departments of the total salary at each department

select max(tot_salary)
  from (
   select dept_name,
          sum(salary) as tot_salary
     from instructor
    group by dept_name
) dept_total;



/* LATERAL: lateral keyword is used to reference columns of the preceding table in the FROM clause.
It is useful when you want to join a table with a subquery that references columns from that table.
It allows you to create a correlated subquery in the FROM clause.
LATERAL is often used in conjunction with the CROSS JOIN or INNER JOIN operators.
It is supported in some SQL databases like PostgreSQL and Oracle.
*/

-- Q14: Find the names of each instructor, along with their salary and the average salary in their department

select name,
       salary,
       avg_salary
  from instructor l1,
       lateral (
          select avg(salary) as avg_salary
            from instructor l2
           where l1.dept_name = l2.dept_name
       );


-- Q15: Find all departments with the maximum budget

with max_budget (value) as (
   select max(budget)
     from department
)
select budget
  from department,
       max_budget
where department.budget = max_budget.value;



-- Q16: Find all departments where the total salary is greater than the average of the total salary at all departments            

with dept_total (dept_name, value) as
(select dept_name, sum(salary)
from instructor
group by dept_name),
dept_total_avg(value) as
(select avg(value)
from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value >= dept_total_avg.value;