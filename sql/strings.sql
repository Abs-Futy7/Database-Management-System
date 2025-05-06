/*
percent (%). The % character matches any substring.
underscore (_). The _ character matches any character.

Pattern matching examples:
● ‘Intro%’ matches any string beginning with “Intro”.
● ‘%Comp%’ matches any string containing “Comp” as a substring.
● ‘_ _ _’ matches any string of exactly three characters.
● ‘_ _ _ %’ matches any string of at least three characters.

SQL supports a variety of string operations such as
● concatenation (using “||”)
● converting from upper to lower case (and vice versa)
● finding string length, extracting substrings, etc. */

--  Find the names of all instructors whose name includes the substring “dar”.

select name from instructor
where name like '%dar%';


-- ORDER

-- List in alphabetic order the names of all instructors

select name from instructor order by name; -- ascending order (default)
select name from instructor order by name desc; -- descending order

