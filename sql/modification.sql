-- DELETE:

-- 1. Delete all instructors

delete from instructor;

-- 2. Delete all instructors from the Finance department

delete from instructor
 where dept_name = 'Finance';

-- 3. Delete all tuples in the instructor relation for those instructors
-- associated with a department located in the Watson building

delete from instructor
 where dept_name in (
   select dept_name
     from department
    where building = 'Waston'
);

-- 4. Delete all instructors with a salary between $13,000 and $15,000.

delete from instructor
 where salary between 13000 and 15000;


-- 5. Delete all instructors whose salary is less than the average salary of instructors

delete from instructor
 where salary < (
   select avg(salary)
     from instructor
);

-- INSERTION:

-- 1. Add a new tuple to course

insert into course values ( 'CS101',
                            'Intro to Computer Science',
                            4,
                            'Computer Science' );
insert into course (
   course_id,
   title,
   credits,
   dept_name
) values ( 'CS101',
           'Intro to Computer Science',
           4,
           'Computer Science' );

-- 2. Add a new tuple to student with tot_creds set to null

insert into students values ( 'John Doe',
                              '123 Main St',
                              '555-1234',
                              null );


-- 3. Make each student in the Music department who has earned more
-- than 144 credit hours, an instructor in the Music department, with a salary of $18,000.

insert into instructor
   select id,
          name,
          dept_name,
          18000
     from students
    where dept_name = 'Music'
      and tot_creds > 144;




-- UPDATE:

-- 1. Increase salaries of all instructor by 5 percent

update instructor
   set
   salary = salary * 1.05;


-- 2. increase the salary of the instructors by 7 percent with salary of less than $70,000

update instructor
   set
   salary = salary * 1.07
 where salary < 70000;


-- 3. Give a 5 percent salary raise to instructors whose salary is less than average

update instructor
   set
   salary = salary * 1.05
 where salary < (
   select avg(salary)
     from instructor
);

-- 4. Increase salaries of instructors whose salary is over $90,000 by 3%,
-- and all others receive a 5% raise

update instructor
   set
   salary = salary * 1.03
 where salary > 100000;
update instructor
   set
   salary = salary * 1.05
 where salary <= 100000;


update instructor
   set
   salary =
      case
         when salary <= 100000 then
            salary * 1.05
         else
            salary * 1.03
      end;



update student s
    set
    tot_cred = (
        select coalesce(sum(credits), 0)
          from takes
        natural join course
         where s.id = takes.id
            and takes.grade <> 'F'
            and takes.grade is not null
    );



-- Create table with same schema

create table temp_account as select * from account where 1=0;

create table temp_account as select * from account