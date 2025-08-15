create database task2;
use task2;
create table departments(deptid int primary key,deptname varchar(50));
insert into departments values(1,'HR'),(2,'IT'),(3,'Sales'); 
Select *from departments; 
create table employees(empid int primary key,empname varchar(50),deptid int,salary 
int,hiredate date, 
foreign key(deptid) references departments(deptid)); 
INSERT INTO employees VALUES 
(101, 'John', 1, 50000, '2018-02-12'),
(102, 'Alice', 2, 60000, '2019-07-10'),
(103, 'Bob', 1, 55000, '2020-05-05'),
(104, 'Carol', 3, 45000, '2017-09-20');
select * from employees;
select empname from employees where deptid=(select deptid from departments 
where deptname='IT');
select *from employees where salary>50000;
select *from employees where hiredate<'2021-01-01'; 
select *from employees order by salary desc; 
select count(*) as total_count from employees; 
select Avg(salary) from employees;
select  deptid,max(salary) from employees group by deptid; 
select deptid from employees group by deptid having count(empid)>1; 
select *from employees where empname like 'A%';
select *from employees where salary>=45000 and salary<=60000;
select e.empname,d.deptname from employees e join departments d on e.deptid=d.deptid;
select deptid,count(*) as Numofemployees from employees group by deptid;
select e.*, d.deptname from employees e left join departments d on e.deptid = d.deptid;



