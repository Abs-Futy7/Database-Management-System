--- create branch table

CREATE TABLE branch(
    branch_name VARCHAR2(50),
    branch_city VARCHAR2(50) CONSTRAINT nn_br_ct NOT NULL,
    assets NUMBER(12),
    CONSTRAINT pk_br_name PRIMARY KEY(branch_name),
    CONSTRAINT chk_asset CHECK (assets >= 100000)
);

--- Here we are creating a table named branch with 3 columns: branch_name, branch_city, and assets.
--- The branch_name column is the primary key, which means it must be unique for each row in the table.
--- The branch_city column cannot be null, meaning it must have a value for each row.
--- The assets column has a check constraint that ensures its value is greater than or equal to 100000.
--- The branch_name column is of type VARCHAR2(15), which means it can hold a string of up to 15 characters.
--- The branch_city column is of type VARCHAR2(12), which means it can hold a string of up to 12 characters.
--- The assets column is of type NUMBER(12), which means it can hold a number with up to 12 digits.
--- The CONSTRAINT nn_br_ct NOT NULL ensures that the branch_city cannot be null.
--- The CONSTRAINT pk_br_nm PRIMARY KEY ensures that the branch_name is unique and cannot be null.
--- The CONSTRAINT chk_as CHECK ensures that the assets are greater than or equal to 100000.


DESCRIBE branch;

--- Describe command is used to display the structure of the table, including the column names, data types, and constraints.


--- creating customer table

CREATE TABLE customer(
    customer_id VARCHAR2(10),
    customer_name VARCHAR2(15),
    customer_city VARCHAR2(15) CONSTRAINT nn_cust_ct NOT NULL,
    customer_phone VARCHAR2(11),
    CONSTRAINT pk_cust_id PRIMARY KEY (customer_id),
    CONSTRAINT unq_cust_phn UNIQUE(customer_phone)
);


--- Here we are creating a table named customer with 6 columns: customer_id, customer_name, customer_street, customer_city, cell, and dob.
--- The customer_id column is the primary key, which means it must be unique for each row in the table.
--- The customer_city column cannot be null, meaning it must have a value for each row.
--- The dob column cannot be null, meaning it must have a value for each row.
--- The cell column has a unique constraint, which means its value must be unique for each row in the table.
--- The customer_id column is of type VARCHAR2(5), which means it can hold a string of up to 5 characters.
--- The customer_name column is of type VARCHAR2(15), which means it can hold a string of up to 15 characters.
--- The customer_street column is of type VARCHAR2(12), which means it can hold a string of up to 12 characters.
--- The customer_city column is of type VARCHAR2(12), which means it can hold a string of up to 12 characters.
--- The cell column is of type VARCHAR2(11), which means it can hold a string of up to 11 characters.
--- The dob column is of type DATE, which means it can hold a date value.
--- The CONSTRAINT nn_cust_ct NOT NULL ensures that the customer_city cannot be null.
--- The CONSTRAINT pk_cust_id PRIMARY KEY ensures that the customer_id is unique and cannot be null.
--- The CONSTRAINT unq_cell UNIQUE ensures that the cell is unique and cannot be null.
--- The CONSTRAINT nn_dob NOT NULL ensures that the dob cannot be null.


DESCRIBE customer;


CREATE TABLE account(
    account_no CHAR(5),
    branch_name VARCHAR2(50),
    balance NUMBER(10,2) NOT NULL,
    CONSTRAINT pk_acc_no PRIMARY KEY (account_no),
    CONSTRAINT fk_acc_br_nm FOREIGN KEY (branch_name) REFERENCES branch(branch_name),
    CONSTRAINT chk_acc_bal CHECK (balance >= 0),
    CONSTRAINT chk_acc_no CHECK (account_no LIKE 'A-%') 
);

--- Here we are creating a table named account with 4 columns: account_no, branch_name, balance.
--- The account_no column is the primary key, which means it must be unique for each row in the table.
--- The branch_name column is a foreign key that references the branch_name column in the branch table.
--- The balance column cannot be null, meaning it must have a value for each row.
--- The balance column has a check constraint that ensures its value is greater than or equal to 0.
--- The account_no column has a check constraint that ensures its value starts with 'A-'.
--- The account_no column is of type CHAR(5), which means it can hold a string of exactly 5 characters.
--- The branch_name column is of type VARCHAR2(15), which means it can hold a string of up to 15 characters.
--- The balance column is of type NUMBER(10,2), which means it can hold a number with up to 10 digits, including 2 decimal places.
--- The CONSTRAINT prik_acc_no PRIMARY KEY ensures that the account_no is unique and cannot be null.
--- The CONSTRAINT forei_acc_br_nm FOREIGN KEY ensures that the branch_name references a valid branch_name in the branch table.
--- The CONSTRAINT chk_acc_bal CHECK ensures that the balance is greater than or equal to 0.
--- The CONSTRAINT chk_acc_no CHECK ensures that the account_no starts with 'A-'.
--- The CONSTRAINT nn_bal NOT NULL ensures that the balance cannot be null.
--- The CONSTRAINT SYS_C00185475668 is a system-generated constraint that was created when the table was created.


ALTER TABLE account DROP CONSTRAINT SYS_C00185475668;


----- The above command is used to drop a system-generated constraint from the account table.
----- The SYS_C00185475668 is a system-generated name for the constraint that was created when the table was created.


ALTER TABLE account MODIFY balance CONSTRAINT nn_acc_bal NOT NULL; 

----- The above command is used to modify the balance column in the account table.
----- The CONSTRAINT nn_bal NOT NULL ensures that the balance cannot be null.


DESCRIBE account;


CREATE TABLE loan(
    loan_no CHAR(5),
    branch_name VARCHAR2(50),
    amount NUMBER(10,2) CONSTRAINT nn_amnt NOT NULL,
    CONSTRAINT pk_ln PRIMARY KEY (loan_no),
    CONSTRAINT fk_br_nm FOREIGN KEY (branch_name) REFERENCES branch(branch_name),
    CONSTRAINT chk_ln_amnt CHECK(amount >= 0),
    CONSTRAINT chk_ln_no CHECK (loan_no Like 'L-%')
);

--- Here we are creating a table named loan with 4 columns: loan_no, branch_name, amount.
--- The loan_no column is the primary key, which means it must be unique for each row in the table.
--- The branch_name column is a foreign key that references the branch_name column in the branch table.
--- The amount column cannot be null, meaning it must have a value for each row.
--- The amount column has a check constraint that ensures its value is greater than or equal to 0.
--- The loan_no column has a check constraint that ensures its value starts with 'L-'.
--- The loan_no column is of type CHAR(5), which means it can hold a string of exactly 5 characters.
--- The branch_name column is of type VARCHAR2(15), which means it can hold a string of up to 15 characters.
--- The amount column is of type NUMBER(10,2), which means it can hold a number with up to 10 digits, including 2 decimal places.
--- The CONSTRAINT pk_loan PRIMARY KEY ensures that the loan_no is unique and cannot be null.
--- The CONSTRAINT forei_br_nm FOREIGN KEY ensures that the branch_name references a valid branch_name in the branch table.
--- The CONSTRAINT chk_am CHECK ensures that the amount is greater than or equal to 0.
--- The CONSTRAINT chk_loan_no CHECK ensures that the loan_no starts with 'L-'.
--- The CONSTRAINT nn_am NOT NULL ensures that the amount cannot be null.


DESCRIBE loan;



CREATE TABLE depositor (
  customer_id VARCHAR2(10),
  account_no CHAR(5),
  CONSTRAINT pk_cust_acc PRIMARY KEY (customer_id, account_no),
  CONSTRAINT fk_cust_id FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  CONSTRAINT fk_acc_no FOREIGN KEY (account_no) REFERENCES account(account_no)
);


--- Here we are creating a table named depositor with 2 columns: customer_id and account_no.
--- The customer_id column is a foreign key that references the customer_id column in the customer table.
--- The account_no column is a foreign key that references the account_no column in the account table.
--- The customer_id column is of type VARCHAR2(5), which means it can hold a string of up to 5 characters.
--- The account_no column is of type CHAR(5), which means it can hold a string of exactly 5 characters.
--- The CONSTRAINT pk_cust_acc PRIMARY KEY ensures that the combination of customer_id and account_no is unique and cannot be null.
--- The CONSTRAINT forei_cust_id FOREIGN KEY ensures that the customer_id references a valid customer_id in the customer table.
--- The CONSTRAINT forei_acc_no FOREIGN KEY ensures that the account_no references a valid account_no in the account table.
--- The CONSTRAINT nn_cust_id NOT NULL ensures that the customer_id cannot be null.


CREATE TABLE borrower (
  customer_id  VARCHAR2(5),
  loan_no      CHAR(5),
  CONSTRAINT pk_br_cust_loan PRIMARY KEY (customer_id, loan_no),
  CONSTRAINT fk_cust_id_br FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  CONSTRAINT fk_br_loan_no FOREIGN KEY (loan_no) REFERENCES loan(loan_no)
);

--- Here we are creating a table named borrower with 2 columns: customer_id and loan_no.
--- The customer_id column is a foreign key that references the customer_id column in the customer table.
--- The loan_no column is a foreign key that references the loan_no column in the loan table.
--- The customer_id column is of type VARCHAR2(5), which means it can hold a string of up to 5 characters.
--- The loan_no column is of type CHAR(5), which means it can hold a string of exactly 5 characters.
--- The CONSTRAINT pk_cust_loan PRIMARY KEY ensures that the combination of customer_id and loan_no is unique and cannot be null.
--- The CONSTRAINT forei_cust_id_br FOREIGN KEY ensures that the customer_id references a valid customer_id in the customer table.
--- The CONSTRAINT forei_loan_no FOREIGN KEY ensures that the loan_no references a valid loan_no in the loan table.


DESCRIBE borrower;


INSERT INTO branch(branch_name, branch_city, assets) VALUES ('A-1', 'Dhaka', 1000000);
INSERT INTO branch(branch_name, branch_city, assets) VALUES ('A-2', 'Sylhet', 2000000);


--- The above command is used to insert a new row into the branch table.
--- The branch_name is 'Dhanmondi', the branch_city is 'Dhaka', and the assets are 10000000.

SELECT * FROM branch;

INSERT INTO branch VALUES ('A-3', 'Chittagong', 3000000);
INSERT INTO branch VALUES ('A-4', 'Khulna', 4000000);


SELKECT * FROM branch;


INSERT INTO account VALUES('A-1', 'Banani', 10000);
INSERT INTO account VALUES('A-2', 'Dhanmondi', 20000);
INSERT INTO account VALUES('A-3', 'Gulshan', 30000);

--- The above command is used to insert a new row into the account table.


SELECT * FROM account;

SELECT branch_name FROM account;

-- The above command is used to select the branch_name column from the account table.


SELECT branch_name, branch_name FROM account;

CREATE TABLE employee(
    emp_id VARCHAR2(5),
    emp_name VARCHAR2(15),
    salary NUMBER(10,2) CONSTRAINT nn_sal NOT NULL,
);

ALTER TABLE employee ADD(
    blood_group VARCHAR2(3)
);

--- The above command is used to add a new column named blood_group to the employee table.
--- The blood_group column is of type VARCHAR2(3), which means it can hold a string of up to 3 characters.

ALTER TABLE employee RENAME emp_name TO emp_full_name;

ALTER TABLE employee ADD(
    emp_phone NUMBER(11)
);

--- The above command is used to add a new column named cell to the employee table.


ALTER TABLE employee MODIFY (emp_phone VARCHAR2(11));

--- The above command is used to modify the cell column in the employee table.



ALTER TABLE employee
ADD CONSTRAINT pk_emp_phn PRIMARY KEY (emp_phone);


--- The above command is used to add a primary key constraint named emp_cell to the cell column in the employee table.


CREATE TABLE ka AS SELECT * FROM employee;

--- The above command is used to create a new table named ka with the same structure and data as the employee table.
--- The new table ka will have the same columns and data types as the employee table.



INSERT ALL
  INTO branch (branch_name, branch_city, assets) VALUES ('Brighton', 'Brooklyn', 7100000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Downtown', 'Brooklyn', 9000000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Mianus', 'Horseneck', 400000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Northtown', 'Rye', 3700000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Perryridge', 'Horseneck', 1700000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Pownal', 'Bennington', 300000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Redwood', 'Palo Alto', 2100000)
  INTO branch (branch_name, branch_city, assets) VALUES ('Round Hill', 'Horseneck', 8000000)



COMMIT;
--- The above command commits the changes made to the branch table.

