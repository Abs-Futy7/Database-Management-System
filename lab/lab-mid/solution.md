# Database Design and Implementation

## 1. Database Design

### a) Tables, Attributes & Datatypes

#### Employee
- `emp_id` (INT, Primary Key)
- `name` (VARCHAR(50))
- `designation` (ENUM: 'Teacher', 'Officer', '3rd Class', '4th Class')
- `basic_salary` (DECIMAL(10,2))
- `increment` (DECIMAL(10,2))
- `promotion_guideline` (TEXT)
- `division` (ENUM: 'Dhaka', 'Chattogram', 'Khulna', 'Barishal', 'Sylhet', 'Rajshahi', 'Rangpur')
- `home_district` (VARCHAR(30))
- `cell_no` (VARCHAR(11), UNIQUE)
- `marital_status` (ENUM: 'Married', 'Single', 'Divorced')
- `date_of_birth` (DATE)
- `blood_group` (ENUM: 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')
- `workplace_id` (INT, Foreign Key)
- `residence_id` (INT, Foreign Key, Nullable)

#### Workplace
- `workplace_id` (INT, Primary Key)
- `workplace_name` (VARCHAR(50))
- `workplace_type` (ENUM: 'Department', 'Office', 'Hall Office')

#### Residence
- `residence_id` (INT, Primary Key)
- `building_name` (VARCHAR(50))
- `room_no` (VARCHAR(10))
- `type` (ENUM: 'Residential', 'Hall')

#### Car
- `car_id` (INT, Primary Key)
- `emp_id` (INT, Foreign Key)
- `car_name` (VARCHAR(30))
- `brand` (VARCHAR(30))
- `registration_year` (YEAR)

#### Child (Weak Entity)
- `child_id` (INT, Primary Key)
- `emp_id` (INT, Foreign Key)
- `child_name` (VARCHAR(40))
- `education_level` (ENUM: 'Primary', 'Secondary', 'Higher Secondary', 'University')
- `institution_name` (VARCHAR(50))

### b) Primary Keys and Foreign Keys

**Primary Keys:**
- Employee: `emp_id`
- Workplace: `workplace_id`
- Residence: `residence_id`
- Car: `car_id`
- Child: `child_id`

**Foreign Keys:**
- `Employee.workplace_id` → `Workplace.workplace_id`
- `Employee.residence_id` → `Residence.residence_id`
- `Car.emp_id` → `Employee.emp_id`
- `Child.emp_id` → `Employee.emp_id`

### c) Schema Diagram (Textual Representation)

```
Employee (emp_id, ..., workplace_id, residence_id)
    ↔ Workplace (workplace_id, ...)
    ↔ Residence (residence_id, ...)
    ↔ Car (car_id, emp_id, ...)
    ↔ Child (child_id, emp_id, ...)
```

## 2. Implement Constraints (SQL)

```sql
-- Employee Table
CREATE TABLE Employee (
        emp_id INT PRIMARY KEY,
        name VARCHAR(50),
        designation ENUM('Teacher','Officer','3rd Class','4th Class'),
        basic_salary DECIMAL(10,2) CHECK (basic_salary >= 8250 AND basic_salary <= 78000),
        increment DECIMAL(10,2),
        promotion_guideline TEXT,
        division ENUM('Dhaka','Chattogram','Khulna','Barishal','Sylhet','Rajshahi','Rangpur'),
        home_district VARCHAR(30),
        cell_no VARCHAR(11) UNIQUE CHECK (
                cell_no LIKE '017%' OR
                cell_no LIKE '015%' OR
                cell_no LIKE '016%' OR
                cell_no LIKE '019%'
        ),
        marital_status ENUM('Married','Single','Divorced'),
        date_of_birth DATE,
        blood_group ENUM('A+','A-','B+','B-','O+','O-','AB+','AB-'),
        workplace_id INT,
        residence_id INT,
        FOREIGN KEY (workplace_id) REFERENCES Workplace(workplace_id),
        FOREIGN KEY (residence_id) REFERENCES Residence(residence_id)
);
-- Other tables should be created similarly with their respective keys and constraints.
```

## 3. E-R Diagram

> *Draw by hand or use a tool. Must include: Employee, Workplace, Residence, Car, Child (weak entity relationship for Child).*

## 4. Insert Necessary Data

```sql
INSERT INTO Workplace VALUES
        (1, 'CSE', 'Department'),
        (2, 'EEE', 'Department'),
        (3, 'FH Hall Office', 'Hall Office');

INSERT INTO Residence VALUES
        (1, 'Shaheed Abul Khair Bhaban', 'A-12', 'Residential');

INSERT INTO Employee VALUES
        (1001, 'Md. Abdur Rahim Chowdhury', 'Teacher', 55000, 5000, 'Every 2 years', 'Dhaka', 'Gazipur', '01712345678', 'Married', '1970-01-01', 'A+', 1, 1);

INSERT INTO Car VALUES
        (1, 1001, 'Axio', 'Toyota', 2018);

INSERT INTO Child VALUES
        (1, 1001, 'Nusrat Jahan', 'University', 'Dhaka University');
-- (Add more data as needed)
```

## 5. Create View: emp_car

```sql
CREATE VIEW emp_car AS
SELECT e.name AS employee_name, e.designation, c.car_name, c.brand, c.registration_year
FROM Employee e
JOIN Residence r ON e.residence_id = r.residence_id
JOIN Car c ON e.emp_id = c.emp_id
WHERE r.building_name = 'Shaheed Abul Khair Bhaban';
```

## 6. SQL Queries

### a) Employees in ‘CSE’, ‘EEE’ or ‘FH Hall Office’ with names ≥ 25 characters

```sql
SELECT e.name, e.division, e.date_of_birth
FROM Employee e
JOIN Workplace w ON e.workplace_id = w.workplace_id
WHERE w.workplace_name IN ('CSE', 'EEE', 'FH Hall Office')
    AND LENGTH(e.name) >= 25;
```

### b) Number of employees and total salary for workplaces with avg salary condition

```sql
WITH office_salary AS (
        SELECT workplace_id, COUNT(*) AS num_emp, SUM(basic_salary) AS total_salary, AVG(basic_salary) AS avg_salary
        FROM Employee
        GROUP BY workplace_id
), min_total AS (
        SELECT MIN(total_salary) AS min_total_salary FROM office_salary
)
SELECT w.workplace_name, o.num_emp, o.total_salary
FROM office_salary o
JOIN Workplace w ON o.workplace_id = w.workplace_id
JOIN min_total m
WHERE o.avg_salary > m.min_total_salary;
```

### c) Children with parents who study at DU departments/institutes

```sql
SELECT c.child_name, c.education_level, c.institution_name, e.name AS parent_name
FROM Child c
JOIN Employee e ON c.emp_id = e.emp_id
WHERE c.institution_name LIKE '%Dhaka University%'
     OR c.institution_name IN (SELECT workplace_name FROM Workplace);
```

### d) Delete residence info for employees with '125' in 4th–6th digits of mobile

```sql
UPDATE Employee
SET residence_id = NULL
WHERE SUBSTRING(cell_no, 4, 3) = '125';
```

## 7. Advanced Queries

### a) Employees who do not have any children (using NOT EXISTS)

```sql
SELECT e.*
FROM Employee e
WHERE NOT EXISTS (
        SELECT 1 FROM Child c WHERE c.emp_id = e.emp_id
);
```

### b) Employees who do not have any children (using LEFT OUTER JOIN)

```sql
SELECT e.*
FROM Employee e
LEFT OUTER JOIN Child c ON e.emp_id = c.emp_id
WHERE c.child_id IS NULL;
```