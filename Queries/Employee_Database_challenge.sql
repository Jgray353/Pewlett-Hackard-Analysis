-- Create a Retirement Titles table that holds all the titles of current employees who were born between January 1, 1952 and December 31, 1955
SELECT employees.emp_no,
	employees.first_name,
    employees.last_name,
	titles.title,
    titles.from_date,
    titles.to_date
INTO retirement_titles
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no

SELECT * FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, 
	first_name, 
    last_name, 
    title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(title), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

-- Query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligible 
FROM employees AS em
LEFT JOIN dept_emp AS de
ON em.emp_no = de.emp_no
LEFT JOIN titles AS ti
ON em.emp_no = ti.emp_no
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no;

SELECT * FROM mentorship_eligible;

