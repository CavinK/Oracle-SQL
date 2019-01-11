-- HR session

select * from employees where employee_id = 100;
select * from employees where employee_id = 101;
select * from employees where employee_id = 102;
-- ������� �ٸ� => �ٸ� ���� ��ȹ���� �ν� => ���� �ٸ� LCO ����
-- => ���� ó���� �ذ�!(PLSQL)

/*
# SQL Plus
------------------
conn hr/hr
var b_id number         <- b_id: ���ε� ����(number Ÿ��), number Ÿ�Կ��� size�� ���� ����
print b_id              <- bind variable�� ���!!!

execute :b_id := 100    <- ���� �Ҵ�(: ���)
select * from employees where employee_id = :b_id;  <- ���ε� �ܰ�

exec :b_id := 200       <- �ٸ� ���� �Ҵ�
------------------
var b_name varchar2(30) <- b_name: ���ε� ����(char Ÿ��), size �� ������ 1����Ʈ�� �ڵ� ����(default)
exec :b_name:='King'
print b_name 
select * from employees where last_name = :b_name;

exec :b_name:='Grant'
print b_name
select * from employees where last_name = :b_name;

var v_id number(1)      <- to figure out each type
*/
-- ���ε� ����: ����â�� �����ִ� ������ ��� ������
--             (���� ������ ������ ���ε� ������ �������)
-- ������: ���ε� �ܰ迡 ��(:b_id���� employee_id��)

-- �޴� -> ���� -> DBMS��� -> hr ����
-- SQL Plus���� ������ ����, set serveroutput on�� ���� �����ϰ� �����ϱ�
-- SQL Plus: l ���� => ���� ��ɾ� // / ���� => ��µ� ���

-- PL/SQL <- ��� ���� ����!!!
begin
      dbms_output.put_line('������');
      dbms_output.put_line('���õ� �ູ�ϴ�!!');
end;
/

declare
        /* scalar data type(���ϰ��� �����ϴ� ����) */
        v_a number(7); -- �ش� ���α׷� �ȿ����� ���Ǵ� ����(��������) <- ���� ���� �ڿ��� �� ;�� �ݾ��ֱ�, ������ "�ϳ�����" �����ϱ�!
        v_b number(3) := 100; -- �ʱⰪ �Ҵ� // '100'��� �ص� ���� ������ ����!(but �� ��ȯ ����)
        v_c varchar2(10) not null := 'plsql'; -- not null �������� �߰�, ���⿡ �ʱⰪ ���� �� �ϸ� ����!(exception)
        v_d constant date default sysdate; -- �Ҵ翬����(:=)�� default�� ���� �ǹ�!
                                           -- constant: ����� �����ϴ� Ű����(�ٸ� ���� ���� �� ����, �ʱⰪ�� ��� ����) => ����� �������� ���� ������ �ʱⰪ ����!
begin
        v_a := 200; -- �������� �������� ��ü ����!
        v_b := 300;
        dbms_output.put_line('v_a ������ �ִ� ���� :' || v_a); -- ���� ���� ������ + NULL�� ����!
                                                            -- �����ϸ�, v_a�� NULL, v_b�� �ʱⰪ ����
        dbms_output.put_line('v_b ������ �ִ� ���� :' || v_b);
        dbms_output.put_line('v_c ������ �ִ� ���� :' || v_c);
        dbms_output.put_line('v_d ������ �ִ� ���� :' || v_d);
        
        v_a := 200; 
        v_b := 300;
        v_d := sysdate+1; -- exception!(��� ���� �߱� ���� cf. �� ��: ���� ����)
        dbms_output.put_line('v_a ������ �ִ� ���� :' || v_a); 
        dbms_output.put_line('v_b ������ �ִ� ���� :' || v_b);
        dbms_output.put_line('v_c ������ �ִ� ���� :' || v_c);
        dbms_output.put_line('v_d ������ �ִ� ���� :' || v_d);
        
        v_a := 200; 
        dbms_output.put_line('v_a ������ �ִ� ���� :' || v_a); 
        dbms_output.put_line('v_b ������ �ִ� ���� :' || (v_b+100)); -- ��ȣ ���ָ� exception!(�켱���� �߻�, ���ڿ��� ���ڸ� �� �� �� ������ numeric or value error �߻�)
        dbms_output.put_line('v_c ������ �ִ� ���� :' || v_c);
        dbms_output.put_line('v_d ������ �ִ� ���� :' || (v_d+10)); -- ����� �̷��� ����!
end;
/

-- ������ ���α׷� �ٱ����� �����ϰ� ���� ���, �ٱ��� �ִ� ������ ������ �鿩�;� �ϴ� ���
-- bind variable: global variable, public variable, ��������

declare
        v_sal number := 1000;
        v_comm number := 100;
        v_total number;
begin
        v_total := v_sal + v_comm;
        dbms_output.put_line(v_total);
end;
/
select * from employees where salary > v_total; -- v_total�� ���� ������ ���α׷� �ۿ��� ���� �� ��(���� ������ ����)

-- bind variable 3�� ����
var b_total number -- var������ number�� ������ �������� ����!(char�� ���)
var b_sal number
var b_comm number -- ; �� �ᵵ ��(bind variable�� ���α׷� �ٱ����� �����ؾ�!)
                  -- bind variable: session�� ���� ������ �����

exec :b_sal := 10000
exec :b_comm := 1000

declare
        v_sal number := :b_sal;
        v_comm number := :b_comm;
begin
        :b_total := v_sal + v_comm;
        dbms_output.put_line(:b_total);
end;
/
select * from employees where salary > :b_total; -- SQL Plus���� ����!
-- global variable: �Է�/���� ���� BUT declare������ ������ �� ����!(bind variable �̿��ؾ�!)
-- bind variable(host variable <- ���α׷� �ٱ����� ����� ����) <- SQL ���� ����(SQL Plus, SQL Developer)
-- => package�� ������!



-- # ���� ���� �� �����ؾ� �� ��
-- ���� �̸�
-- - ���ڷ� �����ؾ� �Ѵ�.
-- - ����, ����, Ư������(_, $, #) ������ �� �ִ�.
-- - ���� ���̴� 30�� ������ ���ڷθ� ����ؾ� �Ѵ�.
-- - ������ ��� �� �Ѵ�(ex. declare, begin, end, exception, select, insert, ...)

-- ������ ������ �ÿ� not null, constant�� ������ �������� �ʱⰪ�� ������ �Ҵ��ؾ� �Ѵ�.
-- �Ҵ翬����(:=, default)
-- �� �ٿ� �ϳ����� ����!

declare
        v_name varchar2(20); -- local, private ����
begin
        dbms_output.put_line('my name is : ' || v_name); -- ���� || null => ����
        v_name := 'james';
        dbms_output.put_line('my name is : ' || v_name);
        v_name := 'ȫ�浿';
        dbms_output.put_line('my name is : ' || v_name);
end;
/



-- # subblock(��ø ����)
declare
        v_sal number(8,2) := 60000; -- number(8,2): 8�ڸ� �߿� 2�ڸ��� �Ҽ�
                                    -- ���� ������ ���� �ߺ� �� ��!!!(���� �ϳ��� ����)
                                    -- subblock������ ���� ����
        v_comm number(8,2) := v_sal * 0.20;
        v_message varchar2(100) := ' eligible for commission';
begin
        declare
                v_sal number(8,2) := 50000; -- block�� �ٸ��� ������, �ٸ� ������ �������� // �ڱ� ��Ͽ� �ִ� �������� ���� ����� �װͺ��� �켱��!
                v_comm number(8,2) := 0;
                v_total number(8,2) := v_sal + v_comm;
        begin
                dbms_output.put_line(v_total);
        end;
        
        declare
                -- v_sal number(8,2) := 50000; -- �ּ� ó�� => �ϴ� �ڱ� ��Ͽ� �ش� ������ ã�� �� ������ ���� ����� �˻�
                -- v_comm number(8,2) := 0;
                v_total number(8,2) := v_sal + v_comm;
        begin
                dbms_output.put_line(v_total);
        end;
        
        declare
                v_sal number(8,2) := 50000; 
                v_comm number(8,2) := 0;
                v_total number(8,2) := v_sal + v_comm;
        begin
                v_message := 'clerk not ' || v_message; -- ���κ���� ������ �ٿ��� overriding ����!
                dbms_output.put_line(v_total); -- �������� ���� ����
                dbms_output.put_line(v_sal);
                dbms_output.put_line(v_comm);
                dbms_output.put_line(v_message);  -- ���κ���� ����!
        end;
        dbms_output.put_line(v_sal); -- ���κ���� ���� ����
        dbms_output.put_line(v_comm);
        dbms_output.put_line(v_message);
        dbms_output.put_line(v_total); -- ����!(�����Ͽ����� ���κ���� ������ �� ������, �� �ݴ�� �� ��) // �������� ������ �����Ͽ����� ��� ����
                                       -- v_total�� ��� ���� ������, global variable �̿�!
end;
/

<<outer>> -- label
declare
        v_sal number(8,2) := 60000; 
        v_comm number(8,2) := v_sal * 0.20;
        v_message varchar2(100) := ' eligible for commission';
begin
        declare
                v_sal number(8,2) := 50000; 
                v_comm number(8,2) := 0;
                v_total number(8,2) := v_sal + v_comm;
        begin
                outer.v_sal := 70000; -- �ش� label(outer)�� �������� �ƿ� ���� ���� // outer �� ���� �������� v_sal�� ����
                v_message := 'clerk not ' || v_message; 
                dbms_output.put_line(v_total);
                dbms_output.put_line(v_sal);
                dbms_output.put_line(outer.v_sal); -- �ٱ� ����� ������� ��
                                                   -- ���κ�ϰ� �������� �������� ������ ���, label�� ��!
                dbms_output.put_line(v_comm);
                dbms_output.put_line(v_message); 
        end;
        dbms_output.put_line(v_sal); -- �̰͵� 70000���� ����(������ �����Ͽ��� �Ѿ���� ���̱� ����)
        dbms_output.put_line(v_comm);
        dbms_output.put_line(v_message);
end;
/

-- # ����
-- � ���� �ӽ÷� ������ �� ���� �������� ������ �����ؼ� ����Ѵ�
/*
## scalar data type ����: ���ϰ��� �����ϴ� ����
- �͸���: oracle db �ȿ� �� ���α׷��� ����Ǿ� ���� ���� <- ���� ���������� ������ �����鼭 �Ź� �� �ҽ� ������ ���� 
           <- ������ ������ �Ź� compile�ؾ� ��(shared pool�� ���� ������ ���α׷��� �� ���� => library cache�� �ִ� �� Ȯ�� => ������ ���� ��ȹ ���� ����)
           <- ������ �͵��� aging out��(v$sql���� executions ���� Ȯ��) 
           => hard parsing�� ���!(object ������ ���α׷��� ���� �ʿ䰡 ���� => reparsing ����)
- �͸���: object(select, DML) ���Ѹ� ������ ��!
- �͸����� ���� 1. reparsing ���
                2. share �� ��(oracle db �ȿ� �� ���α׷��� ����Ǿ� ���� �ʱ� ����) => �ٸ� ����鵵 ���� �ҽ��� ������ �־�� �� => object ������ ���α׷�!(�ý��� ���� �ʿ�) <- select * from user_sys_privs;
                3. �Է°�(:b_id) ó�� �� tool���� �����ϴ� ��(bind variable) �ۿ� ��� �� ��
*/
select * from user_sys_privs; -- user�� ������ �ִ� ���� Ȯ��
select * from user_tab_privs; -- object ����
-- create procesure: procedure �Լ� ��Ű���� ���� ����
-- �������ǵ��� Ʈ���ŷ� ¥���� ����(�ڵ� ����)

/*
declare
          ���� ����;
          �ӽ��� Ŀ�� ����;
          ����ڰ� ������ ���ܻ��� ����;
begin
          ��������;
          select;
          dml;
          commit, rollback, savepoint;
exception
          ����κп��� �߻��� ���� ó���ϴ� �κ�;
end;
/
*/

-- PL/SQL�� ������ ���
-- => �ϳ��� Ʋ���� ���� logic���� ���� ���� �� ��
-- => ������ �߻��ϴ��� �� �����ؾ� �� logic�� �ִ� ���
-- => subblock ���!!!
declare
        v_name varchar2(20) := 'ȫ�浿';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('�л� �̸��� ' || v_name);
        dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name varchar2(20) := '����ȣ';
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '�����'; -- �������� �����͸� ������Ʈ��
                dbms_output.put_line('�л� �̸��� ' || v_name);
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
        end; -- ���κ�ϰ� �������� �����ʹ� �ٸ� ������ �����!(�������� �����ʹ� ����Ǵ� ���� �������� ���κ���� ������ ���)
end;
/

<<outer>>
declare
        v_name varchar2(20) := 'ȫ�浿';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('�л� �̸��� ' || v_name);
        dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
        declare
                -- v_name varchar2(20) := '����ȣ'; <- �ּ�ó�� => ���κ���� �����͸� ã�� => ������ ����!
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '�����';
                dbms_output.put_line('�л� �̸��� ' || v_name);
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('�л� �̸��� ' || outer.v_name); -- outer label�� �ִ� �����͸� ���� �� => �� label�� ������ ����
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(outer.v_date,'yyyymmdd'));
        end; 
                dbms_output.put_line('�л� �̸��� ' || v_name);
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
end;
/

=================================================================================================================

<<outer>>
declare
        v_name varchar2(20) := 'ȫ�浿';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('�л� �̸��� ' || v_name);
        dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name2 varchar2(20) := '����ȣ';
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '�����';
                dbms_output.put_line('�л� �̸��� ' || v_name);
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('�л� �̸��� ' || v_name2); 
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(outer.v_date,'yyyymmdd'));
        end; 
                dbms_output.put_line('�л� �̸��� ' || v_name2); -- ���κ�Ͽ����� �������� ���� ��� �� ��
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
end;
/

<<outer>>
declare
        v_name varchar2(20) := 'ȫ�浿';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('�л� �̸��� ' || v_name);
        dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name2 varchar2(20) := '����ȣ';
                v_date2 date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name2 := upper('james'); -- procedure�� <- �̰� ���� �ؿ� �����鵵 ���� procedure���̶�� �θ�
                                           -- procedure���� �� �� ���� �Լ����� ����!
                dbms_output.put_line('�л� �̸��� ' || v_name);
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('�л� �̸��� ' || v_name2); 
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date2,'yyyymmdd'));
        end; 
                dbms_output.put_line('�л� �̸��� ' || v_name); -- ���κ�Ͽ����� �������� ���� ��� �� ��
                dbms_output.put_line('�л��� ������ ��¥�� ' || to_date(v_date,'yyyymmdd'));
end;
/
-- # procedure��(begin, declare��)�� �� �� ���� �Լ���
-- 1. decode() �Լ� <- BUT case�� ����
-- 2. �׷��Լ�: avg(), sum(), mas(), min(), count(), stddev(), variance()



select last_name
from employees
where employee_id = 100; -- �� select���� ���α׷��� �־��!

begin
      select last_name
      from employees
      where employee_id = 100; -- ����!
                               -- ������ select���� ���α׷��� ��������, ��������� ��Ģ�� �����ؾ�!
                               -- �����͸� ������ load!
end;
/

-- # select into
-- into��: fetch��
-- �Ͻ��� cursor: �� �ȿ��� select ... into ..., dml(insert, update, delete, merge)�� �����
-- - select into: �ݵ�� 1���� row�� fetch�ؾ� �Ѵ�!(where���� ����)
--                0��: no_data_found
--                1�� �ʰ�: too_many_rows => �ذ���: ����� cursor ���!(���� ���� rows�� fetch)
-- - dml <- �� ���� manipulate�Ǵ� ��� ����!
declare
        v_lname varchar2(20); -- ������ <- ���� �������� ���̿� �°� �����ϱ�!(hard coding ���: ���� ���� �������� Ÿ�԰� ����� ���� Ȯ���ؼ� �����ϴ� ��)
                              -- hard coding ����� ���� 1. ������ 2. Ÿ��, ����� modify�� ��� �� ���������ؾ� ��
begin
        select last_name
        into v_lname -- fetch �ܰ�(���� �ʿ��� ������ cursor�� �־ user�� ���� => ������ load ���Ѿ�!)
                     -- into���� ������ select�� �÷� ������ŭ �־��!(���� �����ǰ�!)
        from employees
        where employee_id = 100; 
        dbms_output.put_line(v_lname);
end;
/

declare
        v_lname varchar2(20);
        v_fname varchar2(20);
        v_sal number;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 100; 
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); -- �� select�� <- "�Ͻ��� cursor"��� �θ�!(oracle�� �ڵ������� ����� cursor)
end;
/

-- no_data_found exception
declare
        v_lname varchar2(20);
        v_fname varchar2(20);
        v_sal number;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 300; -- no data found <- select into���� 1���� row�� fetch�ؾ� �ϴµ�, �� ���� 0���� row�� fetch => exception!
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

declare
        v_lname varchar2(20);
        v_fname varchar2(20);
        v_sal number;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where department_id = 10; -- �����(10�� �μ��� ���� ����� 1���̱� ����)
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

-- too_many_rows exception
declare
        v_lname varchar2(20);
        v_fname varchar2(20);
        v_sal number;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where department_id = 20; -- ����(20�� �μ��� ���� ����� ���� ��(multiple rows)�̱� ����)
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

-- cf. ����� cursor: ���� ���� rows�� fetch!



-- # hard coding ���: ���� ���� �������� Ÿ�԰� ����� ���� Ȯ���ؼ� �����ϴ� ��
-- ���� 1. ������
-- ���� 2. �ش� �÷��� Ÿ��, ����� modify�� ���, ���� �������������!

-- solution) soft coding(%type)
-- ���̺�.�÷�%type // ����%type
declare
        v_lname employees.last_name%type; -- �ش� �÷��� Ÿ�԰� ����� �״�� ���� ���ڴٴ� ��
        v_fname v_lname%type; -- �� ������ Ÿ�԰� ����� �״�� ������ ���ڴٴ� ��
        v_sal employees.salary%type;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 100;
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

-- bind variable �̿�
declare
        v_lname employees.last_name%type; 
        v_fname v_lname%type; 
        v_sal employees.salary%type;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 101; -- ��(emp_id = 100)�� �ٸ� �͸� ��� ����!(�ٸ� ������̱� ����) 
                                 -- => �ٽ� compiling�ؾ� ��(LCO�� 2�� �������)
                                 -- => ���� ó���� �ذ�!(bind variable �̿�)
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

var b_id number
exec :b_id := 100
declare
        v_lname employees.last_name%type; 
        v_fname v_lname%type; 
        v_sal employees.salary%type;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = :b_id; -- binding!
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/



drop table test purge;
create table test(id number, name varchar2(20), day date); -- default tablespace�� ����(user_users)
desc test

-- i) insert �۾� ����
insert into test(id, name, day)
values(1, 'ȫ�浿', to_date('2018-01-01', 'yyyy-mm-dd')); -- transaction(���� ������ ����� �� �ƴ�)
                                                         -- parse - bind - execute (fetch�� ���� ����)
select * from test; -- ������ ���� ���� Ȯ�� ����

rollback;

-- ii) ���α׷� �ȿ��� insert
begin
        insert into test(id, name, day)
        values(1, 'ȫ�浿', to_date('2018-01-01', 'yyyy-mm-dd')); 
        -- �� ���� insert/update/delete�� �ƴ��� ��ũ��Ʈ�� �� ���� => ����!
        -- ���α׷� ������ ���� ���� ���·� ���� ���� => update/delete�� ���, �ش� row�� ���� lock�� �ɸ�! 
        -- => �ٸ� user���� Ȯ�� �� ��!!(wait �ܰ�) 
        -- Ʈ������� ���� �� �� ���� �Ǵ��ؾ�!(lock �浹 ���´� DBA�� �ذ� ����������, user�� ���α׷� �ۼ� �� �ذ��ϴ� ���� ����)
end;
/
select * from test;

var b_id number
var b_name varchar2(20)
var b_day number(10) -- date Ÿ���� ����! => char�� ������!
var b_day varchar2(30)

exec :b_id := 1
exec :b_name := 'ȫ�浿'
exec :b_day := '20180101'
exec :b_id := 2
exec :b_name := '������'
exec :b_day := '20180705'

print b_id b_name b_day

begin
        insert into test(id, name, day)
        values(:b_id, :b_name, to_date(:b_day,'yyyymmdd'));
end; -- ���ε� ������ ���ο� �� �ְ� ��� ���� => BUT �� �����ʹ� ������ ����� �͵��� �ƴ�(�ٸ� session������ Ȯ�� �Ұ���) => commit/rollback���� Ȯ��!
/
select * from test; 

commit;

begin
        insert into test(id, name, day)
        select employee_id, last_name, hire_date -- values�� ��� subquery => subquery�� �����Ͱ� ��� insert ��
        from employees;
end;
/

rollback;

begin 
        update test
        set name = '����ȣ'
        where id = 1;
end; -- �� ���� row�� update�Ǿ��ٰ�� ������ ����
/
select * from test; 

rollback;

var b_id number
var b_name varchar2(20)
exec :b_id := 1
exec :b_name := '����ȣ'

begin
        update test
        set name = :b_name
        where id = :b_id;
end;
/
select * from test; 

rollback;

var b_id number
var b_name varchar2(20)
exec :b_id := 0
exec :b_name := '����ȣ'

begin
        update test
        set name = :b_name
        where id = :b_id; -- 0�� ���(:b_id = 0)�� �������� ����(update �� ��) 
                          -- => BUT ��ũ��Ʈ������ �����ߴٰ� ����(������ �� �� �ִ� �� ���� �� �� �� ����) 
                          -- => �Ͻ��� cursor�� �Ӽ����� �Ǵ� <- dbms_output.put_line(sql%rowcount);
end;
/
select * from test; 

rollback;

begin
        update test
        set name = :b_name
        where id = :b_id; 
        dbms_output.put_line(sql%rowcount); -- update�� �Ǽ� ����
end;
/
select * from test; 

rollback;

var b_id number
var b_name varchar2(20)
exec :b_id := 1
exec :b_name := '����ȣ'

begin
        update test
        set name = :b_name
        where id = :b_id; 
        dbms_output.put_line(sql%rowcount || q'[���� row�� �����Ǿ����ϴ�!]'); -- update�� �Ǽ� ����
end;
/
select * from test; 

begin
        insert into test(id, name, day)
        select employee_id, last_name, hire_date 
        from employees;
        dbms_output.put_line(sql%rowcount || q'[���� row�� insert �Ǿ����ϴ�!]');
end;
/

rollback;

drop table emp purge;

create table emp as select * from employees;

begin
        update emp
        set salary = salary * 1.1
        where department_id = 30;
        dbms_output.put_line(sql%rowcount || ' ���� ����');
end;
/
select * from emp; 

rollback;

begin
        delete from emp where department_id = 20; -- �Ͻ��� cursor���� ����
        
        update emp
        set salary = salary * 1.1
        where department_id = 30; -- �Ͻ��� cursor���� ����
        
        dbms_output.put_line(sql%rowcount || ' ���� ����'); -- update�� ���� �Ӽ�(�ٷ� �� ��)
end;
/
select * from emp; 

begin
        delete from emp where department_id = 20; 
        dbms_output.put_line(sql%rowcount || ' ���� ����'); -- �ٷ� �� ���� ���� �Ӽ��� ������
        update emp
        set salary = salary * 1.1
        where department_id = 30;         
        dbms_output.put_line(sql%rowcount || ' ���� ����'); 
end;
/
select * from emp; 

rollback;



-- # sql%found
-- update�� ���� ���� row�� ������ true, ������ false�� ����(boolean)
-- ** ����������� Null�� false!
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 100;
        
        if sql%found then
                dbms_output.put_line('������');
        else
                dbms_output.put_line('�����ȵ�');
        end if;
        rollback;
end;
/

begin
        update emp
        set salary = salary * 1.1
        where employee_id = 00; -- ������ ���� row�� ���� => �����ȵ�
        
        if sql%found then
                dbms_output.put_line('������');
        else
                dbms_output.put_line('�����ȵ�');
        end if;
        rollback;
end;
/

-- # sql%notfound(���� �ݴ�)
-- ������ �� ���� ��� true
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 00;
        
        if sql%notfound then
                dbms_output.put_line('������');
        else
                dbms_output.put_line('�����ȵ�');
        end if;
        rollback;
end;
/
-- merge�� �״�� �־��ָ� ��

-- �̷��� �ϸ� �� ��
declare
        v_name varchar2(20);
        v_sal number;
begin
        select last_name, salary
        into v_name, v_sal
        from employees
        where employee_id = 100;
        
        if sql%found then
                dbms_output.put_line('���=> '||'�����ȣ:'||:v_id||', '||'����̸�: '||v_name||', '||'����޿�: '||v_sal);
        else
                dbms_output.put_line('����� �����ϴ�.');
        end;
end;
/

-- cf.
begin
        delete from emp where department_id = 10;
        update emp
        set salary = salary * 1.1
        where employee_id = 00;
        
        if sql%notfound then
                dbms_output.put_line('������');
        else
                dbms_output.put_line('�����ȵ�');
        end if;
        rollback;
end;
/



-- # Ʃ��(returning�� ���)
var b_id number
execute :b_id := 100
declare
        v_sal emp.salary%type;
begin
        select salary
        into v_sal
        from emp
        where employee_id = :b_id;
        
        dbms_output.put_line(q'[���� �� ���� : ]' || v_sal);
        
        update emp
        set salary = salary * 1.1
        where employee_id = :b_id
        returning salary into v_sal; -- returning��: ������ salary���� �ٷ� ��ȸ(fetch) ���� 
                                     -- => select���� �߰������� ���� �ʾƵ� ��
                                     -- => ���� ���
        
        dbms_output.put_line(q'[���� �� ���� : ]' || v_sal);
        
        rollback;
end;
/



-- # ���� ���(if)
-- - true/false
-- - boolean(data type)
declare
        v_flag boolean := true; -- true�� �����ó�� �̿�('' ���� ����!)
begin
        if v_flag then
              dbms_output.put_line('True');
        end if;
end;
/

declare
        v_flag boolean := false; -- �׳� end if�� ��������(return nothing)
begin
        if v_flag then
              dbms_output.put_line('True');
        end if;
end;
/

declare
        v_flag boolean := false; 
begin
        if v_flag then
              dbms_output.put_line('True');
        else
              dbms_output.put_line('False'); -- else�� optional => v_flag ������ false�� else�� ����
        end if;
end;
/



-- # if��(if ~ elsif ~ end if)
/*
if ���� then
        ����
elsif ���� then
           ����
elsif ���� then
           ����
else
           �⺻��
end if;
*/

-- # �� ������
-- x < y : x�� y���� �۴�
-- x > y 
-- x = y
-- x != y
-- x >= y
-- x <= y

-- # �� ������
-- and, or, not

-- # null ��
-- is null, is not null
-- cf. x = null (wrong!)

/*
ex. 
x := 1
y := null

** ������� => true/false
*** �� ��쿡�� false�̹Ƿ�, else�� ����

if x = y then
         ....
else
         ....
end if;
*/



-- # case ǥ����
/*
* decode(), �׷��Լ��� procedure���� ��� �� ��
v_a := upper('a'); <- procedure������ ��� ����
v_sal := sum(v_salary); <- procedure������ ��� �Ұ����ϴ�.
v_flag := decode(....); <- ��� �Ұ�

cf.
v_flag := case(...); <- ��� �����ϴ�
                     <- ȥ�ڼ� ��� �� ��!(DML �̿�)
*/
declare
        v_grade char(1) := upper('c');
        v_appraisal varchar2(30);
begin
        v_appraisal := case v_grade when 'A' then 'Very good'
                                    when 'B' then 'Good'
                                    when 'C' then 'Good effort'
                                    else 'You''re not a human'
                       end;
        dbms_output.put_line('����� ' || v_grade || ' �򰡴� ' || v_appraisal);
end;
/
-- ��쿡 ���󼭴� case���� if������ �ᵵ ��

declare
        v_grade char(1) := upper('c');
        v_appraisal varchar2(30);
begin
        v_appraisal := case when v_grade = 'A' then 'Very good'
                            when v_grade in ('B', 'C') then 'Good'
                            when v_grade = 'D' then 'Good effort'
                            else 'You''re not a human!!'
                       end;
        dbms_output.put_line('����� ' || v_grade || ' �򰡴� ' || v_appraisal);
end;
/

-- # case�� <- case ǥ���İ��� �ٸ�!!
/*
case ����
     when ��1 then ����1
     when ��2 then ����2
     else
          �⺻��
end case;
*/



-- # �ݺ���
-- 1. �⺻ loop ���� <- ������ ��� �ݺ� => ���� ������ ���� ���! => ���� ����� �� ǥ���ؾ�!
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1; -- �̷��� ���θ� ���ѷ���(overflow)
        end loop;
end;
/

declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1;
              exit; -- Loop ����(�ݺ��� ����)������ ����� �� �ִ� ���� => �ٸ� ���� ����ϸ� �� ��!
        end loop;
end;
/

-- exit�� if���� ���� ���鼭 ���� �ο�
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1;
              if i > 10 then
                        exit; -- 10�� �ݺ��ϰ� ����
              end if;
        end loop;
end;
/

-- cf. count ����(i := i + 1;)�� if�� �ؿ� ��
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              if i > 10 then
                        exit; 
              end if;
              i := i + 1; -- 11�� �ݺ�!
        end loop;
end;
/



-- 2. while loop��
-- while���� ���� ���� �ο� => ���� ���� ����!
-- �ƿ� loop�� ������� �ʴ� ��츦 ����� ���� �� ���!
declare
        i number := 1;
begin
        while i <= 10 loop
                    dbms_output.put_line(i);
                    i := i + 1;
        end loop;
end;
/

declare
        i number := 11; -- �ƿ� loop�� ������� ����
                        -- cf. �⺻ loop ����: ��� �� ���� �����
begin
        while i <= 10 loop
                    dbms_output.put_line(i);
                    i := i + 1;
        end loop;
end;
/

declare
        i number := 1;
begin
        while i <= 10 loop
                    dbms_output.put_line(i);
                    i := i + 1;
                    if i = 5 then
                              exit; -- exit�� ��� �ݺ��������� ��� ����!
                    end if;
        end loop;
end;
/



-- 3. for�� <- �ݺ� Ƚ���� �˰� ���� ��� ���
-- ī��Ʈ ����(i)�� �ڵ����� ������� <- ���� declare�� �ʿ� ����!
-- for ���� in ������..ū�� loop
-- ������ implicit�ϰ� 1�� �����ϵ��� �����Ǿ� ����
-- ���� i�� �׳� ��븸 �ؾ� �� <- �Ҵ�(i := i + 1;)�ؼ��� �� ��! <- 3�� ����, 5�� ���� �̷��� ������ �� �Ѵٴ� ��!!
begin
      for i in 1..10 loop -- ī��Ʈ ���� i <- for�� �ȿ����� ����ϴ� ���� ����!(�Ͻ������� ���� => ���� ������ �ʿ� ����)
              dbms_output.put_line(i);
      end loop;
end;
/

begin
      for i in 1..10 loop
              dbms_output.put_line(i);
              i := i + 3; -- ����!(������ ��븸 �� �� �ְ� �Ҵ��� �� ��)
      end loop;
end;
/

declare
        v_start number := 1;
        v_end number := 10;
begin
        for i in v_start..v_end loop -- range�� ���� ���� ����!
              dbms_output.put_line(i);
        end loop;
end;
/

-- cf1. ������ null�� ���� => ����!(������ �� �����ؾ�!)
declare
        v_start number := 1;
        v_end number; -- null��
begin
        for i in v_start..v_end loop 
              dbms_output.put_line(i);
        end loop;
end;
/

-- cf2. ū ������ ���� �� ������ �ݺ��ϰ� ���� ��� => in reverse!
declare
        v_start number := 1;
        v_end number := 10;
begin
        for i in reverse v_start..v_end loop 
              dbms_output.put_line(i);
        end loop;
end;
/




-- # subloop
-- �⺻ loop, while, for ��� �� �� ����
-- nested loop join(main loop�� row�� ������ŭ subloop�� �����)
var b_dan number
execute :b_dan := 2
execute :b_dan := null
begin
        if :b_dan is null then
            for j in 2..9 loop
                for i in 1..9 loop
                    dbms_output.put_line(j || q'[ * ]' || i || q'[ = ]' || j*i);
                end loop;
            end loop;
        else
            for i in 1..9 loop
                dbms_output.put_line(:b_dan || q'[ * ]' || i || q'[ = ]' || :b_dan*i);
            end loop;
        end if;
end;
/



-- # dbms_output.put() <- �����͸� �޸𸮿� "����"�� �� �׾Ƴ��� �Ŀ� ����ϴ� ��
-- # dbms_output.new_line <- ���� �� ���� ������ ����߸��� ���
-- # dbms_output.put_line() = dbms_output.put() + dbms_output.new_line
var b_id number

execute :b_id := 200

DECLARE
  v_sal 	employees.salary%type;
  v_star 	varchar2(100);
BEGIN
  SELECT salary
  INTO v_sal
  FROM employees
  WHERE employee_id = :b_id;
  
	DBMS_OUTPUT.PUT_LINE('employee_id => '||:b_id ||'  '|| 'salary => '||v_sal);
  
  FOR i in 1..trunc(v_sal/1000) LOOP
    	v_star := v_star||'*';
  END LOOP;
	DBMS_OUTPUT.PUT_LINE('star is => '||v_star);
  
  DBMS_OUTPUT.PUT('star is => ');
  FOR i in 1..trunc(v_sal/1000) LOOP      
    	DBMS_OUTPUT.PUT('*');
  END LOOP;
    	DBMS_OUTPUT.NEW_LINE;
END;
/



-- # continue when: for������ ������ true�̸�, �ٽ� ���� �ö�(���� ������ �������� ����)
-- subloop���� main loop�� �ö� �� �ִ� ���!
-- cf. exit: �ƿ� loop ������ ���� ������ ��
-- continue ����� ������ subloop ��� ��!(����)
declare
        v_total number := 0;
begin
        for i in 1..10 loop
            v_total := v_total + i;
            dbms_output.put_line('Total is : ' || v_total);
            
            continue when i > 5; -- 10�� �ݺ��ϵ�, 6��°���ʹ� �Ʒ��� ������ ������� ����
            
            v_total := v_total + i;
            dbms_output.put_line('Out of loop total is : ' || v_total);
        end loop;
end;
/

-- label �̿�
declare
        v_total number := 0;
begin
        <<toploop>> -- main loop�� label
        for i in 1..10 loop
            v_total := v_total + i;
            dbms_output.put_line('Total is : ' || v_total);
        
        for j in 1..10 loop
            continue toploop when i+j > 5; -- i+j > 5�̸�, toploop�� �ö󰡶�� ��!(main loop�� ����� �ǹ�) => sub loop�� ������� ����
            v_total := v_total + j;
            dbms_output.put_line('Out of loop total is : ' || v_total);
            end loop;
        end loop;
end;
/



-- # select������ * �� fetch
-- ##���� ������ TYPE <- * ���� ���̺��� ��� ���� �˻��� ��, ���� ������ ���� �����ϰ� ��
-- 1. ���ڵ� TYPE: ���ö��� ĭ���� ���� ��

-- a. ���� ����
declare
        v_dept_id departments.department_id%type;
        v_dept_name departments.department_name%type;
        v_mgr_id departments.manager_id%type;
        v_loc_id departments.location_id%type;
begin
        select *
        into v_dept_id, v_dept_name, v_mgr_id, v_loc_id
        from departments
        where department_id = 10;
        dbms_output.put_line(v_dept_id || ' ' || v_dept_name || ' ' || v_mgr_id || ' ' || v_loc_id);
end;
/

-- b. ���ڵ� ����
-- ���� ���ڵ� ������ ������ �ϴ� ����? 
-- oracle�� ���ڵ� ������ ���� ����� �� ����
declare
        type dept_record_type is record
        (dept_id number, -- record�� ���� ���� ����� �ʵ��, Ÿ���� ���� 
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number); -- user defined type(������ ���� ���� ���� ����� Ÿ�� ����) => 4������ ���� ��Ҹ� ���� �� �ִ� ������� �������(4���� ĭ����)
         v_rec dept_record_type; -- ���� ����
begin
        select *
        into v_rec -- simpler
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.dept_id); -- (���ڵ庯����.�ʵ��)
        dbms_output.put_line(v_rec.dept_name);
        dbms_output.put_line(v_rec.dept_mgr);
        dbms_output.put_line(v_rec.dept_loc);
end;
/

-- soft coding�� ����
declare
        type dept_record_type is record
        (dept_id departments.department_id%type, 
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number); 
         v_rec dept_record_type; 
begin
        select *
        into v_rec 
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.dept_id); 
        dbms_output.put_line(v_rec.dept_name);
        dbms_output.put_line(v_rec.dept_mgr);
        dbms_output.put_line(v_rec.dept_loc);
end;
/

-- c. %rowtype �Ӽ�
-- Ÿ�� ������ �ڵ����� �ϰ� ����
-- ���ڵ� Ÿ���� �ս��� ����
declare
        v_rec departments%rowtype; -- �Ͻ�������(oracle�� �˾Ƽ�) Ÿ�� ����
begin
        select *
        into v_rec
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.department_id); -- �÷� �̸��� �ʵ���� ��!
        dbms_output.put_line(v_rec.department_name);
        dbms_output.put_line(v_rec.manager_id);
        dbms_output.put_line(v_rec.location_id);
end;
/

-- ���ڵ� �ȿ� �� ���ڵ�
declare
        type dept_record_type is record
        (dept_id departments.department_id%type, 
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number,
         dept_rec departments%rowtype); -- �ʵ� �ȿ��� ���ڵ� ������ �ʵ带 �� ���� �� ����! 
         v_rec dept_record_type; 
begin
        select *
        into v_rec.dept_rec -- �����ʵ�.�����ʵ�
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.dept_rec.department_id); -- ���� �ʵ�(v_rec) �ȿ� ���� �ʵ�(dept_rec) �ȿ� �÷�
        dbms_output.put_line(v_rec.dept_rec.department_name);
        dbms_output.put_line(v_rec.dept_rec.manager_id);
        dbms_output.put_line(v_rec.dept_rec.location_id);
end;
/

declare
        type dept_record_type is record
        (dept_id departments.department_id%type not null := 10, -- not null => �ʱⰪ �Ҵ�! 
                                                                -- %type�� Ÿ�Ը� ���� �ް�, ���� ������ �̾� ���� ����!!
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number,
         dept_rec departments%rowtype);
         v_rec dept_record_type; 
begin
        select *
        into v_rec.dept_rec
        from departments
        where department_id = v_rec.dept_id;
        dbms_output.put_line(v_rec.dept_rec.department_id); 
        dbms_output.put_line(v_rec.dept_rec.department_name);
        dbms_output.put_line(v_rec.dept_rec.manager_id);
        dbms_output.put_line(v_rec.dept_rec.location_id);
end;
/

-- ## ���յ����� ����
-- ��Į�� �������� �޸� ���߰��� ������ �� �ִ�

-- 1. ���ڵ� Ÿ���� ����: ���� �ٸ� ������ type�� ���� ����(�� select * �϶��� ���� �� �ƴ�) 
--    => scalar ������ ������ ��Ƴ��� ��(���ϰ��� �����ϴ� ������)
-- 2. �迭: "����"�� ������ type�� ���� ���� => �ٸ� type�� �����͸� �����ϰ� ������, ���ڵ�� ���� �̿�!
--    a. index by table(���� �迭)
--    b. nested table(��ø ���̺�)
--    c. varray

-- # �迭 <- ���� �����ϰ� �ű⿡ ������ �׾Ƴ���(���� ��ȹ ����)
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 100;
        
        update emp
        set salary = salary * 1.1
        where employee_id = 200; -- ����: �����ȹ 2���� ���� ������ ��
                                 -- �迭�� ���� �ذ�!(�ϳ��� ������ �������� �׾Ƴ���)
        
        rollback;
end;
/

-- �迭 => 1���� �迭�� ����(table of number, date <- �̷� ���� �Ұ���(���ڵ� Ÿ�Ե� ���� �̿������ ��!)
declare
        type table_id_type is table of number index by binary_integer; -- table_id_type: �迭 Ÿ�� �̸�
                                                                       -- index by: ��� ��ȣ�� �ǹ�
                                                                       --           1. binary_integer: -2G ~ 2G, �� 4G�� ũ��
                                                                       --           2. pls_integer: ������� ���� + ��ȣ ��Ʈ���� ������ ���� => ó�� �ӵ� ����
                                                                       --           3. varchar2: 32767���� �Է� ���� => integer�� �� ����
                                                                       --           cf. number Ÿ���� �� ��
        v_tab table_id_type;
begin
        v_tab(1) := 100; -- v_tab(��ҹ�ȣ) := �迭�� <- ���������ε� ǥ�� ����
        v_tab(2) := 200;
        
        update emp
        set salary = salary * 1.1
        where employee_id = v_tab(1);
        
        update emp
        set salary = salary * 1.1
        where employee_id = v_tab(2); -- update���� 2�� ����� ���� ��ȹ�� �ϳ��� sharing
                                      -- BUT ������ �� ���� => loop�� �ذ�!
        
        rollback;
end;
/

declare
        type table_id_type is table of number index by binary_integer; 
        v_tab table_id_type;
begin
        v_tab(1) := 100; 
        v_tab(2) := 200;
        
        for i in 1..2 loop
            update emp
            set salary = salary * 1.1
            where employee_id = v_tab(i);
        end loop;
        
        rollback;
end;
/

-- ����.first: �迭���� ���� ���� ��� ��ȣ�� ���� �˷��ִ� �޼ҵ�(ù��° ���� �ƴ�!)
-- ����.last
declare
        type table_id_type is table of number index by binary_integer; 
        v_tab table_id_type;
begin
        v_tab(1) := 100; 
        v_tab(2) := 200;
        
        for i in v_tab.first..v_tab.last loop
            update emp
            set salary = salary * 1.1
            where employee_id = v_tab(i);
        end loop;
        
        rollback;
end;
/

declare
        type table_id_type is table of number index by binary_integer; 
        v_tab table_id_type;
begin
        v_tab(1) := 100; 
        v_tab(3) := 200; -- ����!(no data found) => 1, 2, 3�� ���� Ȯ���ؾ� �ϴµ�, 2�� �濡 �����Ͱ� ���� ����
                         -- ���� �迭 ���� �����Ϸ��� �ϸ� ������ ����
        
        for i in v_tab.first..v_tab.last loop -- i in 1..3 => 1, 2, 3
            update emp
            set salary = salary * 1.1
            where employee_id = v_tab(i);
        end loop;
        
        rollback;
end;
/

-- ����.exists(): �� ��° ���� �����ϴ� �� �� �ϴ� ���� ���θ� Ȯ���ϴ� �޼ҵ�
declare
        type table_id_type is table of number index by binary_integer; 
        v_tab table_id_type;
begin
        v_tab(1) := 100; 
        v_tab(3) := 200; 
        
        for i in v_tab.first..v_tab.last loop 
            if v_tab.exists(i) then -- v_tab.exists(2): 2�� ���� �����ϸ� true, �������� ������ false
                update emp
                set salary = salary * 1.1
                where employee_id = v_tab(i)
                returning employee_id into v_tab(i);
            else
                dbms_output.put_line(i || '�� ���� ��ҹ�ȣ�� �����ϴ�.');
            end if;
        end loop;
        
        rollback;
end;
/



-- 1���� �迭
declare
        type num_type is table of number index by pls_integer;
        v_num num_type;
begin
        for i in 100..110 loop
                  v_num(i) := i; -- for���� �̿��ؼ� �迭 �� ��ȣ�� ���� ����
        end loop;
        for i in v_num.first..v_num.last loop
                  dbms_output.put_line(q'[v_num(]' || i || q'[) = ]' || v_num(i));
        end loop;
end;
/

-- # 2���� �迭 <- record, table ȥ��
-- record type ���� �����ϰ�, �̸� �迭�� Ÿ��(v_rec%type)���� ����
declare
        type dept_rec_type is record(id number, name varchar2(30), mgr number, loc number);
        v_rec dept_rec_type;
        type dept_tab_type is table of v_rec%type index by pls_integer;
        v_tab dept_tab_type;
        
        /*
        type ���ڵ�Ÿ�� is record(id number, name varchar2(30), mgr number, loc number);
        v_rec dept_rec_type;
        type dept_tab_type is table of ���ڵ�Ÿ�� index by pls_integer;
        v_tab dept_tab_type;
        */
begin
        for i in 1..5 loop
                  select *
                  into v_tab(i)
                  from departments
                  where department_id = i * 10;
        end loop;
        
        for i in v_tab.first..v_tab.last loop
                  dbms_output.put_line(i || '�� �濡�� ' || v_tab(i).id || '�� �μ��� ����');
        end loop;
end;
/

declare
        type dept_rec_type is record(id number, name varchar2(30), mgr number, loc number);
        
        type dept_tab_type is table of dept_rec_type index by pls_integer; -- record type�� ���� ���� ������ �ʿ�� ����!
        v_tab dept_tab_type;
begin
        for i in 1..5 loop
                  select *
                  into v_tab(i)
                  from departments
                  where department_id = i * 10;
        end loop;
        
        for i in v_tab.first..v_tab.last loop
                  dbms_output.put_line(i || '�� �濡�� ' || v_tab(i).id || '�� �μ� ' || v_tab(i).name || '�� ����'); -- v_tab(i).id <- ���ȣ.�ʵ��̸�
        end loop;
end;
/

declare
        type dept_tab_type is table of departments%rowtype index by pls_integer; -- ���ڵ� ���� ���� �׳� ���̺��� �����͵� ��
        v_tab dept_tab_type;
begin
        for i in 1..5 loop
                  select *
                  into v_tab(i)
                  from departments
                  where department_id = i * 10;
        end loop;
        
        for i in v_tab.first..v_tab.last loop
                  dbms_output.put_line(i || '�� �濡�� ' || v_tab(i).department_id || '�� �μ� ' || v_tab(i).department_name || '�� ����'); -- �� ���, �÷� �̸��� �ʵ���� ��
        end loop;
end;
/



-- 2. �迭: "����"�� ������ type�� ���� ���� => �ٸ� type�� �����͸� �����ϰ� ������, ���ڵ�� ���� �̿�!
--    a. index by table(���� �迭)
--    b. nested table(��ø ���̺�)
--    c. varray



--    a. index by table(���� �迭)
--       �迭 �� ������ �־���� �� => nested table�� �ذ�!
declare
        type tab_char_type is table of varchar2(10) index by pls_integer; -- �迭 type ����
    --  type    Ÿ�� �̸�                 Ÿ��        ��� ��ȣ(pls_integer�� ����)
        v_city tab_char_type;
begin
        v_city(1) := '����';
        v_city(2) := '����';
        v_city(3) := '�λ�';
        v_city(4) := '����'; -- ���� varchar2(10) Ÿ�Կ� �°� �� �Է�
                             -- ��� ��ȣ�� pls_integer Ÿ�Կ� �°�!
        dbms_output.put_line(v_city.count); -- ���(�迭) ���� ���� <- ���⼭�� 4��
        dbms_output.put_line(v_city.first);
        dbms_output.put_line(v_city.last);
        dbms_output.put_line(v_city.next(1)); -- 1�� array ����(next) ��ȣ
        dbms_output.put_line(v_city.prior(2)); -- 2�� array ����(prior) ��ȣ
        
        v_city.delete(3); -- 3�� array ���� => exception!(no data found)
        -- cf1. v_city.delete; <- ��� array ����!
        -- cf2. v_city.delete(1,3); <- 1�� array���� 3�� array ����(1���� 3�� 2���� �����ϰ� ������ �ڵ� 2�� �����ؾ�!)
        
        for i in v_city.first..v_city.last loop
            if v_city.exists(i) then -- exception ����
                dbms_output.put_line(v_city(i)); -- �迭 ���� ������ �ϳ��� �����
            else
                dbms_output.put_line(i||' ��Ҵ� �������� �ʽ��ϴ�.');
            end if;
        end loop;
        
        dbms_output.put_line(''); 
        
        for i in v_city.first..v_city.prior(4) loop
            dbms_output.put_line(v_city(i)); 
            -- 3�� array �����ϰ� v_city.prior(4) �ϸ�, 2�� array ����! 
        end loop;

end;
/



--    b. nested table(��ø ���̺�)
--       declare���� index by�� ����!(��� ��ȣ�� �ڵ����� 1������ ǥ�� => 2G������ ����)
--       v_city tab_char_type := tab_char_type('����','����','�λ�','����');

--       2G�� �Ѱܾ� �� ���� index by table ��� ��(�� �ܿ��� index by table�� �� ���� ����)
--       ex. �迭������ �̸� �˰� ���� ���, nested table�� �̿��ϴ� �� �� ����!

--       �߰��� ���ο� �迭���� ���� �� ����!
--       dynamic�ϰ� ���� ������ �׳� index by table ����!

--       bulk collect into���� ���!
declare
        type tab_char_type is table of varchar2(10); -- �迭 type ����     
        v_city tab_char_type := tab_char_type('����','����','�λ�','����');
    --    ����        type            type(�� �� ����)
begin
        dbms_output.put_line(v_city.count); -- ���(�迭) ���� ���� <- ���⼭�� 4��
        dbms_output.put_line(v_city.first);
        dbms_output.put_line(v_city.last);
        dbms_output.put_line(v_city.next(1)); -- 1�� array ����(next) ��ȣ
        dbms_output.put_line(v_city.prior(2)); -- 2�� array ����(prior) ��ȣ
        
        -- v_city.delete(3); -- 3�� array ���� => exception!(no data found)
        -- v_city.delete; -- ��� array ����!
        -- v_city.delete(1,3); -- 1�� array���� 3�� array ����(1���� 3�� 2���� �����ϰ� ������ �ڵ� 2�� �����ؾ�!)
        
        -- v_city(5) := '�뱸'; -- ����!(index by table�� ���α׷����� �ڵ����� Ȯ�������, nested table�� �迭�� ������!)
                             -- => Ȯ��(v_city.extend()) �ʿ�!
        
        -- v_city.extend(1); -- �迭 Ȯ����� �ϰ� �迭�� �߰�(2G����)
        -- v_city(5) := '�뱸';
        
        -- v_city.delete(3);
        -- v_city(3) := '�뱸'; -- ������ ���� �� �ڸ��� �迭�� ������Ʈ ����!!!
        
        
        for i in v_city.first..v_city.last loop
            if v_city.exists(i) then -- exception ����
                dbms_output.put_line(v_city(i)); -- �迭 ���� ������ �ϳ��� �����
            else
                dbms_output.put_line(i||' ��Ҵ� �������� �ʽ��ϴ�.');
            end if;
        end loop;
        
        dbms_output.put_line(''); 
        
        for i in v_city.first..v_city.prior(4) loop
            dbms_output.put_line(v_city(i)); 
            -- 3�� array �����ϰ� v_city.prior(4) �ϸ�, 2�� array ����! 
        end loop;

end;
/



-- c. varray()
--    nested tableó�� �迭���� �˰� ���� ��� ���
--    BUT ����� ������ �̸� ����!(�� ���� ���� ����)
--    nested tableó�� ������ ���� ������ �װɷ� ���� => �� �ְ� ������ extend ����ؾ� ��!
declare
        type tab_char_type is varray(5) of varchar2(10); -- varray(5) <- �� �������� 5���� ���� �� ����
        v_city tab_char_type := tab_char_type('����','�λ�','����'); -- BUT 3���� �Է� => ���� �߰� �� ��!!!
begin
        -- v_city.extend(3); -- ����!(5�� �̳����� Ȯ���ؾ�!)
        v_city.extend(2);
        v_city(4) := '����';
        v_city(5):= '�뱸';
        for i in v_city.first..v_city.last loop
                dbms_output.put_line(v_city(i));
        end loop;
end;
/

-- # cursor: SQL ���� �޸� ���� 
--           �޸𸮿� ���� ������(���콺 ������ ���� ��)
-- # implicit cursor(�Ͻ��� Ŀ��)
--   - Ŀ���� ����Ŭ�� ����, �����Ѵ�
--   - select ... into ... (�ݵ�� 1���� row�� fetch�ؾ� �Ѵ�.) => ����� Ŀ��: Ŀ�� ������ ���� ������ ����!
--   - DML(insert, update, delete, merge)
--   - �Ͻ��� Ŀ�� �Ӽ� <- sql%rowcount, sql%found, sql%notfound <- DML�� ����� �Ǵ��ϴ� �Ӽ����μ� ���!



-- # explicit cursor(����� Ŀ��)
--   - ���� ���� row�� (������) fetch�ؾ� �Ѵٸ� ����� Ŀ���� ���
--   - ���α׷��Ӱ� Ŀ���� ����, �����ؾ� �Ѵ�(parse-bind-execute-fetch ������ ������ ���� ǥ���ؾ� �Ѵ�)
--   - ������ �� Ŀ�� �̸��� ���� �Ѵ�
--   - select���� ������ cursor�� �޴� ��! 

--   - joined table�� �̿�!!

select * from employees where employee_id = 100; -- pk, �ϳ��� row => implicit cursor
select * from employees where department_id = 20; -- (prospective) multiple rows => explicit cursor

declare
        /* 1. Ŀ�� ���� */
        cursor emp_cur is select last_name from employees where department_id = 20; -- ���� ���μ��� �ȿ� Ŀ���� �������!
     -- cursor Ŀ���̸� is select��
        v_lname varchar2(20);
begin
        /* 2. Ŀ�� open: �޸� �Ҵ�, 
              �޸𸮿� ���� select���� ��� parse(syntax, semantic ���� üũ, ���� ��ȹ ����), 
              bind, execute(pinned), fetch(active set) */
        open emp_cur;
        /* 3. fetch: Ŀ���� �ִ� active set ����� ������ �ε��ϴ� �ܰ�
                     �����͸� ������ load ��Ű�� �۾� => loop ���� �ȿ��� �����ؾ�! */
        loop
        fetch emp_cur into v_lname;
              exit when emp_cur%notfound; -- Ŀ����%notfound: fetch�� �� ���� ���, true(exit)
              dbms_output.put_line(v_lname);
              end loop;
        /* 4. close: �޸� ���� */
        close emp_cur; -- �޸𸮿� ���� �ִ� Ŀ�� ����
end;
/

-- multiple variables declared
-- �Ͻ��� cursoró�� �÷� ������ �°� ���� ����!
declare
        cursor emp_cur is select last_name, salary from employees where department_id = 20;
        v_lname varchar2(20);
        v_sal employees.salary%type;
begin
        open emp_cur;
        loop
        fetch emp_cur into v_lname, v_sal;
              exit when emp_cur%notfound; 
              dbms_output.put_line(v_lname || ', $' || v_sal);
              end loop;
        close emp_cur; 
end;
/

-- select * => record ���!!!
declare
        cursor emp_cur is select * from employees where department_id = 20;
        v_rec emp_cur%rowtype; -- Ŀ����(emp_cur �� �־����!, ���ڵ��%rowtype �� �� <- joined table�� ���)
begin
        open emp_cur;
        loop
        fetch emp_cur into v_rec;
              exit when emp_cur%notfound; 
              dbms_output.put_line(v_rec.last_name || ', $' || v_rec.salary); -- Ŀ����.�÷���
              end loop;
        close emp_cur; 
end;
/

-- ### joined table
declare
        cursor emp_cur is select e.last_name, e.salary, d.department_name -- ��� �� �÷��� �ڵ����� ���ڵ� ������ �ʵ尡 ��!
                                                                          -- alias�� �� ��� => alias�� �ʵ��!
                          from employees e, departments d 
                          where e.department_id = 20 
                          and d.department_id = 20;
        v_rec emp_cur%rowtype;
begin
        open emp_cur;
        loop
        fetch emp_cur into v_rec;
              exit when emp_cur%notfound; 
              dbms_output.put_line(v_rec.last_name || ', $' || v_rec.salary || ', ' || v_rec.department_name);
              end loop;
        close emp_cur; 
end;
/

-- record �� ���� explicit cursor �̿� => ������ ���� ����!
declare
        cursor emp_cur is select e.last_name, e.salary, d.department_name 
                          from employees e, departments d 
                          where e.department_id = 20 
                          and d.department_id = 20;
        v_name varchar2(30);
        v_sal number;
        v_dept_name varchar2(30);
begin
        open emp_cur;
        loop
        fetch emp_cur into v_name, v_sal, v_dept_name;
              exit when emp_cur%notfound; 
              dbms_output.put_line(v_name || ', $' || v_sal || ', ' || v_dept_name);
              end loop;
        close emp_cur; 
end;
/

-- # explicit cursor�� ���� �����ϴ� ���
-- begin���� open, fetch, close �۾��� ���ԵǾ� ���� ����
-- record(emp_rec) ������ �ڵ����� �������!(cursor�� �������!)
-- open, fetch, close �۾��� �ڵ����� ����!
-- �׳� ������ for���� �� �� ����!!

-- open ������ active set�� ������ for loop�� ������� ����!(�� ��쿡�� �Ŵ��� ��� �۾��ؾ� ��)
-- ex. ���� ��� ��ȣ�� �˻��ϴ� ���

-- ## for�� �̿� <- ���ڵ� ����, open, close ����!
declare
        cursor emp_cur is select * from employees where department_id = 20;
begin
        for emp_rec in emp_cur loop -- for ���ڵ庯�� in Ŀ�� loop
                                    -- emp_rec�� for�� �ȿ����� �� �� ����
                                    -- cf. v_rec <- begin�� �ȿ��� �� �� �� ���� <- ���������� ���� ������ �Ŵ����ϰ� �ۼ��ؾ� ��
              dbms_output.put_line(emp_rec.last_name);
        end loop;
end;
/


/*
## ����� �Ӽ� ����

�����Ŀ���̸�%notfound : fetch�Ѱ� ������ true ������ false
�����Ŀ���̸�%found : fetch�Ѱ� ������ true ������ false
�����Ŀ���̸�%rowcount : fetch�� �Ǽ�
�����Ŀ���̸�%isopen : ����� Ŀ���� open�� �Ǿ� ������ true, �ƴϸ� false
*/



declare
        cursor parm_cur_80 is 
        select employee_id, last_name, job_id
        from employees
        where department_id = 80
        and job_id = 'SA_MAN';

        cursor parm_cur_50 is
        select employee_id, last_name, job_id
        from employees
        where department_id = 50
        and job_id = 'ST_MAN'; -- 2���� select���� ������ ������ ����� �ٸ� => �Ȱ��� ���� ��ȹ�� sharing�ϰ� �ϰ� ����! => ���� ó��!
        
        v_rec1 parm_cur_80%rowtype;
begin
        open parm_cur_80;
        loop
            fetch parm_cur_80 into v_rec1;
                  exit when parm_cur_80%notfound;
            dbms_output.put_line(v_rec1.last_name);
        end loop;
        close parm_cur_80;
        
        dbms_output.put_line('');
        
        for v_rec2 in parm_cur_50 loop
            dbms_output.put_line(v_rec2.last_name);
        end loop;
end;
/

-- # parameter�� ���� cursor
-- declare���� select���� ���� ó��
-- �̰� ���� ����: ���� ��ȹ�� �����ϱ� ���ؼ�
-- parameter cursor�� ���� ���� ���� size ���� �� ��
-- �������� ���� ����(���� �Ű�����)���� ���� ��ȹ�� ���� <- ������ � �����Ͱ� �� �� �� 
-- => optimiser�� �������� �������� ���ٴ� ���� ������ �������� ���� ��ȹ�� ����
-- �÷��� index�� �ɷ� �־ �������� �������� �յ����� �� �ϸ� full scan�� �� ���� => �� ��쿡�� ���� �� ���!
-- �ڵ� ¥�� ���� �� select���� ������׷�(��� ����)�� Ȯ���� ��!!(���� 11G���ʹ� oracle�� �ڹ������� adaptive�ϰ� ����)
declare
        cursor parm_cur(p_id number, p_job varchar2) is 
     -- cursor Ŀ����(������ ����Ÿ��) is <- ���⿡�� ���� size�� ���� ���� �� ��!
     --              ���� �Ű����� <- ���ĸ� ����
     --          cf. 80,'SA_MAN' -> ���� �Ű�����
                select employee_id, last_name, job_id
                from employees
                where department_id = p_id
                and job_id = p_job;
        v_rec1 parm_cur%rowtype;
begin
        open parm_cur(80,'SA_MAN');
        -- cf. open parm_cur(50,'ST_MAN'); <- �ߺ� open�� �� ��! <- exception
        --                                 <- open-fetch-close�� ������ �ٽ� open�� ��!
        loop
            fetch parm_cur into v_rec1;
                  exit when parm_cur%notfound;
            dbms_output.put_line(v_rec1.last_name);
        end loop;
        close parm_cur;
        
        dbms_output.put_line('');
        
        for v_rec1 in parm_cur(50,'ST_MAN') loop
            dbms_output.put_line(v_rec1.last_name);
        end loop;
end;
/



-- # PK ����
declare
        cursor sal_cur is 
               select e.employee_id, e.last_name, e.salary, d.department_name
               from employees e, departments d
               where e.department_id = 20
               and d.department_id = 20;
begin
        for emp_rec in sal_cur loop
               dbms_output.put_line(emp_rec.last_name);
               dbms_output.put_line(emp_rec.salary);
               dbms_output.put_line(emp_rec.department_name);
               dbms_output.put_line('');
               
               /*
               update employees
               set salary = salary *1.1
               where last_name = emp_rec.last_name; -- wrong!(�ߺ��Ǵ� �̸��� ���� ��� ������)
               */
               
               update employees
               set salary = salary *1.1
               where employee_id = emp_rec.employee_id; -- PK�� print���� �ʴ���, declare���� cursor���� �÷� �����ؼ� ����� ������ �;�!
        end loop;
end;
/
rollback;

-- # cursor ���� �ÿ� rowid�� ����
-- PK ��� rowid ��� => ���� ���!
declare
        cursor sal_cur is 
               select e.rowid, e.last_name, e.salary, d.department_name
            -- employee_id ��� rowid�� ������
               from employees e, departments d
               where e.department_id = 20
               and d.department_id = 20;
begin
        for emp_rec in sal_cur loop
               dbms_output.put_line(emp_rec.last_name);
               dbms_output.put_line(emp_rec.salary);
               dbms_output.put_line(emp_rec.department_name);
               dbms_output.put_line('');
               
               update employees
               set salary = salary *1.1
               where rowid = emp_rec.rowid; -- index scan �� I/O�� �ϳ��� �� ���̱� => rowid scan(by user rowid)���� ����(I/O 1��)
                                            -- cf. employee_id <- by index rowid(I/O 4��)
        end loop;
end;
/

select rowid
from employees 
where employee_id = 100;

update employees
set salary = salary *1.1
where employee_id = 100; -- unique index scan(I/O 4��)

update employees
set salary = salary *1.1
where rowid = AAAEAbAAEAAAADNAAA; -- by index rowid scan(I/O 1��)

declare
        cursor sal_cur is 
               select e.rowid, e.last_name, e.salary, d.department_name
            -- employee_id ��� rowid�� ������
               from employees e, departments d
               where e.department_id = 20
               and d.department_id = 20;
begin
        for emp_rec in sal_cur loop
               dbms_output.put_line(emp_rec.last_name);
               dbms_output.put_line(emp_rec.salary);
               dbms_output.put_line(emp_rec.department_name);
               dbms_output.put_line('');
               
               update employees
               set salary = salary *1.1
               where rowid = emp_rec.rowid; 
        end loop;
end;
/



/*
SQL Plus

�б� �ϰ���: �� ���ǿ��� DML �۾��� �ϰ� ������ �ٸ� ���ǿ��� ���� ������ Ȯ������ �� �ϰ�, 
            DML �۾��� �� �� => wait �ܰ迡 ����(Lock ���)
            <- salary ������ �����ϴ���, �ʵ尪���� lock�� �ɸ��� �� �ƴ϶�, row ������ �����
            
            => �ش� ���ǿ��� transaction�� �Ϸ��ϸ� wait �ܰ谡 Ǯ���� DML �����
            
undo: ���� ���� �����س��� mechanism <- �� ���ǿ��� transaction�� �Ϸ����� �ʾ��� ���, 
                                     �ٸ� ���ǿ����� undo�� ����� ������ Ȯ�� ����
                                     
���� ���ǿ��� read-read�� ���� // write-write�� �Ұ���

select salary from employees where employee_id = 100 for update; 
<- �ش� ���ǿ��� ���� ���� BUT �ٸ� ���ǿ����� wait ���¿� ����
<- for update: �̸� lock�� ����!
<- ���� select�� lock�� ���� ������, for update�� ����ϸ� �� �� ����

cf. �������� DML �۾��� �� �� for update�� �����ϸ�, �̹����� ���� wait�ؾ� ��!

** DBA���� ����͸� �ϸ鼭 lock �浹 ����(lock ����, kill)
*/



-- # PK, rowid ���� �۾��ϴ� ���
-- for update, where current of <- �� 2���� ���� ��� ��
-- update/delete �ÿ��� ��!
-- �̰� open ������ lock ����
-- -> �ش� ���̺��� ��� row���� �����ϴ� �Ÿ� ��������, 
--    ������ �ɾ �Ϻ��� row���� �����ϴ� ��쿡�� lock �浹�� ��� => �� ��쿡�� ���� rowid ���� ���� ����� ����
--    joined table�� ���, ���� row���� �� lock�� �ɸ�!
declare
        cursor sal_cur is 
               select e.last_name, e.salary, d.department_name
               from employees e, departments d
               where e.department_id = 20
               and d.department_id = 20
               for update of e.salary wait 3; -- rowid�� ������ �Ͱ� ���� ���
                           -- ** ���� ����: join table�� ��� rowid�� e.rowid����, d.rowid���� ���� �� �ؼ� �۾��� ����� �� �Ǵ� ���� ����!
                           -- for update of �ڿ� �ش� ���̺��� �ƹ� column�� �̸��� �������
                           -- wait 3: 3�� ���� wait�� ��ٸ��ڴٴ� ��(���� �ð� ����)
                           -- cf. for update of e.salary nowait; <- �� ��ٸ��ڴٴ� ��                          
begin
        for emp_rec in sal_cur loop
               dbms_output.put_line(emp_rec.last_name);
               dbms_output.put_line(emp_rec.salary);
               dbms_output.put_line(emp_rec.department_name);
               dbms_output.put_line('');
               
               update employees
               set salary = salary *1.1
               where current of sal_cur; -- rowid�� scan�ϴ� �Ͱ� ����
           --  where current of Ŀ��;
        end loop;
end;
/



declare
        cursor emp_cur is select * from employees where department_id = 20;
        v_rec emp_cur%rowtype;
begin
        open emp_cur;
        fetch emp_cur into v_rec;
              dbms_output.put_line(v_rec.last_name);
        fetch emp_cur into v_rec;
              dbms_output.put_line(v_rec.last_name); -- active set ����� 2���̸�, fetch���� 2�� ������ �� => loop�� �̿�!
                                                     -- ���ڵ�: overwriting(�ϳ��� �۾��ϸ�, ���� ���� ������)
                                                     -- cf. �迭: �����͸� ��� �������Ѽ� �۾� ����
        close emp_cur;
end;
/

-- # ���� ��ȯ
-- �Ͻ��� cursor: �� �� fetch�ϸ� ��
-- ����� cursor: ������ȯ(context switch) <- PL/SQL�� SQL ���� ���̿� ������ ����
declare
        cursor emp_cur is select * from employees where department_id = 20; -- ���� ��ȯ 1�� �߻�
        v_rec emp_cur%rowtype;
begin
        open emp_cur; -- active set ��� <- SQL ������ ������ ����
        loop
              fetch emp_cur into v_rec; -- fetch: ������ load <- PL/SQL ������ ���(���� ��ȯ �ʿ�)
                                        -- fetch �ܰ迡�� ���� ��ȯ �߻�(row ������ ���� ���� ��ȯ�� Ƚ���� ������)
                                        -- row�� ���� ������ ����, ���� ����!
                                        -- row ���� ���� �� ���� ���� �� �ֵ��� ������ ����Ǿ� �־�� �� <- Array!!!
                    exit when emp_cur%notfound;
                    dbms_output.put_line(v_rec.last_name);
        end loop;
        close emp_cur;
end;
/

declare
        cursor emp_cur is select * from employees where department_id = 20;
begin
        for v_rec in emp_cur loop
              dbms_output.put_line(v_rec.last_name);
        end loop;
end;
/



-- # bulk collect into <- �뷮�� row���� ������ �� ���� ����!!
-- into �ڿ��� array �������!(2���� �迭)
declare
        type tab_type is table of employees%rowtype; -- nested table(�뷮�� 2G �Ѿ�� �������� �����ؾ� ��! => paging ó��)
        v_tab tab_type;
begin
        select *
        bulk collect into v_tab -- ���� ��ȯ�� 1������ ����
        from employees
        where department_id = 20;
        
        for i in v_tab.first..v_tab.last loop
                dbms_output.put_line(v_tab(i).last_name);
        end loop;
end;
/

-- basic model
declare
        cursor emp_cur is select * from employees where department_id = 20;
        type tab_type is table of emp_cur%rowtype;
        v_tab tab_type;
begin
        open emp_cur;
        fetch emp_cur bulk collect into v_tab;
        close emp_cur;
        
        for i in v_tab.first..v_tab.last loop
              dbms_output.put_line(v_tab(i).last_name);
        end loop;
end;
/

-- # returning ~ bulk collect into
declare
        type rec_type is record(name varchar2(30), sal number);
        type tab_type is table of rec_type;
        v_tab tab_type;
begin
        update employees
        set salary = salary * 1.1
        where department_id = 20
        returning last_name, salary bulk collect into v_tab; -- update �� �ش� �����͸� ����
                                                             -- bulk collect ���ָ� exception!
        
        for i in v_tab.first..v_tab.last loop
              dbms_output.put_line(v_tab(i).name || ' ' || v_tab(i).sal);
        end loop;
end;
/

-- cf.
declare
        type rec_type is record(name varchar2(30), sal number);
        v_tab rec_type;
begin
        update employees
        set salary = salary * 1.1
        where department_id = 10
     -- where department_id = 20 <- exception!(too many rows) => bulk collect into ���!
        returning last_name, salary into v_tab; 
        
        dbms_output.put_line(v_tab.name || ' ' || v_tab.sal);
end;
/



-- # delete���� �迭 �̿�
-- case 1.
drop table emp purge;
create table emp as select * from employees;

begin
      delete from emp where department_id = 10;
      delete from emp where department_id = 20;
      delete from emp where department_id = 30; -- ���� ��ȹ sharing �� ��!
      rollback;
end;
/

-- case 2. �迭
declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        delete from emp where department_id = v_num(1);
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        delete from emp where department_id = v_num(2);
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        delete from emp where department_id = v_num(3); -- delete���� 3�� ����� ���� ��ȹ�� �ϳ�!
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        rollback;
end;
/

-- case 3. �ڵ� ������ �ϳ��� ����(for��)
-- �����δ� case 2�� ����(�ڵ常 �����ϰ� �ٲ� ��)
-- �迭 ���� �ȿ� �ִ� ���� ������ DML(insert, update, delete) �۾��� �����ϴ� ��� => ���� ��ȯ �ٿ���!
declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        for i in v_num.first..v_num.last loop
            delete from emp where department_id = v_num(i); -- ���� ��ȯ �߻�!
                                                            -- delete�� "SQL ����"�� ���
                                                            -- ���� ��ȹ�� 1���̴���, ���� ��ȯ�� 3�� �Ͼ!
                                                            -- cf. select�� ���� ��ȯ�� SQL ������ PL/SQL ���� ������ ���� ��ȯ(���⿡ ����)
                                                            -- ���� ��ȯ�� �Ѳ����� �ϴ� ��(��ȯ ���� ���̴� ��)?
            dbms_output.put_line(sql%rowcount || ' rows deleted.');
        end loop;
        rollback;
end;
/

-- case 4. ����
-- forall��: "DML"�� Ʃ���� ���� ����!(loop���� �ƴ�)
-- delete���� forall�� ���� // print ������ for�� ��� => sql%bulk_rowcount(i)
-- => ���� ��ȯ �ٿ���!
declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        forall i in v_num.first..v_num.last
            delete from emp where department_id = v_num(i); 
        for i in v_num.first..v_num.last loop
            dbms_output.put_line(sql%bulk_rowcount(i) || ' rows deleted.');
        end loop;
        rollback;
end;
/

declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        forall i in v_num.first..v_num.last
            update emp
            set salary = salary * 1.1
            where department_id = v_num(i);
            
        dbms_output.put_line(sql%rowcount || ' rows deleted in total.'); -- ��ü �Ǽ��� ���ϵ�
        
        for i in v_num.first..v_num.last loop
            dbms_output.put_line(sql%bulk_rowcount(i) || ' rows deleted.');
        end loop;
        rollback;
end;
/


/*
Exception
- �����߿� �߻��� pl/sql �����̴�.
- ������ ���� exceptionó���� ���� �ؾ� �Ѵ�.
- ���� ��ȣ ��� ���� �̸����� exceptionó���� ���־�� �Ѵ�.
- oracle�� ���� �Ͻ���(�ڵ�)���� �߻��� ��, ������ �ǵ��Ͽ� ���α׷��� ���� ��������� �߻���Ű�� ���� �� exception ó���� �Ѵ�.
*/

-- ���� �����ȣ�� �Է��Ͽ��� ���ܻ����� �߻����Ѻ��ڴ�.

-- sql
declare 
  v_rec employees%rowtype;

begin
  SELECT *
  INTO v_rec
  FROM employees
  WHERE employee_id = 300;
  
  dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
end;
/
```

-- ORA-01403(������ SELECT �����͸� ��ȯ���� ���� ��, ���� �迭 ��Ҹ� �����Ϸ��� �� �� �߻��ϴ� ����)�� �߻��Ͽ���. 
-- ���� ��ȣ�� ���� �̸����� exceptionó���� ���ش�.

-- ```sql
declare 
  v_rec employees%rowtype;

begin
  SELECT *
  INTO v_rec
  FROM employees
  WHERE employee_id = 300;
  
  dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
  
exception
  when no_data_found then --���� ��ȣ(ORA-01403)�� ���� �̸�(no data found)
    dbms_output.put_line('�ش� ����� �������� �ʽ��ϴ�.');
end;
/
```

-- �ٸ� ������ �߻����� exceptionó���� �غ���.

-- ```sql
declare 
  v_rec employees%rowtype;

begin
  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
end;
/
```

-- ������ ���� exceptionó���� �߰����־�� �Ѵ�.

-- ```sql
declare 
  v_rec employees%rowtype;

begin
  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

exception
  when no_data_found then 
    dbms_output.put_line('�ش� ����� �������� �ʽ��ϴ�.');
  when too_many_rows then
    dbms_output.put_line('�μ��� ������� �������̴� �����Ŀ���� ���');
end;
/
```

-- begin������ ������ �߻��ϸ� exception���� trap�� �߻��Ѵ�. 
-- ���������� �����ϰ� ���� logic�� �ִٸ� sub-block���� exceptionó���� ���ְ� �ش� logic�� main-block���� �����ϵ��� �Ѵ�.


---------����----------------------------------------------


-- Transaction�� �߻����� �� ������ ���������� ���ᰡ �ȴٸ� transaction�� �ڵ� rollback�� �ȴ�.

-- ```sql
SELECT salary
FROM employees
WHERE department_id = 20; 

declare
  v_rec employees%rowtype;

begin
  UPDATE employees
  SET salary = salary * 1.1
  WHERE department_id = 20;
  --�����߻����� �ڵ� rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
  
  rollback;
end;
/
```


-- ������ �߻������� exception handling���� transaction�� ����ְ� �ȴ�. 
-- �׷��� TCL���� ����Ͽ� transaction�� �����־�� �Ѵ�.


-- sql
SELECT salary
FROM employees
WHERE department_id = 20; 

declare
  v_rec employees%rowtype;

begin
  UPDATE employees
  SET salary = salary * 1.1
  WHERE department_id = 20;
  --�����߻����� �ڵ� rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
 
exception
  when too_many_rows then -- ���� ����(���� ��ȣ Ȯ�� ORA-01403)
    rollback; -- transaction�� ��� ������, rollback ����� ��! <- �̰� �� �ϸ� lock �ɸ�!
    dbms_output.put_line('���� ���� row�� fetch�� �� �����ϴ�.');
  when others then -- �� �����ϰ� �������� ���!
    dbms_output.put_line('���� ����');
    dbms_output.put_line(sqlcode); -- ���� �߻��� ���� �ڵ� ����(sqlcode -> 0: ���� �ƴ�, 1: ������ ���� exception ��Ȳ, +100: no data found, ��Ÿ ������ ������ ����))
    dbms_output.put_line(sqlerrm); -- ���� �ڵ� + �޽��� ����
end;
/

-- �Ʒ��� ���α׷����� ���� �ڵ� Ȯ��!
declare
  v_rec employees%rowtype;

begin
  UPDATE employees
  SET salary = salary * 1.1
  WHERE department_id = 20;
  --�����߻����� �ڵ� rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
 
exception
  when others then 
    dbms_output.put_line('���� ����');
    dbms_output.put_line(sqlcode); 
    dbms_output.put_line(sqlerrm); 
end;
/

rollback;



-- child record found
-- ORA-02292 <- �� ���� ��ȣ�� ���� �̸��� ����! => exception �� �� ���� => ��¿ �� ���� when other ����ؾ� ��
-- => �� ������ �� ¤� exception �ɰ� ���� ���?
delete from employees where department_id = 20; -- foreign key constraint(ORA-02292)
delete from departments where department_id = 20; -- primary key constraint(ORA-02292)
delete from departments where department_id = 270; -- ���� ������ �ɷ� �ִ��� �����Ǵ� ���� ���� ������ ���� �� ��!

-- �������� ����(exception ó��) 
begin
          delete from departments where department_id = 20;
exception
          when others then
               dbms_output.put_line(sqlcode);
               dbms_output.put_line(sqlerrm);
          rollback;
end;
/

-- cf. ���������� ����
begin
          delete from departments where department_id = 20;
end;
/

-- 2. exception ����, pragma
-- ������ ���� �̸��� ���� ��� ���!(exception �̸��� ���� ����)
-- oracle ���� �̸��� ���� ���� exception���� ����
-- exception�� �̸��� ���� ǥ��ȭ�� ���� ��Ű�� �ʿ�!(��Ű���� ���� PL/SQL�� § ��) <- DBA�� STANDARD ��Ű�� Ȯ���غ� ��!
declare
          pk_error exception; -- exception �̸��� ���� ����(�����̸� exception;)
          pragma exception_init(pk_error, -2292); -- �� ������ ������ connect�ϴ� �۾�(pragma exception_init(���ܺ����̸�, ������ȣ);)
                                                  -- ���� ��ȣ �� ���� 0�� �־ �ǰ� �� �־ ��
begin
          delete from departments where department_id = 20;
exception
          when pk_error then -- exception �̸�(pk_error)
               dbms_output.put_line('�� ���� �����ϴ� row���� �ֽ��ϴ�.');
          when others then
               dbms_output.put_line(sqlcode);
               dbms_output.put_line(sqlerrm);
          rollback;
end;
/



-- 3. ����ڰ� ������ ���� ���� => raise �����̸�
-- ����ڰ� ��������� ���� ���� ����(oracle�� ���ܰ� �ƴ϶�� �ص�, ����ڰ� ���� ó���ϰ� ���� ���)
-- ex. ȸ�� ���� ���� ��ȸ���� ���ƾ� �� ��� ��ȣ�� �˻��ϴ� ��� => if sql%found then raise �����̸�
-- i) DML��
update employees
set salary = salary * 1.1
where employee_id = 300; -- ������ row�� ������ exception�� �ƴ�!

-- ii) ���α׷�
begin
      update employees
      set salary = salary * 1.1
      where employee_id = 300; -- ������ row�� ������ exception�� �ƴ�! => �̰� ���� ó���ϰ� ����!
end;
/

begin
      update employees
      set salary = salary * 1.1
      where employee_id = 300; -- ������ row�� ������ exception�� �ƴ�! => �̰� ���� ó���ϰ� ����!
      
      if sql%notfound then
            dbms_output.put_line('������ ���� �����ϴ�.');
      else
            dbms_output.put_line(sql%rowcount || '���� row�� �����Ǿ����ϴ�.');
      end if;
      
      rollback;
end;
/

-- # raise �����̸�
-- raise�� ������ ����, ������ exception���� trap
declare
        e_invalid exception;
begin
        update employees
        set salary = salary * 1.1
        where employee_id = 300; 
      
        if sql%notfound then
            raise e_invalid; -- ����ڰ� ������ ���� ����
        end if;
exception
        when e_invalid then
            dbms_output.put_line('������ ���� �����ϴ�.');
        rollback;
end;
/

-- ���� ó�� �� �ƹ� �۾��� �� �ϰ� ���� ��� => null;
declare
        e_invalid exception;
begin
        update employees
        set salary = salary * 1.1
        where employee_id = 300; 
      
        if sql%notfound then
            raise e_invalid;
        end if;
exception
        when e_invalid then
            null;
        rollback;
end;
/

-- # raise_application_error() procedure(object ������ ���α׷�)
-- ������ ������ ���鼭 "���������� ����" ó���ϰ� ���� ���
-- cf. ���� �͵��� ��� "�������� ����"
-- ���� ��ȣ�� ����: -20000 ~ -20999
-- ���� �޽����� ����: 2G byte(�ѱ��� �� ���ڿ� 3 byte)
-- begin������ �ᵵ �ǰ�, exception������ �ᵵ ��
begin
        update employees
        set salary = salary * 1.1
        where employee_id = 300; 
      
        if sql%notfound then
            raise_application_error(-20000, '������ �����Ͱ� �����ϴ�');
         -- raise_application_error(������ȣ, '�����޽���');
        end if;
end;
/

-- ���� �ڵ�, �޽��� Ȯ���� ���� SQL Plus �̿�!
-- true: ���� �ڵ�� �޽����� �� ���� oracle ���� ���� ����
-- false: �� �͸� ���� <- default
declare
        v_rec employees%rowtype;
begin
        SELECT *
        INTO v_rec
        FROM employees
        WHERE employee_id = 300; 
exception
        when no_data_found then
              raise_application_error(-20000, '��ȸ �����Ͱ� �����ϴ�', true);
              -- true: ���� �ڵ�� �޽����� �� ���� oracle ���� ���� ����
rollback;
end;
/

declare
        v_rec employees%rowtype;
begin
        SELECT *
        INTO v_rec
        FROM employees
        WHERE employee_id = 300; 
exception
        when no_data_found then
              raise_application_error(-20000, '��ȸ �����Ͱ� �����ϴ�', false);
              -- false: �� �͸� ����
rollback;
end;
/



-- 7/13
-- # �����ȣ�� �Է°����� �޾Ƽ� �� ����� ������ ����ϴ� ���α׷�
-- select * from employees where employee_id = �Էº���; 
-- <- �����, �Ͻ��� �� �� ��� ������, exception logic�� �����ϱ⿡�� �Ͻ��� cursor�� �� ��
var b_id number
execute :b_id := 100

-- �͸� ���(not object)
declare
          v_rec employees%rowtype;
begin
          select * 
          into v_rec -- ���ڵ庯��
          from employees 
          where employee_id = :b_id; -- �Էº��� <- declare������ ������ ����� ���� => bind variable!
          dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
exception
          when no_data_found then
                  dbms_output.put_line(:b_id || ' ����� �������� �ʽ��ϴ�');
end;
/

/*
- �͸����� ���� 1. reparsing ���(�Ź� compiling�ؾ� ��)
                2. share �� ��(oracle db �ȿ� �� ���α׷��� ����Ǿ� ���� �ʱ� ����) => �ٸ� ����鵵 ���� �ҽ��� ������ �־�� �� => object ������ ���α׷�!(�ý��� ���� �ʿ�) <- select * from user_sys_privs;
                3. �Է°�(:b_id) ó�� �� tool���� �����ϴ� ��(bind variable) �ۿ� ��� �� ��

=> object!(���̺� �����ϵ��� ��ü ����) <- ����(Ư�� SQL���� ������ �� �ִ� �Ǹ�) �ʿ�!
*/
select * from user_sys_privs; -- user�� ������ �ִ� ���� Ȯ��
select * from user_tab_privs; -- ���� �ο���/�ο����� object ���� ���� �� �� ����
select * from session_privs; -- ���� ����Ʈ Ȯ�� => CREATE PROCEDURE(�Լ�, ��Ű��, procedure ���� �� ����)

-- # Procedure ����
-- ���ĸŰ�����
-- 1. in mode
-- 2. out mode
-- 3. in out mode

-- ## in mode <- �Է°� ó��, ����� ����(�ʱⰪ)
-- commit/rollback <- ���α׷��� �־���� ��, �ƴϸ� ȣ���ϴ� ����� �ڹ������� �Ǵ��ϰ� �� ���� �˾Ƽ� ���� ��
create or replace procedure emp_proc(p_id number)
                        -- ���ν����̸�(���ĸŰ����� Ÿ��) <- size ���� �� ��(���� compilation error)
                        -- ���ν����̸�(p_id in number default 0) <- in mode: �Է°� ó��, default 0: exec �� �ƹ� ���� �Է����� ������ default���� 0���� �ڵ� ����
                        -- bind variable ��� �� ��!(�׳� �� �Է°� ó�� ��� ����ϸ� ��)
                        -- local variableó�� �۵�!(����� ����! <- �ʱⰪ �־���� ��!)
-- or replace �ɼ�: ������ ���� procedure�� ���� ���, �̹� �ִ� �� ����� ���� �����ϰڴٴ� ��(���� ���� drop �� �ص� ��)
is -- �͸� ����� declare���� ���� ���(declare���� �ʼ��� �ƴ�����, is���� �ʼ�! <- ������ ������ ������ is�� ����� ��!) => �� ���� compilation error
   -- is ��� as �ᵵ ��
          v_rec employees%rowtype;
begin
       -- p_id := 200; (����: ������ �ѹ� ���� ���� ���ؼ��� ���(����̱� ����))
          select * 
          into v_rec -- ���ڵ庯��
          from employees 
          where employee_id = p_id; -- �Էº��� <- procedure ����鼭 ����(bind variable �� ���� procedure�� �Էº����� ��)
          dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
exception
          when no_data_found then
                  dbms_output.put_line(p_id || ' ����� �������� �ʽ��ϴ�');
end;
/

-- # Procedure ����
exec emp_proc(100) -- exec emp_proc(�����Ű�����) <- �����Ű�����(100)�� ���ĸŰ�����(p_id)�� �������
-- �ҽ� �ڵ�, ������(execute ����)�� �ڵ尪�� �����! => ���� �ӵ��� ����!
exec emp_proc(300)
exec emp_proc() -- in mode�� ����� ����! <- �ʱⰪ �־���� ��!
                -- default 0

-- # program���� procedure�� ȣ��
begin
      emp_proc(100); -- exec ��ɾ�� ����
end;
/

-- �ۼ��� procedure�� ���� �ҽ� Ȯ��
select text
from user_source
where name = 'EMP_PROC';
/*
select text
from user_source
where name = '���ν����̸�';
*/

-- Procedure ����
drop procedure emp_proc;



-- ## out mode
-- ������ ���α׷� �ٱ����� �����ϴ� ���
create or replace procedure emp_proc(p_id in number default 0, p_name out varchar2, p_sal out number)
                         -- emp_proc(���ĸŰ������� in Ÿ��, ���ĸŰ������� out Ÿ��) <- out mode: ������ �ۿ����� �� �� �ְ� ����
is 
begin
          select last_name, salary
          into p_name, p_sal -- �� �� ������ ���α׷� �ܺη� �����ϰ� ���� ���(cf. �͸� ����� bind variable�� ���� ��)
          from employees 
          where employee_id = p_id; 
          dbms_output.put_line(p_name || ' ' || p_sal);
exception
          when no_data_found then
                  dbms_output.put_line(p_id || ' ����� �������� �ʽ��ϴ�');
end;
/

-- desc ���α׷��̸�
desc emp_proc -- ������ �̸�, Ÿ��, in/out Ȯ�� ����



-- cf. �ٱ����� ������ ���� �� -> bind variable �̿�!(�����Ű������� ��� ���� bind variable ��������� ��)
var b_name varchar2(30)
var b_sal number

exec emp_proc(101, :b_name, :b_sal) 
-- exec emp_proc(�����Ű�����)  
-- �μ���: 200(p_id <- in mode)
-- :b_name, :b_sal <- out mode �Ǿ� �ִ� �ֵ��� �޾ƿ�!
-- 200�� ���α׷��� ����־, p_name, p_sal�� �����Ѵ���, �ۿ��� :b_name, :b_sal�� ����
-- in mode: ����� ����(Ư���� ����) // out mode: ������ ����(���α׷� �ٱ����� ����)

print b_name b_sal
select * from employees where salary > :b_sal;



-- cf. �͸� ���
declare
        v_id number := 100; 
        v_name varchar2(30);
        v_sal number;
begin
        emp_proc(v_id, v_name, v_sal);
        dbms_output.put_line(v_id || ' ' || v_name || ' ' || v_sal);
end;
/



-- ## in/out mode
-- in, out ��� ȥ��
create or replace procedure format_phone
(p_phone_no in out varchar2)
is
begin
      p_phone_no := substr(p_phone_no, 1, 3) || '-' || substr(p_phone_no, 4, 4) || '-' || substr(p_phone_no, 8);
      dbms_output.put_line(p_phone_no);
end;
/

var b_phone_no varchar2(30)
exec :b_phone_no := '01012345678'
print b_phone_no

exec format_phone(:b_phone_no) 
print b_phone_no -- ���� ���Ŀ� �°� ������

exec format_phone('01012345678') 
-- ����!(������� ���� �� ����)
-- in/out mode�� �����Ű������� �ʱⰪ�� �ִ� "���� ����"���� ��!

create or replace procedure dept_proc(d_id in number default 0, d_name out varchar2, m_id in out number)
is 
begin
          select department_name, manager_id
          into d_name, m_id
          from departments
          where department_id = d_id; 
          dbms_output.put_line(d_id || ' ' || d_name || ' ' || m_id);
exception
          when no_data_found then
                  dbms_output.put_line(d_id || ' �μ� �������� �ʽ��ϴ�');
end;
/

var d_name varchar2(30)
var m_id number
exec :d_name := 'Marketing'
exec :m_id := 101

exec dept_proc(10, :d_name, :m_id) 



/*
# SQL Plus

* �ٸ� �������� procedure �̿� ���� �ο��ϴ� ���
  - grant execute on query_emp to happy;
  - grant execute on ���ν��� to ����;
  - select * from user_tab_privs; <- �̰� ���� ���� �ο� �޾Ҵ� �� Ȯ�� ����
  
  - exec hr.query_emp(101) <- �ٸ� ������ hr�� procedure ��� ����(���� access) <- ex. ���� â�� ����
                           <- ���� select�ص� ������, ���� ���� ������ procedure�� ���� ���� access ����
                           <- ����ڸ� �� ����� ��!(hr)
    cf. grant select on employees to happy; <- table�� ���� ���� access ���� �ο�
        grant select, insert, update, delete on employees to happy;
                           
  - revoke execute on query_emp from happy; <- ���� ȸ��(������Ʈ�� ���� execute ������ ����)
  
  - revoke�ϰ� exec�ϸ� ���� �� �Ǵµ�, �׿� ������ ���� �޽����� ���� ����!
  
  - hr�� �ٸ� ������ update ���� �ο��ϰ� hr���� update �����ϸ� wait �ܰ迡 ����
    => transaction�� �����ϴ� ���� ����!
*/



create or replace procedure sp_comm(p_id in employees.employee_id%type,
                                    p_name out employees.last_name%type,
                                    p_sal out employees.salary%type,
                                    p_comm in out employees.commission_pct%type)
is
      v_comm employees.commission_pct%type;
begin
      select last_name, salary, nvl(commission_pct, 0)
      into p_name, p_sal, v_comm
      from employees
      where employee_id = p_id;
      
      p_comm := p_comm + v_comm;
exception
      when no_data_found then
            raise_application_error(-20000, sqlerrm);
      when others then
            raise_application_error(-20001, sqlerrm);
end sp_comm;
/
show error

desc sp_comm
-- ���⿡ ����� ���̴���, ���ĸŰ������� ������ ����ϸ� �� ��!

select text from user_source where name = 'SP_COMM'; -- �ҽ� Ȯ��

var g_name varchar2(30)
var g_sal number
var g_comm number
exec :g_comm := 0.1
print g_name g_sal g_comm
exec sp_comm(145, :g_name, :g_sal, :g_comm)
-- in mode�� ��(145)�� ���� out mode�� ���� ������!
-- in out mode�� �ʱⰪ�� ����ִ� ������ ���·� �־�� ��!
print g_name g_sal g_comm

var g_id number
exec :g_id := 145
exec :g_comm := 0.1
exec sp_comm(:g_id, :g_name, :g_sal, :g_comm)
-- :g_id, :g_name, :g_sal, :g_comm <- �����Ű�����(���ĸŰ������� ��ġ�� �����ǰ�!)
-- �̷��� ���ε� ���� ó���ص� ��� ����!
print g_name g_sal g_comm



-- table�� insert�ϴ� ���α׷�
create table sawon(id number, name varchar2(30), day date, deptno number);
create or replace procedure sawon_in_proc
(p_id in number,
p_name in varchar2,
p_day in date default sysdate,
p_deptno in number default 0) -- p_deptno in number := 0 <- �̷��� �ᵵ ��
is
begin
        insert into sawon(id, name, day, deptno)
        values(p_id, p_name, p_day, p_deptno);
end sawon_in_proc;
/

execute sawon_in_proc(1, 'ȫ�浿', to_date('2018-01-01', 'yyyy-mm-dd'), 10)
select * from sawon; -- procedure�� ���� insert �۾� ����!(���� commit/rollback ������ ����)

desc sawon_in_proc
-- desc�δ� default Ȯ�� �Ұ��� <- �ҽ��� Ȯ���ؾ�! 

-- # �̸� ���� ���
-- ����° �Ű�����(p_day in date default sysdate)���� �ƹ� ���� �� �ְ� default�ϰ� �����ϰ� ���� ���
-- => �����Ű������� ������� �ؾ� �ϱ� ������ �Ұ���
-- => "������ => ��"�� ���·� ������ ����! <- ���� �ٲ� ��� ����!!
execute sawon_in_proc(p_id => 2, p_name => '����ȣ', p_deptno => 20)
select * from sawon; -- �̸� ���� ����� ���� procedure ����!

-- # ���� ���
-- ������ ���� + �̸� ������ 2���� ����� �����ؼ� �� �� ����!
execute sawon_in_proc(3, '�����', p_day => to_date('2017-01-01', 'yyyy-mm-dd'))
select * from sawon; -- �Է����� ���� �Ű������� 0���� ����?

execute sawon_in_proc(p_id => 4, '���ӽ�', p_day => to_date('2016-01-01', 'yyyy-mm-dd'))
-- ����!(ù��° �Ű������� �̸� ���� ������� ������, �� �̸� ���� ����� ��� ��!)
-- �ǵ����̸� ���� ��� ���� ���� ������, �̸� ���� �� �߿� �ϳ� �����ؼ� �� ��!



drop table emp purge;
drop table dept purge;

create table emp as select * from employees;
create table dept as select * from departments;

alter table emp add constraint empid_pk primary key(employee_id);
alter table dept add constraint deptid_pk primary key(department_id);

alter table dept add constraint dept_mgr_id_fk foreign key(manager_id)
    references emp(employee_id);
    
select * from user_constraints where table_name in ('EMP','DEPT');
select * from user_cons_columns where table_name in ('EMP','DEPT');



-- �ű� �μ� �Է��ϴ� procedure
-- ȣ�� ���� ���α׷� => procedure ������ exception �߻� => ����(�ڵ� rollback)

-- # exception of procedure
-- 1��° ���
-- �ƿ� exception���� ���� ����
-- 3���� ���� ��� �� ��!(�ڵ� rollback)
create or replace procedure add_dept
(p_name in varchar2, p_mgr in number, p_loc number)
is
      v_max number;
begin
      select max(department_id) into v_max from dept;
      insert into dept(department_id, department_name, manager_id, location_id)
      values(v_max + 10, p_name, p_mgr, p_loc);
end add_dept;
/
begin
      add_dept('�濵����', 100, 1800);
      add_dept('�����ͺм�', 99, 1800); -- emp table�� 99�� ����� ����! => �ܷ�Ű ��������
      add_dept('�ڱݰ���', 101, 1500);
end; -- ���� �߻�!
/
select * from dept;

-- 2��° ���
-- ȣ���� ������ exception�� �ۼ�
-- main procedure�� exception�� ������, ȣ���� ������ ���ƿ�
-- ù��° ����(�濵����)�� ����, ���� �ִ� ����(�����ͺм�) ���ĺ��ʹ� �� ��
begin
      add_dept('�濵����', 100, 1800);
      add_dept('�����ͺм�', 99, 1800); 
      add_dept('�ڱݰ���', 101, 1500);
exception
      when others than
            dbms_output.put_line(sqlerrm);
end; 
/
select * from dept;

-- 3��° ���
-- main procedure�� exception�� ǥ��
-- => ù��° ����(�濵����)�� ����° ����(�ڱݰ���) ��� �����!
-- �� �� �ִ� ��� main procedure�� exception ó���� ��!
create or replace procedure add_dept
(p_name in varchar2, p_mgr in number, p_loc number)
is
      v_max number;
begin
      select max(department_id) into v_max from dept;
      insert into dept(department_id, department_name, manager_id, location_id)
      values(v_max + 10, p_name, p_mgr, p_loc);
exception
      when others then
          dbms_output.put_line('error : '|| p_name);
          dbms_output.put_line(sqlerrm);
end add_dept;
/
begin
      add_dept('�濵����', 100, 1800);
      add_dept('�����ͺм�', 99, 1800); 
      add_dept('�ڱݰ���', 101, 1500);
end; 
/
select * from dept;



-- # �Լ�
-- ����� ���α׷�
-- ǥ������ �Ϻημ� ȣ���ؾ� ��!(���� ������ ������ ��ġ)
-- cf. procedure: sql�������� ȣ�� �� ��

-- �Լ� function
-- return number(return��) => return v_sal;(return��)
create or replace function get_sal (p_id in number) -- �Է°� ó���� �� ������ Ÿ�� �� �ʿ� ����(Java�� void ���� ��)
return number -- return ������Ÿ�� <- �ʼ�!(cf. procedure: �ʿ� ����) <- Ÿ���� ������, �����ݷ� ���� �� ��
              -- procedure�� out mode�� ����!
is
      v_sal number := 0;
begin 
      select salary into v_sal from employees where employee_id = p_id;
      return v_sal; -- ������ �� ����(null�̶� ����) <- cf. procedure�� return => ����!
                    -- return ���� ���� �� �� �� ������, �� �� �ϳ��� return!
exception
      when no_data_found then
            return v_sal;
end get_sal;
/

-- �Լ� ��� => ǥ������ �Ϻημ� ȣ��(procedure�� �̷��� ��� �� ��)
exec dbms_output.put_line(get_sal(100))

declare
        v_sal number;
begin
        v_sal := get_sal(100); -- ǥ������ �Ϻημ� �Լ� ȣ�� <- procedure�� �Ұ���
        dbms_output.put_line(v_sal);
end;
/

-- select������ �Լ� �̿�
select employee_id, get_sal(employee_id) from employees; 

-- �Լ��� �߸��� ��
begin
        get_sal(100); -- �̰� procedure�� ȣ���� �� ���� ��!(�Լ��� �̷��� ���� �� ��)
end;
/



-- # deterministic ��Ʈ
create or replace function dept_name_func(p_dept_id number)
return varchar2
deterministic -- function������ ���� ��Ʈ => scalar subquery�� ����� �����ϰ� ��!(cache ���)
is
          d_name varchar2(30);
begin
          select department_name
          into d_name
          from departments
          where department_id = p_dept_id; 
          return d_name;
exception
          when no_data_found then
               return '�˼����� �μ�';
end;
/



-- ## Package <- ���̽��� Class�� ���
-- ���ü� �ִ� ���� ���α׷�(���ν���, �Լ�), ����(global variable), Ÿ��(ex. ���ڵ�, �迭)�� ��Ƴ��� ���α׷�
-- ���ε� ������ �ƴ� �ٸ� ������� global variable ǥ��(���α׷� �ȿ��� ���� ����) // function, procedure�� ��ȣ ��ȯ�ϸ鼭 ��� <- ���� ������
-- begin���� ����!

-- ���� �� ���α׷��� �ϳ��� ��Ű���� ���� ����
-- 1. �۷ι� ���� ���
-- 2. ���� ���踦 �ٷ�� �� ����

-- Package�� �� ���(spec, body)�� ������ ��! 
-- spec(�۷ι� ������)���� �������ϰ�, body�� �������ϱ�!
-- 1. spec(public)�� ���� ������ ��! <- ���� �ϴ� ��(���� ���� �� ��)
create or replace package comm_pkg 
is
    g_comm number := 0.1;
    procedure reset_comm(p_comm in number); -- ��Ű�� �ȿ� procedure ����(create or replace �ʿ� ����)
                                            -- �Լ��� ���, return data type����!
end comm_pkg;
/
exec dbms_output.put_line(comm_pkg.g_comm) -- ���α׷� �ۿ����� ���� ��� ����!(global variable!) <- ��Ű����.������
-- 2. body(private) <- ���� �ҽ� ���
--                  <- ��Ű�� �ȿ��� ����Ǵ� ���� ����
create or replace package body comm_pkg
is
    function validate_comm(v_comm in number) -- ��Ű�� �������� ���!(�ۿ����� ��� �� ��)
                                             -- �������� ���ƾ� �� ������ body���� ����!
                                             -- spec������ reset_comm()�� ����Ǿ� �ִ� �� Ȯ���� ��!
          return boolean
    is
          v_max_comm number;
    begin
          select max(commission_pct)
          into v_max_comm
          from employees;
          if v_comm > v_max_comm then
              return FALSE;
          else
              return TRUE;
          end if;
    end validate_comm;

    procedure reset_comm(p_comm in number)
    is 
    begin
          if validate_comm(p_comm) then -- validate_comm() �Լ� <- �ٷ� ���� ����(�ڿ� ���ǵǾ� ������ �� ��!)
              dbms_output.put_line('old :' || g_comm);
              g_comm := p_comm;
              dbms_output.put_line('new :' || g_comm);
          else
              raise_application_error(-20000, 'invalid');
          end if;
    end reset_comm;
end comm_pkg;
/
show error

create or replace package comm_pkg 
is
    g_comm number := 0.1;
    procedure reset_comm(p_comm in number); -- ��Ű�� �ȿ� procedure ����(create or replace �ʿ� ����)
                                            -- �Լ��� ���, return data type����!
end comm_pkg;
/
exec dbms_output.put_line(comm_pkg.g_comm) -- ���α׷� �ۿ����� ���� ��� ����!(global variable!)



create or replace package body comm_pkg
is
    function validate_comm(v_comm in number) 
                    return boolean;
    procedure reset_comm(p_comm in number)
    is 
    begin
          if validate_comm(p_comm) then 
              dbms_output.put_line('old :' || g_comm);
              g_comm := p_comm;
              dbms_output.put_line('new :' || g_comm);
          else
              raise_application_error(-20000, 'invalid');
          end if;
    end reset_comm;
    
    function validate_comm(v_comm in number) 
          return boolean
    is
          v_max_comm number;
    begin
          select max(commission_pct)
          into v_max_comm
          from employees;
          if v_comm > v_max_comm then
              return FALSE;
          else
              return TRUE;
          end if;
    end validate_comm;
end comm_pkg;
/

-- �� ���α׷��� ���ε��� ���� ��� ����! BUT g_comm�� �� ����! // ���� ������ ���α׷��� 2���� ��! 
-- => ���� ����!(ex. select�� �÷��� Ÿ�԰� ����� �ٲٸ�, validate()�� reset()�� ���� �Ұ��� ���¿� ���� => �ٽ� ������!)
-- => ��Ű���� ���� ������, �ٽ� �������� �� �� ������!
create or replace function validate_comm(v_comm in number) 
          return boolean
    is
          v_max_comm number;
    begin
          select max(commission_pct)
          into v_max_comm
          from employees;
          if v_comm > v_max_comm then
              return FALSE;
          else
              return TRUE;
          end if;
    end validate_comm;
    /
create or replace procedure reset_comm(p_comm in number)
    is 
        g_comm number := 0.1;
    begin
          if validate_comm(p_comm) then 
              dbms_output.put_line('old :' || g_comm);
              g_comm := p_comm;
              dbms_output.put_line('new :' || g_comm);
          else
              raise_application_error(-20000, 'invalid');
          end if;
    end reset_comm;
    /

/*
SQL Plus

��Ű����.�Լ���() <- �̷��� ���!
exec dbms_output.put_line(comm_pkg.g_comm)
exec comm_pkg.reset_comm(0.2)

*** �� ���ǿ��� ��Ű�� ������ ����� �ٸ� ���ǿ� ������ ��ġ�� ���� => ���氪�� ������ ���� ������ ����
    => �Ȱ��� ��Ű���� ����ص�, ������ �ٸ���, ������� �ٸ� ���� ����
    <- global variable�� Ư¡!
*/



-- # overloading
-- ������ �̸��� ���ν���, �Լ��� ���� �� �ִ�. 
-- ���ο� Ÿ���� ������ ��, ���� ���ο� �Լ� ���� �ʿ� ���� overloading ����� �̿��ϸ� ��!
-- ��ҿ� ���� �Լ��鵵 ���� standard ��Ű���� �ִ� ��!

-- to_char(�Էº���, �Էº���) <- ��Ű�� �ȿ��� overloading ����
--                           <- ���ĸŰ������� ����, mode �Ǵ� Ÿ���� �޶�� �� ex. to_char(��¥, ����) // to_char(����, ����)
--                           <- ��ü ���� ���α׷��� ����!
create or replace package pack_over
is
      type date_tab_type is table of date index by pls_integer; -- spec���� ������ type�� ���α׷� �ٱ����� ��� ����!(global type)
      type num_tab_type is table of number index by pls_integer;
      
      procedure init(tab out date_tab_type, n number); -- init()�̶�� procedure �̸��� ���� but Ÿ���� �ٸ�!(overloading)
      procedure init(tab out num_tab_type, n number);
end pack_over;
/
create or replace package body pack_over
is
      -- ���� �̸��� init()�� �� �� ����!(overloading)
      -- ��¥/���� �迭�� �Է�������, �����Ű������� ��¥/���� �迭 Ÿ������ �޾ƾ� ��!
      procedure init(tab out date_tab_type, n number)
      is
      begin
            for i in 1..n loop
                  tab(i) := sysdate + (i-1);
            end loop;
      end init;
      
      procedure init(tab out num_tab_type, n number)
      is
      begin
            for i in 1..n loop
                  tab(i) := i;
            end loop;
      end init;
end pack_over;
/

declare
        date_tab pack_over.date_tab_type;
        num_tab pack_over.num_tab_type;
begin
        pack_over.init(date_tab, 5); -- �Էº����� � Ÿ���� ���� �ִ��Ŀ� ���� �۵��ϴ� procedure�� �޶���!
        pack_over.init(num_tab, 5); -- ���� init()��, �ٸ��� �۵���!
        for i in 1..5 loop
              dbms_output.put_line(date_tab(i));
              dbms_output.put_line(num_tab(i));
        end loop;
end;
/



-- ## ��Ű�� Ŀ�� ���ӻ���
<׻ʥ��?-����׻ ��?>

CREATE OR REPLACE PACKAGE pack_cur
IS	
  	PROCEDURE open;
	PROCEDURE next(p_num number);
	PROCEDURE close;
END pack_cur;
/

-- �ؿ� ���α׷��� ������ => �ϳ��� fetch => ���� ����!
-- �Ʒ��� ���ӻ���_��Ű�� Ŀ��_FETCH_BULK_LIMIT Ȯ��!! 
CREATE OR REPLACE PACKAGE BODY pack_cur -- cursor�� ���� open(), next(), close() �۾� ������ ����
IS
	CURSOR c1 IS  -- private cursor(body �ȿ����� �� �� ����)
		SELECT  employee_id, last_name
		FROM    employees
		ORDER BY employee_id DESC;
	v_empno NUMBER;
	v_ename VARCHAR2(10);

  PROCEDURE open 
  IS  
	BEGIN  
	 IF NOT c1%isopen then
           OPEN c1; -- fetch, close�� ���� ����!(��Ű�������� �� �� ������ Ŀ���� close�� ������ ��� ���� ����! => Ŀ���� ���� ����)
           dbms_output.put_line('c1 cursor open');
         END IF;
  END open;
  
  PROCEDURE next(p_num number)
  IS  
  BEGIN  
		LOOP 
		    EXIT WHEN c1%ROWCOUNT >= p_num;
		    FETCH c1 INTO v_empno, v_ename;
		    DBMS_OUTPUT.PUT_LINE('Id :' ||v_empno||'  Name :' ||v_ename);
		END LOOP;
   END next;

   PROCEDURE close IS
   BEGIN
			IF c1%isopen then
          			close c1;
				dbms_output.put_line('c1 cursor close');
      			END IF;
   END close;
END pack_cur;
/
<<Package ��?>>

SQL> SET SERVEROUTPUT ON 
         
SQL> EXECUTE pack_cur.open
c1 cursor open

PL/SQL procedure successfully completed.
   
SQL> EXECUTE pack_cur.next(3) -- 3���� row�� fetch
Id :206  Name :Gietz
Id :205  Name :Higgins
Id :204  Name :Baer

PL/SQL procedure successfully completed.


SQL> EXECUTE pack_cur.next(6) -- �����Ͱ� 4��°�� ��ġ => 4��°���� ����!(����)
-- EXECUTE pack_cur.next(3) �� �� �� �Է� => ���� �� ��!(�̹� 3���� ũ�� ����) <- EXIT WHEN c1%ROWCOUNT >= p_num;
Id :203  Name :Mavris
Id :202  Name :Fay
Id :201  Name :Hartstein

PL/SQL procedure successfully completed.

SQL> EXECUTE pack_cur.close
c1 cursor close

PL/SQL procedure successfully completed.



-- ### ���ӻ���_��Ű�� Ŀ��_FETCH_BULK_LIMIT
-- fetch �κп� ���ڵ� �迭 ���� �̿��ؼ� limit��� Ű���� ���
-- �� ���α׷��� ���� ���� �ذ�!
-- BUT �Ѳ����� fetch �ϸ� 2G��� �뷮 ���ѿ� �ɸ� �� ���� => limit �̿�!
-- limit�� select into�������� ��� �� �� => open fetch close ������ ǥ���ؾ�!
CREATE OR REPLACE PACKAGE pack_cur
IS	
  	PROCEDURE open;
	PROCEDURE next(p_num number);
	PROCEDURE close;
END pack_cur;
/

CREATE OR REPLACE PACKAGE BODY pack_cur
IS
	CURSOR c1 IS  
		SELECT  employee_id, last_name
		FROM    employees
		ORDER BY employee_id DESC;
	
  PROCEDURE open 
  IS  
  BEGIN  
      IF NOT c1%isopen then
          OPEN c1;
          dbms_output.put_line('c1 cursor open');
      END IF;
  END open;
  
  PROCEDURE next(p_num number)
  IS
	type tab_type is table of c1%rowtype;
	v_tab tab_type;  
  BEGIN  
       
	IF c1%notfound THEN
	  dbms_output.put_line('�����Ͱ� �����ϴ�.');
	  return; -- exit;�� ������ ����
	ELSE
		FETCH c1 BULK COLLECT INTO v_tab limit p_num; -- limit: bulk�ؾ� �� ����� �� ����! 
      	END IF;
   
   FOR i IN v_tab.first..v_tab.last LOOP
     DBMS_OUTPUT.PUT_LINE('Id :' ||v_tab(i).employee_id||'  Name :' ||v_tab(i).last_name);
   END LOOP;
  END next;

	PROCEDURE close IS
	BEGIN
			IF c1%isopen then
          			close c1;
				dbms_output.put_line('c1 cursor close');
      			END IF;
	END close;
END pack_cur;
/
<<Package ����>>

SQL> SET SERVEROUTPUT ON 
         
SQL> EXECUTE pack_cur.open
c1 cursor open

PL/SQL procedure successfully completed.
   
SQL> EXECUTE pack_cur.next(50)
Id :206  Name :Gietz
Id :205  Name :Higgins
Id :204  Name :Baer

PL/SQL procedure successfully completed.


SQL> EXECUTE pack_cur.next(50)
Id :203  Name :Mavris
Id :202  Name :Fay
Id :201  Name :Hartstein

SQL> EXECUTE pack_cur.next(50) -- 3��° ���� => 7���� row�� ���
SQL> EXECUTE pack_cur.next(50) -- 4��° ���� => ��� row���� fetch�Ǿ�����, �����Ͱ� ���ٴ� �޽����� ����

PL/SQL procedure successfully completed.

SQL> EXECUTE pack_cur.close
c1 cursor close

PL/SQL procedure successfully completed.

/*
### Trigger 

 �̺�Ʈ(DML)�� ���α׷��� �ǹ��Ѵ�. �̶� �̺�Ʈ�� �߻��ϸ� �ڵ����� ����Ǵ� ���α׷��̴�. Ʈ���Ÿ� ������� �ý��۱���(`session_privs`���̺��� `create trigger`)�� �ʿ��ϴ�. Ʈ���ſ��� `Ÿ�̹�(before/after)`�� `DML����`, `BEGIN`���� **�ʼ�**�̴�. Ȥ�� ������ �ؾ��� �ʿ䰡 ������ `DECLARE`�� ����Ѵ�. Ʈ���Ÿ� Ȯ���ϴ� ����� ������ ����.
 
 
```sql
*/
SELECT * FROM user_triggers;
/*
```


 Ʈ���Ŵ� ũ�� ����Ʈ���ſ� ��Ʈ���Ű� �ִ�. **����Ʈ����**�� **������ ���� row�� �Ե� ���� ������ ���ư��� Ʈ����**�̴�. **��Ʈ����**�� **������ ���� row�� ���� ���**���� ���ư���. ������ ������ ���� �����غ���. <BR>

BEFORE/AFTER�� ����Ʈ����

```sql
*/
SELECT * FROM session_privs; --�ý��� ���� Ȯ��

drop table dept purge;

CREATE TABLE dept
AS SELECT * FROM departments;

desc dept


--BEFORE ���� Ʈ����
--insert on �ϱ� ���� trigger�� �����϶�� �ǹ�
CREATE OR REPLACE TRIGGER dept_before
BEFORE --���α׷� ���� ������ �ǹ�
INSERT ON dept


BEGIN
  dbms_output.put_line('insert�ϱ� ���� ����Ʈ���ż���');
end;
/

--AFTER ����Ʈ����
--insert on�� �� trigger�� �����϶�� �ǹ�
CREATE OR REPLACE TRIGGER dept_after
AFTER --���α׷� ���� ������ �ǹ�
INSERT ON dept


BEGIN
  dbms_output.put_line('insert�� �Ŀ� ����Ʈ���ż���');
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
insert�ϱ� ���� ����Ʈ���ż���
insert�� �Ŀ� ����Ʈ���ż���
```

<BR>

BEFORE/AFTER�� ��Ʈ����

```sql
...

BEFORE ��Ʈ����
CREATE OR REPLACE TRIGGER dept_row_before
BEFORE INSERT ON dept
FOR EACH ROW

BEGIN
  dbms_output.put_line('insert�ϱ� ���� ��Ʈ���ż���');
end;
/

AFTER ��Ʈ����
CREATE OR REPLACE TRIGGER dept_row_after
AFTER INSERT ON dept
FOR EACH ROW

BEGIN
  dbms_output.put_line('insert�� �Ŀ� ��Ʈ���ż���');
end;
/
*/
INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
insert�ϱ� ���� ����Ʈ���ż���
insert�ϱ� ���� ��Ʈ���ż���
insert�� �Ŀ� ��Ʈ���ż���
insert�� �Ŀ� ����Ʈ���ż���
```

��µǴ� ������ Ȯ���ؼ� ���� ����� �Ǵ��� Ÿ�̹��� ������.

<br>

#### ����Ʈ����

14�ú��� 15�û����� insert �۾��� �Ұ��ϴ� ��� ���� ��쿡 ����.

```sql
*/
CREATE OR REPLACE TRIGGER secure_dept
BEFORE INSERT ON dept

BEGIN
  if to_char(sysdate,'hh24:mi') between '14:00' and '15:00' then
    raise_application_error(-20000,'insert �ð��� �ƴմϴ�.');
  end if;
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
ERROR at line 1:
ORA-20000: insert �ð��� �ƴմϴ�.
ORA-06512: at "HR.SECURE_DEPT", line 3
ORA-04088: error during execution of trigger 'HR.SECURE_DEPT'
```

 dept ���̺� trigger�� �ɾ��� ������ `insert`�۾��� �Ұ����ϴ�. �� Ʈ���Ŵ� `insert`���� �����ϰ� �ִ� session���� ���ư���. �׷��� `insert`���� �����ϴ� ����(�����ϱ� ������) Ʈ����(`secure_dept`������ `raise_application_error`�� �߻��Ͽ� �ڵ� rollback �ȴ�.

<br>
*/

/*
#### DML�۾��� ���� ����

 `Ÿ�̹�(BEFORE)` �ڿ� `OR`�� DML�� �����Ű��, `inserting`,`updating`,`deleting`�̶� Ű���带 ����Ͽ� ���Ǻ� ��� ����� �� �ִ�.

```sql
*/
CREATE OR REPLACE TRIGGER secure_dept
BEFORE INSERT OR UPDATE OR DELETE ON dept

BEGIN
  if to_char(sysdate,'hh24:mi') between '14:00' and '16:00' then
    if inserting then --trigger�������� inserting.(insert�� sql��)
      raise_application_error(-20000,'insert �ð��� �ƴմϴ�.');
      
    elsif updating then
      raise_application_error(-20001,'update �ð��� �ƴմϴ�.');
      
    elsif deleting then
      raise_application_error(-20002,'delete �ð��� �ƴմϴ�.');
    end if;
  end if;
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);

/*
```

<BR>

#### ��Ʈ���� 

 DML�۾��� ������ ���� row�� ���� ��쿡�� ���ư���. 
 �׷��� �����Ϳ� ���� ����, ���� ������ �� ��� ��Ʈ���Ÿ� ����ϸ� ����. 
 �Ʒ� Ʈ���Ÿ� ���� �����غ���.

```sql
*/
CREATE TABLE copy_emp 
AS 
SELECT employee_id, last_name, salary, department_id
FROM employees;

CREATE OR REPLACE TRIGGER copy_emp_trigger
BEFORE DELETE OR INSERT OR UPDATE OF salary ON copy_emp
--OF �÷�(salary)�� ����Ͽ� �ʵ������ �����Ϸ��� �Ѵ�.
FOR EACH ROW
--��Ʈ���ŷ� ���ڴ�.(������ ���� row�� ���� ��쿡�� trigger���)

WHEN (new.department_id = 20 OR old.department_id = 10)
--when�̶�� �������� ����Ͽ� �����ϰڴ�.(��Ʈ���ſ����� ��� ����)
--when������ ������ �տ� �ݷ�(:) ��� �Ұ�(begin�������� �ݵ�� ���)
--old �� ����, new�� ���ο� ���� �ǹ�
--20������� insert��, 10������� ���� delete��, 10���� 20������� update�ÿ� Ʈ���� �۵�

DECLARE 
  v_sal number;

BEGIN
  if deleting then
    dbms_output.put_line('old salary : ' || :old.salary);
    --delete�ÿ��� ���� ���� �ǹ̰� �����Ƿ� �������� old�� ���
  elsif inserting then
    dbms_output.put_line('new salary : ' || :new.salary);
    --insert�ÿ��� ���� ���� �ǹ̰� �����Ƿ� ���İ��� new�� ���
  else
    v_sal := :new.salary - :old.salary;
    dbms_output.put_line('�����ȣ : ' || :new.employee_id ||    
                         ' �����޿� : ' || :old.salary || 
                         ' �����ȱ޿� : ' || :new.salary || 
                         ' �޿� ���� : ' || v_sal);
  end if;
END;
/
/*
```

 ���� `OF salary`�� ���� �ʾ�����, ������ ���� if������ salary�� ���ѿ��� ����ؾ� �Ѵ�. ���� �ٸ� �÷��鵵 ���Ǻ� ��� ����Ͽ��� ������ �� �ִ�.

```sql
*/
CREATE TABLE copy_emp 
AS 
SELECT employee_id, last_name, salary, department_id
FROM employees;

CREATE OR REPLACE TRIGGER copy_emp_trigger
BEFORE DELETE OR INSERT OR UPDATE ON copy_emp
--OF �÷�(salary) ����
FOR EACH ROW


WHEN (new.department_id = 20 OR old.department_id = 10)


DECLARE 
  v_sal number;

BEGIN
  if deleting then
    dbms_output.put_line('old salary : ' || :old.salary);

  elsif inserting then
    dbms_output.put_line('new salary : ' || :new.salary);

  elsif updating('salary') then 
  --updating�� �÷�(salary)�� ���ѽ��� �־���Ѵ�.
  
    v_sal := :new.salary - :old.salary;
    dbms_output.put_line('�����ȣ : ' || :new.employee_id ||    
                         ' �����޿� : ' || :old.salary || 
                         ' �����ȱ޿� : ' || :new.salary || 
                         ' �޿� ���� : ' || v_sal);
  end if;
END;
/
/*
```

<br>

DELETE ����

```sql
*/
DELETE FROM copy_emp
WHERE department_id = 10;
/*
```
```
old salary : 4400

1 row deleted.
```

10�� �μ��� ����� �����ϴ� trigger�� �۵��Ѵ�.(old)

```sql
*/
DELETE FROM copy_emp
WHERE department_id = 20;
/*
```
```
1 row deleted.
```

20�� �μ��� ����� �����ϴ� trigger�� �۵����� �ʾҴ�.(new)

<br>

INSERT ����

```sql
*/
INSERT INTO copy_emp(employee_id, last_name, salary, department_id)
VALUES(300,'James',1000,20);
/*
```
```
new salary : 1000

1 row created.
```

20�� �μ��� ����� `INSERT`�ϴ� trigger�� �۵��Ѵ�.(new)

```sql
*/
INSERT INTO copy_emp(employee_id, last_name, salary, department_id)
VALUES(300,'James',1000,10);
/*
```
```
1 row created.
```
*/