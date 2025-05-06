# Data Manipulation Language (DML)

Data Manipulation Language (DML) is a subset of SQL (Structured Query Language) used to interact with and manipulate data stored in a database. It allows users to perform operations such as retrieving, inserting, updating, and deleting data.

## Key Features of DML
- **Non-Procedural**: Users specify *what* data they need, not *how* to retrieve it.
- **Data-Oriented**: Focuses on data manipulation rather than database structure.
- **Transactional**: DML operations can be part of a transaction, ensuring data consistency.

## Types of DML Statements
1. **SELECT**: Retrieves data from one or more tables.
    ```sql
    SELECT column1, column2 FROM table_name WHERE condition;
    ```
    - Example:
      ```sql
      SELECT name, age FROM students WHERE age > 18;
      ```

2. **INSERT**: Adds new rows of data into a table.
    ```sql
    INSERT INTO table_name (column1, column2) VALUES (value1, value2);
    ```
    - Example:
      ```sql
      INSERT INTO students (name, age) VALUES ('Alice', 20);
      ```

3. **UPDATE**: Modifies existing data in a table.
    ```sql
    UPDATE table_name SET column1 = value1 WHERE condition;
    ```
    - Example:
      ```sql
      UPDATE students SET age = 21 WHERE name = 'Alice';
      ```

4. **DELETE**: Removes rows from a table.
    ```sql
    DELETE FROM table_name WHERE condition;
    ```
    - Example:
      ```sql
      DELETE FROM students WHERE age < 18;
      ```

## Characteristics of DML
- **Transactional Control**: DML operations can be rolled back or committed using `ROLLBACK` and `COMMIT`.
- **Data Integrity**: Ensures that data remains consistent during manipulation.
- **User-Friendly**: Provides simple syntax for interacting with data.

## Types of DML
- **Procedural DML**: Requires the user to specify how to perform operations.
- **Declarative DML**: Focuses on what data is needed, leaving the "how" to the database system.

## Use Cases
- Retrieving specific data for reporting or analysis.
- Adding new records to a database.
- Updating outdated or incorrect information.
- Deleting obsolete or unnecessary data.

## Example Workflow
1. Insert new data into a table.
2. Retrieve the data to verify the insertion.
3. Update the data if necessary.
4. Delete data that is no longer required.

DML is an essential part of database management, enabling users to interact with data efficiently and effectively.
