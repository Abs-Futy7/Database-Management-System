# Understanding NULL in Databases

## What is NULL?
In databases, `NULL` represents a missing or undefined value. It is not equivalent to zero, an empty string, or any other default value. Instead, it signifies the absence of any value.

## Characteristics of NULL
- `NULL` is not a value; it is a placeholder for unknown or inapplicable data.
- Comparisons involving `NULL` always result in `NULL` (e.g., `NULL = NULL` is `NULL`, not `TRUE`).
- Special operators like `IS NULL` or `IS NOT NULL` are used to check for `NULL` values.

## Functionality of NULL
1. **Storage**: NULL is used to indicate missing or optional data in a table.
2. **Querying**: SQL provides mechanisms to handle NULL values in queries, such as filtering rows with `IS NULL`.
3. **Default Values**: Columns can allow NULL values unless explicitly restricted with `NOT NULL`.

## Aggregate Functions and NULL
Aggregate functions handle `NULL` values in specific ways:
- **Ignored in Aggregates**: Functions like `SUM`, `AVG`, `MAX`, and `MIN` ignore `NULL` values in their calculations.
    ```sql
    SELECT AVG(salary) FROM employees; -- NULL salaries are excluded
    ```
- **COUNT**: `COUNT(column_name)` excludes `NULL` values, while `COUNT(*)` includes all rows.
    ```sql
    SELECT COUNT(column_name) FROM table_name; -- Excludes NULLs
    SELECT COUNT(*) FROM table_name; -- Includes NULLs
    ```

## Handling NULL in Expressions
- Use `COALESCE` to replace `NULL` with a default value:
    ```sql
    SELECT COALESCE(column_name, 'Default Value') FROM table_name;
    ```
- Use `NULLIF` to return `NULL` if two expressions are equal:
    ```sql
    SELECT NULLIF(column1, column2) FROM table_name;
    ```

## Best Practices
- Avoid overusing `NULL` to prevent ambiguity in data.
- Use `NOT NULL` constraints where appropriate to enforce data integrity.
- Handle `NULL` explicitly in queries to avoid unexpected results.
