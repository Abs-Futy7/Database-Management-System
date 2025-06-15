# Domain Relational Calculus (DRC)

Domain Relational Calculus (DRC) is a non-procedural query language for relational databases. Unlike SQL, which specifies *how* to retrieve data, DRC focuses on *what* data to retrieve by describing the properties of the desired result.

## Syntax

A typical DRC query has the form:
```
{ <x1, x2, ..., xn> | P(<x1, x2, ..., xn>) }
```
- `<x1, x2, ..., xn>` are domain variables that take values from attribute domains.
- `P` is a formula involving these variables, logical connectives (∧, ∨, ¬), comparison operators, and quantifiers (∃, ∀).

## Example

Suppose we have a relation `Student(Name, Age, Major)`.

**Query:** Find the names of all students majoring in 'CS'.

DRC expression:
```
{ <n> | ∃a ∃m (Student(n, a, m) ∧ m = 'CS') }
```

## Safety Expression

A DRC query is **safe** if it returns a finite set of results, i.e., all values in the result are from the database domain. Unsafe queries may return infinite results, which is undesirable.

**Unsafe Example:**
```
{ <n> | ¬Student(n, a, m) }
```
This query could return all possible names not in the database, which is infinite.

**Safe Example:**
```
{ <n> | ∃a ∃m (Student(n, a, m) ∧ m = 'CS') }
```
This only returns names present in the `Student` relation.

## Universal Quantification

Universal quantification (∀) is used to express "for all" conditions.

**Example:** Find names of students who have taken all courses.

Suppose `Takes(Name, Course)` and `Course(Course)`.

DRC expression:
```
{ <n> | ∀c (Course(c) → ∃co (Takes(n, co) ∧ co = c)) }
```
This means: For every course `c`, there exists a course `co` such that student `n` has taken `co` and `co = c`.

## Example Queries

1. **Find students older than 20:**
    ```
    { <n> | ∃a ∃m (Student(n, a, m) ∧ a > 20) }
    ```

2. **Find students who are not majoring in 'Math':**
    ```
    { <n> | ∃a ∃m (Student(n, a, m) ∧ m ≠ 'Math') }
    ```

## DRC vs. Tuple Relational Calculus (TRC)

| Feature         | DRC                                         | TRC                                         |
|-----------------|---------------------------------------------|---------------------------------------------|
| Variables       | Range over domain values (attributes)        | Range over tuples (rows)                    |
| Syntax          | `{ <x1, x2, ..., xn> | P(<x1, ..., xn>) }`   | `{ t | P(t) }`                              |
| Example         | `{ <n> | ∃a ∃m (Student(n, a, m)) }`         | `{ t | Student(t) ∧ t.Major = 'CS' }`       |
| Expressiveness  | Equivalent to TRC                            | Equivalent to DRC                           |

**Summary:**  
- DRC uses domain variables for attributes, while TRC uses tuple variables.
- Both are declarative and have the same expressive power.
