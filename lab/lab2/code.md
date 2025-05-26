
## SQL Query Examples

### 1. Display all records from the `course` table

```
SELECT * FROM course;
```

---

### 2. Find the average instructors’ salaries of those departments where the average salary is greater than $42,000

#### Using subquery in the FROM clause

```sql
SELECT dept_name, avg_salary
FROM (
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM instructor
    GROUP BY dept_name
) AS dept_avg
WHERE avg_salary > 42000;
```

#### Using GROUP BY with HAVING clause

```sql
SELECT dept_name, AVG(salary)
FROM instructor
GROUP BY dept_name
HAVING AVG(salary) > 42000;
```

#### Using WITH clause (Common Table Expression - CTE)

```sql
WITH dept_avg AS (
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM instructor
    GROUP BY dept_name
)
SELECT dept_name, avg_salary
FROM dept_avg
WHERE avg_salary > 42000;
```

---

### 3. Find the names of each instructor, along with their salary and the average salary in their department

#### Using LATERAL join (PostgreSQL style)

```sql
SELECT
    name,
    salary,
    avg_salary
FROM instructor l1,
LATERAL (
    SELECT AVG(salary) AS avg_salary
    FROM instructor l2
    WHERE l2.dept_name = l1.dept_name
) AS dept_avg;
```

#### Using correlated subquery

```sql
SELECT
    name,
    salary,
    (
        SELECT AVG(salary)
        FROM instructor i2
        WHERE i2.dept_name = i1.dept_name
    ) AS avg_salary
FROM instructor i1;
```

#### Using subquery in FROM clause

```sql
SELECT
    i.name,
    i.salary,
    d.avg_salary
FROM instructor i,
(
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM instructor
    GROUP BY dept_name
) d
WHERE i.dept_name = d.dept_name;
```

#### Using WITH clause (CTE)

```sql
WITH dept_avg AS (
    SELECT dept_name, AVG(salary) AS avg_salary
    FROM instructor
    GROUP BY dept_name
)
SELECT name, salary, avg_salary
FROM instructor, dept_avg
WHERE instructor.dept_name = dept_avg.dept_name;
```

---

### 4. List all departments with the number of instructors in each

#### Using correlated subquery in SELECT clause

```sql
SELECT dept_name,
    (
        SELECT COUNT(*)
        FROM instructor
        WHERE department.dept_name = instructor.dept_name
    ) AS num_instructors
FROM department;
```

#### Using JOIN and GROUP BY

```sql
SELECT
    d.dept_name,
    COUNT(i.ID) AS num_instructors
FROM department d
CROSS JOIN instructor i
WHERE d.dept_name = i.dept_name
GROUP BY d.dept_name;
```

---

### 5. Find instructors whose salary * 10 > budget of their department

#### Using subquery in WHERE clause

```sql
SELECT name
FROM instructor i
WHERE salary * 10 > (
    SELECT budget
    FROM department d
    WHERE d.dept_name = i.dept_name
);
```

#### Using JOIN

```sql
SELECT i.name
FROM instructor i, department d
WHERE i.dept_name = d.dept_name
    AND i.salary * 10 > d.budget;
```

---

### 6. Delete instructors who taught a class in Fall 2017 with more than 10 students

#### DELETE with correlated subquery using IN

```sql
DELETE FROM instructor
WHERE ID IN (
    SELECT i.ID
    FROM instructor i, teaches t, section s
    WHERE i.ID = t.ID
        AND t.course_id = s.course_id
        AND t.sec_id = s.sec_id
        AND t.semester = s.semester
        AND t.year = s.year
        AND s.semester = 'Fall'
        AND s.year = 2017
        AND (
            SELECT COUNT(*)
            FROM takes tk
            WHERE tk.course_id = s.course_id
                AND tk.sec_id = s.sec_id
                AND tk.semester = s.semester
                AND tk.year = s.year
        ) > 10
);
```

---

#### SELECT to preview such instructors

```sql
SELECT DISTINCT i.name
FROM instructor i, teaches t, section s
WHERE i.ID = t.ID
    AND t.course_id = s.course_id
    AND t.sec_id = s.sec_id
    AND t.semester = s.semester
    AND t.year = s.year
    AND s.semester = 'Fall'
    AND s.year = 2017
    AND (
        SELECT COUNT(*)
        FROM takes tk
        WHERE tk.course_id = s.course_id
            AND tk.sec_id = s.sec_id
            AND tk.semester = s.semester
            AND tk.year = s.year
    ) > 1; -- Example threshold
```