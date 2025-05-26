Table employees{
  emp_id int [pk]
  name varchar(50)
  designation enum('Teacher','Officer','3rd Class','4th Class')
  basic_salary decimal(10,2)
  increment decimal(10,2)
  promotion_guideline text
  division enum('Dhaka','Chattogram','Khulna','Barishal','Sylhet','Rajshahi','Rangpur')
  home_district varchar(30)
  cell_no varchar(11) [unique]
  marital_status enum('Married','Single','Divorced')
  date_of_birth date
  blood_group enum('A+','A-','B+','B-','O+','O-','AB+','AB-')
  workplace_id int [ref: > workplaces.workplace_id]
  residence_id int [ref: > residences.residence_id]
};

Table workplaces {
  workplace_id int [pk]
  workplace_name varchar(50)
  workplace_type enum('Department','Office','Hall Office')
}

Table residences {
  residence_id int [pk]
  building_name varchar(50)
  room_no varchar(10)
  type enum('Residential','Hall')
}

Table cars {
  car_id int [pk]
  emp_id int [ref: > employees.emp_id]
  car_name varchar(30)
  brand varchar(30)
  registration_year year
}

Table children {
  child_id int [pk]
  emp_id int [ref: > employees.emp_id]
  child_name varchar(40)
  education_level enum('Primary','Secondary','Higher Secondary','University')
  institution_name varchar(50)
}
