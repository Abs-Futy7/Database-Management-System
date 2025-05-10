# SQL String Operations and Pattern Matching

## Pattern Matching
- **Percent (%)**: Matches any substring.  
- **Underscore (_)**: Matches any single character.

### Examples:
- `'Intro%'` matches any string beginning with "Intro".  
- `'%Comp%'` matches any string containing "Comp" as a substring.  
- `'___'` matches any string of exactly three characters.  
- `'___%'` matches any string of at least three characters.

## String Operations
SQL supports a variety of string operations, such as:
- **Concatenation**: Using `||`.  
- **Case Conversion**: Converting from upper to lower case (and vice versa).  
- **Other Operations**: Finding string length, extracting substrings, etc.

---

## Examples

### Find the names of all instructors whose name includes the substring "dar":
```sql
SELECT name 
FROM instructor
WHERE name LIKE '%dar%';
```

### List the names of all instructors in alphabetical order:
- **Ascending Order** (default):
```sql
SELECT name 
FROM instructor 
ORDER BY name;
```

- **Descending Order**:
```sql
SELECT name 
FROM instructor 
ORDER BY name DESC;
```