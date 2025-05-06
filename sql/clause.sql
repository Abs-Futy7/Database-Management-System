-- SELECT : lists the attributes desired in the result set

SELECT name FROM instructor;  -- returns the name of all instructors

-- DISTINCT : to force elements to be unique in the result set
-- ALL : to force elements to be non-unique in the result set (default)

/* Q1: Find the names of all departments with instructor, and remove
duplicates */

SELECT DISTINCT dept_name FROM instructor;

/* Q2: Find the names of all departments with instructor */

SELECT ALL dept_name FROM instructor;

SELECT * FROM instructor;  -- returns all attributes of all instructors

-- WHERE : specifies conditions that the result must satisfy

/* Q3 : To find all instructors in Comp. Sci. dept with salary > 80000 */

SELECT * FROM instructor WHERE dept_name = 'Comp. Sci.' AND salary > 80000;


-- FROM : specifies the table from which to retrieve data

SELECT * FROM instructor, teaches; --generates every possible instructor – teaches pair, with all attributes from both relations

-- JOIN : combines tuples from two relations based on a common attribute

/* Q4: For all instructors who have taught some course, find their names
and the course ID of the courses they taught.*/

SELECT names, course_id FROM instructor, teaches WHERE instructor.ID = teaches.ID;

/* Q5: Find the course ID, semester, year and title of each course offered
by the Comp. Sci. department. */

SELECT course_id, semester, year, title FROM section, course
WHERE section.course_id = course.course_id
AND dept_name = 'Comp. Sci.';


-- rename

select id, names, salary/12 as monthy_salary from instructor; -- renames the result set to monthy_salary

/* Q6; Find the names of all instructors who have a higher salary than
some instructor in ‘Comp. Sci’ */

select distinct T.name from instructor T, instructor S
where T.salary > S.salary and S.dept_name = 'Comp. Sci.';


/*Q7: Find the names of all instructors with salary between
$90,000 and $100,000 (that is, ≥ $90,000 and ≤ $100,000)*/

select name from instructor where salary between 90000 and 100000;

-- tuple comparison
-- tuple comparison is a shorthand for multiple comparisons

select name, course_id from instructor, teaches
where (instructor.ID, dept_name) = (teaches.ID, 'Comp. Sci.'); -- returns the names of all instructors who have taught some course in the Comp. Sci. department


