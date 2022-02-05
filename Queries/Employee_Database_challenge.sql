-- Deliverable 1
-- Retirement titles - holds all the titles of employees who were born between January 1, 1952 
-- and December 31, 1955.
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		ti.title,
		ti.from_date,
		ti.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows from retirement_titles table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Retiring titles - retrieve the number of employees by their most recent job title 
-- who are about to retire.
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;

-- Deliverable 2
-- Mentorship Eligibility - holds the employees who are eligible to participate in a 
-- mentorship program.
SELECT DISTINCT ON(e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
INTO mentorship_eligibilty
FROM employees AS e
	INNER JOIN dept_emp AS de 
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	     AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Additional queries for summary section
-- Total number of retirement-age employees
SELECT COUNT(ut.title)
FROM unique_titles AS ut

-- Numbers of mentors by title 
SELECT COUNT(me.title), me.title
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY me.count DESC;








