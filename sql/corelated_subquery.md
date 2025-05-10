# Correlated Subquery

A **correlated subquery** is a type of subquery that uses values from the outer query. Unlike a regular subquery, which is executed independently and only once, a correlated subquery is executed repeatedly—once for each row that the outer query processes.

## Key Characteristics
- **Dependency on Outer Query**: The subquery references columns from the outer query.
- **Execution**: The subquery is executed for every row processed by the outer query.
- **Performance**: Correlated subqueries can be less efficient than regular subqueries due to repeated execution.

## Syntax Example
```sql
SELECT e1.employee_id, e1.salary
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

### Explanation
1. The outer query retrieves employee IDs and salaries.
2. The subquery calculates the average salary for the department of the current employee (`e1.department_id`).
3. The outer query compares the employee's salary to the department's average salary.

## Use Cases
- Filtering rows based on aggregated data.
- Comparing rows within the same table.

## Alternatives
In some cases, correlated subqueries can be replaced with **JOINs** or **Common Table Expressions (CTEs)** for better performance.
