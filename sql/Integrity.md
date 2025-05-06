# Integrity in Databases

Integrity in databases ensures the accuracy, consistency, and reliability of data throughout its lifecycle. It is a critical aspect of database management systems (DBMS) and is maintained through various constraints and rules.

## Types of Integrity

### 1. **Entity Integrity**
- Ensures that each table has a unique identifier (primary key).
- No primary key value can be `NULL`.

### 2. **Referential Integrity**
- Maintains consistency between related tables.
- Foreign keys must match primary keys in the referenced table or be `NULL`.

### 3. **Domain Integrity**
- Ensures that data in a column adheres to a defined domain (data type, format, range, etc.).
- Enforced using constraints like `CHECK` and `DEFAULT`.

### 4. **User-Defined Integrity**
- Custom rules defined by the user to meet specific business requirements.
- Implemented using triggers, stored procedures, or application logic.

## Importance of Integrity
- Prevents data corruption and redundancy.
- Ensures meaningful and accurate query results.
- Supports reliable decision-making processes.

## Constraints for Enforcing Integrity
- **Primary Key**: Ensures entity integrity.
- **Foreign Key**: Enforces referential integrity.
- **Unique**: Prevents duplicate values in a column.
- **Not Null**: Ensures mandatory data entry.
- **Check**: Validates data against specific conditions.

By adhering to these principles, databases maintain high-quality data and support robust applications.