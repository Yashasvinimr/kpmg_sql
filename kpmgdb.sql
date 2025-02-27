create or replace procedure print_message
is 
begin 
    dbms_output.put_line('Hi PLSQL');
end print_message;
/
set SERVEROUTPUT on size 30000;
execute print_message;

begin
    execute immediate 'Create table employee(
        employee_id number(10) primary key,
        first_name varchar2(50),
        last_name varchar2(50),
        performance_rating varchar2(100),
        salary number(10),
        department_id number(10),
        bonus number(10)
    )';
END ;

DECLARE
    cursor emp_cur is
        select * from employee;
    emp_rec emp_cur%ROWTYPE;
BEGIN
    open emp_cur ;
    loop
        fetch emp_cur into emp_rec ;
        exit when emp_cur%NOTFOUND ;
        dbms_output.put_line(emp_rec.employee_id || ' - ' || emp_rec.first_name
            || ' - ' || emp_rec.last_name || ' - ' || emp_rec.performance_rating
            || ' - ' || emp_rec.salary || ' - ' || emp_rec.department_id || ' - ' ||
            emp_rec.bonus);
    end loop;
    close emp_cur;
end;    

DECLARE
    name varchar2(50):='Mike';
    salary number := 5001;
begin
    insert into employee values(1, name, 'XYZ', salary, 50, 3, 5);
    commit;
end;
--DECLARE
--    name varchar2(50):='Mie';
--    salary number := 5001;
--begin
--    insert into employee values(1, name, 'XYZ', salary, 50, 50, 5);
--    commit;
--end;

select * from employee;

DECLARE
    dept_id number := 50;
    percent_increase number :=10;
begin 
    for emp in (select employee_id, salary from employee where department_id = dept_id) loop
        update employee set salary = emp.salary * (1+percent_increase/100)
        where employee_id = emp.employee_id;
    end loop;
    commit;
end;
begin
    update employee set department_id = 50;
end;
declare 
    bonus_rate number :=0.25;
begin 
    for emp in (select employee_id, performance_rating, salary from employee ) loop
        if emp.performance_rating <=4 then
            update employee set bonus = emp.salary * bonus_rate
            where employee_id = emp.employee_id;
        else
            update employee set bonus = 100
            where employee_id = emp.employee_id;
        end if;
    end loop;
    commit;
end;
begin
update employee set performance_rating = 4;
end;

BEGIN 
    for emp in(select employee_id from employee) LOOP
    
        UPDATE employee set performance_rating = 4
            where employee_id = emp.employee_id;
    end loop;
    commit;
end;
/
select * from employee;
DECLARE 
    emp_id number:=1;
    emp_name varchar2(50);
BEGIN
    SELECT first_name || '-' || last_name INTO emp_name
    from employee
    where employee_id = emp_id;
    dbms_output.put_line('EMPLOYEE Name ' || emp_name);
END;

CREATE OR REPLACE PROCEDURE get_employee_name (p_employee_id in number, p_employee_name out varchar2)
as
begin
    select first_name || '_' || last_name into p_employee_name
    from employee
    where employee_id = p_employee_id;
end;

DECLARE
    emp_id NUMBER :=1;
    emp_name varchar2(50);
BEGIN
    get_employee_name(emp_id, emp_name);
    dbms_output.put_line('EMPLOYEE Name ' || emp_name);
END;

CREATE OR REPLACE FUNCTION calculate_bonus(p_employee_id in number)
return number
is
    bonus number;
begin
    select salary into bonus
    from employee
    where employee_id = p_employee_id;
    bonus:=bonus*0.10;
    return bonus;
end;
declare 
    emp_id number:=1;
    expected_bonus number := 500;
    actual_bonus number;
begin
    actual_bonus := calculate_bonus(emp_id);
    if actual_bonus = expected_bonus then
         dbms_output.put_line('UNit test passed');
    else
         dbms_output.put_line('UNit tes t Failed');
    end if;
end;

/
begin
update employee set salary = 5000 where employee_id = 1;
end;
/
declare
    v_name varchar2(100);
BEGIN
     SELECT first_name || ' ' || last_name 
     into v_name
     from employee
     where employee_id = 1;
     DBMS_OUTPUT.PUT_LINE('Employee Name : ' || v_name);
EXCEPTION
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Employee Not Found');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('AN error occured');
END;

DECLARE
    v_grade char(1) := 'A';
BEGIN
    case v_grade
    when 'A' then
         DBMS_OUTPUT.PUT_LINE('Excellent');
    when 'B' then
         DBMS_OUTPUT.PUT_LINE('Good');
    when 'C' then
         DBMS_OUTPUT.PUT_LINE('Average');
    else
        DBMS_OUTPUT.PUT_LINE('Invalid Grade');
    end case;
end;

declare
    v_counter number := 1;
begin
    loop
        exit when v_counter > 5;
            DBMS_OUTPUT.PUT_LINE('Counter: ' || v_counter);
            v_counter := v_counter +1;
    end loop;
end;

declare
    v_counter number := 1;
begin
        while v_counter <= 5 loop
            DBMS_OUTPUT.PUT_LINE('Counter: ' || v_counter);
            v_counter := v_counter +1;
    end loop;
end;

--CREATE PROCEDURE add_employee(p_first_name varchar2, p_last_name varchar2, p_age number) AS
--begin
--    DBMS_OUTPUT.PUT_LINE('EMPLOYEE added: ' || p_first_name || ' ' || p_last_name || ' ' || p_ age);
--end add_employee;
--
--begin 
--    add_employee('PQR', 'MNO', 30);
--end;

create or replace function calculate_age(p_birth_date date) return number as
    v_age number;
begin 
    v_age := floor(months_between(sysdate, p_birth_date)/12);
    return v_age;
end calculate_age;

declare 
    v_birth_date date := to_date('1995-01-01', 'YYYY-MM-DD');
    v_age number;
begin
    v_age := calculate_age(v_birth_date);
    DBMS_OUTPUT.PUT_LINE('Age: ' || v_age);
end;

Create or REPLACE procedure get_employee_info(
    p_employee_id IN number,
    p_first_name OUT varchar2,
    p_last_name OUT varchar2,
    p_salary IN OUT number
) as
begin
    select first_name, last_name
    into p_first_name, p_last_name
    from employee
    where employee_id = p_employee_id;
    
    select floor(salary/12)
    into p_salary
    from employee
    where employee_id = p_employee_id;
end get_employee_info;

declare 
    v_employee_id number :=1;
    v_first_name varchar2(50);
    v_last_name varchar2(50);
    v_salary number := 5501;
begin
    get_employee_info(v_employee_id, v_first_name, v_last_name, v_salary);
    DBMS_OUTPUT.PUT_LINE('Employee:' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('Salary:' || v_salary);
end get_employee_info;

begin
        execute immediate 'create table accounts(account_id number primary key,
        account_name varchar2(100), balance number(10, 2))';
            DBMS_OUTPUT.PUT_LINE('Account table created successfully');
exception when others then
    DBMS_OUTPUT.PUT_LINE('Errors creating accounts table'|| SQLERRM);
end;
DECLARE 
    a_name varchar2(50):='LAKSHMI';
    a_balance number := 100000;
begin
    execute immediate 
    'insert into accounts values(2, Poornima, 20000)';
    DBMS_OUTPUT.PUT_LINE('Account insertion done successfully');
exception when others then
    DBMS_OUTPUT.PUT_LINE('Errors inserting to accounts table'|| SQLERRM);
end;
    