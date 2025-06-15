# Tuple Relational Calculus in DBMS

Tuple Relational Calculus (TRC) is a non-procedural query language used in relational databases. It describes what to retrieve rather than how to retrieve it. In TRC, queries are expressed as formulas with tuple variables.

## Syntax

A typical TRC query has the form:
```
{ t | P(t) }
```
- `t` is a tuple variable.
- `P(t)` is a predicate (logical formula) involving `t`.

## Example Schema

Consider a relation:
```
Student(RollNo, Name, Dept, Age)
```

## Predicate Calculus Formula

In TRC, queries are based on **predicate calculus formulas**. A predicate calculus formula is a logical expression built using:

- **Predicates:** Statements about tuples (e.g., `Student(t)`).
- **Logical connectives:** AND (`∧`), OR (`∨`), NOT (`¬`).
- **Comparison operators:** `=`, `≠`, `<`, `>`, `≤`, `≥`.
- **Quantifiers:**  
    - **Existential (`∃`)**: There exists a tuple satisfying a condition.  
    - **Universal (`∀`)**: All tuples satisfy a condition.

**Example of a predicate calculus formula:**
```
Student(t) ∧ t.Age > 20
```
This formula states that `t` is a tuple in `Student` and `t.Age` is greater than 20.

Formulas can be combined and nested using logical connectives and quantifiers to express complex queries.

## Example Queries

**1. Find names of students in the 'CSE' department:**
```text
{ t.Name | Student(t) ∧ t.Dept = 'CSE' }
```

**2. Find students older than 20:**
```text
{ t | Student(t) ∧ t.Age > 20 }
```

**3. Find students with age between 18 and 22:**
```text
{ t.Name | Student(t) ∧ t.Age ≥ 18 ∧ t.Age ≤ 22 }
```

## Universal Quantification in TRC

Universal quantification (`∀`) allows you to express queries where a condition must hold for all tuples in a relation. In TRC, universal quantification is often used to state that a tuple satisfies a property with respect to all tuples in another relation.

**Example:**  
Find all students who have taken all courses offered in the Biology department.

Suppose we have the following relations:
- `student(ID, Name, ...)`
- `course(course_id, dept_name, ...)`
- `takes(ID, course_id, ...)`

The TRC query can be written as:
```
{ t | ∃ r ∈ student (t[ID] = r[ID]) ∧
    (∀ u ∈ course (u[dept_name] = "Biology" ⇒
       ∃ s ∈ takes (t[ID] = s[ID] ∧ s[course_id] = u[course_id])
    ))
}
```
This means: select all students `t` such that for every course `u` in the Biology department, there exists a tuple `s` in `takes` showing that student `t` has taken course `u`.

Universal quantification is powerful for expressing "for all" conditions, such as "has completed every required course" or "is enrolled in all classes of a department."


## Safety Expression

A TRC query is **safe** if it returns a finite set of results from the database. Unsafe queries may refer to values not present in the database, leading to infinite results.

**Safe Query Example:**
```text
{ t | Student(t) ∧ t.Age > 20 }
```
This is safe because it only returns tuples from the `Student` relation.

**Unsafe Query Example:**
```text
{ t | ¬Student(t) }
```
This is unsafe because it refers to all tuples not in `Student`, which could be infinite.

**Safety Condition:**  
A query is safe if all values in the result are drawn from the active domain (values appearing in the database).

## Summary

- TRC is declarative and uses logical predicates.
- Safety expressions ensure queries return finite, meaningful results.
- Always write safe queries to avoid infinite or undefined outputs.