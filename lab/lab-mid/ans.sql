CREATE TABLE workplaces (
  workplace_id NUMBER PRIMARY KEY,
  workplace_name VARCHAR2(50),
  workplace_type VARCHAR2(20) CHECK (workplace_type IN ('Department','Office','Hall Office'))
);

CREATE TABLE residences (
  residence_id NUMBER PRIMARY KEY,
  building_name VARCHAR2(50),
  room_no VARCHAR2(10),
  type VARCHAR2(15) CHECK (type IN ('Residential','Hall'))
);

CREATE TABLE employees (
  emp_id NUMBER PRIMARY KEY,
  name VARCHAR2(50),
  designation VARCHAR2(15) CHECK (designation IN ('Teacher','Officer','3rd Class','4th Class')),
  basic_salary NUMBER(10,2),
  increment NUMBER(10,2),
  promotion_guideline CLOB,
  division VARCHAR2(15) CHECK (division IN ('Dhaka','Chattogram','Khulna','Barishal','Sylhet','Rajshahi','Rangpur')),
  home_district VARCHAR2(30),
  cell_no VARCHAR2(11) UNIQUE,
  marital_status VARCHAR2(10) CHECK (marital_status IN ('Married','Single','Divorced')),
  date_of_birth DATE,
  blood_group VARCHAR2(3) CHECK (blood_group IN ('A+','A-','B+','B-','O+','O-','AB+','AB-')),
  workplace_id NUMBER REFERENCES workplaces(workplace_id),
  residence_id NUMBER REFERENCES residences(residence_id)
);

CREATE TABLE cars (
  car_id NUMBER PRIMARY KEY,
  emp_id NUMBER REFERENCES employees(emp_id),
  car_name VARCHAR2(30),
  brand VARCHAR2(30),
  registration_year NUMBER(4)
);

CREATE TABLE children (
  child_id NUMBER PRIMARY KEY,
  emp_id NUMBER REFERENCES employees(emp_id),
  child_name VARCHAR2(40),
  education_level VARCHAR2(16) CHECK (education_level IN ('Primary','Secondary','Higher Secondary','University')),
  institution_name VARCHAR2(50)
);
