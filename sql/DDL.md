# Data Definition Language (DDL)

Data Definition Language (DDL) is a subset of SQL used to define and manage the structure of a database. It includes commands that allow users to create, modify, and delete database objects such as tables, indexes, and schemas.

## Common DDL Commands

1. **CREATE**: Used to create new database objects.
    ```sql
    CREATE TABLE students (
         id INT PRIMARY KEY,
         name VARCHAR(50),
         age INT
    );
    ```

2. **ALTER**: Used to modify the structure of existing database objects.
    ```sql
    ALTER TABLE students ADD COLUMN grade CHAR(1);
    ```

3. **DROP**: Used to delete database objects.
    ```sql
    DROP TABLE students;
    ```

4. **TRUNCATE**: Used to remove all records from a table without logging individual row deletions.
    ```sql
    TRUNCATE TABLE students;
    ```

5. **RENAME**: Used to rename database objects.
    ```sql
    RENAME TABLE students TO learners;
    ```

## Characteristics of DDL
- DDL commands are auto-committed, meaning changes are immediately saved.
- They primarily deal with the schema and structure of the database.

## Use Cases
- Creating a new database or table.
- Modifying the structure of existing tables.
- Removing unused or obsolete database objects.
