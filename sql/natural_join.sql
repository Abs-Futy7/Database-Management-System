/* NATURAL JOIN: Natural join matches tuples with the same values for all
common attributes, and retains only one copy of each common column */

select * from instructor natural join teaches; -- returns all attributes of instructors who have taught some course, with common attributes appearing only once

/* Q1: List the names of instructors along with the course ID of the courses that
they taught.
*/

select name, course_id from instructor natural join teaches;

-- another way:

select name, course_id from instructor, teaches
where instructor.ID = teaches.ID;

/*Q2 :List the names of instructors along with the the titles of courses that they
teach.
*/

select name, title from instructor natural join teaches, course
where instructor.ID = teaches.ID;

-- another way:

select name, title
from (instructor natural join teaches)
join course using(course_id);
