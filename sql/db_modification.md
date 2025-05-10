# Database Modification

Database modification involves altering the data stored in a database. The three primary operations for modifying data are `INSERT`, `DELETE`, and `UPDATE`. Below are explanations and examples of each operation, including advanced use cases like conditional updates with `CASE` statements and updates using scalar subqueries.

---

## 1. INSERT
The `INSERT` statement is used to add new rows to a table.

### Example:
```sql
INSERT INTO employees (id, name, department, salary)
VALUES (1, 'John Doe', 'HR', 50000);
```

---

## 2. DELETE
The `DELETE` statement removes rows from a table based on a condition.

### Example:
```sql
DELETE FROM employees
WHERE department = 'HR';
```

---

## 3. UPDATE
The `UPDATE` statement modifies existing rows in a table.

### Example:
```sql
UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT';
```

---

## 4. Conditional Updates with `CASE` Statement
The `CASE` statement allows conditional logic within an `UPDATE` query.

### Example:
```sql
UPDATE employees
SET salary = 
    CASE 
        WHEN department = 'IT' THEN salary + 10000
        WHEN department = 'HR' THEN salary + 5000
        ELSE salary
    END;
```

---

## 5. Updates with Scalar Subqueries
Scalar subqueries return a single value and can be used in `UPDATE` statements.

### Example:
```sql
UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees WHERE department = 'IT')
WHERE department = 'HR';
```

In this example, the salary of all employees in the HR department is updated to the average salary of employees in the IT department.

---

Database modification is a powerful feature that allows you to manage and manipulate data effectively. Use these operations carefully to maintain data integrity.