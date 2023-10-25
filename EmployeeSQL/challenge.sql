DROP TABLE IF EXISTS departments; 
DROP TABLE IF EXISTS dept_emp; 
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS salaries; 

-----------------------------------------------------------------------------------------

CREATE TABLE departments (
  dept_no character varying(10) PRIMARY KEY, 
  dept_name character varying(50)
); 

CREATE TABLE dept_emp (
  emp_no integer NOT NULL,
  dept_no character varying(10),
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no)
); 

CREATE TABLE dept_manager (
  dept_no character varying(10),
  emp_no integer NOT NULL, 
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  PRIMARY KEY (emp_no, dept_no)
); 


CREATE TABLE employees ( 
  emp_no integer PRIMARY KEY, 
  emp_title_id character varying(50), 
  birth_date date NOT NULL, 
  first_name character varying(50), 
  last_name character varying(50), 
  sex character varying(5), 
  hire_date date NOT NULL,
  FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE titles (
  title_id character varying(10) PRIMARY KEY,
  title character varying(50)
);

CREATE TABLE salaries (
	emp_no integer not null,
	salary integer not null,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no), 
	PRIMARY KEY (emp_no, salary)
);


SELECT * FROM public.departments
SELECT * FROM public.dept_emp
SELECT * FROM public.dept_manager
SELECT * FROM public.employees
SELECT * FROM public.salaries
SELECT * FROM public.titles

------------------------------------------------------------------------------------------


--List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees 
JOIN salaries 
ON employees.emp_no = salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.


SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT (YEAR FROM hire_date) = 1986;



--List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dept_manager.dept_no, dept_name, employees.emp_no, last_name, first_name
FROM dept_manager 
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN employees 
ON dept_manager.emp_no = employees.emp_no;



--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, dept_emp.emp_no, last_name, first_name, dept_name
FROM employees 
JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no 
JOIN departments
ON dept_emp.dept_no = departments.dept_no; 



--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT employees.emp_no, last_name, first_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments 
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';



--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments 
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, count (last_name) 
FROM employees
GROUP BY last_name
ORDER BY count(last_name) desc;






