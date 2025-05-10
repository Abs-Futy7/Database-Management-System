# Scalar Subquery  

A **scalar subquery** is a subquery that returns a single value. It is often used in the `SELECT` clause or in conditions within the `WHERE` clause. Scalar subqueries are enclosed in parentheses and can be used wherever a single value is expected.  

### Example 1: List all departments along with the number of instructors in each department  

```sql  
SELECT dept_name,  
    (SELECT COUNT(*)  
     FROM instructor  
     WHERE department.dept_name = instructor.dept_name)  
    AS num_instructors  
FROM department;  
```  

In this query:  
- The scalar subquery `(SELECT COUNT(*) FROM instructor WHERE department.dept_name = instructor.dept_name)` calculates the number of instructors for each department.  
- The result of the subquery is used as the value for the `num_instructors` column in the output.  

### Example 2: Find instructors whose salary multiplied by 10 is greater than the budget of their department  

```sql  
SELECT name  
FROM instructor  
WHERE salary * 10 >  
      (SELECT budget  
    FROM department  
    WHERE department.dept_name = instructor.dept_name);  
```  

In this query:  
- The scalar subquery `(SELECT budget FROM department WHERE department.dept_name = instructor.dept_name)` retrieves the budget of the department corresponding to each instructor.  
- The condition `salary * 10 > (subquery)` ensures that only instructors meeting the criteria are included in the result.  

Scalar subqueries are powerful tools for creating dynamic and context-sensitive queries in SQL.  

### Additional Notes on Scalar Subqueries  

- Scalar subqueries can occur in `SELECT`, `WHERE`, and `HAVING` clauses.  
- Scalar subqueries may also be defined without using aggregate functions.  
- It is not always possible to determine at compile time if a subquery will return more than one tuple. If the subquery returns more than one tuple during execution, a runtime error occurs.  
- Technically, the result of a scalar subquery is still a relation, even if it contains only a single tuple.  
- When a scalar subquery is used in an expression where a single value is expected, SQL implicitly extracts the value from the single attribute of the single tuple in the relation and returns that value.  
- Scalar subqueries provide a concise way to embed queries that dynamically compute values based on the context of the outer query.  