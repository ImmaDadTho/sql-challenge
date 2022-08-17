--DATA ANALYSIS--

--1.List the following details of each employee: 
--employee number, last name, first name, sex, and salary.
select * from employees;

create view Basic_employee_info as
SELECT employees.employee_num as "Employee Number",
       employees.last_name as "Last Name", 
       employees.first_name as "First Name", 
       employees.sex as "Gender", 
       salaries.salary as "Salary"
FROM employees 
join salaries
on employees.employee_num = salaries.employee_num

--2. List first name, last name, and hire date for employees who were hired in 1986.
select * from employees;

create view employee_date_of_hire as
select first_name as "First Name", 
        last_name as "Last Name", 
        hire_date as "Date of Hire"
from employees 
where hire_date >= '19860101' and hire_date <='19861231'
order by hire_date;

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
select * from department_manager;
select * from departments;
select * from employees;

create view department_managers as

select departments.dept_num as "Department ID", 
       departments.dept_name as "Department Name",
       department_manager.employee_num as "Employee ID",
       employees.last_name as "Last Name ",
       employees.first_name as "First Name"
from departments 
join department_manager on department_manager.dept_num = departments.dept_num
join employees on employees.employee_num = department_manager.employee_num;


--4.List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
select * from departments;
select * from employees;
select * from department_employees;

create view employee_job_titles as

select employees.employee_num as "Employee ID", 
       employees.last_name as "Last Name",
       employees.first_name as "First Name",
       departments.dept_name as " Works In"
from employees 
join department_employees on employees.employee_num = department_employees.employee_num
join departments on department_employees.dept_num = departments.dept_num;

--5.List first name, last name, and sex for employees whose first name is 
--"Hercules" and last names begin with "B."

create view employess_name_hercules_b as

select first_name as "First Name", 
       last_name as "Last Name", 
       sex as "Gender"
from employees 
where first_name = 'Hercules' and last_name like 'B%'


--6. List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.

create view employees_in_sales as

select employees.employee_num as "Employee ID", 
       employees.last_name as "Last Name",
       employees.first_name as "First Name",
       departments.dept_name as " Works In"
from employees 
join department_employees on employees.employee_num = department_employees.employee_num
join departments on department_employees.dept_num = departments.dept_num
where dept_name = 'Sales';

--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

create view employees_in_sales_and_development as 

select employees.employee_num as "Employee ID", 
       employees.last_name as "Last Name",
       employees.first_name as "First Name",
       departments.dept_name as " Works In"
from employees 
join department_employees on employees.employee_num = department_employees.employee_num
join departments on department_employees.dept_num = departments.dept_num
where dept_name = 'Sales' or dept_name = 'Development';

--8.List the frequency count of employee last names 
--(i.e., how many employees share each last name) in descending order.
select * from employees;

create view frequency_of_lastNames as

select last_name as "Last Name", 
count (*) as "Frequency"
from employees
group by last_name having count (*) > 1; 
