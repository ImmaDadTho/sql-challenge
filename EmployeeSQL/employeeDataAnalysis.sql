-- 1. create title  table
create table titles 
(   
    titleid varchar primary key,
    title varchar
);

--1A.query titles table to check if it loaded data successfully
select * from titles
limit 5 ;

--2. create employee table and connect it to titles table with foreign key
create table employees
(
    employee_num int primary key,
    emp_title_id varchar,
    birth_date date, 
    first_name varchar,
    last_name varchar,
    sex varchar,
    hire_date date,
    foreign key (emp_title_id) references titles(titleid)
);

--2A. query employees table to check if it loaded data successfully
select * from employees
limit 5 ;

--3. create department table 
create table departments
(
    dept_num varchar primary key,
    dept_name varchar
);

--3A. query department table to check if it loaded data successfully
select * from departments
limit 5;

--4. create department table with composite key and 
--reference department table and employee tabel
create table department_manager
(
   dept_num varchar,
   employee_num int,
   foreign key (dept_num) references departments(dept_num),
   foreign key (employee_num) references employees(employee_num),
   primary key (dept_num, employee_num)
);

--4A. query department_manager table to check if it loaded data successfully
select * from department_manager
limit 5;

--5. create department_employees table with composite key and 
--reference employee and department table
create table department_employees
(
    employee_num int,
    dept_num varchar,
    foreign key (employee_num) references employees(employee_num),
    foreign key (dept_num) references departments(dept_num),
    primary key (employee_num, dept_num)
);

--5A. query department_employees table to check if it loaded data successfully
select * from department_employees
limit 5;

--6. create salaries table and reference to employee table
create table salaries 
(
    employee_num int,
    salary int,
    foreign key (employee_num) references employees(employee_num)
);

--6A. query salary table to check if it loaded data successfully
select * from salaries
limit 5;

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
