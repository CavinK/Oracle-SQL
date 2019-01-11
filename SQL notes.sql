select * from employees;
select * from departments;

-- I. select���� ���


-- 1. projection: ���̺� "�� ����"�� ����(select ����� �˻� ��� ����)
select employee_id from employees;
select employee_id, last_name from employees; --comma�� ��������! 

desc employees -- table�� ���� �ľ�(� column�� ����ִ� ��?)

-- 2. selection: ���̺� "��"�� ������ ��
select * 
from employees
where employee_id = 100; -- table ���� row�� ����! 
-- select�� column�� ����
-- from�� ���̺� ����
-- where���� ���� �����ϴ� ��(�˻��� ����!)

-- 3. join: ���� �ٸ� ���̺��� ���� ���ϴ� �����͸� �����ϴ� ���(����ȭ!)
select * from employees;
desc departments -- semicolon �� ��! 

select department_name
from employees 
where employee_id = 100; -- error!(invalid identifier)

-- 100�� ������� �μ��� ����
select department_id 
from employees 
where employee_id = 100; 

select department_name
from departments
where department_id=90; -- F10Ű: ���� ��ȹ! ���� ��ȹ���� CPU ���, I/O ��� ����. 
                        -- (�����͸� ǥ���ϴ� ��� - ���)
                        -- ���ʿ��� ���� ��ȹ <- CPU ���� ������. 
                        -- => Join ���! (���� �� SQL���� �ϳ��� ����)

select d.department_name
from employees e, departments d -- ���Ǿ�(synonym)!!!
where e.department_id = d.department_id -- (Join)
and e.employee_id = 100; 





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------






-- RDBMS �ȿ� �ִ� �����͸� �����ϴ� ���� SQL ���̴�. (Python, R�δ� ��� �� ��)
-- SQL�� �ð�ȭ �� ��. (Insight �����ϴ� ���� �Ѱ�) 
-- �ð�ȭ: R�� ���ؼ� SQL�� ���� ��. (R������ SQL ���� ����)
-- Hadoop <- Java ���(Hive ���)
-- SQL Developer�� Java ���(Java�� Oracle ����)
-- cf) Orange tool(���̼��� ��� �����ؾ� ��)

-- SELECT ��(Data Query Language) 
-- <- �����͸� ��ȸ�ϴ� ���(���� ���� ���, ���� ���ص� �ʿ�)

-- ���
-- 1. projection: �� ���� ����(table �ȿ�)
-- 2. selection: �� ����
-- 3. join: ���� �ٸ� ���̺��� ������ ����

select * from tab;
-- F10Ű �� �� <- ���� �ο� �� �Ʊ� ����
-- # ������ ������ �ִ� ���̺� ��� Ȯ��, DB�� ����� �� table ���� ���� ����
-- ���������� ���� ���� table �и�
-- (ex. �λ� ������ HR table�� ���� �и�, �ٸ� �μ��� ��� �� ��)
-- (hr user�� ����Ŭ���� ���� �������� ���� sample)
-- where���� optional(select, from�� �� ���ԵǾ� �־�� ��!)
-- from �ڿ��� ��� table �̸� ������ ��
-- * �� ��� �����͸� ��ȸ�ϰڴٴ� ��

desc employees -- "describe" the table of employees
-- table�� ���� Ȯ��(semicolon �� ��)
-- varchar2 <- Oracle���� ����ϰ� �ִ� "���� ���� ���� Ÿ��"
-- (�� Ÿ���� �𵨷��� ������ ���� ������)
-- ����: ������� ȿ���� Ȱ�� // ����: ������Ʈ �� ���ŷο�
-- DATE Ÿ�� <- 7����Ʈ�� ����(���� ���� �ϳ� �� 1����Ʈ(7��Ʈ), 
--                          �ѱ���� ���� �� 2����Ʈ)
-- �ð迭 ���� �м� ���� ������ �� DATE �˻��� Ư�� �Ű���! 
-- NUMBER(8,2) <- ��ü 8�ڸ� �߿� �Ҽ��� 2�ڸ� ���(10�ڸ� �ƴ�)
-- NUMBER(2,2) <- ��ü 2�ڸ� �߿� 2�ڸ� ���� �Ҽ��� �ڸ�
-- NOT NULL <- �� �ʵ忡�� �ݵ�� ���� ����! 
-- ����ġ(NA) <- NULL���� ����ִ� �ʵ�, ���� �� ���� �߻�

-- ## ASSIGNMENT 
-- ��ǻ���� ����(��Ʈ, ����Ʈ, ...) <- �����ϱ�! 

select last_name,salary from employees; 
SELECT LAST_NAME,SALARY
FROM EMPLOYEES;
-- F10Ű(���� ��ȹ, ��� ����) <- CPU�� ���(���� ���� ���)
-- �Ź� ���� ��ȹ�� �ٲ�� ��ǻ�� ���ɿ� �ǿ���! 
-- �� SQL������ Oracle�� ���� ��ȹ�� ����(�ٸ� DBMS�� ��������)
-- SID: �޸� �̸�
-- SQL�� �ϳ��� �����ϸ� Oracle�� "�޸�"�� ����
-- �Ȱ��� SQL���� �����ϸ� Oracle�� �޸𸮿� ����� "�Ȱ���" ���� ��ȹ�� ����
-- cf) �빮�ڷ� �ٲ㼭 ���� ������ SQL���� ������ ��� <- �ٸ� ���� ��ȹ!
-- (����� ��ҹ����� ü�谡 �ٸ�)
-- �޸� ��� ����! CPU ��� ����! 
-- �԰�ȭ�� SQL���� ����� �ʿ䰡 ����(��ҹ��� ������� ����)

-- <������ SQL���� ����>
-- ��Ģ�� �ְ� �����!!(���忡���� ���̵����(ǥ��ȭ ����) ������)
-- Ű����� �빮��, column �̸��� �ҹ���
-- 1. ��ҹ��� ��ġ
-- 2. ���鹮�� ��ġ(�� ĭ ��� �� �� ĭ ���� �ٸ� ���� ��ȹ���� �����)
--    TAB KEY, ENTER KEY
--    (���忡���� ���� �ٸ� �������� ������ �� ��ȣ <- ������ ������)
-- 3. �ּ�(comment) ó��(/* �ּ����� */, -- �ּ�����)
--    �ּ����뵵 ��ġ�Ǿ��! 
-- 4. �����ȹ�� �����ϴ� ��Ʈ /*+FULL(E) */ (Ʃ�� ����)
--    ��Ʈ(���̺��) <- ex. synonym
--    ��Ʈ�� ��ġ�Ǿ��
-- 5. �����, ���ͷ����� ��ġ�Ǿ�� �Ѵ�(ex. employee_id = 100,200)
--    (���ͷ���: single quotation mark�� �����ִ� ��)
--    (PL/SQL: ������� ���� ó�� <- ���ҽ� ��� ����)

select *
from employees
where employee_id=100;

select *
from employees
where employee_id=200;
-- INDEX UNIQUE SCAN
-- ex i. å�� ���� �ܾ ���� ã�ư��� ��� <- Index
-- ex ii. �� �ּ� <- ���󿡼� ������ ��(primary key)
-- �� row���� primary key ����(�ش� row�� �ĺ�)

select rowid, employee_id from employees;
-- �� primary key���� �������� �ּ�(rowid) ������ ����! (å�� "������ ��ȣ" ����)
-- rowid�� ���� column
-- rowid: row�� "������" �ּ�(���� ���� ���� �ּ�, ���� �ߺ����� ����)
-- AAAEAb AAE AAAADN AAA
-- rowid�� ���� 6�ڸ�: object id(object: DB ���� ��ü ex. employees)
-- �� ���� 3�ڸ�: data file ��ȣ
-- (Oracle�� storage�� ������ ���Ϸ� ���� <- ��� ��ġ�� ����Ǿ� �ִ� �� ���)
-- �� ���� 6�ڸ�: block ��ȣ(�� ��° block�� ����Ǿ� �ִ� �� ��� ex. �� �ּ��� ����)
-- �� ���� ������ 3�ڸ�: row slot ��ȣ(�� block �ȿ����� �� ��° ��ġ�� �ִ���)
-- ex. å �ȿ����� �� ��° ���忡 �ش� �ܾ ��ġ�� �ִ���

-- data file �ϳ��� ũ�� <- �ִ� 2�Ⱑ(32��Ʈ OS ����), 64��Ʈ�� ��κ� ���� ����
-- <- data file�� �����ؾ�!(data file ���� �� ����)
-- ũ�� ���� ������ data file ��ȣ�� Ʋ���� �� ����
-- 98��, 99�� row <- block ��ȣ �޶���(���� ��ȣ!)
-- rowid ��� �� �� <- index ���(Ʃ��), index �˰���(ex. 2��Ʈ�� ����)

-- Data ã�� ���� ���� ��� <- rowid�� where���� ���� ��!(rowid scan)
-- <rowid scan>
select *
from employees
where rowid='AAAEAbAAEAAAADNAAA'; -- single quotation mark('') �� ó��!
-- F10Ű <- BY USER ROWID SCAN
-- rowid�� �˻� <- �� �ϳ��� I/O�� �߻�! 

-- cf)
-- <index scan>
select *
from employees
where employee_id=100; -- �� ���� I/O�� �߻�(���� ����)
-- F10Ű <- UNIQUE SCAN
-- ex. ���� ������ ���(index mechanism) <- ���� å�� �� �� ������ Ȯ��(I/O �߻�)
--                                        �ܾ� Ȯ���ϰ� ���� �������� �̵�(I/O �߻�)
-- cf. ���� �������� �ƴ� ���(rowid scan) <- I/O �߻��� Ȯ���� �پ��
--                                         but rowid�� �ƴ� ���� ���� �平
-- ���� ������, index�� �� ��� <- full scan

-- data ó��(�˻�)�ϴ� ����� 2���� ��� ���̴�. 
-- 1. full scan
-- 2. rowid scan
--    2.1 by user rowid scan
--    2.2 index rowid scan(DBA�� rowid�� �𸣴�, index algorithm�� ���� ����!)

-- SQL�� �� ������ ��� ����(���� �ʵ尪�� ���� ����)
select employee_id,salary*12
from employees;
-- # ������
-- 1. ���������(��Ģ������): *, /, +, -
--    ������ �켱 ����: 
--    1����: /,* // 2����: +,- // ���� ������ ���, ���ʿ��� ����������
--    �˾ƺ��� ����(Ȥ�� ������ �켱���� �ٲٱ� ����) ��ȣ ���
--    (((a*b)/c)+d)
--    -----
--    1
--    ----------
--    2
--    ---------------
--    3
-- ��Ģ������ ������ Data type
--    number: *, /, +, -
--    date: +, -
--    char: ��Ģ������ �� ����. 
-- date�� ���� ���� but �ټ��� ������ char������ �ٲ��ֱ⸦ ���� 
-- char���� number������ �ٲ㼭 ���� ����(��¥�� ��ȸ, �Է� �� ���ŷο�)
-- date�� <- ������ ���� ��¥ ������ �޶���

select employee_id,salary,commission_pct,
from employees;
-- commission_pct: NULL�� ȥ��

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) ann_sal  -- 12����ġ salary�� commission �߰�
                                             -- �÷��� ǥ���� �״�� ����
                                             -- �÷����� �� ��Ī(ann_sal)���� ǥ��! 
from employees;
-- ���꿡 NULL���� �ϳ��� ���ԵǸ�, ������� ������ NULL��
-- nvl() �Լ� ���! 

-- nvl �Լ��� NULL���� ������ ��ü������ ��ȯ�ϴ� �Լ�(nvl(�÷���, ��ü��))

-- # NULL�� ����
-- 1. NULL�� ����� �� ���ų�, �Ҵ���� �ʾҰų�, �� �� ���ų�, ������ �� ���� ���̴�. 
-- 2. NULL�� 0�̳� ������ �ƴϴ�. (0�� ������ ���� // ������ �ڸ��� ������ ����)

-- NULL���� �������� ������ �����ϰ� ���� ���(ex. 0���� ��ü) <- select�����δ� �Ұ���
-- <- if���� �̿��ؼ� ���α׷� ���
-- (BUT) SQL�� �������� ��� 
-- <- SQL�� ������ ���α׷� ����(logic ����: PL/SQL)
--    �Լ� ���� or Oracle���� �����ϴ� �Լ�(nvl(�÷���,0)) ���

-- # �� ��Ī(alias)
-- 1. �� �̸��� �ٸ� �̸����� �ٲ۴�. 
-- 2. �� �̸� �ٷ� �ڿ� �� ĭ ��� �Ŀ� ����� �� �ְ�, 
--    �Ǵ�, "as Ű����" �ڿ� ����� �� �ִ�. 
-- ** �� ��Ī ����� �� ���鹮�ڰ� ���ԵǸ� �� ��! 
-- 3. �� ��Ī�� Ư�����ڴ� _, #, $�� �����ϴ�. 
--    �� ���� Ư�����ڸ� ����� ����, �÷��� ��ü�� "" ��� ����ϸ� �ȴ�.
--    (single quotation mark�� �� ��)
-- 4. ""�� ����ϸ� ��ҹ��ڵ� ���еȴ�. 
-- 5. �� ��Ī�� �� �� �κп� ����, Ư������ ������ �� ��. ("" ��� ǥ���ϱ�)

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) "Ann ^ Sal" -- ""�� ��� ǥ��
from employees;

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) "200sal" -- ""�� ��� ǥ��
from employees;

-- �� �÷� ������ �ϳ��� �ʵ尪���� ����
select last_name || first_name || salary -- ���ڸ� ��ĥ ��쿡�� ���� �������� ��ȯ
from employees;

-- # ���� ������
-- 1. ���̳� ���ڿ��� �ٸ� ���� ������ �� ���ȴ�. 
-- 2. �� ���� ���μ�(||)���� ��Ÿ����.
-- 3. ����� ���ڽ����� �����ȴ�.

-- ���ͷ� ���ڿ�(''�� ���鹮�� ǥ��)
select last_name || ' ' || first_name 
from employees;

-- table�� ���� Ư�� ������ ǥ��(���ͷ���('')�� �̿�)
-- ���ͷ����� ����� ���� �ݵ�� ||�� ���� ���
-- alias �� ��Ī ��� ����
select last_name || ' is a ' || job_id "emp details"
from employees;

-- ���ڿ� ���� '�� ǥ���ϰ� ������, ''�� �ϳ� �� Ÿ����! 
select 'My name''s ' || last_name sentence
from employees;
-- �Ǵ�, q������(q'[]')�� �̿� -- (!<{[ ]}>!)
select q'["My name's ]' || last_name || q'["]' sentence 
from employees;
select q'{"My name's }' || last_name || q'{"}' sentence 
from employees;
select q'{["My name's }' || last_name || q'{"]}' sentence 
from employees;
select q'<{["My name's >' || last_name || q'<"]}>' sentence 
from employees;
select q'!<{["My name's !' || last_name || q'!"]}>!' sentence 
from employees;



-------------------------------------------------------------------------------

/* <����1> employees ���̺��� employee_id, last_name�� first_name�� 
�����ؼ� ǥ���ϰ�(�������� ����) �� ��Ī�� ȭ�鿹 ó�� ���� �ۼ��� �ּ���.

ȭ�鿹>
Emp# 	Employee Name
---------- ------------------------------
100 	King Steven
101 	Kochhar Neena
102 	De Haan Lex
103 	Hunold Alexander
104 	Ernst Bruce */

select * from employees;
select employee_id "Emp#", last_name || ' ' || first_name "Employee Name"
from employees;

-- ���� row�鸸 ���� ����
select employee_id "Emp#", last_name || ' ' || first_name "Employee Name"
from employees
where employee_id in (100,101,102,103,104);



/* <���� 2> employees ���̺��� �÷��߿� last_name, job_id�� 
�����ؼ� ǥ���ϰ�(��ǥ�� �������� ����) �� ��Ī�� ȭ�鿹 ó�� ���� �ۼ��ϼ���.


ȭ�鿹>

Employee and Title
-------------------------
Abel, SA_REP
Ande, SA_REP */

select last_name || ', ' || job_id  "Employee and Title"
from employees;

-- ���� row�鸸 ���� ����
select last_name || ', ' || job_id  "Employee and Title"
from employees
where last_name in ('Abel','Ande');

-------------------------------------------------------------------------------



-- # �ߺ��� ����(Unique�� ���� ����)
select distinct department_id from employees;
-- Sort <- �ߺ��� �����ϴ� �ϳ��� ���
-- distinct�� ����ϸ� ���������� sort, "hash �˰���"�� �۵�(F10���� Ȯ��)
-- Hash algorithm: �������� ������ ���� �̿��Ͽ� ����
-- ex. 10���� ���� <- ���� 10���� ������ ������ ���� ���� 0~9�� �з�
-- Hash�� CPU�� ������ ȿ�������� ���� ����
-- Oracle�� �޸� <- Hash algorithm���� ����! 

-- distinct: select���� �� �տ� ���, comma�� ���� ����

select distinct department_id,job_id 
from employees
order by department_id desc;
-- �μ� ���̵�� ����������, job id�� �ٸ� <- �ٸ� row��� �Ǻ�(�ߺ����� ���� �� ��)
-- ����: order by��

-- # where���� ���� ���� �����Ѵ� 
-- �񱳿�����: =, >, >=, <, <=, !=, ^=, <>
-- !=, ^=, <>: "���� �ʴ�"�� ��
-- where���� �� ����ϱ� ���ؼ��� ���� �ľ��� �� �Ǿ� �־��! 

select *
from employees
where department_id=30;
-- where <- �񱳿�����(>,<,=) ���

select *
from employees
where salary>10000;
-- �̻�(>=), ����(<=), �ʰ�(>), �̸�(<) ������ �� �˾ƾ�!! 
-- salary <- number Ÿ��(�񱳿����� ��� ����) 
-- cfi) String Ÿ��: ���ͷ� ���ڿ�('')�� ǥ��
-- cfii) number Ÿ�Կ��� ���ͷ� ���ڿ� ��� ���� but ���ҽ� ���� ������
--       (���� ���� Ÿ���� ����ġ ��Ű��, ��ü������ conversion ��Ŵ)
--       (index scan�� full scan���� �ٲ�)
-- �� ����(column)�� Ÿ���� desc employees�� ���� ��Ȯ�� �ľ��ؾ� ��! 

/*

select *
from employees
where department_id=30;
        number      number
                    '30'
        number   <- char

Ÿ���� �ٸ� ���, �ڵ����� char�� number�� ���󰡵��� ��(conversion)
<- �� ��ȯ �Լ��� �ڵ����� ����! 
where department_id=to_number('30'); <- ������ index scan

cf)
        char ->     number
where to_number(department_id)=30; <- full scan���� �ٲ�!
(char�� number�� ���󰡱� ����)

* where������ char�� number�� �� <- Oracle�� �˾Ƽ� conversion ���� 
** where���� ����� ����, �ݵ�� Ÿ���� ���� ��! 

*/

select *
from employees
where department_id='30';

select *
from employees
where last_name='King';
-- �ҹ��ڷ� king�� �˻��ϸ� ���� �� ��
-- �ʵ尪�� ��� �ҹ��ڷ� ��ȯ�Ѵ��� ��! 



select *
from employees
where lower(last_name)='king'; -- ������ full scan
                               -- �÷����� �Լ��� ���� �ʴ� �� ����
                               
select *
from employees
where upper(last_name)='KING';

select *
from employees
where initcap(last_name)='King'; -- ù���ڸ� �빮�ڷ� ��ȯ

select *
from employees
where to_number(department_id)=10; -- F10: full scan���� �ٲ�!(���ҽ� ����)



-- # Date��

select employee_id "EmpID", hire_date "EmpDate"
from employees;
-- date�� <- ����, �� ���� ��¥ ������ �޶��� 
-- exi. �ѱ�: RR/MM/DD <- 2000�⵵ ������ ����(Oracle���� �ڵ����� conversion ��Ŵ)
--                       (���⸦ ǥ������ ���� ���� - �ϵ� ��ũ ����� ��ձ� ����)
--                       ������ 4�ڸ��� ǥ���ϴ� ���� ������!(2�ڸ��� ǥ���Ǵ���)
-- exii. �̱�: DD-MON-RR <- DD,RR�� ������ ����, MON �κ��� �� ����

select *
from employees
where hire_date='2001/01/13'; -- �ѱ������� �˻� ��. �̱������� ��ȸ �� ��. 

select *
from employees
where hire_date='2001-01-13'; -- �׷��� ���� but �̱������� ��ȸ �� ��

select *
from employees
where hire_date='20010113'; -- �׷��� ���� but �̱����� �ϸ� ���� �� ��

select *
from employees
where hire_date='13-JAN-2001'; -- �˻� �� ��! (Date���� ����, �� ����)

-- ��� ���������� �˻��ϴ� ��(�� ��ȯ �Լ� ���)
select *
from employees
where hire_date=to_date('2001-01-13', -- ''ǥ�� <- ����(���ͷ� ������)
                        'yyyy-mm-dd');  
                        
-- to_date: char -> date
-- ��¥('2001-01-13')�� �⺻������ char��
-- where hire_date='2001-01-13'
--          date       char     
-- �⺻������ date�� char��������, ����(yyyy-mm-dd)�� ���߸� �ڵ����� ���� �ٲ�(�Ͻ���)
-- �̱���('13-JAN-2001')�� ������ �־��� ���� ������ �ʾƼ� ���� �߻�
-- cf) ����� ��ȯ: to_date() <- ���ڴ޸� ��� ��! 

select *
from employees
where hire_date=to_date('20010113',
                        'yyyymmdd'); -- ��¥�� �̷� �������� ���ߴ� �� ����ȭ! 
                        
select *
from employees
where department_id=50
and salary>=10000;

select *
from employees
where department_id=50
or department_id=40;

-- ** NULL <- �������� True�� False�� �� �� �ִٴ� ��
-- True AND NULL <- NULL
-- False AND NULL <- False(��� ���� ������ False�̱� ����)
-- True OR False <- True
-- True OR NULL <- True
-- False OR NULL <- NULL

select *
from employees
where hire_date=to_date('01/13/2001'); 
-- �ڵ����� ��ȯ �� ��(�׻� ���� ���� ���� ����!)
select *
from employees
where hire_date=to_date('01/13/2001','mm/dd/yyyy'); 

/*
<����3> employees ���̺��� �޿��� 2500 ~ 3500�� ������� ��� ������ ��ȸ�ϼ���.

<- ���� ��ĵ�� ����, �̻�/�������� �ʰ�/�̸����� �������� �����! 
*/
select * 
from employees
where salary>=2500
and salary<=3500;

-- ���� �����ϰ� ����� ��
select *
from employees
where salary between 2500 and 3500; -- between ���� �� and ū ��
                                    -- ������ number, date, char Ÿ�� �� ����
                                    -- "�̻�/����"�� �ǹ�("�ʰ�/�̸�"�� �ǹ̰� �ƴ�)
                                    
/*
<����4> �������� �����ȣ�� 100,101,200�� ������� ��� ������ ������ּ���.
*/
select *
from employees
where manager_id=100
or manager_id=101
or manager_id=200;

select *
from employees
where manager_id in (100,101,200);

select employee_id,manager_id
from employees;

select *
from employees
where manager_id<>100
and manager_id<>101
and manager_id<>200; -- or�� and�� �ٲٱ�! 

select *
from employees
where manager_id not in (100,101,200);

-- in ������ = OR
-- not in ������ = NAND(NOR�� �ƴ�)

select *
from employees
where manager_id not in (100,101,300);

select *
from employees
where manager_id not in (100,101,NULL); 
-- ���� �� ����(False) <- NAND�̱� ����(NOR�� �ƴ�) 

select *
from employees
where manager_id in (100,101,NULL);
-- �ʵ尪�� ����(True) <- OR�̱� ����
-- not in <- �����ڰ� �ݴ�� ��ȯ(= <- <>), or�� and�� ��ȯ 
-- char���� ��� <- ���������� '' ǥ��, ��ҹ��� ����!

select *
from employees
where last_name like 'K%'; -- wild card(%): ���� ������ ã������ �� �� ���� ������

select *
from employees
where last_name like '_i%'; -- i�� �ι�°�� ���� �̸�
                            -- %�� ù��° ���ڿ� �� �� ����! �� ��� _ ���!

select *
from employees
where last_name like '__i%'; -- i�� ����°�� ���� �̸�

-- ��Ȯ�� ��ġ�� �� ���� % // ��ġ�� �˰� ���� ���� _
-- like �����ڴ� ���� column�� ������ char Ÿ���̾��! 
-- like �����ڴ� "����" ������ ã�� ������
-- char ���� Ÿ�Կ� �� �����ڸ� �� ��� �۵��� ������ �Ǽ� �ڵ尡 ��

/*
[����5] last_name �ι�° ��ġ�� �ҹ��� o�� �ְ� �ڿ� � ���ڰ� ���� �𸥴�. 
�� ���ǿ� �ش��ϴ� �����͸� �������ּ���.
*/

select *
from employees
where last_name like '_o%';

-- %, _�� ���ڿ� ���Խ��Ѿ� �� ���

select *
from employees
where job_id like 'SA\_%' escape '\'; 
-- �������� "�ٷ� ��"�� �ִ� �� "����(char)"�� �ν�
-- �������� ���� �ٸ� Ư������(^)�� ��� ����
select *
from employees
where job_id like 'SA\_\%' escape '\'; -- %�� ���ڷ� �ν�
/* 
SAREP
SA_REP <- �̰� ã������ �ϴ� ���

where job_id like 'SA_%' escape '\' <- �� �� ����
where job_id like 'SA\_%' escape '\' <- SA_REP�� ����
*/

-- like �����ڴ� "����" ������ ã�� ������
-- char ���� Ÿ�Կ� �� �����ڸ� �� ��� �۵��� ������ �Ǽ� �ڵ尡 ��

select *
from employees
where hire_date like '01%';
-- �ش� row�� ����(test db�� �ش�)
-- but � db�� ������ ���� �߻�
-- internal_function <- �Ǽ� �ڵ�� ���� ������ ����
-- like �����ڴ� �⺻������ char Ÿ���� ���� �� ������, 
-- column(hire_date: date Ÿ��)�� char������ �ڵ� ��ȯ <- full scan
-- <- �� �������� �Ǽ� �ڵ尡 ��

-- SOLUTION 1(date������ between �����ڷ� range scan�� ����)
select *
from employees
where hire_date 
between to_date('2001-01-01','yyyy-mm-dd')
and to_date('2001-12-31','yyyy-mm-dd');
-- but �����Ϳ� ���� loss�� ���� �� ����
-- ������ �� �ð��� 00:00:00���� �����Ǿ� ���� <- �� �ð� ������ row�� ������! 
-- �ú��ʸ� ���� �������� ������, Oracle�� �ڵ������� 00:00:00�� �ڵ� ����
select *
from employees
where hire_date 
between to_date('2001-01-01','yyyy-mm-dd')
and to_date('2001-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');
-- hh24:mi:ss�� ���� �ú��� ������ ����! 

-- SOLUTION 2
select *
from employees
where hire_date>=to_date('2001-01-01','yyyy-mm-dd')
and hire_date<to_date('2002-01-01','yyyy-mm-dd');



-- �켱����(and�� or���� ���� �۵�)
select *
from employees
where (job_id='SA_REP' 
or job_id='AD_PRES')
and salary>10000;

select *
from employees
where job_id='SA_REP' 
or job_id='AD_PRES'
and salary>10000; 
-- �̷��� ����, where job_id='SA_REP' or (job_id='AD_PRES' and salary>10000); 
-- <- �̷� ������ �۵�!!!(SQL�� �������� ���)
-- or�� and�� ���ÿ� �� ����, ��ȣ�� �� �����ϱ�





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------




/*
���� data vs ������ data

ASSIGNMENT: ������ ���� �� �ܿ��
*/

-- # SORT ����
-- order by ���� select ���� ���������� ����Ѵ�. 
-- default�� �������� ���ĵȴ�. <- asc(ascending)
-- ������������ ���� <- desc(descending)
select last_name,salary
from employees
order by last_name;

select last_name,salary
from employees
order by salary;

select last_name,salary
from employees
order by salary asc;

select last_name,salary
from employees
order by salary desc;

select department_id, salary
from employees
order by department_id asc, salary desc;
-- �μ����� ������������ �����ϰ�, �� �ȿ� ������ ������������ ����

select last_name, department_id, salary*12 ann_sal
from employees
order by salary*12; -- ǥ���� �״�� ��� ����

select last_name, department_id, salary*12 ann_sal
from employees
order by ann_sal; -- alias ����ؼ� ����

select last_name, department_id, salary*12 "ann_sal"
from employees
order by "ann_sal";  -- ""�� synonym�� ������� ���� order by������ "" ǥ���ϱ�

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 3; -- ��ġ ǥ���("ann_sal" <- 3��° column) 

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 2 asc, 3 desc;

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 3 desc, 2 asc;

-- order by���� ���� �������� ��(ȭ�� �� ����ϱ� ���� sort �۾�)
-- NULL ���� ���������� �� ���� ��, ���������� �� ���� �տ� ��ġ(���� ū ������ �ν�)



-- DB�� �ִ� ������ ����
-- select �̿��� ����� �����ϴ� ���α׷� <- �Լ�

-- �Լ�: ����� ���α׷�
-- �Լ� <- �̸� ¥���� ��(PL/SQL)



-- 1. �����Լ�
--    �����Լ��� �Էº����� char���� ����־���� ��
--    ���ڸ� ���������, ���� �߻� <- char������ ��ȯ������� ��
select lower(last_name),upper(last_name),initcap(last_name)
from employees; 
--    ��ҹ��� �������ִ� �Լ�
--    �� 3���� - lower: �ҹ��� ��ȯ // upper: �빮�� ��ȯ // initcap: ù ���� �빮��
select *
from employees
where last_name = 'king'; -- by index rowid
                          -- index: rowid �̿ܿ� 'King'�� ������ ������ ����

select *
from employees
where lower(last_name) = 'king'; 
-- ��� ����� �������� ����
-- ������ ���� ���� ������ select �κп��� �Լ� �����ϱ�
-- �� �ڵ�ó�� �Է��ϸ� �Ǽ� ���α׷��� ��(full scan) 
-- <- �Լ��� where�� �������� ���� �� ������ ��!(�����ؼ� ����)
-- �̷��� �Լ��� ��ȸ �ܰ躸�ٴ� �Է�, ���� �ܰ迡�� ���� �� �� ������ 



-- concat(): ���� ������(||) <- concat�� �μ������� 2���� ���!! 
select last_name||first_name, concat(last_name,first_name)
from employees;

select last_name||first_name||salary, concat(last_name,first_name)
from employees; -- ||�� ������� char��



-- length(): ������ ���� 
select last_name, length(last_name)
from employees; 



-- substr(): ���ڸ� �Ϻκ� ���� 
-- <- ex i. substr(x,1,3): x�� 1���� 3���� ����
-- <- ex ii. substr(x,1,1): x�� ù ���ڸ� ����
-- <- ex iii. substr(x,-2,2): x�� -2���� 2���� ���� ����(-2���� "������"���� 2�̵�)
select last_name, length(last_name), 
substr(last_name,1,3)
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-2,2) -- -2���� "����������" 2 �̵�!!!
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-1,1)
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-2,1) -- ������ 2��° ���� �ϳ��� ����
from employees;



-- lpad(), rpad(): ���ڸ� ���ڷ� ������Ű�� �Լ�(�ڸ��� ������Ű�� �۾� ����)
select salary, lpad(salary,10,'*') -- salary���� 10�ڸ��� ������Ű��, 
                                   -- ������ ������ *�� ó��(������� �ڸ��� �𸣰Բ�)
from employees;

select salary, lpad(salary,10,'*'), rpad(salary,10,'*') -- ������ ����! 
from employees;

-- dual: dummy table
-- �Լ��� ǥ���Ŀ� table ��𿡵� ���� ���� �Է��� ���
-- <- from���� dummy table(���� ���̺� ����) <- dual
-- test �۾��� ������ �� ���� ��
select instr('abbcabbc','c') -- c�� ��� ��ġ�� �ִ� �� ���ڷ� ���ϰ� ǥ��
                             -- �Էº��� �ڿ� 1,1�� ������ ��
                             -- instr('abbcabbc','c',1,1) 
                             -- ���� 1�� ����! 
from dual; -- dummy table



-- instr(): ���̺�(�÷�)�� �ش� ���ĺ��� �ִ� ���� ���θ� ������ �ľ� 
select instr('abbcabbc','c'), instr('abbcabbc','c',1,2) 
-- 1���� ���ۿ��� "2��° c"�� ������ �� ǥ��
from dual;

select instr('abbcabbc','c'), instr('abbcabbc','z',1,1) 
from dual;

select 1+2
from dual;

select last_name, instr(last_name,'i')
from employees; -- employees ���̺��� last_name �÷��� i�� ��ġ�� �ִ� ���� ���� �ľ�
                -- text mining�� ���� �̿��
                
select last_name
from employees
where last_name like '%i%';

select last_name
from employees
where instr(last_name,'i')>0; -- like ������ �̿��� ���� ������ �����
                              -- instr() ���� 0�� �ʰ��ϸ�, �ʵ忡 �����Ѵٴ� ��
                              -- �̰�(instr) ���� ��(like)���� ������ �� ����
                              -- <- �Լ��� ���� ó���ϱ� ����



-- trim(): �ش� ���ڸ� ������ �Լ� <- "����, ���� �κ�"�� ���� �� ����(�߰� �κ��� �ȵ�)
-- trim( from )
select trim('A' from 'AABBCAA')
from dual;

select trim('A' from 'AbABBCAA') -- b ���� A�� ���� �ȵ�
from dual;

-- ltrim() <- ���� ���� �κ� ���� // rtrim() <- ������ ����
-- ltrim(), rtrim()�� ��ȣ �ȿ��� from�� ���� ����
select trim('A' from 'AABBCAA'), ltrim('AABBCAA','A'), rtrim('AABBCAA','A')
from dual;

-- �� �� ���� ���� ����
select trim('A' from 'AABBCAA'), ltrim('  BBCAA ',' '), rtrim(' BBCA  ',' ')
from dual;



-- replace(): �ϳ��� ����(-)�� ã�Ƽ� �ٸ� ����(%)�� ġȯ
-- �߰� �κе� ���� ����
select replace('100-001','-','%')
from dual;

select replace('100-001','0','9')
from dual;
-- �ؽ�Ʈ ������ �м��� �� ǥ���� �ϰ��ǰ� ����� ���� ���

select replace('100-001','-','')
from dual;
-- �� ���� ��ȣ �����ϱ� ���ϰ� ����� ���� hyphen, ���� ���� ����

select replace('1 0 0 0 0 1',' ','')
from dual;



-- 2. �����Լ�
-- round(), trunc(), mod()



-- round(): �ݿø�
select round(45.926, 0)
from dual;

select round(45.926, 0), round(45.926, 1), round(45.926, 2) -- �Ҽ��� ��° �ڸ�
from dual;

select round(45.926, 0), round(45.926, 1), round(45.926, 2), round(45.926, -1)
from dual; -- -1: 10�� �ڸ� ����!! 

select round(45.926, 0), round(45.926, 1), round(45.926, 2), 
round(45.926, -1) "10�� �ڸ� �ݿø�", 
round(45.926, -2) "100�� �ڸ� �ݿø�(0)", 
round(55.926, -2) "100�� �ڸ� �ݿø�(100)"
from dual;



-- trunc(): ���� // ceil(): �ø�
select trunc(45.926, 0), trunc(45.926, 1), trunc(45.926, 2), trunc(45.926, -1)
from dual;

select ceil(45.0), ceil(45.12), ceil(45.926)
from dual;



-- mod(): ������ ���� �� ���� �ƴ� ������ ���� ����(ex. Hash, ���� ...)
select mod(13,2)
from dual;



-- 3. ��¥ �Լ�
-- ��¥ ���
select sysdate 
from dual; -- ���� DB ������ �ð���(����, �� ����)



-- ��¥ + ����(�ϼ�) = ��¥ <- �ϼ� ������ 
select sysdate, sysdate+7 
from dual;
-- ��¥ - ����(�ϼ�) = ��¥
select sysdate, sysdate+7, sysdate-7
from dual;
-- ��¥ - ��¥ = ����(�ϼ�) <- ��¥�� char������ �Ǿ� �ִ� ���, Ÿ�� ��ȯ! 
select employee_id, sysdate-hire_date
from employees;
-- ��¥ + �ð�/24 = ��¥ <- 24�ð����� ȯ��!! 
-- ��¥ + ��/(24*60) = ��¥
-- ��¥ + ��/(24*60*60) = ��¥
-- ��¥ + ��¥ = ����! 



-- ��¥ �Լ�



-- months_between(�ֱٳ�¥, ���ų�¥): �� ��¥ ������ ���� �� ǥ��
-- ������ ��¥ ����(date Ÿ��)�� �־���� ��!! 
-- �Է°��� date Ÿ��������, ���ϰ��� number Ÿ��
-- ���ϰ�(���� ��)�� �Ҽ��� ���ְ� ������ trunc() ���� ��
select months_between(sysdate,hire_date)
from employees;

select months_between(to_date('2018-05-24','yyyy-mm-dd'), 
                   -- to_date() <- �� ��ȯ �Լ�
to_date('2018-11-22','yyyy-mm-dd'))
from dual; -- ����� ���������� ����

select months_between(to_date('2018-11-22','yyyy-mm-dd'), 
to_date('2018-05-24','yyyy-mm-dd'))
from dual;



-- add_months(��¥ ����, ���� ��): �ش� ��¥�� ���� ���� ����
select add_months(sysdate,6)
from dual;



-- next_day(���� ��¥, ����): ����� "�̷�" ������ ���Ͽ� �ش��ϴ� ��¥ ���� ����
select next_day(sysdate,'�ݿ���') -- ��¥�� ������ �� ����
from dual;



-- last_day(): �� ���� ������ ��(��¥ ������ �Է�!) 
select last_day(sysdate)
from dual;



-- round(��¥, 'month or year'), trunc(��¥, 'month or year')
-- overloading: ���� �Լ� �̸�, �ٸ� ���(�ٸ� Ÿ���� �μ�)
select round(sysdate,'month') -- ������ �������� �ؼ� "��(day)"�� ���� ��! 
from dual;

select round(sysdate,'month') "���� ���� �ݿø�", 
round(sysdate,'year') "���� ���� �ݿø�"
from dual;

select trunc(sysdate,'month') "���� ���� ����", -- �� ���� 1��
trunc(sysdate,'year') "���� ���� ����" -- �� �� 1�� 1��
from dual;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------




-- # ����ȯ �Լ�
-- ������ Ÿ���� �ٲ�� ����� �Լ�

-- �Ͻ��� ����ȯ <- �ǵ�ġ �ʰ� ���� ��ȯ��(�� ���� ���)
desc employees

select *
from employees
where department_id = '10';
--        number    = number
-- cfi)   number    = char <- ���� �ȸ���(���α׷� ���� <- ��ü������ recession �߻�)
-- char�� number�� �i�ư����� �Ǿ� ����(�Ͻ��� ����ȯ)
-- cfii)  char      = number <- ����Ŭ���� ��ü������ recession ó��(�Ͻ��� ����ȯ)
--                           <- char�� ����ȯ �Լ��� �۵� 
--                           <- ���� ��ȹ�� ������(full scan) <- �־��� ���̽�
--                           <- number�ʿ� ��������� ����ȯ �����ִ� �� ����

-- �ٸ� type�� �����ٰ� ������ ����ȯ �������� ����(ex. 10, '��' <- ���� �޽���)

select *
from employees
where hire_date = '2001/01/01';
--        date  =  char <- ����(����Ŭ���� ����ȯ but ����ó�� ������ �ٲ����� ����)
-- date�� ����, �� �ΰ� <- �� ���� �´� ���ڸ� ������ ���� ����ȯ
-- ex. �ѱ����� Jan�̶�� ������ ��쿡�� ���� �޽���
select *
from employees
where hire_date = '01-01-2001';
-- ����Ŭ������ '01-01-2001'�� ��¥�� �ν����� ����(�ѱ��� ��¥ ������ �ƴϱ� ����)
-- ���� �޽���! 

select last_name || salary
--         char  || number
from employees;
-- �ٸ� type�� �������� ���� <- char�� ��! 
-- date || number <- char�� �ν�! 

select 1+'2'
-- number+char
from dual; -- ����Ŭ���� ��ü������ ���ͷ� ����('2')�� number�� �ٲ���! 



-- to_char �Լ�: number -> char 
--             // date -> char������ ��ȯ�ϴ� �Լ� <- ���� �ۼ���!
-- OVERLOADING <- date, number

-- to_char(��¥,'����') <- '' �ȿ� �ִ� ���ͷ� ���ڴ� ""�� ǥ��! 

select sysdate from dual; -- # sysdate: �����ð���(RDBMS: ���� ���α׷� O, OS X)
                          -- �����ð�: OS�� ������ �ִ� �ð����� ������(PC�� �ð�!)
                          -- R, Python�� ��������
                          -- OS�� �ð��� �߸� �����Ǿ� ������, Ʋ���� ǥ��
                          -- sysdate�� ��¥�� ����, "�ð�" �������� ������ ����
                          -- date ������ ���� ���ϰ� ������ų �� ���� <- to_char()
select to_char(sysdate,'yyyy')
from dual; -- ��¥ ����(sysdate)�� char Ÿ������ ��ȯ
select to_char(sysdate,'yyyy year') -- ���ڿ����ε� ���� ����
from dual;

select to_char(sysdate,'yyyy year 
                        mm month mon') -- ���ڴ�, ���ڴ��� ���(�� ����)
                                       -- ������ ���� ������ ������ ��! 
from dual;

select to_char(sysdate,'yyyy year 
                        mm month mon 
                        dd day')
from dual;

select to_char(sysdate,'ddd dd d') -- ddd: 365�� �߿� ���� �� ��
                                   -- dd: �� ���� �� ��
                                   -- d: �� ���� �� ��(ex. ȭ���� <- 3) <- ��������!
from dual;

select to_char(sysdate,'ddd dd d day') -- day: ����(�� ����)
from dual;

select to_char(sysdate,'ddd dd d day dy') -- dy: ������ ���
from dual;

select to_char(sysdate,'ddd dd d day dy q"�б�"') -- q: �б�(�� 4�б�)
                                                 -- '' �ȿ��� ""�� ���ͷ� ���� ǥ��
                                                 -- '' �ȿ��� || ����ϸ� �� ��
from dual;

select to_char(sysdate, 'hh24:mi:ss.sssss') -- hh24: 24�ð� ȯ��(default: 12�ð�)
                                          -- �ð��� 01,02,03... �̷��� ����
                                          -- ���� 0�� �����ϰ� ���� ��� <- fmhh24
from dual;

select to_char(sysdate, 'hh:mi:ss.sssss am') -- �ð� �� ���(am, pm)
from dual;

select to_char(sysdate, 'fmhh24:mi:ss.sssss') -- ���� 0�� �����ϰ� ���� ���
from dual;

select to_char(sysdate,
              'ddspth') -- �� ���� ��(dd)�� ���縵(sp)���� ǥ���ϰ� ����(th)������
from dual;

select to_char(hire_date, 'day')
from employees
order by to_char(hire_date, 'day'); -- '��ȭ�������' �̷��� sort �� ��!
                                    -- 'ddd dd d day dy'�� d Ȱ��! 
                                    
select to_char(hire_date, 'day')
from employees
order by to_char(hire_date, 'd'); -- ����� ���� ���� ����! 
                                    
select to_char(hire_date, 'day')
from employees
order by to_char(hire_date-1, 'd'); -- �����Ϻ��� ����(hire_date-1)



-- ��Ÿ ��¥ �� ���
select to_char(sysdate,'bc scc yyyy') -- bc: �����, ���� // scc: ����
from dual; 

select to_char(sysdate,'bc scc yyyy ww w') -- ww: 1�� �� ���° �� // w: �� ���� ��
from dual; 

select to_char(sysdate+216,'bc scc yyyy ww w') -- ���ش� 53�ֱ���
from dual; 



-- number -> char
-- number������ ,. �� ��
-- ����� ���� char�� number�� �ٲ�� ��(,. ����) <- ������ ���� �۾�
select to_char(salary,'999,999.00') -- õ���� ����(number -> char Ÿ�� ��ȯ)
from employees;

select to_char(salary,'999,999,999.00') 
from employees;

select to_char(salary,'000,000,999.00') -- �� �ڸ��� ���� ������ 0�̶� ���
from employees;

select to_char(salary,'999,999.00'),to_char(salary,'999g999d00') -- ���� �����
                                                -- �������� ,. ������ �ٸ� ��� ���
from employees;

select to_char(salary,'$999,999.00') -- �޷�ȭ ǥ��
from employees;

select to_char(salary,'l999,999.00') -- ��ȭ ǥ��(���ĺ� l: �� ������ ��ȭ ǥ��)
from employees;

select to_char(salary,'999.00') -- �ڸ� ���� �� �´� ��� <- ########���� ����
from employees;



-- to_number(): char -> number ����ȯ �Լ�



-- ���� ����

select * from nls_session_parameters;

ALTER SESSION SET NLS_TERRITORY=KOREA;
ALTER SESSION SET NLS_LANGUAGE =KOREAN;

ALTER SESSION SET NLS_TERRITORY = GERMANY;
ALTER SESSION SET NLS_LANGUAGE= GERMAN;

ALTER SESSION SET NLS_LANGUAGE =JAPANESE;
ALTER SESSION SET NLS_TERRITORY=JAPAN;

ALTER SESSION SET NLS_LANGUAGE =FRENCH;
ALTER SESSION SET NLS_TERRITORY=FRANCE;

ALTER SESSION SET NLS_TERRITORY=AMERICA;
ALTER SESSION SET NLS_LANGUAGE =AMERICAN;

ALTER SESSION SET NLS_TERRITORY=china;
ALTER SESSION SET NLS_LANGUAGE = 'simplified chinese';

ALTER SESSION SET NLS_TERRITORY = GERMANY; -- ���� ����
ALTER SESSION SET NLS_LANGUAGE= JAPANESE; -- �Ϻ���

-- alter session set: �����ϴ� ���ȿ��� ���� <- ������ ������ �� ���·� ȸ��
-- territory, language <- parameters

select employee_id, 
      to_char(salary,'l999g999d00'),
      to_char(hire_date, 'YYYY-MONTH-DD DAY')
from employees; -- ������ ��� ���� �ڵ尡 �۵��� �� �ְ� ����

select sysdate from dual;
alter session set nls_date_format = 'yyyymmdd';
-- nls_date_format ���� ����(���� ��������)
select sysdate from dual;
select * from employees where hire_date > '20020101';
-- ��¥�� ���������� �Է��ϴ���, ������ ������ format��� ��� ��!



-- to_date: char -> date ����ȯ �Լ�
select employee_id "Emp ID", last_name "Last Name", hire_date "Hire Date"
from employees
where mod(to_number(to_char(hire_date,'fmmm')),2)<>0
and hire_date>=to_date('2006/01/01','yyyy/mm/dd')
and hire_date<to_date('2007/01/01','yyyy/mm/dd');



-- ��¥ ������ column type
-- �ð� ���� �������ִ� �Լ�(5��)
-- sysdate, systimestamp <- ������ �ð�
-- current_date, current_timestamp, localtimestamp <- Ŭ���̾�Ʈ�� �ð���(���� �ð���)

-- nls ���� ��θ� �ϰ� ������ <- �׳� �� 5�� date type ���� ��
-- date Ÿ���� �� ������ �ڸ����� �����ϰ� ������ <- to_char()

-- date �Ӹ� �ƴ϶�, timestamp Ÿ�Ե� ����
-- date Ÿ�� <- �ڸ� �� ǥ�� �� ��
-- timestamp(9) <- �� ������ �ڸ� �� ǥ��(9���� ����, default = 6)

-- timestamp with time zone <- date Ÿ�Կ� time zone �������� ǥ��(time zone���� ������ �� �ִ� ��¥ Ÿ��)
-- timestamp with local time zone <- �ð��븦 �ڵ����� ����ȭ��Ŵ(�ð��븦 ���� ������ �°� �ڵ����� ������), time zone ǥ�� ����
--                                   ����(�ѱ�)�� Ŭ���̾�Ʈ(�̰���)���� ���� �ð��� ������!

select sysdate, systimestamp, current_date, current_timestamp, localtimestamp
from dual;
-- sysdate <- date Ÿ���� ����(nls_date_format)
-- systimestamp <- �� ���� 9�ڸ�(timestamp Ÿ��), time zone ǥ��

-- current_date <- sysdate�� ���� �������� ǥ��(date Ÿ��)
-- current_timestamp <- ���� �̸� ǥ��(instead of time zone) <- systimestamp�� ���
-- localtimestamp <- time zone ����(timestamp(9) ǥ��), ������ �ð��� timestamp ��������!

-- current_date, current_timestamp, localtimestamp <- time zone�� ������ ����(Ŭ���̾�Ʈ �ð���)

-- ex. �ѱ� ������ �̿�������, Ŭ���̾�Ʈ�� �̰����� �����ϰ� �ִ� ���
-- sysdate, systimestamp <- ������ �ð�(����Ŭ DB�� �ν�)
-- current_date, current_timestamp, localtimestamp <- Ŭ���̾�Ʈ�� �ð���(session�� �ð���)

alter session set time_zone = '+08:00'; -- �̰��� �ð�
-- sysdate, systimestamp ����(���� �ð�)
-- current_date, current_timestamp, localtimestamp �ٲ�(Ŭ���̾�Ʈ �ð�)
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss.sssss'), 
systimestamp, 
to_char(current_date,'yyyy-mm-dd hh24:mi:ss.sssss'), 
current_timestamp, 
localtimestamp
from dual;
-- sysdate�� current_date�� �ٸ� ��(�ð� ������ �� ���� ��)
-- �ٸ� �ð����� ������ ����ؾ� �� �� �̿�(ex. ����� �������ý���)
-- Ŭ���̾�Ʈ�� �ð��� ���Ҿ�, time zone�� �������� �־���!(ex. 10:00 am +09:00) <- timestamp with time zone(current_timestamp)
-- (current_date���� time zone ������ ��)
-- �ð��븦 ����ȭ��Ű�� ���� �ʿ� <- timestamp with local time zone(localtimestamp)
-- timestamp with time zone, timestamp with local time zone <- �۷ι� ���, �̱� ������� ���� ��(������ time zone ����)
-- timestamp with local time zone(localtimestamp) <- �ð��� �ڵ� ����ȭ(���� ������ �°� �ڵ����� ����), ������ �ð����� �������ֵ� timestamp ��������
--                                                <- ����(�ѱ�)�� Ŭ���̾�Ʈ(�̰���)���� ���� �ð��� ������!

alter session set time_zone = '-05:00'; -- ���� �ð�
select sysdate, systimestamp, current_date, current_timestamp, localtimestamp
from dual;
    


-- �Ⱓ�� ����ϴ� date Ÿ�� (ex. 3�� ����, 2�� ����)
interval year to month -- ����, ������ only
interval day to second -- ��, �ú��� ���� 9�ڸ������� �Ⱓ ��� ����
-- ��¥ + ��¥ <- ���� ����
-- ������ interval year to month Ÿ���� ���� �� ��

-- ����ȯ �Լ�
to_yminterval() -- char Ÿ���� interval year to month Ÿ������ �ٲ���
to_dsinterval() -- char Ÿ���� interval day to second Ÿ������ �ٲ���
-- �Ⱓ ����� �� �ִ� Ÿ��! 

select sysdate + to_yminterval('10-02') from dual; -- sysdate�� 10�� 2������ ����(10-02)
                                                   -- char Ÿ���� '10-02'�� interval year to month Ÿ������ ����
                                                   -- "��¥ + ��¥"�ӿ��� ���� �� ��
select sysdate + to_yminterval('00-300') from dual; -- ����! (����, ������ �����ذ��� �Է��ؾ�!) 
select sysdate + to_yminterval('10-00') from dual; -- +10��
select sysdate + to_yminterval('01-00') from dual; -- +1��
select sysdate + to_yminterval('00-10') from dual; -- +10����
select sysdate + to_yminterval('00-12') from dual; -- ����! (01-00���� �Է�!)
select sysdate + to_yminterval('01-12') from dual; -- ����! (02-00���� �Է�!)

select sysdate + to_dsinterval('100 10:00:00') from dual; -- 100�� 10�� 00�� 00��
select sysdate + 100 + 10/24 from dual; -- 100�� 10�ð� plus(���� ���� ��� but ���ŷο�)



-- extract( from ) <- numeric Ÿ������ ���ϰ� ����
select to_char(sysdate,'yyyy') from dual; -- ��¥�� ������ ����
                                          -- date�� ���������δ� numeric �������� �����(�׷��� ������ ������ ��)
                                          -- to_date(): ��¥ �������� �Է�, ��ȸ
                                          -- to_char(): ��¥���� �Ϻκ�(ex. ����) ���� <- ���ϰ��� "char��"
select extract(year from sysdate) from dual; -- to_char()ó�� �Ϻκ� ���� but ���ϰ��� "numeric Ÿ��!!!"
                                             -- ����� �� �� �ٲ� �ʿ� ����
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual; -- "��" ����(���� �ƴ�)
select extract(hour from sysdate) from dual; -- ����! (sysdate�� "���ϰ�"�� �ú��ʰ� ���� ����, sysdate ���������� �����ϴ� �ſʹ� ��� ����)
select extract(hour from localtimestamp) from dual;
select extract(minute from localtimestamp) from dual;
select extract(second from localtimestamp) from dual;

select extract(timezone_hour from systimestamp) from dual; -- Ÿ������ �ð��� ex. �ѱ�: +09:00, ����: -05:00
select extract(timezone_minute from systimestamp) from dual;
select extract(timezone_hour from current_timestamp) from dual;
select extract(timezone_minute from current_timestamp) from dual;

alter session set time_zone = 'Asia/Seoul';

select extract(timezone_region from current_timestamp) from dual;
select extract(timezone_abbr from current_timestamp) from dual;

select * from v$timezone_names; -- �� time zone�� name ex. Asia/Seoul - KST

-- ����Ÿ���� ���� ����



-- NULL ���� �Լ�
-- nvl(), nvl2(), coalesce() <- NULL���� �ٸ� ������ ��ü�ϴ� �Լ�
-- nullif() <- NULL���� ����� �Լ�

-- nvl() <- NULL���� �ٸ� ������ ��ü�ϴ� �Լ�
-- nvl2(A,B,C) <- A�� NULL�� �ƴϸ� B ����, A�� NULL�̸� C ����
--             <- nvl()���� �޸�, �μ��� type�� ��ġ��Ű�� �ʾƵ� ��
--             <- ������ �ι�°(B)�� ����°(C)�� ��ġ��ų ��! 
-- coalesce() <- �μ��� ������ ���� �� ��, NULL���� ������� �ʴ� �μ��� ��� ã�ư�
--               (ù��°�� NULL�̸� �ι�° ����, �ι�°�� NULL�̸� ����° ���� ... ������ ��ü �� �Ǹ� �׳� NULL)
--               �� �������� ����� �Է��ϸ�, ������ ��ü �� �ǵ� NULL �� ������ �� ������� ����
--               nvl()�� �� �� �Ϲ�ȭ��Ų �Լ�
select last_name, salary, commission_pct, 
(salary*12) + (salary*12 * commission_pct)
from employees;
select last_name, salary, commission_pct, 
(salary*12) + (salary*12 * nvl(commission_pct,0)) -- nvl()�� 2���� �μ� type�� ��ġ! 
from employees;

select employee_id, nvl(to_char(commission_pct),'no comm') -- char������ ��ȯ
from employees;

select employee_id, 
       nvl2(commission_pct, (salary*12)+(salary*12*commission_pct), salary*12) 
from employees;
-- nvl2(A,B,C) <- A�� NULL�� �ƴϸ� B ����, A�� NULL�̸� C ����

select employee_id, 
       nvl2(commission_pct, (salary*12)+(salary*12*commission_pct), salary*12),
       coalesce((salary*12)+(salary*12*commission_pct),salary*12,salary) -- 3���� �μ�(NULL ���� �ƴ� �ɷ� ��� ��ü��!)
from employees;

select employee_id, 
       nvl2(commission_pct, '(salary*12)+(salary*12*commission_pct)', 'salary*12'), -- ���ͷ� ����('') 
                                                                                    -- <- ���ڿ��� ��ü��! 
                                                                                    -- <- ��� �μ��� type�� ��ġ��ų �ʿ�� ����! 
       coalesce((salary*12)+(salary*12*commission_pct),salary*12,salary) 
from employees;



-- nullif(A,B) <- NULL ���� ����� �Լ�
--             <- ù��° �μ���(A)�� �ι�° �μ���(B)�� ��ġ�ϸ� NULL, 
--             <- ��ġ���� ������ ù��° �μ���(A) ����
select employee_id, nullif(length(last_name),length(first_name))
from employees;

/* if a=b then
            null;
   else
            a;
   end if;
*/



-- NULL�� ��ȸ <- IS NULL // IS NOT NULL
select *
from employees
where commission_pct is null; -- null���� ���Ե� row�鸸 ����

select *
from employees
where commission_pct is not null; -- null���� ���� row�鸸 ����



select to_char(sysdate,'yyyy Year mm mon dd day dy d Ddspth') from dual;
select to_char(localtimestamp,'"I will be on leave on " dd mon yyyy') from dual;
select to_char(salary,'l999g999d00') from employees;

select sysdate,systimestamp,current_date,current_timestamp,localtimestamp from dual;

select round(avg(commission_pct),2) from employees;

select coalesce(commission_pct*2,commission_pct,0.22) from employees;

select salary from employees;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------




-- ���� �׷���(*)
select last_name, salary, rpad(' ',trunc(salary/1000)+1,'*') star
from employees
order by salary desc;

select 24*60*60
from dual; -- 86400��

select to_date('20180530 00:00:00.00000','yyyymmdd hh24:mi:ss.sssss')
from dual; -- �Է°�: �츮 ������ �ð�ó�� ��������, �����δ� char Ÿ��!

select to_date('20180530 23:59:59.86399','yyyymmdd hh24:mi:ss.sssss')
from dual; -- �Ϸ��� ��(range scan�� �� �� ���� ����!) <- Time Series!!

-- to_date(): ���� ��¥�� �Է��ϸ� �װ� ��¥�� ��ȯ
-- date: �� ������ 5�ڸ� �̻� �� �Ѿ
-- timestamp: 9�ڸ����� ǥ��



-- to_timestamp(): �Է°�(��¥ó�� ���̴� char Ÿ��)�� timestamp�� ��ȯ�ϴ� �Լ�
-- ss.ff
select to_timestamp('20180530 11:16:00','yyyymmdd hh24:mi:ss')
from dual; -- �� ������ �Ҽ��� 9�ڸ����� ǥ��

select to_timestamp('20180530 11:16:0','yyyymmdd hh24:mi:ss.s')
from dual; -- ����! 

select to_timestamp('20180530 11:16:0','yyyymmdd hh24:mi:ss.ff')
from dual; -- timestamp�� �� ������ �Ҽ��� ���� �κп� ff��� ǥ�� <- 9�ڸ��� ǥ����

select to_timestamp('20180530 11:16:00.123','yyyymmdd hh24:mi:ss.ff')
from dual; -- 9�ڸ��� ������

select to_timestamp('20180530 11:16:00.000000000','yyyymmdd hh24:mi:ss.ff')
from dual;

select to_timestamp('20180530 11:16:00.999999999','yyyymmdd hh24:mi:ss.ff')
from dual; -- �Ҽ��� ���ϸ� 9�ڸ� �̻����� �Է��ϸ� ���� ��! 

select to_char(systimestamp, 'ss.ff') -- systimestamp���� �� ������ ����(���ϰ��� char Ÿ��)
from dual; -- �Ҽ��� ���� 6�ڸ��� ��µ�

select to_char(systimestamp, 'ss.ff2') 
from dual; -- �Ҽ��� ���� 2�ڸ�

select to_char(systimestamp, 'ss.ff9') 
from dual; -- �Ҽ��� ���� 9�ڸ�

select to_timestamp('20180530 11:16:00.000000000','yyyymmdd hh24:mi:ss.ff3')
from dual; -- ���⼭�� �Ҽ��� ���� �ڸ��� ������ �� ����! (�״�� 9�ڸ��� ����)



-- rr Ÿ��
-- ���� ����! 
select to_date('95-10-27','rr-mm-dd') from dual; -- rr: 21���� <- 1995���� ������ ���Ե�! 
                                                 -- ���� ���� �ݿ�

select to_date('95-10-27','yy-mm-dd') from dual; -- yy: 20���� ����(storage ������ ���� ���� �� ��)
                                                 -- 2095���� ����(�̷� �������� �ڹٲ�)
                                                 -- ���� ������ �������� ������ ���� �ݿ�! 

select to_char(to_date('95-10-27','rr-mm-dd'),'yyyy') from dual; -- 1995�� ����

select to_char(to_date('95-10-27','yy-mm-dd'),'yyyy') from dual; -- 2095�� ����

-- # RR Ÿ��
--                                ������ ����(DB�� ���� ex. hire_date)
--                                   0~49                                  50~99
-- ���翬��(��ȸ ����) 0~49    ��ȯ ��¥�� ���缼�⸦ �ݿ�               ��ȯ��¥�� ���� ���⸦ �ݿ�
--                  50~99    ��ȯ ��¥�� ���ļ��⸦ �ݿ�               ��ȯ��¥�� ���� ���⸦ �ݿ�

-- ���翬��       �������Է³�¥(������ ����)          RR(���� ǥ ����)                                      YY(���翬���� ���� <- ����!)
--  1994��         95-10-27                      1995��(���缼��)                                      1995��(���翬���� 20����ϱ� 20����� ����)
--  1994��         17-10-27                      2017��(���翬�� 50~99, �������� 0~49 <- ���ļ���!)      1917��(���翬���� ���� �ݿ�!)
--  2001��         17-10-27                      2017��(���缼��)                                      2017��(���缼��)
--  2048��         52-10-27                      1952��(��������)                                      2052��(���缼��)
--  2051��         47-10-27                      2147��(���ļ���)                                      2047��(���缼��)

-- ���: RRŸ���� ���� ������ �����ϰ� �ذ��� �� �ƴ�! <- yyyy 4�ڸ� �� �Է��ؼ� ���� ǥ���ϱ�! 

select to_date('20180530 10:00:00.36000','yyyymmdd hh24:mi:ss.sssss')
from dual; -- ������ ���� �ְ� ���� ��� <- �ð�(10:00:00)�� �� ������ ȯ���ؼ� �Է�! 
           -- 00.36000 �� . ������ �κ��� 10:00:00�� "��"�� ȯ���� �κ�! (�Ҽ����� �ƴ�)
           -- . ���Ŀ� �ƹ� ���̳� �Է��ϸ� �� ��! 
select to_date('20180530 00:00:01.00001','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:00:02.00002','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:00:10.00010','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:01:00.00060','yyyymmdd hh24:mi:ss.sssss')
from dual;



-- ���� ��� <- select�������� �� ��. �Լ��� ����! 
-- �⺻��) nvl()
-- if ���� �� then
--             ����
-- end if;

-- 1) nvl2()
-- if ���� �� then
--             ����1;
-- else
--             �⺻��1;
-- end if;

-- 2) coalesce()
-- if ���� �� then
--             ����1;
-- else if ���� �� then
--             ����2;
-- else if ���� �� then
--             ����3;
-- else
--             �⺻��1;
-- end if;

-- ���ǿ� ���յ��� �ʴµ� else���� ���� ��� <- NULL



-- ���Ǻ� ǥ����(�Լ�)
-- decode(<- �Լ�), case(<- ǥ����) <- �����δ� case�� �Լ�! 
-- ��ø ����!
select last_name, job_id, salary
from employees;

select last_name, job_id, salary -- job_id ���� ���� <- select�������� ����
from employees;

-- ex. job_id�� IT_PROG�� �޿� �λ�
select last_name, job_id, salary, -- decode(���ذ�, �񱳰�, ����) <- ��������� �ʼ�!
decode(job_id, 'IT_PROG', salary*1.1) -- ���� ���� ��ҹ��� ����! 
from employees;
-- if ���ذ� = �񱳰� then
--                  ����
-- end if;



-- decode() �Լ�
-- ���ǹ� ���� ��, ���ذ��� �񱳰��� ����(=)�� ���� �ۿ� �� ����
-- �����࿡ �׷��Լ� �� ����!
select last_name, job_id, salary, -- decode(���ذ�, �񱳰�1, ����1, �񱳰�2, ����2, ...)
decode(job_id, 'IT_PROG', salary*1.1,
               'ST_CLERK', salary*1.15,
               'SA_REP', salary*1.20) -- �������� ���� �� ���� ���� ����(�ϳ��� �÷�!)
                                      -- �񱳰�, ������ �鿩���� ���� ������!(�˾ƺ��� ���ϰ�)
from employees;

select last_name, job_id, salary, -- decode(���ذ�, �񱳰�, ����, ..., else��)
decode(job_id, 'IT_PROG', salary*1.1,
               'ST_CLERK', salary*1.15,
               'SA_REP', salary*1.20,
               salary) -- �� �������� else!
                       -- decode()�� row���� �۵���(���⼭�� �� 4��)
from employees;



-- case ǥ���� <- �� ����! 
-- = �Ӹ� �ƴ϶� �ٸ� �����ڵ� ���� �� ����

-- = ������
select last_name, job_id, salary, 
       case job_id
            when 'IT_PROG' then salary*1.1 -- case�� ��ȣ ���� ���� ����! comma�� �� ��! 
            when 'ST_CLERK' then salary*1.15
            when 'SA_REP' then salary*1.20
            else salary
       end 
from employees;

-- = �̿��� �� ������
select last_name, salary,
       case 
           when salary < 5000 then 'low' -- �ٸ� ������(>,<,in,between and)�� ����� ���, ���ذ��� �ƿ� when���� ����
           when salary < 10000 then 'medium' -- 5000<=salary<10000
           when salary < 20000 then 'good'
           else
                'excellent'      
       end       
from employees;

select last_name, salary,
       case 
           when salary < 5000 then 'low' 
           when salary < 10000 then 'medium' 
           when salary < 20000 then 'good'
           else
                'excellent'      
       end "Salary Level" -- ALIAS ��Ī
from employees;

select last_name, salary, commission_pct, 
       case 
            when commission_pct is not null then (salary*12) + -- or�� ���� ���� ���� �� ǥ�� ����
                 (salary*12*commission_pct)
            else
                 salary * 12
       end ann_sal
from employees;

------------ ���ݱ��� ��� �Լ��� <- ������ �Լ�(������� ���۵Ǵ� �Լ�) -------------

-- cf. �׷� �Լ�: �׷� �� ����(���� ���� �Ѳ����� ó��)



-- �������Լ�: �����Լ�, �����Լ�, ��¥�Լ�, ����ȯ�Լ�, NULL���õ� �Լ�, ����ǥ���� �Լ�
-- �׷��Լ�: max(), min(), sum(), avg(), count(), variance(), stddev()



-- �ִ밪 max <- �Է°��� �� number Ÿ���� �� �ʿ�� ����
-- �ּҰ� min
-- scatter plot ����� �� ���� ��(����� �������� �ؼ� ������� ���� <- range!)
select max(salary), min(salary) from employees;
select max(hire_date), min(hire_date) from employees; -- date Ÿ��
select max(last_name), min(last_name) from employees; -- char Ÿ��

select max(salary), min(salary), 
       max(hire_date), min(hire_date), 
       max(last_name), min(last_name) 
from employees
where department_id = 50; -- ó������: from - where - select



-- count() <- ���� ���� ����
select count(*) from employees; -- table�� ���Ե� ��� row���� ��(NULL ����)
                                -- full scan, DBA�� �𸣰� index ���
                                -- transforming(�Է°� *�� �� table �ȿ� �ִ� primary key�� �ڵ����� �ٲ�! <- indexing)
select count(employee_id)       -- PRIMARY KEY <- ���� select���� ���� scan ��� ���!
                                -- Deep Learning <- �ڵ� tuning(�Ǽ� �ڵ带 ã�Ƽ� �ڵ����� ��ȯ)
from employees;
select count(commission_pct) -- NULL���� ������ row���� ����(���� ���� �ٸ�)
from employees; 

select count(department_id) -- NULL���� ������ row���� ����(���� ���� �ٸ�)
from employees; 

select count(distinct department_id) -- �ߺ��� ����
from employees;



-- max(), mean(), count() <- Ÿ�� ���� �� ����
-- sum(), avg() <- �Է°����� ������ numeric�� ���! (char, date �� ��)



-- sum(): ��
select sum(salary) -- NULL���� �ڵ����� ���ܽ�Ű�� ���� ����
from employees;

select sum(salary) 
from employees
where department_id=50; 



-- avg(): ���
-- �ڷ��� �߽� ��ġ�� ǥ���ϴ� ��ǥ�� ����(��� mean, �߾Ӱ� median, �ֺ� mode)
-- median <- SQL���� ���� �� ��(R�� �����ؾ� ��!)
-- mean <- avg() // mode <- count()
select avg(salary) from employees; -- NULL�� �����ϰ� ���(��ü ����� �ƴ�)
                                   -- ��� ��� �� �������� ��ǥ�ϴ� ���� ������ ���� �� ����
-- ex. data: 10 30 NULL
-- ���� ��� = (10+30)/3
-- SQL���� ���Ǵ� ��� = (10+30)/2
-- cf. 10 30 nvl(NULL,0)
-- SQL���� ���Ǵ� ��� = (10+30+0)/3
select avg(commission_pct) from employees;
select avg(nvl(commission_pct,0)) from employees; -- �ٷ� ���� ������ ������� �ٸ�



-- variance(): �л� variance <- ��հ����κ��� ��ŭ ������ �ִ���(������� ����)
select variance(salary) from employees; -- NULL���� �ڵ����� ���ܵ�(������ ��ǥ�� ������)



-- stddev(): ǥ������ standard deviation
select stddev(salary) from employees; -- NULL���� �ڵ����� ���ܵ�(������ ��ǥ�� ������)



-- group by: �׷캰 ��� 
select avg(salary) from employees; -- ��ü ���
select department_id, avg(salary) from employees group by department_id; -- �μ��� ���

select department_id, job_id, avg(salary) 
from employees 
group by department_id, job_id; -- �׷��Լ�(avg())�� ���Ե��� ���� �÷���(department_id, job_id)�� ��� group by���� ǥ���Ǿ�� ��! 

select avg(salary) 
from employees 
group by department_id, job_id; -- select���� ���� �� �Ǿ ���࿡�� ���� ���� 
                                -- but ������ �м��� �־ ���ǹ���
                                
select department_id dept_id, job_id, avg(salary) 
from employees 
group by dept_id, job_id; -- ����! (�� �� ó�� ������ ���� <- group by���� select������ �� ���� ����)
                          -- �׷��Լ����� �� ��Ī ����� �� ����! 

select department_id dept_id, job_id, avg(salary) 
from employees 
group by department_id, job_id; -- group by������ �÷��� �״�� ǥ���ؾ� ��! 

select department_id, sum(salary)
from employees
group by department_id; -- �μ��� �Ѿ� �޿�

select department_id, sum(salary)
from employees
where department_id!=10 -- where��: ���� �����ϴ� ��(group �Լ��� ����� �����ϴ� �� �ƴ�)
group by department_id; -- group by���� where�� �ڿ� �;�!(where���� ���� �����)

select department_id, sum(salary)
from employees
where sum(salary)>100000 -- ����!(�� ���� �� group by���� �� ���߿� ����Ǳ� ����)
                         -- group �Լ��� ����� ������ ���� ����
group by department_id;



-- having�� <- where�� ��� ���, group �Լ��� ����� ������ �� ���
select department_id, sum(salary)
from employees
having sum(salary)>100000 -- �׷��Լ�(sum())�� ��� ����
group by department_id;

select department_id, sum(salary)
from employees
group by department_id
having sum(salary)>100000; -- having���� group_by�� �ڿ� ��ġ���ѵ� ��� ����

select department_id, sum(salary)
from employees
where department_id in (20,30,40,50) -- where���� having���� ȥ��
group by department_id
having sum(salary)>1000; -- HASH GROUP BY ���� <- ������� ���ĵǼ� ������ ����

select department_id, sum(salary)
from employees
where department_id in (20,30,40,50) 
group by department_id
having sum(salary)>1000
order by department_id; -- order by��: ���� ����� ������ sorting <- ������尡 ũ�� ����



/*
���� ����(GHO)

4. select department_id, sum(salary)
1. from employees
2. where department_id in (20,30,40,50) 
3. group by department_id
5. having sum(salary)>1000
6. order by department_id; <- ���� ����� ����
*/



select max(avg(salary))
from employees
group by department_id;

select department_id, max(avg(salary)) -- ����! 
                                       -- �׷��Լ��� ��ø�ϸ� �ٸ� �÷��� ���� �� ����
                                       -- ��������(select�� �ȿ� �Ǵٸ� select��) ����ؾ�!
from employees
group by department_id;



-- �� ������ ������ �� having ���� �� ��! 
select department_id, sum(salary)
from employees
where department_id in (10,20)
group by department_id; -- by index rowid scan

select department_id, sum(salary)
from employees
having department_id in (10,20)
group by department_id; -- full scan
                      -- having�� index�� ������� group by��, select�� ������ ����
                      





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # JOIN

desc employees
desc departments

-- JOIN: �� �� �̻��� table���� �����͸� �������� ���
-- 1:M ���� <- 1�� ����(departments) vs. M�� ����(employees)
select last_name, department_name
from employees, departments; 
-- Cartesian Product
-- - Join ������ ������ ���
-- - Join ������ �߸��� ���
-- - ù��° table�� ��� ���� �ι�° table�� ��� �࿡ join�ȴ�



-- �ذ� ���(��ȿ�� join�� ����) <- where��: join ������ ����!
-- 1. equi join(inner join, simple join, � join)
-- 2. self join: �ڱ� �ڽ��� table ��� <- �ڱ� �ڽ��� ����
-- 3. outer join(+) <- key���� ��ġ���� �ʴ� ������(NULL)�� ����
-- 4. non equi join(�� join) <- range�� ��ġ�Ǵ� �� ã��! (between and)
-- �Ǽ� ����(1�� ����, M�� ����) <- Ʃ�� ������ ���ڶ�� outer join ����!



-- 1. equi join(inner join, simple join, � join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- column ������ ��ȣ�� �ذ�(���ξ�!)
                                    -- table�� ��ü�� ���ξ�� ���� �޸� ��� ����!
                                    -- key���� ��ġ�Ǵ� ������ ���� <- equi join
                                    -- 106�� ����(1�� ���� <- NULL��)
                                    -- join ���� ����

-- cfi) semantic error
select last_name, department_name
from employees, departments 
where department_id = department_id; -- �� �� table�� �� column�� ���� <- semantic

-- cfii) syntax error
selec last_name, department_name
from employees, departments 
where department_id = department_id;

-- cfiii) column ambiguously defined
select last_name, department_name
from employee, departments -- from���� object�� üũ
where department_id = department_id;

-- cfiv) column ambiguously defined
select last_nam, department_name
from employees, departments 
where department_id = department_id;

-- cfv) column ambiguously defined
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = department_id; -- column�� ��ȣ��
                                       -- from���� d��� ���������� ���! 

-- select�� �����ϸ� parsing �۾��� �Ѵ�.
-- ���� 1. ���� check(cfii)
-- ���� 2. column check(cfiii, cfiv)
-- ���� 3. �ǹ� �м�(cfi)



-- �� table�� ������� ���� ���
desc locations
select *
from employees;
select *
from departments; -- dept_id�� �ߺ��� ����, location_id�� �ߺ��� ����
select *
from locations; -- location_id�� �ߺ���, NULL�� ���� <- PRIMARY KEY

select e.last_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id; -- join ���� ����
                                   -- ������� ����� ���Դ��� �׻� ����! 
                                   -- Key��, ������ ǰ�� ��� <- ���� �۾�
                                   
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id -- join ���� ����
and e.department_id=10; -- ��join ���� ����



-- join ���� ���� vs. ��join ���� ����
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id -- ���ϴ� �۾� <- ���� ������ �� ����! 
and e.department_id=10;

select e.last_name, d.department_name
from employees e, departments d
where d.department_id=10 
and e.department_id=10; -- Cartesian Product
                        -- �ٷ� ���� ������ ���� ��ȹ�� ����
                        -- ���� ����� ���� �ڵ������� �� �������� ��ȯ! 
                        
-- 2. self join: �ڱ� �ڽ��� table ��� <- �ڱ� �ڽ��� ����
select employee_id, last_name, manager_id
from employees;

select w.employee_id, w.last_name, m.employee_id, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id; -- w: worker // m: manager
                                    -- 1�� ���� �� ��(NULL��)



-- SQL Command Line
-- l: �����ߴ� ���� �ٽ� ������
-- /: ���� ���� �ٽ� ����

-- Command Line ���� ���� ���� 
-- <- col �÷��� format a20 
-- <- Developer�� �ڵ����� ����!



-- 3. outer join(+) <- equi join�� ���� �ذ� ����! 
--                  <- key���� ��ġ���� �ʴ� �����͵鵵 ����
--                  <- (+): Oracle������ ����(�ٸ� DBMS������ �� ��!)

-- cf) equi join <- e.department_id = d.department_id ���࿡ ����Ǵ� 
--                  row���� ���� �� ��
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- equi join(NULL���� ���Ե� row�� ����)
                                         -- key���� ��ġ�Ǵ� �����͸� ����

select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- (+) <- NULL���� �ִ� column
-- employees ���̺� �ִ� ������ ��� �����ϰ� ������, "�ݴ� ��" (+) �Է�! 
-- ��� �μ����� �Ҽӵ��� �ʴ� ������� �����ͱ��� ����

select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- ���ɺμ���(departments)���� ����! 
                                            -- ���ʿ� (+) ������ �� ��!
                                            
-- outer join�� ���� <- ���ʿ� (+) ���� �� ����!
--                  <- �����Լ� ���!!



-- union ������
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
union -- set ������ <- ���ϰ� ����!(�ߺ��� ���ֱ� ���� sort ���� �߻�) <- tuning!
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- �� query���� ���� ����� �ϳ��� ��ħ! 
-- union: �ߺ� ����
-- union all: �ߺ��� ����� ����

select e.last_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+); -- (+)�� 2�� �־���!
-- 3���� table(e,d,l)�� join�ϴ� ���
-- e�� d�� ���� join�ϰ�, �� ������� �޸𸮿� �����ؼ�, �װ� l�� join
-- d�� l�� (+)�� �־ �����ؾ�! 




-- F5 <- ���������� �� ���� ����

drop table job_grades purge;

CREATE TABLE job_grades
( grade_level varchar2(3),
  lowest_sal  number,
  highest_sal number);

INSERT INTO job_grades VALUES ('A',1000,2999);
INSERT INTO job_grades VALUES ('B',3000,5999);
INSERT INTO job_grades VALUES ('C',6000,9999);
INSERT INTO job_grades VALUES ('D',10000,14999);
INSERT INTO job_grades VALUES ('E',15000,24999);
INSERT INTO job_grades VALUES ('F',25000,40000);
commit; -- DB�� ������ ����

select * from job_grades;



-- 4. non equi join(�� join) <- range�� ��ġ�Ǵ� �� ã��! 
-- between and ������ ���
-- ��Ȯ�� ������ ��ġ���� ������, ���������� ��ġ�ϴ� ���
select last_name, salary
from employees;
select * from job_grades; -- �� table�� join <- key������ ��ġ�Ǵ� column�� ����! 

select e.last_name, e.salary, j.grade_level
from employees e, job_grades j
where e.salary between j.lowest_sal
and j.highest_sal;    





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- REVIEW

desc employees
desc locations
desc departments
desc job_grades

select e.last_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select d.department_name, d.manager_id, e.last_name
from employees e, departments d
where e.employee_id = d.manager_id(+);

select w.employee_id "Worker ID", w.last_name "Worker Name",
m.employee_id "Manager ID", m.last_name "Manager Name",
d.department_name "Dept Name"
from employees w, employees m, departments d
where w.manager_id = m.employee_id(+)
and w.department_id = d.department_id(+); -- w�� m�� join�ϰ�, �� ���� d�� join!

select * from job_grades;
select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e, job_grades j
where e.salary between j.lowest_sal
and j.highest_sal;

------------------------------------------------------------------------------

select e.last_name, e.department_id, 
d.department_id, d.department_name, d.location_id, 
l.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id 
-- e.department_id, d.department_id, d.location_id <- M������
-- l.location_id <- 1������
-- M x 1 <- M���� Ʃ��! 
-- �Ǽ� ���� <- 107���� ���;� �ϴµ�, �����δ� 106���� ����
-- outer join!! 
order by 2,3;

select e.last_name, e.department_id, 
d.department_id, d.department_name, d.location_id, 
l.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+) 
-- e�� d�� ���� join�ϰ�, �� ����� �ٽ� l�� join
-- l.location_id�� �� (+) �־�� ��!
order by 2,3;

------------------------------------------------------------------------------



-- ANSI Standard(���� ǥ��ȭ!) <- �ٸ� DBMS������ ���
-- (JOIN ���� <- �ٸ� table�� ������ column���� ã�ƺ���) <- natural join

-- # Cartesian Product (�ǵ�ġ ���� ��(N x M)) <- cross join
select last_name, department_name
from employees e, departments d;

select last_name, department_name
from employees e cross join departments d;



-- 1. natural join
--    - �� ���̺��� �̸��� ���� ��� �÷��� ������� �����Ѵ�
--    - ����: join ���� ���� �� ���� ��
--    - ����1: ������ �÷����� �ϳ��� ���� ����� �۵���
--    - ����2: ������ �̸��� ���� �÷��� ���� �ٸ� ������ Ÿ���� ������ ����
select last_name, department_name
from employees natural join departments; -- join ���� ���� ���� �Է��� �ʿ� ����!
                                         -- ����� Ʃ�� ���� �ʹ� ����!
                                         -- dept_id �̿ܿ� manager_id���� �����! 
                                         -- ������ �÷����� 1���� ���� ����ϱ�!! 
                                         
select department_name, city
from departments natural join locations;



-- 2. join using���� ����ϴ� join
--    join�� ����� �÷��� ����! 
--    using���� �÷��� ��� table�� �����ȴٰ� ���ξ ǥ���ϸ� �� ��!(��ȣ�� �ذ� ����)
select last_name, department_id, department_name
from employees join departments 
using(department_id); -- join�� ����� �÷��� ���� ����

select e.last_name, department_id, d.department_name
from employees e join departments d
using(department_id)
where d.department_id=80; 

select e.last_name, e.department_id, d.department_name -- ����!(���ξ� ���� �� ��)
from employees e join departments d
using(department_id); 

select e.last_name, department_id, d.department_name
from employees e join departments d
using(e.department_id); -- ����!(���ξ� ���� �� ��)

select e.last_name, department_id, d.department_name
from employees e join departments d
using(department_id)
where department_id in (20,30); -- where ������ alias ��Ī ���ξ� ���� �� ��



-- 3. join on���� ����ϴ� join <- from���� ���!(where���� �ƴ�)
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id; -- on�� ���!
                                      -- where���� join ���� ���� ���� �� ��
                                      -- where���� ���� �����ϴ� ��
                                      
select e.last_name, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e join departments d -- 3�� join�� �� ��
on e.department_id = d.department_id;

-- 3�� join
select e.last_name, d.department_name, l.city
from employees e join departments d 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id; -- e�� d�� ���� join�ϰ�, �� ���� l�� join

select e.last_name, d.department_name, l.city
from employees e join departments d 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where e.department_id in (20,30); -- where���� ���� ������ ���� ��!

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal
and j.highest_sal;

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.department_id = 20; -- on���� join�� ����, where�� �� ����

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.department_id = 20
and e.salary > 10000;



-- oracle�� ansi ǥ�� ��
-- oracle
select d.department_name, d.manager_id, e.last_name
from employees e, departments d
where e.employee_id = d.manager_id(+)
order by d.department_name;

-- ansi
select d.department_name, d.manager_id, e.last_name
from employees e left outer join departments d
on e.employee_id = d.manager_id
order by d.department_name;



-- 4. left outer join, right outer join, full outer join <- from���� ���!
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e left outer join departments d -- M�� ��������! 
                                               -- oracle�� (+)�� �ݴ� ����!
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id; -- ansi�� union �� �ʿ� ����!! 
                                      -- cf) oracle�� ���ʿ� (+) �� ��
                                      -- �̰� union���� ������ �� ����!!!



-- oracle�� ansi ǥ�� ��(3���� table�� join)
-- oracle
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

-- ansi
select e.last_name, d.department_name, l.city
from employees e left outer join departments d
on e.department_id = d.department_id
left outer join locations l -- left outer ��� d�� NULL Ʃ�õ� ���� ����! 
on d.location_id = l.location_id; 



select *
from employees; -- ó������ 50���� �ุ ���� <- ��ũ���� ���� ���� �� ���� ���� �þ
                -- ����¡ ó��(�Ǽ� ������ ���� count() ���!)





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- subquery(��������)
-- ���ؾ� �� ���� �� �� ��

-- SQL�� �ȿ� select���� �ִ� query�� subquery��� �Ѵ�.

-- single row subquery(������ ��������)
-- multiple row subquery(������ ��������)
-- multiple column subquery(���߿� ��������)

select job_id -- ���⼭ �ش�Ǵ� job_id �ϳ� ����
from employees
where employee_id = 141;

select job_id
from employees
where job_id = ?; -- 141�� ����� job_id�� �𸣴� ���
                  -- ���� ������ �����Ѵ���, �� ����� ����ϰ�, �̰� �����ؾ�!
                  -- �� �� ������ �ϳ��� ���� <- subquery



-- # ��ø subquery(nested subquery)      
-- select�� �ȿ� select���� �ִµ�, 
-- subquery ���� ����ǰ�, �� ���� �̿��� main query ����

-- single row subquery(������ subquery)�� ���� <- subquery�� ���� ����� ���� �ϳ�! 
-- ������ subquery <- �� �����ڵ� ������!(=, <, >, <=, >=, <>, !=, ^=)
select job_id
from employees
where job_id = (select job_id
from employees
where employee_id = 141); -- ? �ȿ� ù��° ������ �״�� �������(��ȣ ǥ��)
                  -- () ���� subquery ���� �����ϰ�, �� ���� �̿��ؼ� main query ����
                  -- subquery�� ���� ����ǰ�, �� ���� main query ����! 
                  -- ������ �ٸ� ���̽��� ����! 

-- ex. 141�� ������� �޿��� ���� �޴� ������� Ʃ�� ����                  
select *
from employees
where salary > (select salary
from employees
where employee_id = 141);

select *
from employees
where salary > all(select salary
from employees
where employee_id = 141);

select *
from employees
where salary > any(select salary
from employees
where employee_id = 141);

-- cf1. �ߺ� Ʃ��
select *
from employees
where salary > (select salary
from employees
where last_name = 'King'); -- ����!
                           -- ������ subquery ���� �� �� ����(�系�� King ����� 2��)
                           -- multiple row subquery ���! 

-- cf2. column �� ��ġ                          
select *
from employees
where salary > (select job_id, salary -- ����!(salary > job_id, salary)
from employees
where employee_id = 141); -- where�� �¿��� column ���� ����� ��! 
                          -- multiple column subquery(������ subquery)

-- ex1. AND ����                         
select *
from employees
where job_id = (select job_id
                from employees
                where employee_id = 141)
and salary > (select salary
              from employees
              where employee_id = 141); -- AND�� ���� subquery�� �� ������ �� ����!

-- ex2. �׷��Լ�          
select *
from employees
where salary = (select min(salary)
                from employees); -- group function�� where���� �̿��Ϸ��� �� ��!
                
-- ex3. having��
select job_id, avg(salary)
from employees
group by job_id -- group by�� ���� ����!
having avg(salary) = (select min(avg(salary)) -- having�������� subquery ���!
                      from employees
                      group by job_id);
                      
select *
from employees
where salary between (select min(avg(salary))
                      from employees
                      group by job_id)
             and (select median(avg(salary))
                  from employees
                  group by job_id);
                  
                           


-- multiple row subquery(���� �� subquery)
-- ������ �� �����ڸ� ���(in, not in, > any, < any, = any, > all, < all)

select d.department_name, e.last_name
from employees e join departments d
on e.department_id = d.department_id
where salary in (select min(salary) -- in ���! (���ϰ��� ���� ��)
                 from employees
                 group by department_id); -- correlated subquery �̿��ؾ�! 



select salary
from employees
where job_id = 'IT_PROG'; -- ���� ���� �� ����



-- ���� ����� ��(any, all) <- group function�� ���� ��
-- any: OR�� ����(> any: �ּҰ����� ŭ // 
--               < any: �ִ밪���� ���� // 
--               = any: in ������)
-- all: AND�� ����(> all: �ִ밪���� ŭ // 
--                < all: �ּҰ����� ���� // 
--                = all: NULL <- ������!)



-- any: OR�� ���� 
--      ex. {100,200,300} <- WHERE sal>100 OR sal>200 OR sal>300
--                        <- �� �� ���� �߿� �ϳ��� ���ԵǸ� ��
--                        <- (�ּҰ�(100)���� ū �Ÿ� ǥ���ϸ� ��) <- sal>100
--                        <- "> any": �ּҰ����� ŭ
--      cf. WHERE sal<100 OR sal<200 OR sal<300
--          <- �ִ밪���� ����!

-- ���� �� "> any" = ���� �� "> min()"
select *
from employees
where salary > any (select salary -- "> any" <- ���� �� subquery 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary > (select min(salary) -- min()�� �Ἥ ���� ������ �ٲ�
                       from employees
                       where job_id = 'IT_PROG'); -- �ٷ� �� ������ ��� ����
                                                  -- "> any" = "> min()"

-- ���� �� "< any" = ���� �� "< max()"                                   
select *
from employees
where salary < any (select salary 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary < (select max(salary)
                       from employees
                       where job_id = 'IT_PROG'); 

-- "= any" = in ������                  
select *
from employees
where salary = any (select salary 
                    from employees
                    where job_id = 'IT_PROG');
      
select *
from employees
where salary in (select salary
                 from employees
                 where job_id = 'IT_PROG'); 



-- all: AND�� ����
--      ex. {100,200,300} <- WHERE sal>100 AND sal>200 AND sal>300
--                        <- 3���� ���� ��� �������Ѿ�!(������) <- sal>300
--                        <- �ִ밪���� ũ�� ��!

-- ���� �� "> all" = ���� �� "> max()"
select *
from employees
where salary > all (select salary -- "> all" <- ������ subquery 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary > (select max(salary) -- max()�� �Ἥ ���� ������ ��ȯ
                       from employees
                       where job_id = 'IT_PROG');
                    
-- ���� �� "< all" = ���� �� "< min()"
select *
from employees
where salary < all (select salary 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary > (select min(salary) 
                       from employees
                       where job_id = 'IT_PROG');



-- OR(True + NULL = True)
select *
from employees
where employee_id in ( -- OR ���� <- NULL�� ���ԵǼ� ���
select manager_id
from employees
);

-- NAND(True + NULL = NULL) <- subquery�� NULL�� ���������!
select *
from employees
where employee_id not in ( 
select manager_id
from employees
where manager_id is not null -- NULL�� ����!
);



--------------------------------------------------------------------------------

-- review

select w.last_name "Worker's Name", w.hire_date "Worker's Date", 
       m.last_name "Manager's Name", m.hire_date "Manager's Date"
from employees w join employees m
on w.manager_id = m.employee_id
where w.hire_date < m.hire_date;

select e.last_name, e.salary, e.hire_date, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where salary between 8000 and 10000
and extract(year from e.hire_date) = '2006'
and e.department_id in (60,80);





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- Correlated Subquery
-- ��ȣ���ü�������, �����������
-- ���������� �÷��� �������� �ȿ� �� �ִ� ���
-- ���ݱ��� ����� �� ��ø ��������(nested subquery)! 

select o.*
from employees o
where o.salary > (
select avg(salary)
from employees 
where department_id = o.department_id 
)
order by o.department_id;

-- ��ø ��������: ���������� ���� ����ǰ� �� ������ ���������� ����ǵ� ���� ����
-- cf. ��� ��������: ���������� ���� ������ �� ����(���������� ������ �� �ֱ� ����)
-- correlated subquery�� main query���� ���� ����! 

-- # Correlated Subquery ���� ���
-- ù��° row�� �ĺ������� ������Ű�� �۾� ����
-- ù��° row�� �ش� ����(department_id)�� �ĺ����� �Ǽ�, 
-- subquery�� ����(o.department_id)�� ��

-- Active Set(main query���� ��� ����) ����
-- => ù��° row�� �ĺ������� ����, ����
-- => �ĺ����� �������� subquery�� ���� 
-- => �ĺ��ప���� ���� ���ϵ� ������ main query�� where�� ��
-- => �ι�°, ����°, �׹�° row���� �ĺ������� ���� ��� ���� ����
-- ���谪�� main query���� row�� ����ŭ ����(row ����ŭ subquery ����!)
-- <- CPU ���� ����! <- Oracle�� �˾Ƽ� transforming! 



-- # exists 'x'
-- boolean ������(True/False) <- ������ column ���� �� ��!

-- manager_id(����) = o.employee_id 
select *
from employees o
where exists ( -- exists: boolean ������ <- true/false ����(���ʿ� ���� ���� �� ��)
select 'x' -- ���� ���� ������(�ٸ� �� �Է��ص� ��)
from employees 
where manager_id = o.employee_id 
); -- 1�� ����(employee_id)�� �̿��ؼ� M�� ����(manager_id)�� �� <- ���� ����!
   -- �ĺ��� ��(employee_id)�� manager_id�� �����ϸ�, 
   -- �� �̻� manager_id���� ������ ���� <- exists�� ���! 

-- cf. employee_id(����) = manager_id
select *
from employees
where employee_id in ( 
select manager_id
from employees
); -- subquery�� M�� ����(manager_id)�� �̿��ؼ� 1�� ����(employee_id)�� ��
   -- ������ ������ ���ؾ� �� <- ���� ����



-- # not exists
-- �����ڰ� �ƴ� ���(not in, is not null) <- not exists!
select *
from employees o
where not exists ( 
select 'x' 
from employees 
where manager_id = o.employee_id 
); -- not exists: �������� ���ƾ�, �츮�� ã�� ������
   -- �ĺ����� �� �˻��ؼ� �����Ͱ� ������ �ٸ� �ĺ����� ���� <- not exists�� ���!
   -- Oracle�� is not null �������� �̰ɷ� �ַ� ��ȯ�ؼ� ����



select * from employees where department_id = 30; 
select * from employees where department_id = 50; 



-- inline view: �������̺� <- subquery�� ����! 
-- �κ������� �������μ� CPU �̿� ȿ�� ����! 
-- from�� �ȿ� select�� �������!
select e2.*
from (select department_id, round(avg(salary),0) avgsal from employees
      group by department_id) e1, -- ���� ���̺� JOIN �̿�
      employees e2
where e1.department_id = e2.department_id
and e1.avgsal < e2.salary;

-- cf. ������ ���
select o.*
from employees o
where o.salary > (
select avg(salary)
from employees e2
where department_id = o.department_id 
)
order by o.department_id; -- ��� ���� �ݺ��ؼ� ���谪(avg())�� ���ؾ� �Ѵ�
                          -- DBMS�� group by���� �ڴ�� �� <- CPU ����
                          -- JOIN�� �̿��ϴ� �� ����(���� ���̺� �̿�!)
                          -- INLINE VIEW: ���� ���̺�! 
                          -- �˾Ƽ� ���� ������ ��ȯ��
                          


-- Inline View�� �̿��� JOIN �� ������ ���� ����!
select d.department_id, d.department_name, e.cnt
from departments d,
     (select department_id, count(*) cnt -- count(*)�� alias ��Ī���� �����ؾ�!
     from employees
     group by department_id
     having count(*) < 3) e -- 3�̸��� �����͸� �̾Ƴ��� JOIN(�κ�����) <- CPU ����!
where d.department_id = e.department_id;

select d.department_id, d.department_name, count(*)
from employees e join departments d -- join �̿� 
                                    -- <- ��� �����͸� JOIN�ϱ� ������ CPU ����! 
                                    -- Inline View�� �� ȿ����!
on e.department_id = d.department_id
group by d.department_id, d.department_name -- group by���� ���
having count(*) < 3;



--------------------------------------------------------------------------------

-- REVIEW

select *
from employees e
where salary > (
select avg(salary)
from employees
where department_id = e.department_id
)
order by 1;

select * from job_history;

select *
from employees e
where 2<= (
select count(e.employee_id)
from job_history
where employee_id = e.employee_id
);

select *
from employees e
where exists (
select 'x'
from employees
where manager_id = e.employee_id
);

select *
from employees e
where not exists (
select 'x'
from employees 
where manager_id = e.employee_id
);

select *
from departments d
where 0= (
select count(*)
from employees
where department_id = d.department_id
);

select *
from departments o
where not exists (
select 'x'
from employees
where department_id = o.department_id
);

select *
from employees e
where department_id in (
select department_id
from employees
where salary > e.salary
and hire_date > e.hire_date
);

select *
from employees e
where exists (
select 'x'
from employees
where department_id = e.department_id
and salary > e.salary
and hire_date > e.hire_date
);

select e2.*
from (
select department_id a, avg(salary) b
from employees
group by department_id
) e, 
employees e2
where e.a = e2.department_id
and e2.salary > e.b;

select e.*
from employees e, 
(select count(employee_id) cn, employee_id
from job_history
group by employee_id
) j
where e.employee_id = j.employee_id
and j.cn >= 2;

select e.*
from employees e,
(select employee_id, count(*) cn
from job_history
group by employee_id
having count(*)>=2) j
where e.employee_id = j.employee_id; 

select e.department_id, d.department_name, e.cn
from departments d,
(select department_id, count(*) cn
from employees
group by department_id
having count(*) < 3
) e
where d.department_id = e.department_id;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- multiple column subquery(���� ��, ���� �� subquery)

-- ���� �� subquery(���ؾ� �� column�� ���� ��!)
select *
from employees
where (manager_id, department_id) in 
(select manager_id, department_id from employees where first_name = 'John');

-- cf. ���� �� ���� �� subquery
select *
from employees
where manager_id in (select manager_id from employees 
                     where first_name = 'John')
and department_id in (select department_id from employees 
                      where first_name = 'John'); -- ���� �ٸ� �����!
                                                  -- �� ��� ��ü�� �ٸ�!
                      
-- ���� �� <- �ֺ� ���
-- ���� �� <- ��ֺ� ���

-- ���� ��(�ֺ�)
-- (manager_id, department_id) <- �� 2���� �ϳ��� columnó�� ������ ������(�񱳵�)
-- cf. ���� ��(��ֺ�)
-- manager_id AND department_id <- ������ ����� ���� ��
-- �ֺ񱳿��� �� �������� ��ֺ񱳿��� ������ �����Ͱ� ����!

select *
from employees
where (manager_id, department_id, job_id) in -- 3���� ������ ���� �ֺ�
(select manager_id, department_id, job_id from employees 
                                          where first_name = 'John');
                                          


-- INLINE VIEW�� ����
select d.department_name, e.sumsal
from (select department_id, sum(salary) sumsal
      from employees
      group by department_id
      having sum(salary) > (select avg(sumsal)
                            from (select sum(salary) sumsal
                                  from employees
                                  group by department_id))) e, departments d
where e.department_id = d.department_id;
-- �μ��� �Ѿ�(sum(salary))�� 2�� �����ϰ� ���� 
-- ������ ��� set�� 2�� ����� ���� <- CPU ����!
-- inline view�� ������ ��� set�� �ٽ� ȣ���ؼ� �� �� ����! (����)
-- WITH���� �̿��ؼ� �ذ�! 



-- WITH AS�� <- Oracle RDBMS������ ����
-- ���� query�� �ȿ��� ������ select���� �ι��̻� �ݺ��� ��쿡 
-- �� query block�� ���� ����ϸ� ������ ���ȴ�.
-- query block <- ex. dept_cost, avg_cost
-- ��Ż��� billing ���� �� ���� ���(Oracle RDBMS)

-- with �ȿ��� ���� ���̺��� ����
-- inline view�� ����(ȣ�� �Ұ���) �غ�
with 
dept_cost -- dept_cost��� ���� ���̺��� ����
as (select d.department_name, sum(e.salary) as sumsal -- sumsal: ���� column
                                                      -- ���⼭ as�� alias �ƴ�!
    from employees e, departments d
    where e.department_id = d.department_id(+) -- equi join <- null�� ����!
                                               -- (+)�� �Է������! (outer join)
    group by d.department_name), -- ���� ���̺��� ,�� ��������(dept_cost, avg_cost)
avg_cost as (select sum(sumsal)/count(*) as deptavg
             from dept_cost) -- ���� ���� ���̺�(dept_cost) ȣ�� ����
                             -- (inline view�� �Ұ���)
select *
from dept_cost
where sumsal > (select deptavg
                from avg_cost);
                
                
                
-- # ���տ�����(union, intersect, minus) <- ������� ������ ���� ���� ����!
-- ������
-- ������ <- equi join
-- ������ <- not exists

-- 1. �������� ����, Ÿ�� ��ġ��Ű��!
-- 2. union, intersect, minus�� �ڵ����� sort ����(order by���� �߰��� �ų� ��������)
-- 3. ���� ���տ����� ����� ���� ��ȣ�� ����ؼ� �����ϱ�
-- 4. order by���� ���� �ؿ� ǥ���ϱ�!(order by�� �÷����� ù��° query�� ǥ������ ��)
--    �򰥸��ϱ� ��ġ ǥ���(1,2)�� ���� ������ ������!
-- 5. union, intersect, minus�� �������̸� ���� ����!
--    union <- union all + not exists
--    intersect <- exists
--    minus <- not exists



-- ������
-- union, union all + not exists
select employee_id, job_id -- ù��° ��� set
from employees
union -- �������̸鼭 �ߺ��� �����ʹ� ����
      -- �ڵ����� sort operation�� �۵���
      -- �����ϸ鼭 �ߺ� üũ
      -- �����ϴ� �������� CPU ����(���ɿ� ����)
      -- ���� �����͸� �ٷ� ���� sorting ���� �ʴ� ���� ���� <- union ����� �����ϱ�!
select employee_id, job_id -- �ι�° ��� set <- �ߺ� ����!
from job_history;

-- cf. union all 
-- union = union all + not exists
-- union�� �ڵ����� sorting�Ǳ� ������ ���� ����� ���� union all + not exists�� ����!
select employee_id, job_id 
from employees
union all -- sort operation�� �۵����� ���� <- �ߺ� ���� �� ��
select employee_id, job_id 
from job_history;

select employee_id, job_id 
from employees 
union all -- union�� ���� �ʰ� union all + not exists�� �ذ� <- �ߺ� ����!
select employee_id, job_id 
from job_history j
where not exists 
(select 'x'
from employees
where employee_id = j.employee_id
and job_id = j.job_id); -- where���� 2���� column���� ��� �־�� ��!

-- union, union all�� ��Ģ
-- ù��° select���� column ����, Ÿ��(employee_id, job_id)�� 
-- �ι�° select���� �װ͵�(employee_id, job_id)�� ��ġ��Ű��!

select employee_id, job_id, salary -- ����! (column�� ������ �� ����
                                   -- but job_history ���̺��� salary�� ����
from employees
union all 
select employee_id, job_id 
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, null -- null�� �̿��ؼ� ���� ����!
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, 0 -- 0 �־ ��
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, x -- ����! (Ÿ���� �� �¾Ƽ�)
from job_history;



-- ������
-- intersect, join, exists
select employee_id, job_id -- ù��° ��� set
from employees
intersect -- �̰͵� sort ���� <- ���� ����
          -- join�̳� exists �����ڸ� ����ؼ� �ذ�
select employee_id, job_id 
from job_history; -- �μ� �̵��� ���� ���ؼ� ������ job���� �ٽ� ���ƿ� ���

select e.employee_id, e.job_id 
from employees e join job_history j
on e.employee_id = j.employee_id
and e.job_id = j.job_id; -- sort �� �� <- ���� ���� �ذ�!

select employee_id, job_id 
from employees e
where exists 
(select 'x'
from job_history
where employee_id = e.employee_id
and job_id = e.job_id); -- sort �� �� <- ���� ���� �ذ�!
                        -- �ǵ����̸� 1�� ������ M�� ���տ� ���ϱ�! (�˻� �ӵ� ���)
                        


-- ������
-- minus, not exists
select employee_id, job_id 
from employees
minus -- �̰͵� sort operation ���� <- ���� ���� <- ���� ����!
select employee_id, job_id 
from job_history; -- �μ� �̵� �̷¿� �ִ� ����� ����
                  -- �����ϰ� ù��° ��� set�� �ִ� �͸� ����

select employee_id, job_id 
from employees e
where not exists 
(select 'x'
from job_history
where employee_id = e.employee_id
and job_id = e.job_id); -- ���� ���!



--------------------------------------------------------------------------------

-- REVIEW

with 
dept_cost
as (select d.department_name, sum(e.salary) as sumsal
    from employees e, departments d
    where e.department_id = d.department_id(+)
    group by d.department_name),
avg_cost
as (select sum(sumsal)/count(*) as deptavg from dept_cost)
select *
from dept_cost
where sumsal > (select deptavg from avg_cost);





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





select department_id, job_id
from employees
where job_id = 'ST_CLERK';

select * from locations;
select * from countries;
select * from regions;



select c.country_id, c.country_name
from countries c
where not exists 
(select 'x'
from departments d, locations l
where d.location_id = l.location_id
and l.country_id = c.country_id);

SELECT country_id,country_name
FROM countries
MINUS
SELECT l.country_id,c.country_name
FROM departments d, locations l, countries c
WHERE l.country_id = c.country_id
AND d.location_id = l.location_id; -- ������ 1. ����
                                   -- ������ 2. countries ���̺� �̿� �ݺ�
                                   --          <- not exists ������ ���!

SELECT country_id,country_name
FROM countries c
WHERE NOT EXISTS(
        SELECT 'x'
        FROM locations l , departments d
        WHERE d.location_id=l.location_id
        AND l.country_id = c.country_id); -- countries�� join�� �ʿ� ����!!!
                                        -- countries ���̺��� �� ���� ���(tuning)

-- 2���� �κ����� ����
-- 1.       
SELECT country_id,country_name
FROM countries;
-- 2.
SELECT l.*
FROM locations l , departments d
WHERE d.location_id=l.location_id;

select e.employee_id, e.last_name, d.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;



select department_id, job_id, manager_id, sum(salary)
from employees
group by department_id, job_id, manager_id
union all
select department_id, job_id, null, sum(salary)
from employees
group by department_id, job_id
union all
select department_id, null, null, sum(salary)
from employees
group by department_id
union all
select null, null, null, sum(salary)
from employees; -- ����: employees ���̺��� 4�� �������ؾ���!



-- rollup ������
-- group by ������ ������ �� ����Ʈ�� �����ʿ��� �������� 
-- �� �������� �̵��Ͽ� �׷�ȭ�� �����. (���� �� �ٲ�)
select department_id, job_id, manager_id, sum(salary)
from employees
group by rollup(department_id, job_id, manager_id); 



-- cube ������
-- group by �� ������ ������ ��� �׷�ȭ�� �Ѵ�.
select department_id, job_id, manager_id, sum(salary)
from employees
group by cube(department_id, job_id, manager_id); 

-- group by rollup(a,b,c) <- �� ����!
-- sum(sal) = {a,b,c}
-- sum(sal) = {a,b}
-- sum(sal) = {a}
-- sum(sal) = {} <- ��ü ��

-- cf1. group by cube(a,b,c) <- �׷� ������ ��� ����!
-- sum(sal) = {a,b,c}
-- sum(sal) = {a,b}
-- sum(sal) = {b,c}
-- sum(sal) = {a,c}
-- sum(sal) = {a}
-- sum(sal) = {b}
-- sum(sal) = {c}
-- sum(sal) = {} <- ��ü ��



-- cf2. grouping sets ������
-- ���� ���� ���ϴ� �׷��� ���� �� ���
select department_id, manager_id, job_id, sum(salary)
from employees
group by grouping sets((department_id, manager_id),
                       (department_id, job_id),()); -- �κ����� �Ϻ� ����
                                                    -- () <- ��ü sum(salary)
                                                    


-- �����˻�
-- Tree ������� query�� ����� ����
select employee_id, last_name, manager_id
from employees
order by 1;
-- 100�� ����� �������� ��������ó�� �����(manager - employee)
-- ex. 100�� -> 101�� -> 108�� -> 109�� -> �������� ���� -> �ٽ� 108������ �ö� ...
-- ������ �˻� ����

select employee_id, last_name, manager_id
from employees
start with employee_id = 100
connect by prior employee_id = manager_id;

select employee_id, last_name, manager_id
from employees
start with employee_id = 101 -- 101���� �������� ����Ʈ(primary key �̿�!)
connect by prior employee_id = manager_id; -- �����(top down)
-- ù��° �ܰ�: employee_id = 101�� �ش�Ǵ� ��� ����
-- �ι��� �ܰ�: ù��° employee_id�� manager_id�� ��� �ִ� �� ����
-- ������ �ܰ�: �ι�° employee_id�� manager_id�� ��� �ִ� �� ����
-- ���� �� �ܰ迡 �ش�Ǵ� ���� ������ �� �ܰ�� �ö�

-- cf. prior�� �ٸ� ������ �̵�
select employee_id, last_name, manager_id
from employees
start with employee_id = 101
connect by employee_id = prior manager_id; -- (bottom up)
-- 101�� ����� �����ϴ� manager(���) ����

select employee_id, last_name, manager_id
from employees
start with employee_id = 109
connect by employee_id = prior manager_id;

select employee_id, last_name, manager_id
from employees
start with last_name = 'King' -- �ߺ����� ����(but ����� �ָ�����)
connect by prior employee_id = manager_id;



-- level(���� column)
select level, last_name -- �ش� �����Ͱ� �� ��°�� ������ ���� �ִ� �� ������!
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by 1;



-- depth
select level, lpad(' ', 2*level-2, ' ') || last_name -- �ð������� ���� ���� ����!
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by 1;

select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by last_name; -- ������ �� ����

select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order siblings by last_name; -- ������ ��߳��� �ʴ� ������ ����



-- where���� �� ����
select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
where employee_id != 101 -- start�� ���� where�� ��ġ
                         -- �ϳ��� �ุ ���ѵǰ� �� ���� ������ �״�� ����
start with employee_id = 100
connect by prior employee_id = manager_id
order siblings by last_name;

-- cf. connect�� ���� and�� ����
select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
and employee_id != 101 -- �� ��쿡�� 101�� ���� �������� �α׸� ������
order siblings by last_name;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





/*
����������

  ������(privilege) : Ư���� SQL ���� ������ �� �ִ� �Ǹ�
  
    -�ý��۱��� : DBMS�� ������ �� �� �ִ� �Ǹ�
      CREATE USER : ������ ������ �� �ִ� ����
      CREATE SESSION : ������ �� �ִ� ����
      CREATE (OBJECT) : (OBJECT)�� ������ �� �ִ� ����
      ...
*/
select * from session_privs;  --�ý��۱����� Ȯ�� : DBA�� �����ڰ� ��� �� ������ ������ �ο��ϱ� ���ŷο��� ����� �س��� �ο��ϴ� ����

select * from user_sys_privs; --DBA�� ���� �������� �ý��۱��� Ȯ��

select * from session_roles;  --DBA�� ���� ���� ROLE�� ���� ���� Ȯ��
                              --ROLE : ������ ���ϰ� �����ϱ����� ��ü/������ ����

select * from role_sys_privs; --������ ROLE �ȿ� ����ִ� ���� Ȯ��
/*
    -��ü���� : ��ü���ٰ� ������ �� �� �ִ� �Ǹ�
*/
select * from user_tab_privs; --���� ���� ��ü���Ѱ� ���� �ο��� ��ü���ѿ� ���� ������ Ȯ��
                              --Ex) SYS�� ���� EXCUTE(���)������ �޾Ҵ�.

select * from role_tab_privs; --���� ���� ROLE �ȿ� ��� �ִ� ��ü���ѿ� ���� ������ Ȯ��
/*
(DBA ����)

    -DBA���� Ȯ�ι��
      ���� -> �ʷ� +
      ���� �̸� dba
      ����� �̸� sys
      ��й�ȣ oracle
      �� SYSDBA
*/
select * from session_privs;  
select * from dba_sys_privs;  --�ý��۱����� � �������� �ο��ߴ��� ����
select * from dba_tab_privs;  --��ü������ � �������� �ο��ߴ��� ����
select * from dba_roles;       --DB�� ROLE�� ���� ����
select * from dba_role_privs; --ROLE�� � �������� �ο��ߴ��� ����
/*
      SQL> conn sys/oracle as sysdba

  �������� ������� ���� Ȯ��
  
    -DB�� �����Ǿ� �ִ� ���� ���� Ȯ��
      Ex) HR�� DEFAULT_TABLESPACE USERS : HR�� USERS�� ���̺��� �����Ѵ�.
(DBA ����)
*/
select * from dba_users;
/*
    -TABLESPACE ���� Ȯ��
      SYSTEM, SYSAUX, UNDO, TEMP �ʼ�
      TEMP : 
      UNDO : ���� ���� ������ ���� ����
      STSTEM : ���ݱ��� SELECT�ؼ� ���� �� ����Ǿ� ���� 
      SYSAUX : ������ Ʃ���ϱ� ���ؼ� �Ǽ� �ڵ���� 
*/
select * from dba_tablespaces;--tablespace ������ Ȯ��
/*
    -�������� ������� ���� Ȯ��
      Ex) USERS�� FILE_NAME
      DATABASE(����)              OS(������)
      tablespace      (1 : m)      data file
      segment(table)
      extent
      block           (1 : m)      os block(��κ�512byte)
*/
select * from dba_data_files;
/*
    -���� : HR ������ ������ ��������� Ȯ���غ���.
(HR ����)
*/
select * from user_tables;      --HR�� TABLESPACE�� USERS���� Ȯ���Ѵ�.
/*
(DBA ����)
*/
select * from dba_data_files;   --DBA���� USERS�� ������ ��������� Ȯ���� �� �ִ�.
/*
  ����������
  
    -SYS�������� ��������
(DBA ����)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -��������
*/
alter user olap
identified by oracle          --�ٲٰ� ���� ���� ������ �ȴ�.
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -���Ѻο�
*/
select * from dba_users;
select * from dba_ts_quotas;
/*
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap;                         --���� �ο��ϴ� ���

select * from dba_sys_privs where grantee = 'OLAP';   --���� �ο��� ������ Ȯ���ϴ� ���
/*
SQL> conn olap/oracle
Connected.
SQL> select * from session_privs;
*/
revoke create session from olap;                      --������ ȸ���ϴ� ���
select * from dba_sys_privs where grantee = 'OLAP';
/*
SQL>/
SQL>l
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap; 
/*
SQL> create table test(id number);

      ���̺��� �����Ϸ��� �ΰ��� ������ �ʿ��ϴ�.
      1.�ý��۱��� : CREATE TABLE

SQL> select * from session_privs;

      2.tablespace�� ����� �� �ִ� ����(�������)
*/
select * from user_ts_quotas;
grant create table to olap;
/*
SQL> select * from session_privs;
SQL> select * from user_users;
/*
(olap ����)
    -
      ���� -> �ʷ� +
      ���� �̸� olap
      ����� �̸� olap
      ��й�ȣ oracle
      �� default

    -OLAP
*/
select * from user_users;
create table test(id number);

select * from user_tables;
create table test1(id number) tablespace users;

drop table test purge;
drop table test1 purge;

create table emp(id number(4), name varchar2(20), day date)
tablespace users;

select * from emp;
/*
��INSERT
  �����ο� ROW�� �����ϴ� ��ɹ�
*/
desc emp

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));
select * from emp;

rollback;

select * from emp;    --insert�� ������ ���������� ���� �ƴϱ� ������ ����� �� �ִ�.

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));

select * from emp;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --������ �������� �ʾұ� ������ �� �� ����.
*/
commit;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --������ �����߱� ������ �� �� �ִ�.

    -commit�̵� rollback�̵� �ϸ� transaction�� ����ȴ�.
*/
insert into emp(id, name, day)
values(2,'����ȣ',sysdate);

select * from emp;
rollback;                  --����ȣ���� ������ �ش�.

insert into emp(id, name, day)
values(2,'����ȣ',sysdate);

select * from emp;
/*
    -NULL�� �ִ� ���
*/
insert into emp(id, name, day)
values(3,'������',NULL);

commit;
/*
SQL> select * from emp;
*/
insert into emp(id, name)
values(4,'���θ�');

select * from emp;

commit;

insert into emp
values(5, '�����', sysdate);

commit;
/*
����������
  ��SYS����
*/
drop user olap;   --ERROR: �̹� �������̰ų� �̹� ������Ʈ�� �������� ���

select * from v$session where username = 'OLAP';
/*
  ��SESSION KILL ���
*/
alter system kill session '113,57' immediate;    --'SID��,SERIAL#'
alter system kill session '49,19' immediate;

drop user olap;
drop user olap cascade; -- object����� ��������!
/*
      (�ٽ� olap�����Ѵ��� �� 5�� �ο�)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;

grant create session to olap; 
grant create table to olap;
/*
      ���� -> �ʷ� +
      ���� �̸� olap
      ����� �̸� olap
      ��й�ȣ oracle
      �� default
*/
create table emp(id number(4), name varchar2(20), day date)
tablespace users;

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));
insert into emp(id, name, day)
values(2,'����ȣ',sysdate);
insert into emp(id, name, day)
values(3,'������',NULL);
insert into emp(id, name)
values(4,'���θ�');
insert into emp
values(5, '�����', sysdate);

select * from emp;

commit;
/*
������

(olap ����)

  �����̺��� row ����
*/
create table emp_new(id number(4), name varchar2(20), day date)
tablespace;

select * from emp;
select * from emp_new;
 
insert into emp_new(id, name, day)    --�� table�� ���밡 �Ȱ����� ()�����ص� �ȴ�.
select * from emp;

select * from emp_new;

commit;

drop table emp_new purge;
/*
  �����̺��� ������ row ��� ����
*/
create table emp_new
as select * from emp;   --rollback�ҿ����. ����� ������ drop�ؾ��Ѵ�.

select * from emp_new;

commit;

drop table emp_new purge;
/*
  �����̺��� ������ ����
*/
create table emp_new
as select * from emp where 1=2;   --1=2�� ���� �������� �ʾ� row�� �������� �ʴ´�.

select * from emp_new;







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- �Լ�, ����� RDBMS���� ��Ī���� ���ݾ� �ٸ�



-- dba�� ����
select * from dba_users; -- Dictionary Table view(���� �׼����� ���� view)
                         -- OBJECT_NAME: ���� object �̸�
select * from user$; -- Dictionary Table view 

-- ��: ���� ���� ���ϰ� �ϱ� ���� �ϳ��� object
--     ������ ����ִ� object
-- hr �������δ� sysdba�� ���� �� ��
-- ����: Ư���� sql ������ ������ �� �ִ� �Ǹ�
-- priviledge

select * from dba_data_files; 
-- tablespace: DB ���� ������ ����
-- file_name: tablespace�� ����Ǿ� �ִ� ������ ����
-- ���� �����ʹ� �� ��ũ�� ����Ǿ� ����(���� ����)
-- binary �������� �Ǿ� �־ ������ ��� ���� ����
-- system tablespace
-- SYSTEM file_ID: #1
-- SYSTEM tablespace �����ϸ� DB ��ü�� ����!
-- �� �� ������ �����ϴ� tablespace���� ������ ����
-- UNDOTBS1 <- rollback ��� ����
-- SYSTEM, UNDOTBS1, SYSAUX <- �� 3���� �ʼ�!
-- USERS <- �ʼ��� �ƴ�, ���� �������� �������

select * from dba_temp_files;
-- sort(order by, ���� ����, distinct, group by(���� ����))
-- <- ������ �޸𸮷δ� �۾��� �Ѱ谡 ����
-- <- ������ ���� ��ũ�� �����ؾ� �� <- temp files

select * from dba_objects where owner = 'HR'; -- hr�� ���ڷ� ����Ǿ� ����!
                                           -- hr������ �����ϴ� object ���� Ȯ�ΰ���
                                           
select * from dict; -- �츮�� �� �� �ִ� dictionary table�� ���� ����

create user ora10 
identified by oracle; -- user id: ora10 // pw: oracle

select * from dba_users where username = 'ORA10'; -- �ش� row ����
-- DEFAULT_TABLESPACE: �Ϲ� user�� object�� SYSTEM tablespace�� �����ϴ� �� ����!

alter user ora10 default tablespace users;
-- alter user �����̸� default tablespace ���̺����̽��̸�;
-- DEFAULT_TABLESPACE�� ������ SYSTEM���� USERS�� �ٲ�

select * from dba_ts_quotas; -- ������ ���� �� ������ ������ ���� ��!
alter user ora10 quota 1m on users; -- ���� ����(quota�� ����) -- 1k, 1m, ...
                                    -- MAX_BYTES�� �����
alter user ora10 quota unlimited on users; -- MAX_BYTES�� -1�� ������
                                           -- -1: �����̶�� ��
                                           -- BYTES: ���� ����ϰ� �ִ� ����Ʈ ��

alter user ora10 identified by ora10; -- pw ����(oracle => ora10)

-- ������ ������ٰ� �ؼ� �Ժη� �� DB�� �� ���� ����!
-- run command line �� conn ora10/ora10�� �Է��ص� ����!

grant create session to ora10; -- ���� �ο�(run command line �� ���� ����)
select * from dba_sys_privs where grantee = 'ORA10';

alter user ora10 account lock; -- ���� ���(ACCOUNT_STATUS���� LOCKED�� ������)
                               -- run command line �� ���� �Ұ���
select * from dba_users where username = 'ORA10';

alter user ora10 account unlock; -- �ٽ� ���� ǰ(ACCOUNT_STATUS���� OPEN���� ������)
                                 -- run command line �� ���� ����
select * from dba_users where username = 'ORA10';

/* run command line
create table test(id number); <- ����!(create table�� ���� ������ ���� ����)
                              <- ������ �ο� �޾ƾ� ��(grant) */
grant create table to ora10; -- ���� �ο��� dba â������ ����!
select * from dba_sys_privs where grantee = 'ORA10';
-- # table ������ �� �ʿ��� ����
-- 1. create table
-- 2. quota��(tablespace)
select * from user_ts_quotas;

/* run command line
create table test(id number); 
create table test_1(id number) tablespace users; <- �̷��� tablespace�� �����ؾ�!
                                                 <- �̷��� �� �ϸ� default�� �����
*/

-- �����͸� �����ϴ� object�� table�̴�.
-- ���̺� �̸�, �÷��� �̸� ��Ģ, �����̸�, object �̸�
-- - ���ڷ� ����
-- - ���̴� 1~30��
-- - ������(��ҹ��� ���� �� ��), ����, _, #, $
-- - ���̺���� �ѱ���� ���� ���� ����(�ٸ� ���󿡼��� �� ����)
-- - ������ ������ ������ �ٸ� ��ü�� �̸��� �ߺ��Ǹ� �� �ȴ�.
-- - ����Ŭ ������ ������ ����� �� ����. (ex. sysdate, select, ...)

-- �÷��� ������ ����
-- varchar2(4000): �������� ���ڵ����� �ּҰ� 1, �ִ밪 4000 <- ������ ǥ�� ���ϸ� ����
-- char: �������� ���ڵ����� �ּҰ� 1, �ִ밪 2000 <- ������ ǥ�� ���ϸ� �ּҰ�(default)
-- number(p,s): ���� �ڸ����� p�̰� �Ҽ��� ���� �ڸ����� s
--              p�� �ڸ��� 1~38, �ڸ��� ǥ�� �� �ϸ� �������� ������!
-- date: ��¥ ������ Ÿ��
-- long: ���� ���� ������, �ִ� 2G <- clob���� ��ü
-- clob: ���� ���� ������, �ִ� 4G
-- blob: ���� ������, �ִ� 4G <- image file
-- bfile: �ܺ� ���Ͽ� ����� ���� ������, �ִ� 4G
create table emp
(id number(4),
name varchar2(10),
day date default sysdate
)
tablespace users;

-- ora10���� ����

-- # ����
insert into emp(id,name,day)
values(1,'ȫ�浿',to_date('2018-06-10','yyyy-mm-dd'));

select * from emp;
-- command line������ �� ����(������ �ٸ��� ����)
-- commit�� �����ؼ� ��ũ�� �����ؾ� ��!(commit �ϸ� ��� �� ��!)
commit; -- transaction

insert into emp(id,name,day)
values(2,'����ȣ',default); -- default�� ����
select * from emp;

insert into emp(id,name)
values(3,'������'); -- day �κп� �ڵ����� default���� ��
                   -- (������ �ǵ����̸� ���� ����� �̿��ϱ�)
select * from emp;

insert into emp(id,name,day)
values(4,'���θ�',null); -- null�� default���� �켱 ����
select * from emp;

insert into emp(id,name,day)
values(5,default,default); -- name�� null���� ��
select * from emp;

commit; -- �� ���������� ��� ���� ���� ������ �ݿ�

-- # ����
update emp
set day = sysdate - 10; -- ��� row���� ������Ʈ��
select * from emp; -- ���� ������ undo�� �ӽ÷� ������ ���� <- rollback�� ���

rollback; -- ���� ������ �ǵ��ƿ�

update emp
set day = sysdate - 10
where id = 4; 
select * from emp;

commit;

update emp
set name = '�����'
where id = 5; 
select * from emp;

commit;

insert into emp(id, name, day)
values(6,null,null);
commit;
select * from emp;

update emp
set name = '����', day = default -- ���� �ʵ尪 ���� <- ,�� ����
where id = 6;
select * from emp;

commit;

delete from emp;
select * from emp; -- ��� row���� ������

rollback;

delete from emp 
where id = 6;
select * from emp;
-- insert, delete: row ���� ����
-- update: �ʵ� ���� ����

commit;

-- transaction: �������� DML�� �ϳ��� ���� ó���ϴ� �۾� ����
-- commit, rollback
-- savepoint a, savepoint b: rollback�� �����ִ� ���(commit�� �ش���� ����)
-- savepoint a�� 2�� ǥ���ϸ�, ������ ���� ���õ�
-- savepoint a, savepoint b ~ rollback to b <- savepoint b ���� transaction�� ���
--                                          <- ���� �κ��� ��� �� ��
-- ~ commit <- savepoint�� rollback to�� �ݿ��� ���� ����� ����

select * from emp;
delete from emp where id = 5;

create table emp_new
(id number, name varchar2(20), day date)
tablespace users; -- commit�� ���� �ʾҴµ��� Ʈ������� �����(���� ���� ������ �ݿ���)
                  -- autocommit(���� �𸣰� commit �߻�)
                  -- create �ȿ� commit ����� ���� ���� <- ���� Ʈ����ǿ� ����
rollback; -- �ѹ��ص� �ҿ� ����

-- # autocommit�� �߻��ϴ� ���
-- 1. DDL, DCL ������ �����ϴ� ��� <- DDL, DML, DCL�� ���� �������� �۾��ϸ� �� ��!
-- 2. �������� ����(exit �Է�)�� ���� ��
-- 3. �ٸ� �������� connect�� ������ �� <- ex. conn ora10/ora10 => conn hr/hr

-- cf. �ڵ� rollback�� �߻��� ��
--     �ڵ� rollback�ϰ� �Ǹ� ���� ������ ��ũ�� �ݿ����� ����
--     autocommit�� �����ϸ� ��!
-- 1. ���������� ���ᰡ �߻��� ��(ex. â�ݱ�, PC ����, ��Ʈ��ũ ���)

select * from hr.employees; -- hr ����ڰ� ������ �ִ� table�� �˻��Ϸ��� ��
                            -- ������ ���� ��
                            -- table�� ���� �� �ƴ϶� ������ ���� ���� ��
                            -- table �����ڷκ��� �׻� ������ �ο� �޾ƾ� ��
select * from user_tab_privs; -- ���� ������ ����! (�� �������� Ȯ���ϱ�)
                              -- object ������, DBA�� ���� �ο�
                              -- hr���� ���� ������ ��Ͽ��� üũ ����
                              
select * from hr.employees; -- hr ����ڰ� grant�� ���� ���� �ο��ϸ� �� �� ����
select * from hr.departments;
select e.last_name, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id;

-- # insert subquery
insert into emp(id,name,day)
select employee_id, last_name, hire_date
from hr.employees
where department_id = 30; -- �ٸ� �����(hr)�� table�� �ʵ尪 �Է�
                          -- 30�� �μ� ������� ������ table�� �Է�
                          -- �������� ���� Ÿ�� ��ġ���Ѿ�!
                          -- transaction �߻�!
rollback;

select * from emp;
commit;

-- # as subquery <- create, insert�� �̿��� �� subquery �� �� ����
create table emp_copy
as select * from hr.employees where 1 = 2; -- table�� ���븸 ����(1=2 <- false)

select * from emp_copy; -- no data

insert into emp_copy -- employees ���̺��� ������ ����
select * from hr.employees;
rollback;

-- department ���̺��� �����͵� ����
create table dept_copy
as select * from hr.departments where 1 = 2; -- ���̺� �������� ����
insert into dept_copy 
select * from hr.departments; -- ������ ����
select * from dept_copy; -- hr�� ���̺��� ora10���� ��������

drop table emp purge;
drop table emp_new purge;
drop table emp_copy purge;
drop table dept_copy purge;







create table emp
as select employee_id, last_name, salary, department_id
from hr.employees
where 1 = 2;

desc emp

create table dept
as select * from hr.departments where 1=2; -- c.t.as /��Ÿ��/ <- create subquery

-- # �÷� �߰�
desc emp
alter table emp add job_id varchar2(10); -- job_id �÷� �߰�
                                         -- �� �ؿ� �߰�(���� �ٲ� �� ����)
                                         -- ���� �ٲٰ� ������ ���� �����ؾ� 

-- # �÷� ���� column modification
alter table emp modify job_id varchar2(20); -- ������ Ÿ�� ����
-- �� �÷��� �����Ͱ� ������ �÷��� Ÿ���� �ٲ� �� ����
-- �̹� �����Ͱ� �ִ� ��쿡�� Ÿ�� �� �ٲ�
-- char <-> varchar�� ���� ����
-- ����� �ø��� �� ����������, ���̴� �� �� �Ǵ� ��찡 ����(������ ����)

-- # �÷� ����
alter table emp drop column job_id; -- drop column ���� �Է������!
-- �÷��� ������ ���� �� ���� �����Ͱ� �߿��� ���� ���ε� �����ؾ� ��
-- alter <- DML <- autocommit ���(rollback ���� �� ��)

desc emp
alter table emp set unused(salary); -- salary �÷� �� ���� but �����ϴ� �� �ƴ�
                                    -- �ϴ� set unused �ɾ����, 
                                    -- ����ڵ��� �� �� �� ����

select * from user_unused_col_tabs; -- unused ���� �÷� ���� ǥ��(�÷����� �� ����)

alter table emp drop unused columns; -- unused �ɸ� �÷��� �� ������ 







desc emp
desc dept

insert into emp(employee_id, last_name, department_id)
values(1, 'hong', 10);
insert into emp(employee_id, last_name, department_id)
values(1, 'kim', 10); -- employee_id�� �ߺ��Ǹ� �� ��(�������� ǰ���� ������)
                      -- ��������: �ߺ�, null�� ����
insert into emp(employee_id, last_name, department_id)
values(null, 'kim', 10);
                      
delete from emp;
                      
-- # ��������
--   1. primary key
--   2. foreign key <- null ���
--   3. check <- sal>500
--   4. unique <- null ���
--   5. not null <- alter modify �̿�, �� ���� ���� only

--   primary key: ���̺��� ��ǥŰ ����
--   - ������ ��, null�� üũ
alter table emp 
add constraint emp_id_pk primary key(employee_id); 
-- ���ο� �������� ����
-- ������ Ű ��, null �� ������ ��
-- �����Ͱ� �̹� �� �ִ� ���¿��� ���������� �߰��ϸ� ������ ���� �� ����!
/*
alter table emp 
add constraint ���������̸� primary key(�÷��̸�); 
- �������� �̸� ���� �� ������ �̸����� �����!
*/

select * from user_constraints
where table_name = 'EMP'; -- �������ǿ� ���� ������ Ȯ���ϴ� ����

alter table dept
add constraint dept_id_pk primary key
(department_id); -- dept ���̺� �������� �߰�
select * from user_constraints
where table_name = 'DEPT';
-- department_id <- foreign key(dept ���̺��� "��"�� ����)

desc emp
desc dept

-- # foreign key(�ܷ�Ű)
--   - primary key�� ���� �����ϴ� ��������
alter table emp
add constraint emp_dept_id_fk
foreign key(department_id)
references dept(department_id); -- parent keys not found(���� ���̺� ���� ����)

drop table dept purge;
create table dept
as select * from hr.departments;
alter table dept
add constraint dept_id_pk primary key
(department_id); -- dept ���̺� �������� �߰�
alter table emp
add constraint emp_dept_id_fk
foreign key(department_id)
references dept(department_id); -- foreign key �������� �߰�
                                -- foreign key�� �ߺ�, null ��� 
                                
select *
from user_constraints
where table_name = 'EMP'
order by 2;
-- �������� �Ŵ� ����
-- - ������ ǰ�� ����
-- - emp�� dept ���� ���� ���� ����(foreign key)

-- # ���� ���� ����
alter table emp drop primary key;
alter table dept drop primary key; -- foreign key ������ ���� �� ��
alter table dept drop primary key cascade; -- pk, fk ���ÿ� ����!
alter table dept drop constraint dept_id_pk; -- ���� ���� �̸� ������ ����
alter table dept drop constraint dept_id_pk cascade;

drop table emp purge;
drop table dept purge;

create table emp
(id number constraint emp_id_pk primary key,
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_sal_ck check(sal > 500)); -- check ���� ����
 
create table emp
(id number constraint emp_id_pk primary key, -- �� ���� ����
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_sal_ck check(sal > 500)); -- ���̺� ���� ����
 
create table emp
(id number,
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_id_pk primary key(id) -- ���̺� ���� ����
 constraint emp_sal_ck check(sal > 500)); -- ���̺� ���� ���� 

insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',500,10); -- check �������� ����
                          -- 1. �ߺ��� üũ // 2. null�� üũ // 
                          -- 3. check ��������(sal>500) üũ
                          
insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',5000,10); -- �����!

insert into emp(id,name,sal,dept_id)
values(1,'����ȣ',1000,10); -- pk ����(�ߺ���)

insert into emp(id,name,sal,dept_id)
values(null,'����ȣ',1000,10); -- pk ����(null��)

select * from emp; 
-- # ��ɹ� ���� rollback
--   ���Ŀ� insert �Ǵ� row(����ȣ)���� pk ���ݵǾ, 
--   ������ row(ȫ�浿)�鿡 ������ ���� ����

insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',5000,10); -- insert the first row

select * from emp;

insert into emp(id,name,sal,dept_id)
values(null,'����ȣ',1000,10); -- ��ɹ� ���� rollback
                              -- applied to the second row only
                              
rollback;
                              
insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',null,10); -- check ���������� null�� ���!
                           -- check ��������: DML ������ �����ϴ� ���� �����
                           -- select�������� �������� ������� ����
                           -- <- Pl/SQL���� trigger ��� �����!
                           
rollback;

select * from emp;

-- dept ���̺� ����
create table dept
(dept_id number constraint dept_id_pk primary key,
 dept_name varchar2(20) constraint dept_name_uk unique);
-- primary key: �ߺ�, null üũ
-- unique: �ߺ��� üũ(null ���)
-- foreign key: �̰͵� null ���
 
select *
from user_constraints
where table_name = 'DEPT';

insert into dept(dept_id, dept_name)
values(10,'�ѹ���');
insert into dept(dept_id, dept_name)
values(20,'�ѹ���'); -- unique constraint(�ߺ� ��� �� ��)
insert into dept(dept_id, dept_name)
values(20,null); -- unique constraint(null�� ���)

rollback;

insert into dept(dept_id, dept_name)
values(20,'�����ͺм���');

commit;

insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',1000,30); -- foreign key�� �Ἥ 30�� �μ��� ���� �ʰ� �ؾ� ��
                           -- (outer join ����)
                           -- �Ʒ� �������� �ɰ� �����Ű�� ���� ����!
insert into emp(id,name,sal,dept_id)
values(1,'ȫ�浿',1000,null); -- foreign key ���������� null �����
                           
alter table emp
add constraint emp_dept_id_fk
foreign key(dept_id)
references dept(dept_id);

select * from emp;
select * from dept;

-- # Not null ��������: modify�� �����ؾ� ��!
alter table emp modify name constraint emp_name_nn not null;

insert into emp(id,name,sal,dept_id)
values(1,null,1000,20); -- name�� not null ���� ������ �ɸ� <- ����!

alter table emp modify name constraint emp_name_nn null; -- null �� �� �ְ� ���
alter table emp drop constraint emp_name_nn; -- �̰� �ᵵ ��!

create table emp
(id number,
 name varchar2(20) constraint emp_name_nn not null, 
 -- not null ���������� �� ���� ���Ƿθ� ����, table ���� ���Ƿδ� �� ��
 sal number,
 dept_id number,
 constraint emp_id_pk primary key(id),
 constraint emp_sal_ck check(sal > 500));
 
create table emp
(id number,
 name varchar2(20) constraint emp_name_nn not null, 
 sal number,
 dept_id number,
 constraint emp_id_pk primary key(id),
 constraint emp_sal_ck check(sal > 500),
 constraint emp_dept_id_fk foreign key(dept_id) references dept(dept_id));
 -- foreign key�� table ���Ƿ� ����
 
create table emp
(id number,
 name varchar2(20) constraint emp_name_nn not null, 
 sal number,
 dept_id number constraint emp_dept_id_fk references dept(dept_id), 
 -- foreign key�� �� ������ ����(references ���� ������ ��)
 constraint emp_id_pk primary key(id),
 constraint emp_sal_ck check(sal > 500));
 
-- hr�� ����

select * from user_tab_privs; -- dictionary view
                              -- ���� �ο����� ���� + ���� ���� ���� ���ÿ� ������
grant select on hr.employees to ora10;
grant select on hr.departments to ora10;

select * from user_tab_privs; -- ora10���� �ο��� ���� Ȯ�� ����







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





/*
����������

  ������(privilege) : Ư���� SQL ���� ������ �� �ִ� �Ǹ�
  
    -�ý��۱��� : DBMS�� ������ �� �� �ִ� �Ǹ�
      CREATE USER : ������ ������ �� �ִ� ����
      CREATE SESSION : ������ �� �ִ� ����
      CREATE (OBJECT) : (OBJECT)�� ������ �� �ִ� ����
      ...
*/
select * from session_privs;  --�ý��۱����� Ȯ�� : DBA�� �����ڰ� ��� �� ������ ������ �ο��ϱ� ���ŷο��� ����� �س��� �ο��ϴ� ����

select * from user_sys_privs; --DBA�� ���� �������� �ý��۱��� Ȯ��

select * from session_roles;  --DBA�� ���� ���� ROLE�� ���� ���� Ȯ��
                              --ROLE : ������ ���ϰ� �����ϱ����� ��ü/������ ����

select * from role_sys_privs; --������ ROLE �ȿ� ����ִ� ���� Ȯ��
/*
    -��ü���� : ��ü���ٰ� ������ �� �� �ִ� �Ǹ�
*/
select * from user_tab_privs; --���� ���� ��ü���Ѱ� ���� �ο��� ��ü���ѿ� ���� ������ Ȯ��
                              --Ex) SYS�� ���� EXCUTE(���)������ �޾Ҵ�.

select * from role_tab_privs; --���� ���� ROLE �ȿ� ��� �ִ� ��ü���ѿ� ���� ������ Ȯ��
/*
(DBA ����)

    -DBA���� Ȯ�ι��
      ���� -> �ʷ� +
      ���� �̸� dba
      ����� �̸� sys
      ��й�ȣ oracle
      �� SYSDBA
*/
select * from session_privs;  
select * from dba_sys_privs;  --�ý��۱����� � �������� �ο��ߴ��� ����
select * from dba_tab_privs;  --��ü������ � �������� �ο��ߴ��� ����
select * from dba_roles;       --DB�� ROLE�� ���� ����
select * from dba_role_privs; --ROLE�� � �������� �ο��ߴ��� ����
/*
      SQL> conn sys/oracle as sysdba

  �������� ������� ���� Ȯ��
  
    -DB�� �����Ǿ� �ִ� ���� ���� Ȯ��
      Ex) HR�� DEFAULT_TABLESPACE USERS : HR�� USERS�� ���̺��� �����Ѵ�.
(DBA ����)
*/
select * from dba_users;
/*
    -TABLESPACE ���� Ȯ��
      SYSTEM, SYSAUX, UNDO, TEMP �ʼ�
      TEMP : 
      UNDO : ���� ���� ������ ���� ����
      STSTEM : ���ݱ��� SELECT�ؼ� ���� �� ����Ǿ� ���� 
      SYSAUX : ������ Ʃ���ϱ� ���ؼ� �Ǽ� �ڵ���� 
*/
select * from dba_tablespaces;--tablespace ������ Ȯ��
/*
    -�������� ������� ���� Ȯ��
      Ex) USERS�� FILE_NAME
      DATABASE(����)              OS(������)
      tablespace      (1 : m)      data file
      segment(table)
      extent
      block           (1 : m)      os block(��κ�512byte)
*/
select * from dba_data_files;
/*
    -���� : HR ������ ������ ��������� Ȯ���غ���.
(HR ����)
*/
select * from user_tables;      --HR�� TABLESPACE�� USERS���� Ȯ���Ѵ�.
/*
(DBA ����)
*/
select * from dba_data_files;   --DBA���� USERS�� ������ ��������� Ȯ���� �� �ִ�.
/*
  ����������
  
    -SYS�������� ��������
(DBA ����)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -��������
*/
alter user olap
identified by oracle          --�ٲٰ� ���� ���� ������ �ȴ�.
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -���Ѻο�
*/
select * from dba_users;
select * from dba_ts_quotas;
/*
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap;                         --���� �ο��ϴ� ���

select * from dba_sys_privs where grantee = 'OLAP';   --���� �ο��� ������ Ȯ���ϴ� ���
/*
SQL> conn olap/oracle
Connected.
SQL> select * from session_privs;
*/
revoke create session from olap;                      --������ ȸ���ϴ� ���
select * from dba_sys_privs where grantee = 'OLAP';
/*
SQL>/
SQL>l
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap; 
/*
SQL> create table test(id number);

      ���̺��� �����Ϸ��� �ΰ��� ������ �ʿ��ϴ�.
      1.�ý��۱��� : CREATE TABLE

SQL> select * from session_privs;

      2.tablespace�� ����� �� �ִ� ����(�������)
*/
select * from user_ts_quotas;
grant create table to olap;
/*
SQL> select * from session_privs;
SQL> select * from user_users;
/*
(olap ����)
    -
      ���� -> �ʷ� +
      ���� �̸� olap
      ����� �̸� olap
      ��й�ȣ oracle
      �� default

    -OLAP
*/
select * from user_users;
create table test(id number);

select * from user_tables;
create table test1(id number) tablespace users;

drop table test purge;
drop table test1 purge;

create table emp(id number(4), name varchar2(20), day date)
tablespace users;

select * from emp;
/*
��INSERT
  �����ο� ROW�� �����ϴ� ��ɹ�
*/
desc emp

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));
select * from emp;

rollback;

select * from emp;    --insert�� ������ ���������� ���� �ƴϱ� ������ ����� �� �ִ�.

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));

select * from emp;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --������ �������� �ʾұ� ������ �� �� ����.
*/
commit;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --������ �����߱� ������ �� �� �ִ�.

    -commit�̵� rollback�̵� �ϸ� transaction�� ����ȴ�.
*/
insert into emp(id, name, day)
values(2,'����ȣ',sysdate);

select * from emp;
rollback;                  --����ȣ���� ������ �ش�.

insert into emp(id, name, day)
values(2,'����ȣ',sysdate);

select * from emp;
/*
    -NULL�� �ִ� ���
*/
insert into emp(id, name, day)
values(3,'������',NULL);

commit;
/*
SQL> select * from emp;
*/
insert into emp(id, name)
values(4,'���θ�');

select * from emp;

commit;

insert into emp
values(5, '�����', sysdate);

commit;
/*
����������
  ��SYS����
*/
drop user olap;   --ERROR: �̹� �������̰ų� �̹� ������Ʈ�� �������� ���

select * from v$session where username = 'OLAP';
/*
  ��SESSION KILL ���
*/
alter system kill session '113,57' immediate;    --'SID��,SERIAL#'
alter system kill session '49,19' immediate;

drop user olap;
drop user olap cascade; -- object����� ��������!
/*
      (�ٽ� olap�����Ѵ��� �� 5�� �ο�)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;

grant create session to olap; 
grant create table to olap;
/*
      ���� -> �ʷ� +
      ���� �̸� olap
      ����� �̸� olap
      ��й�ȣ oracle
      �� default
*/
create table emp(id number(4), name varchar2(20), day date)
tablespace users;

insert into emp(id, name, day)
values(1,'ȫ�浿',to_date('2018-06-11','yyyy-mm-dd'));
insert into emp(id, name, day)
values(2,'����ȣ',sysdate);
insert into emp(id, name, day)
values(3,'������',NULL);
insert into emp(id, name)
values(4,'���θ�');
insert into emp
values(5, '�����', sysdate);

select * from emp;

commit;
/*
������

(olap ����)

  �����̺��� row ����
*/
create table emp_new(id number(4), name varchar2(20), day date)
tablespace;

select * from emp;
select * from emp_new;
 
insert into emp_new(id, name, day)    --�� table�� ���밡 �Ȱ����� ()�����ص� �ȴ�.
select * from emp;

select * from emp_new;

commit;

drop table emp_new purge;
/*
  �����̺��� ������ row ��� ����
*/
create table emp_new
as select * from emp;   --rollback�ҿ����. ����� ������ drop�ؾ��Ѵ�.

select * from emp_new;

commit;

drop table emp_new purge;
/*
  �����̺��� ������ ����
*/
create table emp_new
as select * from emp where 1=2;   --1=2�� ���� �������� �ʾ� row�� �������� �ʴ´�.

select * from emp_new;









-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- insa�� ����

/*
[����95]  insa ������ ���̺��������.pdf�� ERD(Entity Relationship Diagram)�� 
Ȯ�� ���� table instance chart��  ���鼭 ���̺��� �����ϼ���.
*/
create table emp
(id number(5),
name varchar2(50) constraint emp_name_nn not null,
hire_date date constraint emp_date_nn not null,
sal number(8,2),
mgr number(5) constraint emp_mgr_fk references emp(id),
dept_id number(3) constraint emp_dept_id_fk references dept(dept_id),
constraint emp_id_pk primary key(id),
constraint emp_sal_ck check(sal>100));

create table dept
(dept_id number(3),
dept_name varchar2(50) constraint dept_nn not null,
mgr number(5),
constraint dept_pk primary key(dept_id),
constraint dept_uk unique(dept_name));

select * from user_constraints
where table_name = 'EMP'; -- Dictionary view

select * from user_cons_columns 
where table_name = 'EMP'; -- � ���� ������ �ɷ� �ִ� �� Ȯ��

select * from user_constraints
where table_name = 'DEPT'; -- Dictionary view



/*
[����96] hr.departments ���̺��� department_id, department_name, manager_id �����͸� 
insa ������ dept ���̺�� insert ���� ������ �����ϼ���. (������ ����, �̰�)
*/
select * from hr.employees;
select * from hr.departments;
insert into dept(dept_id, dept_name, mgr)
select department_id, department_name, manager_id
from hr.departments;

/*
[����97] hr.employees ���̺��� employee_id, last_name, hire_date, salary, 
manager_id, department_id �����͸� insa ������ emp ���̺�� insert ���� 
������ �����ϼ���.
*/
insert into emp(id, name, hire_date, sal, mgr, dept_id)
select employee_id, last_name, hire_date, salary, manager_id, department_id
from hr.employees;

commit;
rollback;

/*
[����98] insa������ dept ���̺��� �μ����� �߿� �Ҽӻ���� ���� �μ������� ������ �� 
������ �����ϼ���.
correlated subquery
*/
delete from dept d
where dept_id not in
(select dept_id
from emp
where dept_id = d.dept_id
and dept_id is not null);

delete from dept d
where not exists
(select 'x'
from emp
where dept_id = d.dept_id);
-- where exists, where dept_id = ## <- ���� �� ��!(foreign key �������� ����)

select * from dept;

desc emp

select *
from user_constraints
where table_name = 'EMP';

-- # ���� ���� ����
alter table emp 
modify dept_id constraint emp_dept_id_nn not null; -- ����!(dept_id�� null��)

-- # ���Ŀ� ������ �����Ϳ��� ���� ������ ����ǰ� ����
alter table emp 
modify dept_id constraint emp_dept_id_nn not null
enable novalidate; -- �������!
                   -- ������ �� �Ǵ� �� �ƴ�!
                   
create table test(id number not null disable novalidate);
insert into test(id) values(null);

select *
from user_constraints
where table_name = 'TEST';

rollback;

/*
disable novalidate: disable�� default(�׳� disable�� �Է��ϸ� novalidate�� �ν�!)
                    �������� ��Ȱ��ȭ(��뷮 ������ ���� �ӵ� ��)
                    ���������� ����� ����, Ȱ��ȭ������ �ʰڴٴ� ��
disable validate: �������� ����� ����, �ش� table�� ���� DML �۾� ����
                  DML �۾��� �ƿ� �� ��!(����!)
enable novalidate: ���������� Ȱ��ȭ��Ű�鼭, ���� �����ʹ� �������� �ʰڴٴ� ��
enable validate: �⺻��(default)

enable ���� �� �������� Ȱ��ȭ �� �� => disable�� �۾��Ѵ��� ���� �۾�
*/

alter table test modify id null; -- ���� ���� ������(not null�� modify�� ���� ����)
alter table test modify id constraint test_id_nn not null disable validate;
insert into test(id) values(null); -- ����!(disable validate)

drop table test purge;

create table test(id number not null disable validate);
insert into test(id) values(null); -- ����!

rollback;
drop table test purge;

create table test(id number, name char(10), sal number);
insert into test(id,name,sal) values(1,'a',1000);
insert into test(id,name,sal) values(2,'b',100);
insert into test(id,name,sal) values(1,'a',2000);
commit;
select * from test;
-- �������� �߰�
alter table test add constraint test_id_pk primary key(id); -- pk ����!
-- enable validate <- ���� ������ üũ(id���� �ߺ����� �־ pk�� �� ����!)
alter table test add constraint test_id_pk primary key(id) enable novalidate;
-- enable novalidate <- pk�� ���� ������ ���� �� �ϰ� ������ �� ����!(����!)
-- pk ������ ���� disable�� �����!
alter table test add constraint test_id_pk primary key(id) disable;
-- disable (novalidate) <- �������� �������� ������ ����Ǵ� �� �ƴ�



-- # �������ǿ� ���ݵǴ� ������ ã�� ��
/*
SQL COMMAND LINE
��������:
@%ORACLE_HOME%\rdbms\admin\utlexpt1 <- ������Ʈ��
������:
@$ORACLE_HOME/rdbms/admin/utlexpt1
@%ORACLE_HOME% = C:\oraclexe\app\oracle\product\11.2.0\server
*/
select * from tab; 
-- EXCEPTIONS <- �������� Ȱ��ȭ�� �� �����Ǵ� ������ �߻��� �� �� table�� �ε��
desc exceptions

alter table test enable constraint test_id_pk exceptions into exceptions;
-- enable <- enable validate(���� �����ͱ��� üũ)
-- exceptions into exceptions: �������ǿ� ���ݵǴ� �����͸� exceptions�� �ű�

select * from exceptions; -- �̰� ������ rowid Ȯ��

select * from test where rowid = 'AAAE+HAAEAAAAG+AAC';
select * from test where rowid = 'AAAE+HAAEAAAAG+AAA';

update test set id = 3 where rowid = 'AAAE+HAAEAAAAG+AAA'; -- �����Ǵ� row ����

select * from test order by 1;

commit;

alter table test add constraint test_sal_ck check(sal > 1000); -- Error!
alter table test add constraint test_sal_ck check(sal > 1000)
enable novalidate; -- �̷��� ����� ���� ����

insert into test(id,name,sal) values(4,'c',500); -- Error!(check constraint)

-- �������ǿ� ���ݵǴ� ������ ����
select distinct * from exceptions;

select * from test where rowid = 'AAAE+HAAEAAAAG+AAB';
update test set sal = 1500 where rowid = 'AAAE+HAAEAAAAG+AAB';
select * from test where rowid = 'AAAE+HAAEAAAAG+AAA';
update test set sal = 3500 where rowid = 'AAAE+HAAEAAAAG+AAA';

alter table test enable constraint test_sal_ck exceptions into exceptions;

-- �ٸ� ���
alter table test add constraint test_sal_ck check(sal > 1000) enable novalidate;
delete from exceptions; -- �� ���̺� �ִ� ������ ���ְ� ����

commit;

alter table test enable constraint test_sal_ck  exceptions into exceptions;
select * from exceptions;
select * from test where rowid in ('AAAGpeAAEAAAAHkAAA', 'AAAGpeAAEAAAAHkAAB');
update test
set sal = null
where rowid in ( 'AAAGpeAAEAAAAHkAAA', 'AAAGpeAAEAAAAHkAAB');

select * from test;

commit;

delete from exceptions;

commit;

alter table test enable constraint test_sal_ck  exceptions into exceptions;
select * from exceptions;



-- # �������̺� insert
--   1. ������ insert all
--   2. ���� insert all(when into)
--   3. ���� first insert(insert first ~ else) <- if�� ����ϰ� ����

-- 1. ������ insert all
create table sal_history -- target
as select employee_id, hire_date, salary
from employees where 1=2; -- ����

desc sal_history

create table mgr_history -- target
as select employee_id, manager_id, salary
from employees where 1=2;

-- ������ insert all
insert all 
into sal_history(employee_id, hire_date, salary)
          values(employee_id, hire_date, salary) -- values: �ҽ��� �÷� ����
into mgr_history(employee_id, manager_id, salary)
          values(employee_id, manager_id, salary)
select employee_id, hire_date, manager_id, salary -- �ҽ� ���̺�
from employees;

insert all 
into sal_history(employee_id, hire_date, salary)
          values(id, hdate, sal) -- alias ������ values������ alias ����!
into mgr_history(employee_id, manager_id, salary)
          values(id, hdate, sal)
select employee_id id, hire_date hdate, manager_id mgr, salary sal 
from employees;

/*
insert into table (...)
values (...)
insert into table ...
select * from ...
*/

select * from sal_history;
select * from mgr_history;

rollback;

-- 2. ���� insert all(when into)
create table emp_history
as select employee_id, hire_date, salary
from employees where 1=2;

create table emp_sal
as select employee_id, commission_pct, salary
from employees where 1=2;

insert all 
when hire < to_date('2005-01-01','yyyy-mm-dd') then -- when ����!
into emp_history(employee_id, hire_date, salary)
          values(id, hire, sal)
select employee_id id, hire_date hire, salary sal, commission_pct comm
from employees;

insert all 
when hire < to_date('2005-01-01','yyyy-mm-dd') then 
into emp_history(employee_id, hire_date, salary)
          values(id, hire, sal)
when comm is not null then -- �ϳ��� �����Ͱ� ���� when�� �� �� �ְ�, 
                           -- ���ʿ��� �� ���� �ְ� �ƿ� �� �� ���� ����
                           -- if�� �ٸ���, ù��° when�� �¾Ƶ� �� ���� when�� üũ
into emp_sal(employee_id, commission_pct, salary)
      values(id, comm, sal)
select employee_id id, hire_date hire, salary sal, commission_pct comm
from employees;

select * from emp_history;
select * from emp_sal;

-- 3. ���� first insert(insert first ~ else)
create table sal_low
as select employee_id, last_name, salary
from employees where 1=2;

create table sal_high
as select employee_id, last_name, salary
from employees where 1=2;

create table sal_mid
as select employee_id, last_name, salary
from employees where 1=2;

insert first
when salary < 5000 then
into sal_low(employee_id, last_name, salary) -- salary�� 5000 �̸��̸� sal_low
      values(employee_id, last_name, salary)
when salary between 5000 and 10000 then
into sal_mid(employee_id, last_name, salary) 
      values(employee_id, last_name, salary)
else                                         -- �� ��(else)
into sal_high(employee_id, last_name, salary) 
       values(employee_id, last_name, salary)
select employee_id, last_name, salary
from employees; -- if��ó�� �ϳ��� ���ǿ��� �ɸ��� ����!

select * from sal_low;
select * from sal_mid;
select * from sal_high;







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # csv���� ����� ��
-- ���� -> �����ͺ��̽� �ͽ���Ʈ -> hr����, ��� ��� ����(���̺� ����)
-- -> ������ ����(�÷� ����)
-- �ͽ��ͳ� ���̺�
-- �ܺ����� �޾��� ��� -> ������ ���͸� ���� -> read, write ���� ����(DBA ���)
-- �ܺ������� ��¥ �κ� ����!

select sysdate from dual;

/*
# external table�� ����
1. DML �۾� �� ��(read�� ������ table)
2. index ���� �� ��

select * from empext where hire_date like '2002%'; <- �� ��ȯ!

select * from empext 
where hire_date  >= to_date('20020101','yyyymmdd')
and hire_date < to_date('20030101','yyyymmdd');

* external table �󿡼��� ���� 2�� �߿� ��� �� ������ ���� �� ���� ����! 

* �� �Ǹ� �˻��ϰ��� �� ���� external table�� ��ȿ����!
*/



-- # object
-- 1. table: data�� ����(rows & columns)
-- 2. user
-- 3. VIEW

-- view
-- - �ϳ� �̻��� table�� �ִ� data�� �������� ó���ϴ� object�̴�. 
-- - select���� ������ �ִ�. 

-- ��Ÿ��(create table as)
create table dept_20
as select * from employees where department_id = 20;
create table dept_30
as select * from employees where department_id = 30;
-- �μ������� �Ҽ� �μ��� ���� ������ ���� ��! 
-- ��ü ���, �μ� ���� ����� ���� ���� �˻�
-- �� ��� �ߺ��Ǵ� �����͸� 2���� ������ �� 
-- ���� ���� ��������, ���� ���� ����
-- ���� �μ� ����� ���� ������ table�� �ƴ� view�� ���� �ߺ� ����
-- view <- ���� ������

-- view <- select���常 ����(�����͸� �������θ� ������ ����)
-- cf. table <- ���������ε� ������ ����
create view dept_v20
as select * from employees where department_id = 20;
create view dept_v30
as select * from employees where department_id = 30;
select * from dept_v20; -- 20�� �μ��� ��� ����
select * from dept_v30; -- 30�� �μ��� ��� ����

create view emp_vw
as select employee_id, last_name, department_id
from employees; -- �ش� column�鸸 �� �� �ֵ��� ����

select * from emp_vw;

grant select on hr.emp_vw to ora10; 
-- user(ora10)���� �� view�� select�� �� �ִ� ���� �ο�
-- ���� ������(�ش� column�鸸 �� �� �ְ� ��)
-- cf. ���� ������ <- ���� table �ǵ帱 �� ����

select * from user_views where view_name = 'EMP_VW';
-- ���� ���� view�� ���� ���� Ȯ��
-- TEXT �÷� <- view�� ȣ���� select���� ����!

select * from user_objects where object_name = 'EMP_VW';
-- ���� ���� object�� Ȯ��
-- OBJECT_TYPE �÷� <- VIEW
-- view�� select�ϴ� ����, view�� ���� select���� ȣ���ؼ� �ٽ� ����(recursive)

-- view�� ���� �� ��! 
-- �����Ϸ���, drop view�Ѵ���, �ٽ� create�ؾ� ��!(alter ���� �� ��)
-- create or replace: drop/create �� 2���� �� ���� ����
create or replace view emp_vw
as select employee_id, last_name || first_name 
from employees; -- ����!(���� ������(||) �� ���� alias ����ؾ� ��!)

create or replace view emp_vw
as select employee_id, last_name || first_name name
from employees;

select * from emp_vw;

-- �ܼ� view
-- ���� view

-- # �ܼ� view
drop table emp_new purge;
create table emp_new
as select employee_id, last_name, salary, department_id
from employees
where department_id = 20;
select * from emp_new;

create view emp_vw2
as select * from emp_new; 
-- �ܼ� view(subquery�� �ȿ� �׷��Լ�, group by, join ����)
-- �װ͵��� ������ ���� view!
-- �ܼ� view�� �����ϰ� �ִ� table�� ���� DML �۾��ϴ� ���� ����
-- view�� ���ؼ� ���� �ִ� row�鸸ŭ�� DML �۾�(insert, update, delete) ����
-- table�� view ��� ������!(�ܼ� view�� ����)
update emp_vw2
set department_id = 200; -- view�� ���� DML �۾�!(table�� view ��� ������!)

select * from emp_vw2; -- view(���� �׼���)
select * from emp_new; -- ���� table

rollback;

delete from emp_vw2; -- table�� view ��� ������!

insert into emp_vw2(employee_id, last_name, salary, department_id)
             values(1,'james',1000,10); -- view�� ���� insert
                                        -- (table�� view ��� ������!)

select * from emp_vw2;
select * from emp_new;

desc emp_vw2

insert into emp_vw2(employee_id, last_name, salary, department_id)
             values(2,null,2000,20); 
-- insert �� ��(not null �������� ����)
-- not null ���������� �ɷ� �ִ� column�� ���ؼ��� null�� insert �� ��!
-- �ܼ� view�� ���������� �ɷ� ������ table�� ���� DML �۾� �� ��!

rollback;

create or replace view emp_vw2 -- ������ view�� drop�ϰ� ���ο� view�� ��ü
as select employee_id, salary, department_id
from emp_new;

update emp_vw2
set last_name = 'james'; -- ����!(�� view���� last_name �÷��� ���� ����!)

insert into emp_vw2(employee_id, salary, department_id)
values(3,2000,10); -- ����!(view�� �����ϴ� �÷� �߿� not null �ɷ��� ���)

create or replace view emp_vw2 
as select employee_id, salary*12 sal, department_id -- ������ �ܼ� view
from emp_new;
-- delete ����, insert �� ��(ǥ�������� �Ǿ� �ֱ� ����)
-- update �� ��(ǥ�������� �Ǿ� �ֱ� ����)

-- # ���� view
-- view �ȿ� �׷��Լ�, group by, join ���� ����ִ� view�� ���� view�̴�. 
-- DML �� �� ����. (��, �����Ϸ��� pl/sql trigger ����� �ذ��� �� �ִ�)

create or replace view empvu20
as select *
from employees
where department_id = 20 -- check ���������� ���ǽ�
with check option constraint empvu20_ck; -- view���� check �������� �� �� ����
                                         -- ���ǽ� ����(where���� ���ǽ��� ��!)
                                         -- �ٸ� ���������� �߰� �� ��Ŵ

select * from empvu20;
select * from user_constraints where table_name = 'EMPVU20';
-- CONSTRAINT_TYPE <- V

update empvu20
set department_id = 30
where employee_id = 201; -- update �� ��!(check ���������� ���ǽĿ� ���ݵǱ� ����)

-- cf.
create or replace view empvu20
as select *
from employees
where department_id = 20;

drop trigger HR.UPDATE_JOB_HISTORY; -- Ʈ���� ����

update empvu20
set department_id = 30
where employee_id = 201;

select * from empvu20;

rollback;

-- �ܼ� view�� DML �۾��� �����ϰ� ���� ��(with read only)
create or replace view empvu20 -- �ܼ� view
as select *
from employees
where department_id = 20 
with read only;

-- # sequence
select * from session_privs;
select * from user_sys_privs; -- create view <- view ���� ����
-- create sequence <- �ڵ� �Ϸù�ȣ ���� ����

-- sequence
-- - �ڵ� �Ϸù�ȣ�� �����ϴ� object
-- - create sequence �ý��� ������ �ʿ��ϴ�
-- - insert �ÿ� ���� ��

create table emp_seq
(id number,
name varchar2(20),
day timestamp default systimestamp);

create sequence emp_id_seq -- sequence ����(�� �� ���常 �Է��ص� ��!)
increment by 1 -- default
start with 1
maxvalue 50 -- 10^27���� ǥ�� ���� cf. minvalue
cache 20 -- ���� ����, no cache ���� ����(LAST_NUMBER ������ �߿�����)
nocycle; -- ��ȯ �� ��
         -- cf. cycle: maxvalue�� �����ϰ� �ٽ� ��ȯ

select * from user_sequences where sequence_name = 'EMP_ID_SEQ';

drop sequence emp_id_seq; -- sequence ����

alter sequence emp_id_seq; -- start with�� ���� �� ��!

insert into emp_seq(id, name, day)
             values(emp_id_seq.nextval, user, default);
                -- sequence�̸�.�����÷� <- ���� ��� ������ ��ȣ�� ����(���� �÷�)

select * from emp_seq; -- ���� insert���� ������ ������ row���� �߰���!
select emp_id_seq.currval from dual; -- ���� �� ������ ��� �� ����
                                     -- cf. nextval: ���ο� ��ȣ ����!(gap ����)

rollback; -- insert�� �� ��ҵ� <- select���� 1,2,3�� ������ ������
          -- insert, select�� �ٽ� �����ϸ� 4���̶�� ����!
          -- �� �� ����� ��ȣ�� rollback �ϴ��� �������!
          -- sequence���� gap�� ���� �� ����!
          -- gap ���ַ��� maxvalue ����!
          
select * from user_sequences where sequence_name = 'EMP_ID_SEQ';
-- LAST_NUMBER <- 21(CACHE ����� ���� 1������ 20�������� �޸𸮿� �̸� ������� ��!)
-- CACHE <- insert �ӵ� ������!(CACHE ������ �ӵ� ������!)
-- �� dictionary view ������� ���� �Ϸù�ȣ�� Ȯ���� �� ����!
-- currval ����� ��!






-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------






-- # DBA SESSION

select * 
from v$sql 
where sql_text like 'select * from emp%'
and sql_text not like '%v$sql%';
-- v$sql: shared pool �ȿ� library cache(DBA�� Ȯ�� ����)
-- shared pool �ȿ� library cache �ȿ� ������� �ִ� LCO�� SQL�� ���� Ȯ�� ��
-- (�� query���� �����ؼ� ���� ����� LCO!)
-- hr session���� �����ߴ� select�� ��ȸ ����
-- ��ҹ���, ���鹮��, comment, ���/literal�� ��� ��ġ�ؾ�!

-- hr session���� drop table �ص� LCO�� ���� ����! (OBJECT_STATUS: INVALID)
-- hr session���� �ٽ� create table�ϰ� select�ϸ� ������ LCO�� �̿���!
-- FIRST_LOAD_TIME: ���� �ð� // OBJECT_STATUS: VALID // LAST_LOAD_TIME: ���� �ð�

select * 
from v$sql
where sql_text like '%emp%' 
and sql_text not like '%v$sql%';
-- emp�� ����ִ� ��� select�� Ȯ�� ����
-- semantic üũ�� �� ����ϴ�(������ user�� �Է������� ����) query���鵵 �� �� ����

select * from v$sql; 
-- library cache�� �ִ� �� �� ������

alter system flush shared_pool; 
-- ȸ�簡 ���ް� �� �� ��(���� ������ ���� �� 3�� ��)
-- shared_pool ���� ���� ��� ����! 
-- �̰� �����ϸ�, ���� ��ȹ ��� ������
-- �������� ������ sql���� ��� hard parsing
-- 4031 ���� �߻� �� ���(free memory ����) <- just like ��ũ ���� ����
-- �ʹ� hard parsing ���� �ϸ� memory chunk ���������� hard parsing�� �Ұ��� <- flush!

-- SQL������ SQL_ID �������
-- INVALIDATIONS <- ��ȿȭ �߻� �Ǽ�
-- PARSE_CALLS <- parse calls Ƚ��
-- PARSING_SCHEMA_NAME <- �� SQL���� ���� user�� ������ �ľ��� �� ����
-- OBJECT_STATUS <- LCO�� ���� ���� ����(VALID) 
-- FIRST_LOAD_TIME vs LAST_LOAD_TIME

select * 
from v$sql_plan
where sql_id = '0t028xxgcphg0';
-- ���� ���� ��ȹ!
-- OPERATION, OBJECT_NAME, OPTIONS, COST <- F10 ���� ��ȹ ������ ���⼭ Ȯ�� ����!
-- F10�� user���� ���� ���ϰ� �ٲ��� ��!
-- v$ �迭�� ���� DBA�� ���� ��!

select * from table(dbms_xplan.display_cursor('0t028xxgcphg0'));
-- ���� ��ȹ�� ���� ���ϰ� �鿩���� ����!(�̰͵� DBA�� �� �� ����)
-- ���Ǻ� ����(where) �Է����� ��, optimiser�� ��� ���� ��ȹ�� ®�� �� �ľ� ����
-- dbms_xplan: ��Ű�� // display_cursor: �Լ�
-- Hash value <- plan ������ ���� hash value ������
-- depth�� ���� ���� �ʺ��� �ؼ�
-- ex. 0�� select���� 1�� table�� �� �鿩���� �Ǿ� ������ �̰ͺ��� �ؼ�!
-- 1 - filter(): ���� 1���� mapping���Ѽ� ����!
-- filter ����: filter�� ��Ȯ�� �� ��("EMPLOYEE_ID"=100)�� 
--             ��� table�� ��� ��ġ�� �ִ� �� �� ��, 
--             table�� ��� �ʵ带 scan�ؾ� ��(���� ã�Ҿ ��� scan)
-- cf. access: rowid�� ������ �ٷ� ã�ư�(block�� ��Ȯ�� ��ġ�� �ƴ� ���)
-- dynamic sampling: ���� ��ȹ�� ���� ��� ����(������)�� �� ��, 
--                   �Ϻ� block�� ���� "ǥ��(sampling)" ����(����ġ)

-- hr session���� INDEX ���� �� select�� ����
-- => ���� ��ȹ�� 2. INDEX RANGE SCAN���� �ٲ�� ����!!(access)
-- PARSE_CALLS <- hr session���� select�� ������ ������ ��� ����! 
--             <- �̰� ������ ���� ���� ���� ����ϴ� SQL��
--             <- memory�� �����ص� �� LCO�� ������ ���� ����!
-- access: rowid�� ������ �ٷ� ã�ư�(block�� ��Ȯ�� ��ġ�� �ƴ� ���)
-- rowid�� index�� ������ �ְ�, index�� leaf block�� ���� <- INDEX RANGE SCAN ����
-- 2��(deepest)���� index������ rowid�� ã�� ����,
-- 1������ ���� ��ġ�� ã�ư�(access ���� �κп��� Ȯ��!)
-- ��ȣ �տ� * �پ� �ִ� �͵��� �ؿ� ���Ǻ� ��� ǥ���Ǿ� ����

-- # EXPLAIN PLAN <- F10���� ���� ��ȹ�� Ȯ���� �� ���� ���!(ex. SQL Plus ����)
-- - optimiser�� sql�� ���࿡ ����ϴ� ���� ��ȹ ������ Ȯ���� �� �ִ�.
-- - plan_table�� ����
-- - plan_table�� ����� ���
--   @%ORACLE_HOME%\rdbms\admin\utlxplan.sql
-- - 10g �������ʹ� �ڵ� ��ġ�� �Ǿ� �ִ�. (���� �ٷ� ���� �� ���� ��ġ�� �ʿ� ����)
select *
from all_synonyms
where synonym_name = 'PLAN_TABLE';
-- all_synonyms: ����ڰ� ������ ���� synonyms����
-- user_synonyms: ����ڰ� ���� synonyms ����Ʈ
-- dba_synonyms: DBA�� ���� synonyms ����Ʈ
-- PLAN_TABLE$ <- Dictionary Table
--             <- �� ���������� �̰� ������ F10 ���� ������ ������ ������
-- SQL>set linesize 200 <- ���� ����

-- # Synonyms
select * from sys.plan_table$;
select * from plan_table;
-- plan_table <- sys.plan_table$�� synonym(DBA�� ����)

select * from dba_segments where segment_name = 'EMP';
-- BLOCKS 8�� // EXTENTS 1�� <- �ϳ��� EXTENT�� ��� �ִ� BLOCK�� ��
-- INITIAL_EXTENT <- �ϳ��� EXTENT�� ũ��(64K)
-- ���� ���������� ���ڰ� Ʋ�� ���� ����!
show parameter db
-- db�ڰ� ���Ե� parameter�� ǥ��
-- db_file_multiblock_read_count: 1���� I/O query�� ������ �� load�� �� �ִ� block�� ��(128)
-- <- EXTENT �ȿ� ����ִ� BLOCK�� ���� ����!(128���� �Ѳ����� �ҷ������� �� ��)
-- EXTENT�� ũ�Ⱑ ũ�� Ŭ ���� full scan�� �� ����(������ I/O �� ���� �߻�)
-- overwrite?



-- # HR SESSION

drop table emp purge;
create table emp
as select * from employees;

select * from emp where employee_id = 100;
rollback;

select num_rows, blocks, avg_row_len
from user_tables
where table_name = 'EMP';
-- ��� ���� Ȯ��(about user)
-- cf. DBA: dba_tables
-- num_rows(��ü row�� ��), blocks(#block), avg_row_len(�� row�� ����)
-- �̰� �𸣸�(null), dynamic sampling�ؼ� ���� ��ȹ ����!
-- ���� ��ȹ ����� ��� ������ ���⿡ �������� �ʰ�, �ٷ� purge��!

-- # ��� ���� ����
-- ��� �����ϴ� ���� <- dynamic sampling�ϴ� ����ο��� ���� ����
select * from user_tab_privs;
-- ���� user�� ���� object ����
-- DBMS_STATS <- ��� ������ ���� ����

exec dbms_stats.gather_table_stats('hr', 'emp')
-- exec ��Ű��.�Լ�('�����', '���̺�')
-- �̰� �����ϰ� ���� select num_rows, blocks, avg_row_len �����ϸ� ���� ����!
-- ��� �����ϸ� ���� ��ȹ ��ȿȭ! 
-- DBA���� select * from v$sql... �����ϸ�, OBJECT_STATUS�� invalidated�� �ٲ��� ��!
-- but ���� valid�� ���� ����
-- ����: SQL�� latch ���(�˻� ȿ���� ���� ��� ��ȿȭ ����)

exec dbms_stats.gather_table_stats('hr', 'emp', no_invalidate=>False)
-- latch ��� ����(no_invalidate=>False: ��� ��ȿȭ)
-- DBA���� select * from v$sql... �����ϸ�, OBJECT_STATUS�� INVALID�� �ٲ�!
-- but ��� ��ȿȭ�� �����ϴ� ����, �ٸ� �μ��� SQL�� ���࿡ �ǿ���
-- ��� ������ �ִ��� �����ϰ�, �� �ؾߵ� ���� latch ����� ���� õõ�� ��ȿȭ�ؾ� ��! 
-- ��ȿȭ�� ���� ��ȹ�� �ٽ� �� ��(�� ������ ��)

-- DBA���� select * from v$sql... ����
-- => LAST_LOAD_TIME: ���� �ð��� �ƴ�
-- => select * from emp where employee_id = 100; ����
-- => OBJECT_STATUS�� VALID�� �ٲ��, LAST_LOAD_TIME�� �ֽ� �ð����� �ٲ�
-- => ���� �ð��� FIRST_LOAD_TIME�� ������ ���� 
-- => ���� ��ȹ�� ��ȿȭ�� �߻��ص� LCO�� ������ ����!(�޸� �Ҵ�Ǵ� ���� ���̱� ����)

-- # INDEX ����
create index emp_id_idx
on emp(employee_id);
-- non-unique index
-- index ���� => ���� ��ȹ ��ȿȭ!

-- # EXPLAIN PLAN
explain plan for select * from emp where employee_id = 100;
select * from plan_table;
-- explain plan�� ����� �� plan_table�� ���� <- but ���� ������
select * from table(dbms_xplan.display(null,null,'typical'));
-- user���� ���� ���ϰ� ����(�԰�ȭ)
-- �̰� DBA �Ӹ� �ƴ϶�, user�鵵 �� �� ����!
-- ������ �� �� select���� F10 ���� ���ϰ� ����!
select * from table(dbms_xplan.display(null,null,'basic'));
-- �Ϻ� ���� ����(typical ���� �� ����)

drop index emp_id_idx;
explain plan for select * from emp where employee_id = 100;
select * from table(dbms_xplan.display(null,null,'typical'));
-- filter ����(employee_id = 100�� ��� ��ġ�� �ִ� �� ��)

-- # full table scan
-- - ���� ���� �����͸� �˻��� �� �����ϴ�.
-- - �����Լ��� �� �� full scan�� �� ����.
-- - Multiblock I/O �߻� <- ���� �����͸� �Ѳ����� buffer cache�� �÷��� I/O �� ����
--   <- ���� block�� �Ѳ����� load �Ϸ��� ������ �־�� �� <- extent

alter session set db_file_multiblock_read_count = 128;
-- �� session level���� load�� �� �ִ� block �� ����
select * from emp;
-- full scan

-- # Hint
-- /*+ full(���̺�� or alias) */
select /*+ full(e) */ * from emp e;
-- full scan �ϰڴٰ� ���
select /*+ full(e) */ employee_id, last_name from emp e;
select /*+ full(e) parallel(e,2) */ * from emp e;
-- full parallel
-- 1. 2���� processor�� ����� block���� �ݶ��ؼ� ó��(���� ó��)
-- (CPU�� �ϳ��� ���� �ҿ� ����) <- CPU�� ������ ����
-- 2. direct lead ���(�ӵ� up)
-- cf. full: buffer cache ��ħ
-- Oracle�� �ڹ������� full scan�� �������� �ʴ� ��찡 ����
-- full scan���� �����ϴ� �� <- index scan �� �ϰ� ���� <- �� ��ȯ �Լ� �̿�!

-- direct lead: �����͸� buffer cache�� ��ġ�� �ʰ� 
--              �ٷ� cursor�� direct�ϰ� active set ����
--              but �׷��� memory(buffer cache)�� �÷��� �۾��ϴ� �� ȿ����!
-- cf. ������ disk�� �ִ� block����, buffer cache�� ���� cursor�� ����(serial ���)

-- # rowid scan
-- - by user rowid scan, by index rowid scan�� �̿��Ͽ� 
--   �ҷ��� �����͸� �˻��� �� �����ϴ�. 
-- - Single Block I/O <- block �� ���� �ҷ����� 
--   cf. full scan: Multiblock I/O <- db_file_multiblock_read_count
select rowid, employee_id from emp;
select * from emp where rowid = 'AAAE//AAEAAAAJDAAH';
-- #object id #file id #block id #rowslot
--  6          3        6         3

-- # index scan
select * from user_ind_columns where table_name = 'EMP';
-- index ����
-- 1. index unique scan
--    - column�� ������ ������ index�� �����Ǿ� ���� ��
--    - �񱳿����ڴ� =�� ����� ��
alter table emp add constraint emp_id_pk primary key(employee_id);
-- ���� ���� ����(����) => ���� select�� �ٽ� ���� => unique index ����
-- primary key, unique <- unique index �ڵ� ����
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
-- UNIQUENESS <- UNIQUE: unique index�� �ɷ� �ִٴ� ��
-- ���� user_ind_columns�� user_indexes�� join�ؼ� ���� ��
select * from emp where employee_id = 100; -- unique index scan
select * from emp where employee_id >= 100; -- full scan
select * from emp where employee_id <= 100; -- range scan
-- index: ��� ���� �ڵ� ����(�ּҰ�, �ִ밪 �� �� ����)
-- 100�� �ּҰ��̶�� ������ ������ �����Ƿ� <= 100�� range scan
explain plan for select * from emp where employee_id = 100; -- index unique scan
explain plan for select * from emp where employee_id >= 100; -- table access full
-- full table scan���� ������ ����
-- �̰� index range scan���� �����ϸ� �����Ǵ� ����
-- - employee_id �̿��� column�� ���ؼ��� ������ ����
-- - index range scan�� single block I/O
-- - ��� ���� �˻��ϴ� �Ϳ� ���� I/O �߻�(���� ����)
explain plan for select employee_id from emp where employee_id >= 100; -- INDEX RANGE SCAN
-- index range scan�� ���� 
-- - employee_id �÷��� ���� �Ǳ� ����
explain plan for select employee_id, last_name from emp where employee_id >= 100; -- TABLE ACCESS FULL
-- select���� �������� �÷����� �������� �� ��!(full scan���� �ٲ�)
explain plan for select * from emp where employee_id <= 100; -- index range scan
select * from table(dbms_xplan.display(null,null,'typical'));

-- 2. index range scan
--    - index�� leaf block���� �ʿ��� ������ ��ĵ�ϴ� ���
--    - non-unique index�� �ɸ� ������ index range scan
--      <- = �����ڸ� ������ ������ index range scan
--    - one plus one scan ���(leaf block�� ���������� �� ���� �ǵ帲)
explain plan for select * from emp where department_id = 10; -- full table scan
select * from table(dbms_xplan.display(null,null,'typical')); 
-- index �����
create index emp_dept_idx
on emp(department_id);
-- unique index�� �� ����(������ �����Ϳ� �ߺ����� ���ԵǾ� �ֱ� ����)
explain plan for select * from emp where department_id = 10; -- index range scan
select * from table(dbms_xplan.display(null,null,'typical')); 
-- index range scan: department_id = 10�� �ش�Ǵ� ���� ã�Ҵ��� ��� scanning
-- "vertical(root->leaf) to horizontal(range(neighboring leaves))" scanning
select * from user_indexes where table_name = 'EMP';
-- �� select������ non-unique index �ɷ� �ִ� �� Ȯ��(NONUNIQUE)

-- 3. inlist iterator <- index scan�� �ϳ��� ���
--    - in, or ������ �̿� => set �����ڷ� transforming
--    - set operator: ���� ��ȹ �и�
--    - index�� �ݺ��Ѵ�. (root-branch-leaf�� �ݺ�)
--    - ���� ������ ������ ���� ����, in �����ڸ� �Ἥ inlist iterator�� ����
--    - ���� ������ <- ������׷����� ǥ��
explain plan for 
select * from emp where employee_id in (100, 200);
select * from table(dbms_xplan.display(null,null,'typical')); 
select * from emp where employee_id = 100
union
select * from emp where employee_id = 200;
select * from emp where employee_id = 100
union all
select * from emp where employee_id = 200;
-- �� 3���� select���� ���� �ǹ̸� ����(in, union, union all)

-- cf. ���� ������ �ִ� ���
select * from emp where employee_id in (100, 101, 102); -- inlist iterator
select * from emp where employee_id = 100
union all
select * from emp where employee_id = 101;
union all
select * from emp where employee_id = 102;
-- ���� ������ �������� inlist iterator ����(I/O ����) => range scan���� �ٲ�� ��!
select * from emp where employee_id between 100 and 102; -- range scan

explain plan for
select * from emp where employee_id = 100
union
select * from emp where employee_id = 200;
select * from table(dbms_xplan.display(null,null,'typical')); 



select * from user_tables;
-- NUM_ROWS <- �ִ� �͵� �ְ� ���� �͵� ����
-- LAST_ANALYZED <- ��¥ ���� ������ ��� ���� �� �� ��
-- ��� ����: DBA���� ����(user���� ��û, Hint �̿�)
--           ���뷮 ������ -> range scan // ��뷮 ������ -> full scan
--           union all, hint�� ���� �� 2���� select���� �ٸ� ������� ����






-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





select * from hr.emp where dept_id = 10;
-- unique index���� histogram �� ����
-- non-unique index �߿� histogram ����!
-- => histogram�� ���������, �������� �������� �ұյ��� ���� ���� ó�� �ϸ� �� ��
--    (����� ���־� ��!)
-- ���� ��ȹ�� parsing �ܰ迡�� ���� => �������� �������� ��
-- => �������� ���ٴ� ���� �������� ����
-- cf. 11G ���� => Machine Learning�� ���� �ذ�!(Adaptive Cursor Sharing)
--             => ���� ���� ó�� �ص� ��!

-- filter ��� ���� full scan�� �Ǽ� ������ ���ϵǹǷ�, index�� ��!

-- full parallel �߻� => Disk���� �о���� �� ����(Memmory)���� �о����
-- => �߰��� gap�� ���ԵǾ� ������ Multiblock I/O�� ���� �� ��
-- => ��� singleblock���� load�� => ���� ����!

alter system flush buffer_pool;
-- buffer cache�� flush!

-- buffer pinning <- leaf block�� pinning => I/O �پ��!









-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # JOIN <- Loop��!(��������� ���η���(dept_id)�� ����, ���η������� row ����ŭ ������� ����)
--   ������ ���, ���� �Ű���!

-- # �����ȹ
-- 1. �����͸� ó���ϴ� ����� ����
--    1) table full scan
--    2) rowid scan
--       a. by user rowid
--       b. by index rowid
-- 2. join ���
--    1) nested loop
--    2) sort merge
--    3) hash
-- 3. join�� ����

-- �������� Ʃ��, �м��Լ�, ���Խ� ǥ����



-- # nested loop join
--   - join�Ǵ� �Ǽ��� ���� �� �����ϴ�.
--   - access ��� ���!(block�� ��ġ�� �˰� ã�ư��� ��� <- rowid, pk index)
--   - �ε��� ���谡 �� �Ǿ� �־�� �Ѵ�. <- �׷��� ������ full table scan �߻�
--   - ��Ʈ(optimiser���� ���� ��ȹ�� �̷��� ������ ��û)
--     : user_nl(nested loop�� ���� ��Ʈ), ordered(join�� ����), leading

alter session set statistics_level = all;

select /*+ use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;
-- nested loop, table access(2���� ������ ���� => ������ ������ �ؼ�! cf. depth�� �ٸ��� �Ʒ����� ����) <- F10: ������ ��!

select /*+ gather_plan_statistics use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

alter session set statistics_level = all; -- gather_plan_statistics�� ����ο��� ����!
                                          -- �׳� �� ���� select���� �����ص� ���� ��ȹ Ȯ�� ����
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
-- 2���� 4���� ���� ���� => ������ �Ʒ��� �ؼ�(TABLE ACCESS BY INDEX ROWID)
-- 2��: outer/driving table
-- 4��: inner/driven table
-- <- Join�� ����!(join�� �ϳ��� ����)
-- Outer table�� ���� �� ���� Join tuning�� �ٽ�!
-- (Outer 100�� ������ Inner�� 100�� �����)
-- * �κ�(3��, 5��): �� join ���� ���� �κ� ����
-- 3�� ���۷��̼��� ���� ���� �����ϰ�, �� ������ 2�� ���� 
-- => active set ����(e.department_id: 2������ ���� active set ���)
-- => 5������ �̵�
-- 3�� ���۷��̼��� ���� ���� �����ϴ� ����: e.employee_id = 100�� �ش��ϴ� rowid�� ã�� ����

-- # driving table 
--   1. �ε����� ���� �� 
--   2. ���� table

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;  -- nested loop
                          -- join ����� ���� ���� ���!
                          -- ������ ���� ������ ��ȿ����(row ����ŭ random I/O �߻�)

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id; -- merge join
                                         -- ��join ���� ���� ����
                                         
-- # ���� �ε���
-- ��join ���� ��� �û� ���ȴٸ�, "���� �ε���" �Ŵ� �͵� �ϳ��� ���!
-- cf. clustering table: join�� ����� �ƿ� �����س���



select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1500; -- d.location_id�� e.department_id�� �ε����� �ɷ��ִ� �� ����(����)
                          -- d.location_id�� ã�� ����, table emp�� �ǳʰ� e.department_id�� ã��
                          
                          -- �� ���̺��� ���غ���(table emp���� �� join ������ ������ dept�� �� ���� ���̺�!)
                          -- dept�� ���� ��ĵ�Ѵ���, �ε����� ���� emp�� ���� �� �� ȿ����(dept�� driving table)
                          -- ���� count(*)�� ����ؼ� � �� driving table�� �� �� ���ϱ�!
                          
                          -- �� join ���� ��� ���Ե� table�� driving�ϱ�!

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.department_id = 10; -- and���� �÷��� �ε����� �ɰ� d.department_id�� ���� table emp�� ����
                          -- e.department_id�� �ε��� �ɷ� �־��!
        
select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 10; 
-- oracle�� and�� �÷��� �ڵ������� d.department_id�� ��ȯ
-- f10 Ȯ���غ��� ���� ���� ���� d.department_id=10�� �ڵ������� �� ����
-- nested loop join�� �ߴ���, �����δ� emp�� dept�� ���̺��� merge�� �Ͱ� ���� �����

select e.*, d.*, l.*
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto'; -- �� join ���� ����� access ����� ���� ��!(index ����)
                        -- 1. and���� �÷�(l.city)�� index �ɰ�, �� rowid�� ������ table loc�� ���� l.location_id üũ
                        -- 2. l.location_id�� ������ table dept�� ���� d.location_id Ȯ��(d.location_id�� �ε��� �ɷ� �־��!)
                        -- 3. d table�� d.department_id�� ������ table emp�� ����(e.department_id�� �ε��� �ɷ� �־��!)
                        -- 4. �ٽ� leaf block���� ���ƿͼ� �ٸ� rowid�� ���� �����ϰ� range scan ����(�� �� non-unique index)
                        -- 5. �� �������� active set ����� user���� ����
                        -- join�� ����: l => d => e
                        -- nested join�� index ���谡 �� �Ǿ� �־��!(l.city, d.location_id, e.department_id)
                        -- ������ �÷��� �ε��� �ɷ� �־ �̿� �� ��!
                        -- �ε��� ����� ���� �÷��� driving �ϴ��Ŀ� ���� �޶���(l => d => e)
                        -- �� join ���� ��� ������ nested loop join �ϸ� �� ��!(���� ����)
                        
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



select /*+ use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';
-- nested loop�� 2�� ����(Oracle�� ���ο� ���!)



-- # ordered: from���� �����Ǿ� �ִ� table�� ������� join ����
select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- nested loop(ū ���̺��� driving, ���� ���̺��� driven)

select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from departments d, employees e
where e.department_id = d.department_id; -- ���̺��� ������ �ٲ�!(buffer �پ��)

-- # leading(join�� ���� ����): from���� �����ʹ� ��� ����, leading�� ���� ���� ����!
--   use_nl() <- ������ ������ ���� join�� ������ ��� ����
--   ordered���� ���� ����
select /*+ leading(e,d) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select /*+ leading(e,d) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- nested loop(ū ���̺��� driving, ���� ���̺��� driven)

select /*+ leading(d,e) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from departments d, employees e
where e.department_id = d.department_id; -- ���̺��� ������ �ٲ�!(buffer �پ��)

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



-- 3���� ����
select /*+ leading(l, d, e) use_nl(d) use_nl(e) */ e.*, d.*, l.* -- use_nl()�� inner �ʸ� ����!
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto';



-- nested loop�� 2�� ���� ����

-- # table prefetch ���
--   - ��ũ I/O�� �߻��ϰ� �Ǹ�, ����� ���� ��� ������, 
--     �� ���� I/O call�� �ʿ��� �ʿ��� ������ ���̾� ���� ���ɼ��� �ִ� block�� 
--     data buffer cache�� �̸� ������ �δ� ���
select /*+ optimizer_features_enable('10.2.0.5') leading(d,e) use_nl(e,d) */ -- �� ����
       e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- ������ ���� => ���� ��ȹ ����!(nested loop�� �� ���� �ٲ�)
                          -- inner table�� 1���� �ö� ����, 3,4���� outer
                          -- prefetch ���: physical I/O�� ���� �ٿ��� ������ ������
                          -- <- inner table�� range scan�� �� �����(unique scan ���� �� ��)
                          -- �޸𸮿� ���� �� Ȯ���ϸ�, �����͸� �� ��Ͽ� �˻��ؼ� "�Ѳ�����" ����
                          -- �Ϲ����� ���: �ϳ��� �ϳ��� ���������
                          -- clustering factor�� ���� ���, ���� ��� ������ ��
                          -- ������ ��: inner�� leaf ��ϸ� ������(rowid�� ������) �ϴ� join ����

-- # batch I/O ���
--   - inner �� �ε����� �����ϸ鼭 �߰� ��� ����(active set) ���� �Ŀ� 
--     inner ���̺�� �ϰ�(batch) ó���Ѵ�. 
select /*+ optimizer_features_enable('11.2.0.1.1') leading(d,e) use_nl(e,d) */ 
       e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- �� ����: nested loop�� ���޾� ����
                          -- 2���� ���� ���� ����, 3��(outer), 5��(inner)�� ���� ����
                          
select /*+ leading(d,e) use_nl(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500;  -- batch I/O ������� ����

-- nlj_batching()
select /*+ leading(d,e) use_nl(e) nlj_batching(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500;  

select /*+ leading(d,e) use_nl(e) no_nlj_batching(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- ���� �ٸ��� ����

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



-- 2. Sort Merge Join
--    - join�Ǵ� �Ǽ��� ���� �� ����
--    - BUT sort�� ���� ���� ������ �߻��� �� �ִ�
--    - ��Ʈ: use_merge()
--    - driving/outer table�� 1�� �����̸鼭 ���� ���̺��� �����ϱ�!
--    - ����: �ڵ������� order by���� �����ϱ� ������ ���� ����!
--    - outer = first // inner = second <- ��� üũ!

select e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id;
-- F10: SORT MERGE JOIN
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
-- �� ���̺� ��ü�� �ٶ���� ��(�Ǽ��� ����)
-- => nested join�� ������(range�� �ʹ� �о���)
-- => sort join�̳� hash join ���!
-- ��뷮 ���̺��̰�, �� join ���� ��� ������ optimiser�� sort join�̳� hash join ����!

-- sort merge join: �� ���̺��� �Ʒ�ó�� 2���� select������ ������ �����Ѵ���, merge!
--                  (�޸𸮿��� ����Ǵ� ��!)
select last_name, salary, department_id
from emp
order by 3; -- �������� ����(sorting)
select department_id, department_name
from dept
order by 1; -- �������� ����(sorting)
-- driving table: DEPT(1���� ������ M���� ��ĵ!)
-- sort merge join: join�� ������ �߿�(driving/outer�� 1�� ������ �����ϱ�!)
-- 10�� �μ��� ������� �� ��ĵ�� ����, ǥ���ڸ� ������ ���� ����, 20�� �μ��� ������� ��ĵ <- sort�� �Ǿ� �ֱ� ������ ����
-- (������ ó������ ������ ��ĵ������ ����!)
-- LOC <- 3���� �������

-- ����: �ڵ������� order by���� �����ϱ� ������ ���� ����!
-- order by �۾��� ������ �÷��� index�� �ɷ� �ִ� ���

-- ���� ��ȹ�� 3���� index full scan�� ���� => ������� ���� �ϱ� ���� => single block I/O
-- I/O�� 27��(index ��)�� �ƴ� 6�� �߻��� ���� <- buffer pinning
-- 1���� sort join�� �ƴ� ���� <- index�� ����ϱ� ����(���� ���̺��̶� ����)
-- cf) 5�� => index�� �̿��ϰ� �Ǹ� random I/O�� 107�� �߻� 
--        => �뷮�� ū table�� index�� �־ �׳� sort �۾� �߻�(sort join)
--        => ���� ����!(4���� �޸� ��뷮 üũ!)
-- ���� ���̺��� driving/first table�� ����!(���� ��ȹ�� �տ� ����)

-- ��Ʈ�� ����Ͽ� sort merge join ����
select /*+ use_merge(e,d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id;
-- e.department_id(M�� ������ key) // d.department_id(1�� ������ key)
select /*+ leading(d,e) use_merge(e) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
-- leading�� ���� driving table ����(use_merge()���� driven table�� ����!)
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
select /*+ leading(d,e) use_merge(e) full(d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; -- second(driven) table�� ������ sorting!

-- cf. M�� ������ driving���� �����ϴ� ���(wrong!)
select /*+ leading(e,d) use_merge(d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
select /*+ leading(e,d) use_merge(d) index(e emp_dept_id) */ 
       e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
-- ���� ���̺��� sorting �ϴϱ� 4���� �޸� ��뷮�� �پ���
-- BUT ���������� oracle�� driving table�� sort �۾����� ����(index scan) 
--     => ���� ���̺��� driving �ϸ� random I/O �߻��ص� �� ���� ����
-- cf. ū ���̺��� driving�ϸ� random I/0�� �����(row�� ��ü �Ǽ���ŭ) ���� �߻�
--     => clustering factor�� ���� ��� ���� ���ϰ� �ɰ����� �� ����
--     => �� ��� index �� ���� �ڵ������� full scan�� ����� �� ����(CPU ���� ����)
--     ** ���� ���̺��� sort join�� ���(���� select��) => buffer�� �پ�������, �޸� ��뷮 ���� 
--        <- ���̺��� ũ�Ⱑ Ŀ���� ������ �� �� ����
select /*+ leading(e,d) use_merge(d) full(e) full(d) */ 
       e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 



-- ### ��뷮 ������!(buffer ���� Ȯ���� ���̳��� ���� Ȯ���ϴ� ���� ����!)
create table emp_copy2
as select rownum emp_id, last_name, first_name, job_id, hire_date, salary, commission_pct, email, department_id
from employees, (select rownum emp_id from dual connect by level <= 100)
order by dbms_random.value;

exec dbms_stats.gather_table_stats('hr', 'emp_copy2')

create index emp_copy_dept_idx on emp_copy2(department_id);

select /*+ leading(d,e) use_merge(e) full(d) */ e.last_name, e.salary, d.department_name
from emp_copy2 e, dept d
where e.department_id = d.department_id;
select /*+ leading(e,d) use_merge(d) index(e emp_copy_dept_idx) */ 
       e.last_name, e.salary, d.department_name
from emp_copy2 e, dept d
where e.department_id = d.department_id; 

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------






select * from user_ind_columns where table_name = 'EMPLOYEES'; -- �� �÷��� �ɷ� �ִ� �ε��� Ȯ��
select * from user_indexes where table_name = 'EMPLOYEES';








-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- ## �м��Լ�

-- # �������� ���ϴ� �� <- over!

select employee_id, 
       salary,
       department_id,
       sum(salary) over (order by department_id asc rows between unbounded preceding and current row) as total
from employees
where department_id = 20;

-- self join �̿�
select e.employee_id, e.salary, e.department_id, sum(t.salary) as total
from employees e, employees t
where e.department_id = 20
and t.department_id = 20
and e.employee_id >= t.employee_id -- cummulative
group by e.employee_id, e.salary, e.department_id -- select���� �׷� �Լ��� ������ ��� �÷��� group by���� ����!
order by 1;
-- ū ���̺��� 2�� �׼����ϰ� ����(�������� ����) => ���� ����!(�м� �Լ� �̿��ϱ�!)



-- �Ϲ����� �׷� �Լ��� select���� over�� �Ἥ ������ ����!
select employee_id, salary, department_id, sum(salary) over (order by employee_id) as total
from employees
where department_id = 20;

select employee_id, salary, department_id, sum(salary) over (order by employee_id) as total
from employees;

-- cf1. order by ���� => �׳� �Ѿ׸� ��������!
select employee_id, salary, department_id, sum(salary) over () as total
from employees
where department_id = 20;

-- cf2. average �Լ� ���
select employee_id, salary, department_id, avg(salary) over (order by employee_id) as average
from employees
where department_id = 20;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

-- partition by
select employee_id, salary, department_id, 
       sum(salary) over (partition by department_id) as dept_total, -- �μ� �� ������ row ������ ����
       sum(salary) over (partition by department_id order by employee_id) as total -- �μ� ���� ���� ���� ������(partition by �� ���� �׳� ��ü row�� ������� �������� ����!)
from employees;



-- # top-n �м�
-- rank(): 2���� 2���̸� �� ������ 4��!
-- dense_rank(): ������ ����(1223456678...)
-- rank �Լ����� partition by�ؼ� �μ� ���� ��ũ�ϴ� �� ����!
select employee_id, salary, 
       rank() over(order by salary desc), -- �޿��� desc �����ϰ� ������ �ű�
       dense_rank() over(order by salary desc)
from employees;

select employee_id, salary,
       sum(salary) over(order by employee_id rows between unbounded preceding and current row) rank1, -- row ������ ���
       sum(salary) over(order by employee_id) rank2, -- rank1�� ����(default)
       sum(salary) over(order by employee_id rows between unbounded preceding and unbounded following) rank3, -- ����(ó������ ������)
       sum(salary) over() rank4 -- rank3�� ����
from employees;

-- rows between unbounded preceding and current row: ���� ����� ó������ "������"������ ��� <- current row
-- rows between unbounded preceding and unbounded following: ���� ����� ó���� "��"�� ���(��ü��) <- unbounded following

select department_id, salary, 
       first_value(salary) over (partition by department_id order by salary rows between unbounded preceding and unbounded following) first_value,
       last_value(salary) over (partition by department_id order by salary rows between unbounded preceding and unbounded following) last_value
from employees;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));