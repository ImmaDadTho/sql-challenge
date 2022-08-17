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