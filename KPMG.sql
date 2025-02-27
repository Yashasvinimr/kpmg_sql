CREATE DATABASE sql_concept;
use sql_concept;

create table dept_tab(
deptno varchar(5),
dname varchar(50),
mgr_id varchar(10),
location_id varchar(10),
constraint pk_dept_tab PRIMARY KEY (deptno));

describe dept_tab;

create table emp_tabl(
empno varchar(5),
ename varchar(50) not null,
job varchar(50),
manager varchar(50),
hiredate DATE,
salary int(20),
commision varchar(20),
deptno varchar(5),
CONSTRAINT pk_emp_tab primary key (empno),
CONSTRAINT fk_dept_tab foreign key (deptno) references dept_tab(deptno));
describe emp_tabl;

create table country_tab(
country_id varchar(5),
country_name varchar(50),
constraint pk_country_tab primary key(country_id));
desc country_tab;
create table state_tab(
state_id varchar(10),
state_name varchar(50),
country_id varchar(5),
CONSTRAINT pk_state_tab primary key (state_id),
CONSTRAINT fk_country_tab foreign key (country_id) references country_tab(country_id));
desc state_tab;

insert into dept_tab(deptno, dname, mgr_id, location_id) values (30, 'Purchasing', 100, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (40, 'Human Resources', 114, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (70, 'Public relations', 125, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (80, 'Sales', 105, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (90, 'Executives', 100, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (100, 'Finances', 114, 1700);
insert into dept_tab(deptno, dname, mgr_id, location_id) values (110, 'Accounting', 100, 1700);

select * from dept_tab;
select count(*) from dept_tab;

insert into emp_tabl values(8000, 'KING', 'PRESIDENT', null, str_to_date('17-11-2005', '%d-%m-%Y'),5000, null, 40);
select * from emp_tabl; 
insert into emp_tabl values(7000, 'KING', 'PRESIDENT', null, '2005-11-17' ,5000, null, 40);
insert into emp_tabl values(9000, 'CLARK', 'VICE PRESIDENT', null, str_to_date('17-11-2005', '%d-%m-%Y'),5000, null, 40);
insert into emp_tabl values(6000, 'JONES', 'PRESIDENT', null, str_to_date('16-12-2007', '%d-%m-%Y'),6500, null, 70);
insert into emp_tabl values(5000, 'SCOTT', 'Manage', null, str_to_date('07-10-2015', '%d-%m-%Y'),7500, null, 80);
insert into emp_tabl values(4000, 'LARRY', 'Analyst', null, str_to_date('08-11-2005', '%d-%m-%Y'),600, null, 100);
insert into emp_tabl values(3000, 'RACHEL', 'Analyst', null, str_to_date('17-11-2005', '%d-%m-%Y'),5000, null, 30);
insert into emp_tabl values(1000, 'RACHEL', 'Analyst', null, str_to_date('17-11-2005', '%d-%m-%Y'),3000, null, 30);

insert into country_tab values(1, 'India');
insert into country_tab values(2, 'USA');
insert into country_tab values(3, 'Canada');
select * from country_tab;

insert into state_tab values(1, 'California', 2);
insert into state_tab values(2, 'Texas', 1);
insert into state_tab values(3, 'Karnataka', 1);

select * from state_tab;


select empno, 10*(salary+100) as 'Updated Salary' from emp_tabl;
select concat(ename, ' belong to ', deptno, ' department number ') as "employee department dta" from emp_tabl;
select count(distinct deptno) from emp_tabl;
select * from emp_tabl;
select distinct deptno, ename from emp_tabl;

select empno, ename, salary from emp_tabl where ename!='KING';
select empno, ename, salary from emp_tabl where deptno in (30, 40) ;

select empno, ename, salary, manager from emp_tabl where manager is not null;
select empno, ename, salary,deptno, manager from emp_tabl where deptno=30 or deptno=40 and salary>4200;
select empno, ename, salary,deptno, manager from emp_tabl where (deptno=30 or deptno=40) and salary>4200;

select empno, ename, salary,deptno, manager from emp_tabl order by salary, ename desc;
select substr('Hello Everyone', 7, 5) as 'Sunstring Message' from dual;

create table state_tab2(
state_id varchar(10),
state_name varchar(50),
country_id varchar(5),
CONSTRAINT pk_state_tab2 primary key (state_id),
CONSTRAINT fk_country_tab2 foreign key (country_id) references country_tab(country_id));

insert into state_tab2 select * from state_tab;
select * from state_tab2;