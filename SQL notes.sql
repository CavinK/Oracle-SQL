select * from employees;
select * from departments;

-- I. select문의 기능


-- 1. projection: 테이블에 "열 단위"로 추출(select 말고는 검색 방법 없음)
select employee_id from employees;
select employee_id, last_name from employees; --comma로 구분지음! 

desc employees -- table의 구조 파악(어떤 column이 들어있는 지?)

-- 2. selection: 테이블에 "행"을 추출할 때
select * 
from employees
where employee_id = 100; -- table 안의 row을 추출! 
-- select절 column을 지정
-- from절 테이블 지정
-- where절은 행을 제한하는 절(검색의 기준!)

-- 3. join: 서로 다른 테이블에서 내가 원하는 데이터를 추출하는 방법(정규화!)
select * from employees;
desc departments -- semicolon 안 씀! 

select department_name
from employees 
where employee_id = 100; -- error!(invalid identifier)

-- 100번 사원명의 부서명 추출
select department_id 
from employees 
where employee_id = 100; 

select department_name
from departments
where department_id=90; -- F10키: 실행 계획! 실행 계획마다 CPU 사용, I/O 통계 만듬. 
                        -- (데이터를 표현하는 방법 - 통계)
                        -- 불필요한 실행 계획 <- CPU 성능 나빠짐. 
                        -- => Join 사용! (위의 두 SQL문을 하나로 통일)

select d.department_name
from employees e, departments d -- 동의어(synonym)!!!
where e.department_id = d.department_id -- (Join)
and e.employee_id = 100; 





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------






-- RDBMS 안에 있는 데이터를 조작하는 언어는 SQL 뿐이다. (Python, R로는 사용 못 함)
-- SQL은 시각화 안 됨. (Insight 제공하는 데에 한계) 
-- 시각화: R을 통해서 SQL을 끌고 옴. (R에서도 SQL 구문 제공)
-- Hadoop <- Java 기반(Hive 사용)
-- SQL Developer도 Java 기반(Java도 Oracle 소유)
-- cf) Orange tool(라이센스 비용 지불해야 함)

-- SELECT 문(Data Query Language) 
-- <- 데이터를 조회하는 언어(가장 많이 사용, 업무 이해도 필요)

-- 기능
-- 1. projection: 열 단위 추출(table 안에)
-- 2. selection: 행 추출
-- 3. join: 서로 다른 테이블의 데이터 추출

select * from tab;
-- F10키 안 됨 <- 권한 부여 안 됐기 때문
-- # 유저가 가지고 있는 테이블 목록 확인, DB에 저장된 각 table 관련 정보 제공
-- 현업에서는 업무 별로 table 분리
-- (ex. 인사 업무는 HR table로 따로 분리, 다른 부서는 사용 못 함)
-- (hr user는 오라클에서 교육 목적으로 만든 sample)
-- where절은 optional(select, from은 꼭 포함되어 있어야 함!)
-- from 뒤에는 대상 table 이름 적으면 됨
-- * 는 모든 데이터를 조회하겠다는 뜻

desc employees -- "describe" the table of employees
-- table의 구조 확인(semicolon 안 씀)
-- varchar2 <- Oracle에서 사용하고 있는 "가변 길이 문자 타입"
-- (각 타입은 모델러가 협업을 통해 디자인)
-- 장점: 저장공간 효율적 활용 // 단점: 업데이트 시 번거로움
-- DATE 타입 <- 7바이트로 고정(영어 글자 하나 당 1바이트(7비트), 
--                          한국어는 글자 당 2바이트)
-- 시계열 관련 분석 업무 수행할 때 DATE 검색에 특히 신경써야! 
-- NUMBER(8,2) <- 전체 8자리 중에 소수점 2자리 사용(10자리 아님)
-- NUMBER(2,2) <- 전체 2자리 중에 2자리 전부 소수점 자리
-- NOT NULL <- 이 필드에는 반드시 값이 들어가야! 
-- 결측치(NA) <- NULL값이 들어있는 필드, 현업 시 문제 발생

-- ## ASSIGNMENT 
-- 컴퓨터의 단위(비트, 바이트, ...) <- 공부하기! 

select last_name,salary from employees; 
SELECT LAST_NAME,SALARY
FROM EMPLOYEES;
-- F10키(실행 계획, 통계 정보) <- CPU를 사용(저장 공간 사용)
-- 매번 실행 계획이 바뀌면 컴퓨터 성능에 악영향! 
-- 각 SQL문마다 Oracle은 실행 계획을 만듬(다른 DBMS도 마찬가지)
-- SID: 메모리 이름
-- SQL문 하나를 실행하면 Oracle은 "메모리"에 저장
-- 똑같은 SQL문을 실행하면 Oracle은 메모리에 저장된 "똑같은" 실행 계획을 재사용
-- cf) 대문자로 바꿔서 같은 내용의 SQL문을 실행할 경우 <- 다른 실행 계획!
-- (영어는 대소문자의 체계가 다름)
-- 메모리 사용 증가! CPU 사용 증가! 
-- 규격화된 SQL문을 사용할 필요가 있음(대소문자 구분지어서 개발)

-- <동일한 SQL문의 기준>
-- 규칙성 있게 만들기!!(현장에서는 가이드라인(표준화 형식) 제공함)
-- 키워드는 대문자, column 이름은 소문자
-- 1. 대소문자 일치
-- 2. 공백문자 일치(한 칸 띄울 걸 두 칸 띄우면 다른 실행 계획으로 저장됨)
--    TAB KEY, ENTER KEY
--    (현장에서는 절을 다른 문장으로 나누는 걸 선호 <- 가독성 높아짐)
-- 3. 주석(comment) 처리(/* 주석내용 */, -- 주석내용)
--    주석내용도 일치되어야! 
-- 4. 실행계획을 제어하는 힌트 /*+FULL(E) */ (튜닝 관련)
--    힌트(테이블명) <- ex. synonym
--    힌트도 일치되어야
-- 5. 상수값, 리터럴값이 일치되어야 한다(ex. employee_id = 100,200)
--    (리터럴값: single quotation mark로 묶여있는 값)
--    (PL/SQL: 상수값을 변수 처리 <- 리소스 사용 절약)

select *
from employees
where employee_id=100;

select *
from employees
where employee_id=200;
-- INDEX UNIQUE SCAN
-- ex i. 책의 일정 단어를 빨리 찾아가는 방법 <- Index
-- ex ii. 집 주소 <- 세상에서 고유한 것(primary key)
-- 각 row마다 primary key 보유(해당 row를 식별)

select rowid, employee_id from employees;
-- 각 primary key마다 개별적인 주소(rowid) 가지고 있음! (책의 "페이지 번호" 개념)
-- rowid는 가상 column
-- rowid: row의 "물리적" 주소(저장 공간 상의 주소, 절대 중복되지 않음)
-- AAAEAb AAE AAAADN AAA
-- rowid의 앞의 6자리: object id(object: DB 상의 객체 ex. employees)
-- 그 다음 3자리: data file 번호
-- (Oracle이 storage의 데이터 파일로 저장 <- 어느 위치에 저장되어 있는 지 명시)
-- 그 다음 6자리: block 번호(몇 번째 block에 저장되어 있는 지 명시 ex. 집 주소의 번지)
-- 그 다음 마지막 3자리: row slot 번호(그 block 안에서도 몇 번째 위치에 있는지)
-- ex. 책 안에서도 몇 번째 문장에 해당 단어가 위치해 있는지

-- data file 하나당 크기 <- 최대 2기가(32비트 OS 기준), 64비트는 대부분 제약 없음
-- <- data file을 분할해야!(data file 여러 개 구성)
-- 크기 제약 때문에 data file 번호는 틀려질 수 있음
-- 98번, 99번 row <- block 번호 달라짐(고유 번호!)
-- rowid 기억 못 함 <- index 사용(튜닝), index 알고리즘(ex. 2진트리 구조)

-- Data 찾는 가장 빠른 방법 <- rowid를 where절에 쓰는 것!(rowid scan)
-- <rowid scan>
select *
from employees
where rowid='AAAEAbAAEAAAADNAAA'; -- single quotation mark('') 꼭 처리!
-- F10키 <- BY USER ROWID SCAN
-- rowid로 검색 <- 딱 하나의 I/O만 발생! 

-- cf)
-- <index scan>
select *
from employees
where employee_id=100; -- 몇 번의 I/O가 발생(성능 저하)
-- F10키 <- UNIQUE SCAN
-- ex. 색인 페이지 사용(index mechanism) <- 먼저 책의 맨 뒤 페이지 확인(I/O 발생)
--                                        단어 확인하고 실제 페이지로 이동(I/O 발생)
-- cf. 실제 페이지를 아는 경우(rowid scan) <- I/O 발생이 확연히 줄어듬
--                                         but rowid를 아는 경우는 극히 드뭄
-- 실제 페이지, index를 모를 경우 <- full scan

-- data 처리(검색)하는 방법은 2가지 방법 뿐이다. 
-- 1. full scan
-- 2. rowid scan
--    2.1 by user rowid scan
--    2.2 index rowid scan(DBA가 rowid를 모르니, index algorithm를 통해 유도!)

-- SQL문 상에 연산자 사용 가능(개별 필드값에 연산 적용)
select employee_id,salary*12
from employees;
-- # 연산자
-- 1. 산술연산자(사칙연산자): *, /, +, -
--    연산자 우선 순위: 
--    1순위: /,* // 2순위: +,- // 동일 순위일 경우, 왼쪽에서 오른쪽으로
--    알아보기 쉽게(혹은 연산자 우선순위 바꾸기 위해) 괄호 사용
--    (((a*b)/c)+d)
--    -----
--    1
--    ----------
--    2
--    ---------------
--    3
-- 사칙연산이 가능한 Data type
--    number: *, /, +, -
--    date: +, -
--    char: 사칙연산할 수 없다. 
-- date는 연산 가능 but 다수의 고객들이 char형으로 바꿔주기를 원함 
-- char형을 number형으로 바꿔서 연산 수행(날짜를 조회, 입력 시 번거로움)
-- date형 <- 지역에 따라 날짜 포맷이 달라짐

select employee_id,salary,commission_pct,
from employees;
-- commission_pct: NULL값 혼재

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) ann_sal  -- 12개월치 salary에 commission 추가
                                             -- 컬럼명에 표현식 그대로 나옴
                                             -- 컬럼명을 열 별칭(ann_sal)으로 표현! 
from employees;
-- 연산에 NULL값이 하나라도 포함되면, 결과값은 무조건 NULL값
-- nvl() 함수 사용! 

-- nvl 함수는 NULL값을 별도의 대체값으로 변환하는 함수(nvl(컬럼명, 대체값))

-- # NULL값 정의
-- 1. NULL은 사용할 수 없거나, 할당되지 않았거나, 알 수 없거나, 적용할 수 없는 값이다. 
-- 2. NULL은 0이나 공백이 아니다. (0은 엄밀히 숫자 // 공백은 자릿수 가지고 있음)

-- NULL값이 있음에도 연산을 수행하고 싶은 경우(ex. 0으로 대체) <- select만으로는 불가능
-- <- if문을 이용해서 프로그램 사용
-- (BUT) SQL은 비절차적 언어 
-- <- SQL에 별도의 프로그램 가미(logic 구현: PL/SQL)
--    함수 구현 or Oracle에서 제공하는 함수(nvl(컬럼명,0)) 사용

-- # 열 별칭(alias)
-- 1. 열 이름을 다른 이름으로 바꾼다. 
-- 2. 열 이름 바로 뒤에 한 칸 띄운 후에 사용할 수 있고, 
--    또는, "as 키워드" 뒤에 사용할 수 있다. 
-- ** 열 별칭 사용할 때 공백문자가 포함되면 안 됨! 
-- 3. 열 별칭에 특수문자는 _, #, $만 가능하다. 
--    그 외의 특수문자를 사용할 때는, 컬럼명 전체를 "" 묶어서 사용하면 된다.
--    (single quotation mark는 안 됨)
-- 4. ""를 사용하면 대소문자도 구분된다. 
-- 5. 열 별칭의 맨 앞 부분에 숫자, 특수문자 적으면 안 됨. ("" 묶어서 표현하기)

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) "Ann ^ Sal" -- ""로 묶어서 표현
from employees;

select employee_id,salary,commission_pct,
    salary*12+nvl(commission_pct,0) "200sal" -- ""로 묶어서 표현
from employees;

-- 두 컬럼 변수를 하나의 필드값으로 병합
select last_name || first_name || salary -- 숫자를 합칠 경우에는 문자 형식으로 변환
from employees;

-- # 연결 연산자
-- 1. 열이나 문자열을 다른 열에 연결할 때 사용된다. 
-- 2. 두 개의 세로선(||)으로 나타낸다.
-- 3. 결과는 문자식으로 생성된다.

-- 리터럴 문자열(''로 공백문자 표현)
select last_name || ' ' || first_name 
from employees;

-- table에 없는 특정 문구를 표현(리터럴문('')을 이용)
-- 리터럴문을 사용할 때는 반드시 ||와 같이 사용
-- alias 열 별칭 사용 가능
select last_name || ' is a ' || job_id "emp details"
from employees;

-- 문자열 내에 '를 표현하고 싶으면, ''로 하나 더 타이핑! 
select 'My name''s ' || last_name sentence
from employees;
-- 또는, q연산자(q'[]')를 이용 -- (!<{[ ]}>!)
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

/* <문제1> employees 테이블에서 employee_id, last_name과 first_name은 
연결해서 표시하고(공백으로 구분) 열 별칭은 화면예 처럼 보고서 작성해 주세요.

화면예>
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

-- 위의 row들만 따로 추출
select employee_id "Emp#", last_name || ' ' || first_name "Employee Name"
from employees
where employee_id in (100,101,102,103,104);



/* <문제 2> employees 테이블에서 컬럼중에 last_name, job_id를 
연결해서 표시하고(쉼표와 공백으로 구분) 열 별칭은 화면예 처럼 보고서 작성하세요.


화면예>

Employee and Title
-------------------------
Abel, SA_REP
Ande, SA_REP */

select last_name || ', ' || job_id  "Employee and Title"
from employees;

-- 위의 row들만 따로 추출
select last_name || ', ' || job_id  "Employee and Title"
from employees
where last_name in ('Abel','Ande');

-------------------------------------------------------------------------------



-- # 중복행 제거(Unique한 값만 추출)
select distinct department_id from employees;
-- Sort <- 중복을 제거하는 하나의 방법
-- distinct를 사용하면 내부적으로 sort, "hash 알고리즘"이 작동(F10으로 확인)
-- Hash algorithm: 나누기의 나머지 값을 이용하여 정렬
-- ex. 10개의 상자 <- 값을 10으로 나눠서 나머지 수에 따라 0~9로 분류
-- Hash는 CPU만 좋으면 효율적으로 관리 가능
-- Oracle의 메모리 <- Hash algorithm으로 관리! 

-- distinct: select문의 맨 앞에 사용, comma는 쓰지 않음

select distinct department_id,job_id 
from employees
order by department_id desc;
-- 부서 아이디는 동일하지만, job id는 다름 <- 다른 row라고 판별(중복으로 제거 안 됨)
-- 정렬: order by절

-- # where절을 통해 행을 제한한다 
-- 비교연산자: =, >, >=, <, <=, !=, ^=, <>
-- !=, ^=, <>: "같지 않다"는 뜻
-- where절을 잘 사용하기 위해서는 업무 파악이 잘 되어 있어야! 

select *
from employees
where department_id=30;
-- where <- 비교연산자(>,<,=) 사용

select *
from employees
where salary>10000;
-- 이상(>=), 이하(<=), 초과(>), 미만(<) 구분할 줄 알아야!! 
-- salary <- number 타입(비교연산자 사용 가능) 
-- cfi) String 타입: 리터럴 문자열('')로 표현
-- cfii) number 타입에도 리터럴 문자열 사용 가능 but 리소스 낭비 심해짐
--       (양쪽 행의 타입을 불일치 시키면, 자체적으로 conversion 시킴)
--       (index scan이 full scan으로 바뀜)
-- 각 변수(column)의 타입을 desc employees를 통해 정확히 파악해야 함! 

/*

select *
from employees
where department_id=30;
        number      number
                    '30'
        number   <- char

타입이 다를 경우, 자동으로 char가 number를 따라가도록 됨(conversion)
<- 형 변환 함수가 자동으로 생김! 
where department_id=to_number('30'); <- 여전히 index scan

cf)
        char ->     number
where to_number(department_id)=30; <- full scan으로 바뀜!
(char이 number를 따라가기 때문)

* where절에서 char와 number을 비교 <- Oracle이 알아서 conversion 해줌 
** where절을 사용할 때는, 반드시 타입을 맞출 것! 

*/

select *
from employees
where department_id='30';

select *
from employees
where last_name='King';
-- 소문자로 king로 검색하면 추출 안 됨
-- 필드값을 모두 소문자로 변환한다음 비교! 



select *
from employees
where lower(last_name)='king'; -- 하지만 full scan
                               -- 컬럼명에는 함수를 쓰지 않는 게 좋음
                               
select *
from employees
where upper(last_name)='KING';

select *
from employees
where initcap(last_name)='King'; -- 첫글자만 대문자로 변환

select *
from employees
where to_number(department_id)=10; -- F10: full scan으로 바뀜!(리소스 낭비)



-- # Date형

select employee_id "EmpID", hire_date "EmpDate"
from employees;
-- date형 <- 지역, 언어에 따라 날짜 포맷이 달라짐 
-- exi. 한국: RR/MM/DD <- 2000년도 오류법 개선(Oracle에서 자동으로 conversion 시킴)
--                       (세기를 표기하지 않은 이유 - 하드 디스크 비용이 비쌌기 때문)
--                       연도를 4자리로 표기하는 습관 가지자!(2자리로 표현되더라도)
-- exii. 미국: DD-MON-RR <- DD,RR은 지역에 종속, MON 부분이 언어에 종속

select *
from employees
where hire_date='2001/01/13'; -- 한국에서만 검색 됨. 미국에서는 조회 안 됨. 

select *
from employees
where hire_date='2001-01-13'; -- 그래도 나옴 but 미국에서는 조회 안 됨

select *
from employees
where hire_date='20010113'; -- 그래도 나옴 but 미국에서 하면 추출 안 됨

select *
from employees
where hire_date='13-JAN-2001'; -- 검색 안 됨! (Date형은 지역, 언어에 종속)

-- 어느 지역에서든 검색하는 법(형 변환 함수 사용)
select *
from employees
where hire_date=to_date('2001-01-13', -- ''표현 <- 문자(리터럴 문자형)
                        'yyyy-mm-dd');  
                        
-- to_date: char -> date
-- 날짜('2001-01-13')는 기본적으로 char형
-- where hire_date='2001-01-13'
--          date       char     
-- 기본적으로 date는 char형이지만, 형식(yyyy-mm-dd)만 맞추면 자동으로 형이 바뀜(암시적)
-- 미국식('13-JAN-2001')은 지역에 주어진 형에 맞추지 않아서 오류 발생
-- cf) 명시적 변환: to_date() <- 숫자달만 써야 함! 

select *
from employees
where hire_date=to_date('20010113',
                        'yyyymmdd'); -- 날짜는 이런 형식으로 맞추는 걸 습관화! 
                        
select *
from employees
where department_id=50
and salary>=10000;

select *
from employees
where department_id=50
or department_id=40;

-- ** NULL <- 언젠가는 True나 False가 올 수 있다는 뜻
-- True AND NULL <- NULL
-- False AND NULL <- False(어느 값이 들어오든 False이기 때문)
-- True OR False <- True
-- True OR NULL <- True
-- False OR NULL <- NULL

select *
from employees
where hire_date=to_date('01/13/2001'); 
-- 자동으로 변환 안 됨(항상 모델을 쓰는 습관 갖기!)
select *
from employees
where hire_date=to_date('01/13/2001','mm/dd/yyyy'); 

/*
<문제3> employees 테이블에서 급여가 2500 ~ 3500인 사원들의 모든 정보를 조회하세요.

<- 범위 스캔할 때는, 이상/이하인지 초과/미만인지 고객들한테 물어보기! 
*/
select * 
from employees
where salary>=2500
and salary<=3500;

-- 보다 심플하게 만드는 법
select *
from employees
where salary between 2500 and 3500; -- between 작은 값 and 큰 값
                                    -- 변수는 number, date, char 타입 다 가능
                                    -- "이상/이하"의 의미("초과/미만"의 의미가 아님)
                                    
/*
<문제4> 관리자의 사원번호가 100,101,200인 사원들의 모든 정보를 출력해주세요.
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
and manager_id<>200; -- or를 and로 바꾸기! 

select *
from employees
where manager_id not in (100,101,200);

-- in 연산자 = OR
-- not in 연산자 = NAND(NOR가 아님)

select *
from employees
where manager_id not in (100,101,300);

select *
from employees
where manager_id not in (100,101,NULL); 
-- 값이 안 나옴(False) <- NAND이기 때문(NOR가 아님) 

select *
from employees
where manager_id in (100,101,NULL);
-- 필드값이 나옴(True) <- OR이기 때문
-- not in <- 연산자가 반대로 변환(= <- <>), or는 and로 변환 
-- char형일 경우 <- 개별적으로 '' 표시, 대소문자 구분!

select *
from employees
where last_name like 'K%'; -- wild card(%): 문자 패턴을 찾으려고 할 때 쓰는 연산자

select *
from employees
where last_name like '_i%'; -- i가 두번째에 오는 이름
                            -- %는 첫번째 문자에 올 수 없음! 그 대신 _ 사용!

select *
from employees
where last_name like '__i%'; -- i가 세번째에 오는 이름

-- 정확한 위치를 모를 때는 % // 위치를 알고 있을 때는 _
-- like 연산자는 기준 column이 무조건 char 타입이어야! 
-- like 연산자는 "문자" 패턴을 찾는 연산자
-- char 외의 타입에 이 연산자를 쓸 경우 작동은 하지만 악성 코드가 됨

/*
[문제5] last_name 두번째 위치에 소문자 o가 있고 뒤에 어떤 글자가 올지 모른다. 
이 조건에 해당하는 데이터를 추출해주세요.
*/

select *
from employees
where last_name like '_o%';

-- %, _를 문자에 포함시켜야 할 경우

select *
from employees
where job_id like 'SA\_%' escape '\'; 
-- 역슬래쉬 "바로 뒤"에 있는 건 "문자(char)"로 인식
-- 역슬래쉬 말고 다른 특수문자(^)도 사용 가능
select *
from employees
where job_id like 'SA\_\%' escape '\'; -- %도 문자로 인식
/* 
SAREP
SA_REP <- 이걸 찾으려고 하는 경우

where job_id like 'SA_%' escape '\' <- 둘 다 나옴
where job_id like 'SA\_%' escape '\' <- SA_REP만 나옴
*/

-- like 연산자는 "문자" 패턴을 찾는 연산자
-- char 외의 타입에 이 연산자를 쓸 경우 작동은 하지만 악성 코드가 됨

select *
from employees
where hire_date like '01%';
-- 해당 row는 나옴(test db에 해당)
-- but 운영 db로 돌리면 문제 발생
-- internal_function <- 악성 코드로 변할 소지가 있음
-- like 연산자는 기본적으로 char 타입을 위한 것 때문에, 
-- column(hire_date: date 타입)도 char형으로 자동 변환 <- full scan
-- <- 이 과정에서 악성 코드가 됨

-- SOLUTION 1(date형에는 between 연산자로 range scan을 수행)
select *
from employees
where hire_date 
between to_date('2001-01-01','yyyy-mm-dd')
and to_date('2001-12-31','yyyy-mm-dd');
-- but 데이터에 대한 loss가 생길 수 있음
-- 마지막 날 시간이 00:00:00으로 설정되어 있음 <- 이 시간 이후의 row는 누락됨! 
-- 시분초를 따로 설정하지 않으면, Oracle은 자동적으로 00:00:00로 자동 설정
select *
from employees
where hire_date 
between to_date('2001-01-01','yyyy-mm-dd')
and to_date('2001-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');
-- hh24:mi:ss를 통해 시분초 단위도 설정! 

-- SOLUTION 2
select *
from employees
where hire_date>=to_date('2001-01-01','yyyy-mm-dd')
and hire_date<to_date('2002-01-01','yyyy-mm-dd');



-- 우선순위(and가 or보다 먼저 작동)
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
-- 이렇게 쓰면, where job_id='SA_REP' or (job_id='AD_PRES' and salary>10000); 
-- <- 이런 식으로 작동!!!(SQL은 비절차적 언어)
-- or와 and를 동시에 쓸 때는, 괄호로 꼭 구분하기





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------




/*
정형 data vs 비정형 data

ASSIGNMENT: 문제에 대한 답 외우기
*/

-- # SORT 정렬
-- order by 절은 select 문의 마지막절로 써야한다. 
-- default는 오름차순 정렬된다. <- asc(ascending)
-- 내림차순으로 정렬 <- desc(descending)
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
-- 부서부터 오름차순으로 정렬하고, 그 안에 월급을 내림차순으로 정렬

select last_name, department_id, salary*12 ann_sal
from employees
order by salary*12; -- 표현식 그대로 사용 가능

select last_name, department_id, salary*12 ann_sal
from employees
order by ann_sal; -- alias 사용해서 정렬

select last_name, department_id, salary*12 "ann_sal"
from employees
order by "ann_sal";  -- ""로 synonym을 만들었을 때는 order by절에도 "" 표시하기

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 3; -- 위치 표기법("ann_sal" <- 3번째 column) 

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 2 asc, 3 desc;

select last_name, department_id, salary*12 "ann_sal"
from employees
order by 3 desc, 2 asc;

-- order by절은 가장 마지막에 씀(화면 상에 출력하기 전에 sort 작업)
-- NULL 값은 오름차순일 때 제일 뒤, 내림차순일 때 제일 앞에 위치(가장 큰 값으로 인식)



-- DB에 있는 데이터 조작
-- select 이외의 기능을 수행하는 프로그램 <- 함수

-- 함수: 기능의 프로그램
-- 함수 <- 미리 짜놓은 거(PL/SQL)



-- 1. 문자함수
--    문자함수의 입력변수는 char형을 집어넣어줘야 함
--    숫자를 집어넣으면, 오류 발생 <- char형으로 변환시켜줘야 함
select lower(last_name),upper(last_name),initcap(last_name)
from employees; 
--    대소문자 조작해주는 함수
--    총 3가지 - lower: 소문자 변환 // upper: 대문자 변환 // initcap: 첫 글자 대문자
select *
from employees
where last_name = 'king'; -- by index rowid
                          -- index: rowid 이외에 'King'을 별도의 공간에 저장

select *
from employees
where lower(last_name) = 'king'; 
-- 출력 결과는 변형되지 않음
-- 변형된 값을 보고 싶으면 select 부분에서 함수 적용하기
-- 위 코드처럼 입력하면 악성 프로그램이 됨(full scan) 
-- <- 함수를 where의 조건절에 쓰는 건 자제할 것!(주의해서 쓰기)
-- 이러한 함수는 조회 단계보다는 입력, 수정 단계에서 쓰는 게 더 적절함 



-- concat(): 연결 연산자(||) <- concat은 인수값으로 2개만 허용!! 
select last_name||first_name, concat(last_name,first_name)
from employees;

select last_name||first_name||salary, concat(last_name,first_name)
from employees; -- ||의 결과값은 char형



-- length(): 문자의 길이 
select last_name, length(last_name)
from employees; 



-- substr(): 문자를 일부분 추출 
-- <- ex i. substr(x,1,3): x를 1부터 3까지 추출
-- <- ex ii. substr(x,1,1): x의 첫 글자만 추출
-- <- ex iii. substr(x,-2,2): x의 -2에서 2개의 글자 추출(-2에서 "오른쪽"으로 2이동)
select last_name, length(last_name), 
substr(last_name,1,3)
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-2,2) -- -2에서 "오른쪽으로" 2 이동!!!
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-1,1)
from employees;

select last_name, length(last_name), 
substr(last_name,1,3), substr(last_name,-2,1) -- 끝에서 2번째 글자 하나만 추출
from employees;



-- lpad(), rpad(): 숫자를 문자로 변형시키는 함수(자리수 고정시키는 작업 수행)
select salary, lpad(salary,10,'*') -- salary값을 10자리로 고정시키고, 
                                   -- 왼쪽의 공백을 *로 처리(사람들이 자리수 모르게끔)
from employees;

select salary, lpad(salary,10,'*'), rpad(salary,10,'*') -- 오른쪽 공백! 
from employees;

-- dual: dummy table
-- 함수의 표현식에 table 어디에도 없는 값을 입력할 경우
-- <- from절에 dummy table(가상 테이블 만듬) <- dual
-- test 작업을 수행할 때 종종 씀
select instr('abbcabbc','c') -- c가 어디에 위치해 있는 지 숫자로 리턴값 표현
                             -- 입력변수 뒤에 1,1이 생략된 것
                             -- instr('abbcabbc','c',1,1) 
                             -- 앞의 1은 고정! 
from dual; -- dummy table



-- instr(): 테이블(컬럼)에 해당 알파벳이 있는 지의 여부를 빠르게 파악 
select instr('abbcabbc','c'), instr('abbcabbc','c',1,2) 
-- 1부터 시작에서 "2번째 c"가 나오는 것 표현
from dual;

select instr('abbcabbc','c'), instr('abbcabbc','z',1,1) 
from dual;

select 1+2
from dual;

select last_name, instr(last_name,'i')
from employees; -- employees 테이블의 last_name 컬럼에 i가 위치해 있는 지의 여부 파악
                -- text mining에 자주 이용됨
                
select last_name
from employees
where last_name like '%i%';

select last_name
from employees
where instr(last_name,'i')>0; -- like 연산자 이용할 때와 동일한 결과값
                              -- instr() 값이 0을 초과하면, 필드에 존재한다는 뜻
                              -- 이게(instr) 위에 꺼(like)보다 성능이 더 좋음
                              -- <- 함수는 병렬 처리하기 때문



-- trim(): 해당 문자를 버리는 함수 <- "접두, 접미 부분"만 지울 수 있음(중간 부분은 안됨)
-- trim( from )
select trim('A' from 'AABBCAA')
from dual;

select trim('A' from 'AbABBCAA') -- b 뒤의 A는 제거 안됨
from dual;

-- ltrim() <- 왼쪽 연속 부분 제거 // rtrim() <- 오른쪽 제거
-- ltrim(), rtrim()의 괄호 안에는 from을 넣지 않음
select trim('A' from 'AABBCAA'), ltrim('AABBCAA','A'), rtrim('AABBCAA','A')
from dual;

-- 앞 뒤 공백 문자 제거
select trim('A' from 'AABBCAA'), ltrim('  BBCAA ',' '), rtrim(' BBCA  ',' ')
from dual;



-- replace(): 하나의 문자(-)를 찾아서 다른 문자(%)로 치환
-- 중간 부분도 수정 가능
select replace('100-001','-','%')
from dual;

select replace('100-001','0','9')
from dual;
-- 텍스트 데이터 분석할 때 표현을 일관되게 만들기 위해 사용

select replace('100-001','-','')
from dual;
-- 고객 계좌 번호 관리하기 편하게 만들기 위해 hyphen, 공백 문자 제거

select replace('1 0 0 0 0 1',' ','')
from dual;



-- 2. 숫자함수
-- round(), trunc(), mod()



-- round(): 반올림
select round(45.926, 0)
from dual;

select round(45.926, 0), round(45.926, 1), round(45.926, 2) -- 소수점 몇째 자리
from dual;

select round(45.926, 0), round(45.926, 1), round(45.926, 2), round(45.926, -1)
from dual; -- -1: 10의 자리 기준!! 

select round(45.926, 0), round(45.926, 1), round(45.926, 2), 
round(45.926, -1) "10의 자리 반올림", 
round(45.926, -2) "100의 자리 반올림(0)", 
round(55.926, -2) "100의 자리 반올림(100)"
from dual;



-- trunc(): 버림 // ceil(): 올림
select trunc(45.926, 0), trunc(45.926, 1), trunc(45.926, 2), trunc(45.926, -1)
from dual;

select ceil(45.0), ceil(45.12), ceil(45.926)
from dual;



-- mod(): 나누기 했을 때 몫이 아닌 나머지 값을 리턴(ex. Hash, 윤년 ...)
select mod(13,2)
from dual;



-- 3. 날짜 함수
-- 날짜 계산
select sysdate 
from dual; -- 현재 DB 서버의 시간대(지역, 언어에 종속)



-- 날짜 + 숫자(일수) = 날짜 <- 일수 더해짐 
select sysdate, sysdate+7 
from dual;
-- 날짜 - 숫자(일수) = 날짜
select sysdate, sysdate+7, sysdate-7
from dual;
-- 날짜 - 날짜 = 숫자(일수) <- 날짜가 char형으로 되어 있는 경우, 타입 변환! 
select employee_id, sysdate-hire_date
from employees;
-- 날짜 + 시간/24 = 날짜 <- 24시간으로 환산!! 
-- 날짜 + 분/(24*60) = 날짜
-- 날짜 + 초/(24*60*60) = 날짜
-- 날짜 + 날짜 = 오류! 



-- 날짜 함수



-- months_between(최근날짜, 과거날짜): 두 날짜 사이의 개월 수 표시
-- 무조건 날짜 정보(date 타입)만 넣어줘야 함!! 
-- 입력값은 date 타입이지만, 리턴값은 number 타입
-- 리턴값(개월 수)의 소수점 없애고 싶으면 trunc() 쓰면 됨
select months_between(sysdate,hire_date)
from employees;

select months_between(to_date('2018-05-24','yyyy-mm-dd'), 
                   -- to_date() <- 형 변환 함수
to_date('2018-11-22','yyyy-mm-dd'))
from dual; -- 결과가 음수값으로 나옴

select months_between(to_date('2018-11-22','yyyy-mm-dd'), 
to_date('2018-05-24','yyyy-mm-dd'))
from dual;



-- add_months(날짜 정보, 개월 수): 해당 날짜에 개월 수를 더함
select add_months(sysdate,6)
from dual;



-- next_day(기준 날짜, 요일): 가까운 "미래" 시점의 요일에 해당하는 날짜 정보 리턴
select next_day(sysdate,'금요일') -- 날짜는 지역과 언어에 종속
from dual;



-- last_day(): 그 달의 마지막 일(날짜 정보를 입력!) 
select last_day(sysdate)
from dual;



-- round(날짜, 'month or year'), trunc(날짜, 'month or year')
-- overloading: 같은 함수 이름, 다른 기능(다른 타입의 인수)
select round(sysdate,'month') -- 개월을 기준으로 해서 "일(day)"을 보는 것! 
from dual;

select round(sysdate,'month') "개월 기준 반올림", 
round(sysdate,'year') "연도 기준 반올림"
from dual;

select trunc(sysdate,'month') "개월 기준 버림", -- 그 달의 1일
trunc(sysdate,'year') "연도 기준 버림" -- 그 해 1월 1일
from dual;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------




-- # 형변환 함수
-- 데이터 타입이 바뀌게 만드는 함수

-- 암시적 형변환 <- 의도치 않게 형이 변환됨(안 좋은 경우)
desc employees

select *
from employees
where department_id = '10';
--        number    = number
-- cfi)   number    = char <- 형이 안맞음(프로그램 오류 <- 자체적으로 recession 발생)
-- char가 number를 쫒아가도록 되어 있음(암시적 형변환)
-- cfii)  char      = number <- 오라클에서 자체적으로 recession 처리(암시적 형변환)
--                           <- char에 형변환 함수가 작동 
--                           <- 실행 계획이 망가짐(full scan) <- 최악의 케이스
--                           <- number쪽에 명시적으로 형변환 시켜주는 게 나음

-- 다른 type을 적었다고 무조건 형변환 해주지는 않음(ex. 10, '십' <- 오류 메시지)

select *
from employees
where hire_date = '2001/01/01';
--        date  =  char <- 오류(오라클에서 형변환 but 위에처럼 무조건 바꿔주진 않음)
-- date는 지역, 언어에 민감 <- 그 나라에 맞는 문자를 적었을 때만 형변환
-- ex. 한국에서 Jan이라고 적었을 경우에는 오류 메시지
select *
from employees
where hire_date = '01-01-2001';
-- 오라클에서는 '01-01-2001'을 날짜로 인식하지 않음(한국식 날짜 포맷이 아니기 때문)
-- 오류 메시지! 

select last_name || salary
--         char  || number
from employees;
-- 다른 type의 변수들이 조합 <- char가 됨! 
-- date || number <- char로 인식! 

select 1+'2'
-- number+char
from dual; -- 오라클에서 자체적으로 리터럴 문자('2')를 number로 바꿔줌! 



-- to_char 함수: number -> char 
--             // date -> char형으로 변환하는 함수 <- 보고서 작성용!
-- OVERLOADING <- date, number

-- to_char(날짜,'문장') <- '' 안에 있는 리터럴 문자는 ""로 표시! 

select sysdate from dual; -- # sysdate: 서버시간대(RDBMS: 응용 프로그램 O, OS X)
                          -- 서버시간: OS가 가지고 있는 시간으로 가져옴(PC의 시간!)
                          -- R, Python도 마찬가지
                          -- OS의 시간이 잘못 설정되어 있으면, 틀리게 표시
                          -- sysdate는 날짜는 물론, "시간" 정보까지 가지고 있음
                          -- date 형식을 보기 편하게 변형시킬 수 있음 <- to_char()
select to_char(sysdate,'yyyy')
from dual; -- 날짜 정보(sysdate)를 char 타입으로 변환
select to_char(sysdate,'yyyy year') -- 문자연도로도 리턴 가능
from dual;

select to_char(sysdate,'yyyy year 
                        mm month mon') -- 문자달, 문자달의 약어(언어에 종속)
                                       -- 연도는 따로 형식을 만들어야 함! 
from dual;

select to_char(sysdate,'yyyy year 
                        mm month mon 
                        dd day')
from dual;

select to_char(sysdate,'ddd dd d') -- ddd: 365일 중에 현재 몇 일
                                   -- dd: 이 달의 몇 일
                                   -- d: 그 주의 몇 일(ex. 화요일 <- 3) <- 요일정렬!
from dual;

select to_char(sysdate,'ddd dd d day') -- day: 요일(언어에 종속)
from dual;

select to_char(sysdate,'ddd dd d day dy') -- dy: 요일의 약어
from dual;

select to_char(sysdate,'ddd dd d day dy q"분기"') -- q: 분기(총 4분기)
                                                 -- '' 안에는 ""로 리터럴 문자 표현
                                                 -- '' 안에는 || 사용하면 안 됨
from dual;

select to_char(sysdate, 'hh24:mi:ss.sssss') -- hh24: 24시간 환산(default: 12시간)
                                          -- 시간이 01,02,03... 이렇게 나옴
                                          -- 앞의 0을 제거하고 싶은 경우 <- fmhh24
from dual;

select to_char(sysdate, 'hh:mi:ss.sssss am') -- 시간 모델 요소(am, pm)
from dual;

select to_char(sysdate, 'fmhh24:mi:ss.sssss') -- 앞의 0을 제거하고 싶은 경우
from dual;

select to_char(sysdate,
              'ddspth') -- 그 달의 일(dd)를 스펠링(sp)으로 표현하고 서수(th)단위로
from dual;

select to_char(hire_date, 'day')
from employees
order by to_char(hire_date, 'day'); -- '월화수목금토' 이렇게 sort 안 됨!
                                    -- 'ddd dd d day dy'의 d 활용! 
                                    
select to_char(hire_date, 'day')
from employees
order by to_char(hire_date, 'd'); -- 제대로 요일 정렬 됐음! 
                                    
select to_char(hire_date, 'day')
from employees
order by to_char(hire_date-1, 'd'); -- 월요일부터 정렬(hire_date-1)



-- 기타 날짜 모델 요소
select to_char(sysdate,'bc scc yyyy') -- bc: 기원전, 서기 // scc: 세기
from dual; 

select to_char(sysdate,'bc scc yyyy ww w') -- ww: 1년 중 몇번째 주 // w: 그 달의 주
from dual; 

select to_char(sysdate+216,'bc scc yyyy ww w') -- 올해는 53주까지
from dual; 



-- number -> char
-- number형에는 ,. 못 들어감
-- 계산할 때는 char를 number로 바꿔야 함(,. 제거) <- 데이터 정제 작업
select to_char(salary,'999,999.00') -- 천단위 구분(number -> char 타입 변환)
from employees;

select to_char(salary,'999,999,999.00') 
from employees;

select to_char(salary,'000,000,999.00') -- 그 자리에 값이 없으면 0이라도 출력
from employees;

select to_char(salary,'999,999.00'),to_char(salary,'999g999d00') -- 같은 결과값
                                                -- 지역마다 ,. 구분이 다른 경우 사용
from employees;

select to_char(salary,'$999,999.00') -- 달러화 표시
from employees;

select to_char(salary,'l999,999.00') -- 원화 표시(알파벳 l: 그 지역의 통화 표시)
from employees;

select to_char(salary,'999.00') -- 자리 수가 안 맞는 경우 <- ########으로 나옴
from employees;



-- to_number(): char -> number 형변환 함수



-- 국가 변경

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

ALTER SESSION SET NLS_TERRITORY = GERMANY; -- 독일 지역
ALTER SESSION SET NLS_LANGUAGE= JAPANESE; -- 일본어

-- alter session set: 접속하는 동안에만 접속 <- 세션이 끝나면 원 상태로 회귀
-- territory, language <- parameters

select employee_id, 
      to_char(salary,'l999g999d00'),
      to_char(hire_date, 'YYYY-MONTH-DD DAY')
from employees; -- 지역에 상관 없이 코드가 작동될 수 있게 만듬

select sysdate from dual;
alter session set nls_date_format = 'yyyymmdd';
-- nls_date_format 변경 가능(세션 내에서만)
select sysdate from dual;
select * from employees where hire_date > '20020101';
-- 날짜를 문자형으로 입력하더라도, 기존에 정해진 format대로 써야 함!



-- to_date: char -> date 형변환 함수
select employee_id "Emp ID", last_name "Last Name", hire_date "Hire Date"
from employees
where mod(to_number(to_char(hire_date,'fmmm')),2)<>0
and hire_date>=to_date('2006/01/01','yyyy/mm/dd')
and hire_date<to_date('2007/01/01','yyyy/mm/dd');



-- 날짜 형식의 column type
-- 시간 정보 리턴해주는 함수(5개)
-- sysdate, systimestamp <- 서버의 시간
-- current_date, current_timestamp, localtimestamp <- 클라이언트의 시간대(지사 시간대)

-- nls 포맷 대로만 하고 싶으면 <- 그냥 위 5개 date type 쓰면 됨
-- date 타입을 초 이하의 자리수를 제어하고 싶으면 <- to_char()

-- date 뿐만 아니라, timestamp 타입도 있음
-- date 타입 <- 자리 수 표현 못 함
-- timestamp(9) <- 초 이하의 자리 수 표현(9까지 지정, default = 6)

-- timestamp with time zone <- date 타입에 time zone 정보까지 표현(time zone까지 저장할 수 있는 날짜 타입)
-- timestamp with local time zone <- 시간대를 자동으로 정규화시킴(시간대를 오는 지역에 맞게 자동으로 맞춰줌), time zone 표현 없음
--                                   서버(한국)와 클라이언트(싱가폴)에서 보는 시간이 제각각!

select sysdate, systimestamp, current_date, current_timestamp, localtimestamp
from dual;
-- sysdate <- date 타입의 형식(nls_date_format)
-- systimestamp <- 초 이하 9자리(timestamp 타입), time zone 표시

-- current_date <- sysdate와 같은 형식으로 표시(date 타입)
-- current_timestamp <- 지역 이름 표시(instead of time zone) <- systimestamp와 비슷
-- localtimestamp <- time zone 없음(timestamp(9) 표시), 세션의 시간을 timestamp 형식으로!

-- current_date, current_timestamp, localtimestamp <- time zone의 영향을 받음(클라이언트 시간대)

-- ex. 한국 서버를 이용하지만, 클라이언트가 싱가폴에 거주하고 있는 경우
-- sysdate, systimestamp <- 서버의 시간(오라클 DB가 인식)
-- current_date, current_timestamp, localtimestamp <- 클라이언트의 시간대(session의 시간대)

alter session set time_zone = '+08:00'; -- 싱가폴 시간
-- sysdate, systimestamp 동일(서버 시간)
-- current_date, current_timestamp, localtimestamp 바뀜(클라이언트 시간)
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss.sssss'), 
systimestamp, 
to_char(current_date,'yyyy-mm-dd hh24:mi:ss.sssss'), 
current_timestamp, 
localtimestamp
from dual;
-- sysdate와 current_date도 다른 값(시간 정보만 안 보일 뿐)
-- 다른 시간대의 고객들을 상대해야 할 때 이용(ex. 뉴욕과 샌프랜시스코)
-- 클라이언트의 시간과 더불어, time zone의 정보까지 넣어줌!(ex. 10:00 am +09:00) <- timestamp with time zone(current_timestamp)
-- (current_date에도 time zone 정보가 들어감)
-- 시간대를 정규화시키는 과정 필요 <- timestamp with local time zone(localtimestamp)
-- timestamp with time zone, timestamp with local time zone <- 글로벌 기업, 미국 기업에서 많이 씀(지사의 time zone 저장)
-- timestamp with local time zone(localtimestamp) <- 시간대 자동 정규화(보는 지역에 맞게 자동으로 맞춤), 세션의 시간으로 리턴해주되 timestamp 형식으로
--                                                <- 서버(한국)와 클라이언트(싱가폴)에서 보는 시간이 제각각!

alter session set time_zone = '-05:00'; -- 뉴욕 시간
select sysdate, systimestamp, current_date, current_timestamp, localtimestamp
from dual;
    


-- 기간을 명시하는 date 타입 (ex. 3년 보증, 2년 보증)
interval year to month -- 연수, 개월수 only
interval day to second -- 일, 시분초 이하 9자리까지의 기간 명시 가능
-- 날짜 + 날짜 <- 보통 오류
-- 하지만 interval year to month 타입은 오류 안 뜸

-- 형변환 함수
to_yminterval() -- char 타입을 interval year to month 타입으로 바꿔줌
to_dsinterval() -- char 타입을 interval day to second 타입으로 바꿔줌
-- 기간 명시할 수 있는 타입! 

select sysdate + to_yminterval('10-02') from dual; -- sysdate에 10년 2개월을 더함(10-02)
                                                   -- char 타입인 '10-02'가 interval year to month 타입으로 변함
                                                   -- "날짜 + 날짜"임에도 오류 안 뜸
select sysdate + to_yminterval('00-300') from dual; -- 오류! (연수, 개월수 생각해가며 입력해야!) 
select sysdate + to_yminterval('10-00') from dual; -- +10년
select sysdate + to_yminterval('01-00') from dual; -- +1년
select sysdate + to_yminterval('00-10') from dual; -- +10개월
select sysdate + to_yminterval('00-12') from dual; -- 오류! (01-00으로 입력!)
select sysdate + to_yminterval('01-12') from dual; -- 오류! (02-00으로 입력!)

select sysdate + to_dsinterval('100 10:00:00') from dual; -- 100일 10시 00분 00초
select sysdate + 100 + 10/24 from dual; -- 100일 10시간 plus(위와 같은 결과 but 번거로움)



-- extract( from ) <- numeric 타입으로 리턴값 추출
select to_char(sysdate,'yyyy') from dual; -- 날짜에 연도만 추출
                                          -- date도 물리적으로는 numeric 형식으로 저장됨(그래서 연산이 가능한 것)
                                          -- to_date(): 날짜 형식으로 입력, 조회
                                          -- to_char(): 날짜에서 일부분(ex. 연도) 추출 <- 리턴값은 "char형"
select extract(year from sysdate) from dual; -- to_char()처럼 일부분 추출 but 리턴값이 "numeric 타입!!!"
                                             -- 계산할 때 형 바꿀 필요 없음
select extract(month from sysdate) from dual;
select extract(day from sysdate) from dual; -- "일" 추출(요일 아님)
select extract(hour from sysdate) from dual; -- 오류! (sysdate의 "리턴값"에 시분초가 없기 때문, sysdate 내부적으로 보유하는 거와는 상관 없음)
select extract(hour from localtimestamp) from dual;
select extract(minute from localtimestamp) from dual;
select extract(second from localtimestamp) from dual;

select extract(timezone_hour from systimestamp) from dual; -- 타임존의 시간대 ex. 한국: +09:00, 뉴욕: -05:00
select extract(timezone_minute from systimestamp) from dual;
select extract(timezone_hour from current_timestamp) from dual;
select extract(timezone_minute from current_timestamp) from dual;

alter session set time_zone = 'Asia/Seoul';

select extract(timezone_region from current_timestamp) from dual;
select extract(timezone_abbr from current_timestamp) from dual;

select * from v$timezone_names; -- 각 time zone의 name ex. Asia/Seoul - KST

-- 서머타임은 지역 종속



-- NULL 관련 함수
-- nvl(), nvl2(), coalesce() <- NULL값을 다른 값으로 대체하는 함수
-- nullif() <- NULL값을 만드는 함수

-- nvl() <- NULL값을 다른 값으로 대체하는 함수
-- nvl2(A,B,C) <- A가 NULL이 아니면 B 실행, A가 NULL이면 C 실행
--             <- nvl()과는 달리, 인수의 type을 일치시키지 않아도 됨
--             <- 하지만 두번째(B)와 세번째(C)는 일치시킬 것! 
-- coalesce() <- 인수의 개수가 고정 안 됨, NULL값이 적용되지 않는 인수를 계속 찾아감
--               (첫번째가 NULL이면 두번째 수행, 두번째가 NULL이면 세번째 수행 ... 끝까지 대체 안 되면 그냥 NULL)
--               맨 마지막에 상수를 입력하면, 끝까지 대체 안 되도 NULL 안 나오고 그 상수값이 나옴
--               nvl()을 좀 더 일반화시킨 함수
select last_name, salary, commission_pct, 
(salary*12) + (salary*12 * commission_pct)
from employees;
select last_name, salary, commission_pct, 
(salary*12) + (salary*12 * nvl(commission_pct,0)) -- nvl()의 2개의 인수 type을 일치! 
from employees;

select employee_id, nvl(to_char(commission_pct),'no comm') -- char형으로 변환
from employees;

select employee_id, 
       nvl2(commission_pct, (salary*12)+(salary*12*commission_pct), salary*12) 
from employees;
-- nvl2(A,B,C) <- A가 NULL이 아니면 B 실행, A가 NULL이면 C 실행

select employee_id, 
       nvl2(commission_pct, (salary*12)+(salary*12*commission_pct), salary*12),
       coalesce((salary*12)+(salary*12*commission_pct),salary*12,salary) -- 3개의 인수(NULL 값이 아닌 걸로 계속 대체함!)
from employees;

select employee_id, 
       nvl2(commission_pct, '(salary*12)+(salary*12*commission_pct)', 'salary*12'), -- 리터럴 문자('') 
                                                                                    -- <- 문자열로 대체됨! 
                                                                                    -- <- 모든 인수의 type을 일치시킬 필요는 없음! 
       coalesce((salary*12)+(salary*12*commission_pct),salary*12,salary) 
from employees;



-- nullif(A,B) <- NULL 값을 만드는 함수
--             <- 첫번째 인수값(A)과 두번째 인수값(B)이 일치하면 NULL, 
--             <- 일치하지 않으면 첫번째 인수값(A) 리턴
select employee_id, nullif(length(last_name),length(first_name))
from employees;

/* if a=b then
            null;
   else
            a;
   end if;
*/



-- NULL값 조회 <- IS NULL // IS NOT NULL
select *
from employees
where commission_pct is null; -- null값이 포함된 row들만 추출

select *
from employees
where commission_pct is not null; -- null값이 없는 row들만 추출



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




-- 막대 그래프(*)
select last_name, salary, rpad(' ',trunc(salary/1000)+1,'*') star
from employees
order by salary desc;

select 24*60*60
from dual; -- 86400초

select to_date('20180530 00:00:00.00000','yyyymmdd hh24:mi:ss.sssss')
from dual; -- 입력값: 우리 눈에는 시간처럼 보이지만, 실제로는 char 타입!

select to_date('20180530 23:59:59.86399','yyyymmdd hh24:mi:ss.sssss')
from dual; -- 하루의 끝(range scan할 때 초 단위 주의!) <- Time Series!!

-- to_date(): 문자 날짜를 입력하면 그걸 날짜로 변환
-- date: 초 단위를 5자리 이상 못 넘어감
-- timestamp: 9자리까지 표현



-- to_timestamp(): 입력값(날짜처럼 보이는 char 타입)을 timestamp로 변환하는 함수
-- ss.ff
select to_timestamp('20180530 11:16:00','yyyymmdd hh24:mi:ss')
from dual; -- 초 단위가 소수점 9자리까지 표현

select to_timestamp('20180530 11:16:0','yyyymmdd hh24:mi:ss.s')
from dual; -- 오류! 

select to_timestamp('20180530 11:16:0','yyyymmdd hh24:mi:ss.ff')
from dual; -- timestamp는 초 단위의 소수점 이하 부분에 ff라고 표기 <- 9자리로 표현됨

select to_timestamp('20180530 11:16:00.123','yyyymmdd hh24:mi:ss.ff')
from dual; -- 9자리로 맞춰짐

select to_timestamp('20180530 11:16:00.000000000','yyyymmdd hh24:mi:ss.ff')
from dual;

select to_timestamp('20180530 11:16:00.999999999','yyyymmdd hh24:mi:ss.ff')
from dual; -- 소수점 이하를 9자리 이상으로 입력하면 오류 뜸! 

select to_char(systimestamp, 'ss.ff') -- systimestamp에서 초 단위만 추출(리턴값은 char 타입)
from dual; -- 소수점 이하 6자리로 출력됨

select to_char(systimestamp, 'ss.ff2') 
from dual; -- 소수점 이하 2자리

select to_char(systimestamp, 'ss.ff9') 
from dual; -- 소수점 이하 9자리

select to_timestamp('20180530 11:16:00.000000000','yyyymmdd hh24:mi:ss.ff3')
from dual; -- 여기서는 소수점 이하 자리수 지정할 수 없음! (그대로 9자리로 나옴)



-- rr 타입
-- 세기 구분! 
select to_date('95-10-27','rr-mm-dd') from dual; -- rr: 21세기 <- 1995년의 정보가 포함됨! 
                                                 -- 세기 정보 반영

select to_date('95-10-27','yy-mm-dd') from dual; -- yy: 20세기 형식(storage 문제로 세기 구분 안 함)
                                                 -- 2095년의 정보(미래 시점으로 뒤바뀜)
                                                 -- 현재 연도를 기준으로 현재의 세기 반영! 

select to_char(to_date('95-10-27','rr-mm-dd'),'yyyy') from dual; -- 1995년 리턴

select to_char(to_date('95-10-27','yy-mm-dd'),'yyyy') from dual; -- 2095년 리턴

-- # RR 타입
--                                지정된 연도(DB에 저장 ex. hire_date)
--                                   0~49                                  50~99
-- 현재연도(조회 시점) 0~49    반환 날짜는 현재세기를 반영               반환날짜는 이전 세기를 반영
--                  50~99    반환 날짜는 이후세기를 반영               반환날짜는 현재 세기를 반영

-- 현재연도       데이터입력날짜(지정된 연도)          RR(위의 표 참조)                                      YY(현재연도의 세기 <- 고정!)
--  1994년         95-10-27                      1995년(현재세기)                                      1995년(현재연도가 20세기니까 20세기로 리턴)
--  1994년         17-10-27                      2017년(현재연도 50~99, 지정연도 0~49 <- 이후세기!)      1917년(현재연도의 세기 반영!)
--  2001년         17-10-27                      2017년(현재세기)                                      2017년(현재세기)
--  2048년         52-10-27                      1952년(이전세기)                                      2052년(현재세기)
--  2051년         47-10-27                      2147년(이후세기)                                      2047년(현재세기)

-- 결론: RR타입이 세기 문제를 온전하게 해결한 거 아님! <- yyyy 4자리 꼭 입력해서 세기 표현하기! 

select to_date('20180530 10:00:00.36000','yyyymmdd hh24:mi:ss.sssss')
from dual; -- 임의의 값을 넣고 싶은 경우 <- 시간(10:00:00)을 초 단위로 환산해서 입력! 
           -- 00.36000 중 . 이후의 부분은 10:00:00를 "초"로 환산한 부분! (소수점이 아님)
           -- . 이후에 아무 값이나 입력하면 안 됨! 
select to_date('20180530 00:00:01.00001','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:00:02.00002','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:00:10.00010','yyyymmdd hh24:mi:ss.sssss')
from dual;
select to_date('20180530 00:01:00.00060','yyyymmdd hh24:mi:ss.sssss')
from dual;



-- 조건 제어문 <- select문에서는 못 씀. 함수로 제공! 
-- 기본형) nvl()
-- if 조건 평가 then
--             참값
-- end if;

-- 1) nvl2()
-- if 조건 평가 then
--             참값1;
-- else
--             기본값1;
-- end if;

-- 2) coalesce()
-- if 조건 평가 then
--             참값1;
-- else if 조건 평가 then
--             참값2;
-- else if 조건 평가 then
--             참값3;
-- else
--             기본값1;
-- end if;

-- 조건에 부합되지 않는데 else절이 없는 경우 <- NULL



-- 조건부 표현식(함수)
-- decode(<- 함수), case(<- 표현식) <- 실제로는 case도 함수! 
-- 중첩 가능!
select last_name, job_id, salary
from employees;

select last_name, job_id, salary -- job_id 별로 구분 <- select문에서는 無理
from employees;

-- ex. job_id가 IT_PROG면 급여 인상
select last_name, job_id, salary, -- decode(기준값, 비교값, 참값) <- 여기까지가 필수!
decode(job_id, 'IT_PROG', salary*1.1) -- 비교할 때는 대소문자 구분! 
from employees;
-- if 기준값 = 비교값 then
--                  참값
-- end if;



-- decode() 함수
-- 조건문 만들 때, 기준값과 비교값이 같다(=)는 조건 밖에 못 만듬
-- 단일행에 그룹함수 못 넣음!
select last_name, job_id, salary, -- decode(기준값, 비교값1, 참값1, 비교값2, 참값2, ...)
decode(job_id, 'IT_PROG', salary*1.1,
               'ST_CLERK', salary*1.15,
               'SA_REP', salary*1.20) -- 참값으로 여러 개 동시 설정 가능(하나의 컬럼!)
                                      -- 비교값, 참값은 들여쓰는 습관 가지기!(알아보기 편하게)
from employees;

select last_name, job_id, salary, -- decode(기준값, 비교값, 참값, ..., else값)
decode(job_id, 'IT_PROG', salary*1.1,
               'ST_CLERK', salary*1.15,
               'SA_REP', salary*1.20,
               salary) -- 맨 마지막에 else!
                       -- decode()는 row마다 작동됨(여기서는 총 4번)
from employees;



-- case 표현식 <- 더 편함! 
-- = 뿐만 아니라 다른 연산자도 만들 수 있음

-- = 연산자
select last_name, job_id, salary, 
       case job_id
            when 'IT_PROG' then salary*1.1 -- case는 괄호 열고 닫지 않음! comma도 안 씀! 
            when 'ST_CLERK' then salary*1.15
            when 'SA_REP' then salary*1.20
            else salary
       end 
from employees;

-- = 이외의 비교 연산자
select last_name, salary,
       case 
           when salary < 5000 then 'low' -- 다른 연산자(>,<,in,between and)를 사용할 경우, 기준값을 아예 when절에 넣음
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
       end "Salary Level" -- ALIAS 별칭
from employees;

select last_name, salary, commission_pct, 
       case 
            when commission_pct is not null then (salary*12) + -- or를 통해 조건 여러 개 표현 가능
                 (salary*12*commission_pct)
            else
                 salary * 12
       end ann_sal
from employees;

------------ 지금까지 배운 함수들 <- 단일행 함수(행단위로 조작되는 함수) -------------

-- cf. 그룹 함수: 그룹 당 조작(여러 행을 한꺼번에 처리)



-- 단일행함수: 문자함수, 숫자함수, 날짜함수, 형변환함수, NULL관련된 함수, 조건표현식 함수
-- 그룹함수: max(), min(), sum(), avg(), count(), variance(), stddev()



-- 최대값 max <- 입력값에 꼭 number 타입이 들어갈 필요는 없음
-- 최소값 min
-- scatter plot 계산할 때 많이 씀(평균을 기준으로 해서 흩어지는 정도 <- range!)
select max(salary), min(salary) from employees;
select max(hire_date), min(hire_date) from employees; -- date 타입
select max(last_name), min(last_name) from employees; -- char 타입

select max(salary), min(salary), 
       max(hire_date), min(hire_date), 
       max(last_name), min(last_name) 
from employees
where department_id = 50; -- 처리순서: from - where - select



-- count() <- 행의 수를 구함
select count(*) from employees; -- table에 포함된 모든 row들의 수(NULL 포함)
                                -- full scan, DBA도 모르게 index 사용
                                -- transforming(입력값 *을 이 table 안에 있는 primary key로 자동으로 바꿈! <- indexing)
select count(employee_id)       -- PRIMARY KEY <- 위의 select문과 같은 scan 방식 사용!
                                -- Deep Learning <- 자동 tuning(악성 코드를 찾아서 자동으로 변환)
from employees;
select count(commission_pct) -- NULL값을 포함한 row들은 제외(위와 값이 다름)
from employees; 

select count(department_id) -- NULL값을 포함한 row들은 제외(위와 값이 다름)
from employees; 

select count(distinct department_id) -- 중복값 제거
from employees;



-- max(), mean(), count() <- 타입 영향 안 받음
-- sum(), avg() <- 입력값으로 무조건 numeric을 써야! (char, date 안 됨)



-- sum(): 합
select sum(salary) -- NULL값을 자동으로 제외시키고 합을 구함
from employees;

select sum(salary) 
from employees
where department_id=50; 



-- avg(): 평균
-- 자료의 중심 위치를 표현하는 대표값 측정(평균 mean, 중앙값 median, 최빈값 mode)
-- median <- SQL에서 제공 안 함(R과 연동해야 함!)
-- mean <- avg() // mode <- count()
select avg(salary) from employees; -- NULL값 제외하고 계산(전체 평균이 아님)
                                   -- 평균 계산 시 모집단을 대표하는 데에 문제가 생길 수 있음
-- ex. data: 10 30 NULL
-- 실제 평균 = (10+30)/3
-- SQL에서 계산되는 평균 = (10+30)/2
-- cf. 10 30 nvl(NULL,0)
-- SQL에서 계산되는 평균 = (10+30+0)/3
select avg(commission_pct) from employees;
select avg(nvl(commission_pct,0)) from employees; -- 바로 위의 구문과 결과값이 다름



-- variance(): 분산 variance <- 평균값으로부터 얼만큼 떨어져 있는지(흩어짐의 정도)
select variance(salary) from employees; -- NULL값은 자동으로 제외됨(모집단 대표성 떨어짐)



-- stddev(): 표준편차 standard deviation
select stddev(salary) from employees; -- NULL값은 자동으로 제외됨(모집단 대표성 떨어짐)



-- group by: 그룹별 계산 
select avg(salary) from employees; -- 전체 평균
select department_id, avg(salary) from employees group by department_id; -- 부서별 평균

select department_id, job_id, avg(salary) 
from employees 
group by department_id, job_id; -- 그룹함수(avg())에 포함되지 않은 컬럼들(department_id, job_id)은 모두 group by절에 표현되어야 함! 

select avg(salary) 
from employees 
group by department_id, job_id; -- select문에 포함 안 되어도 실행에는 문제 없음 
                                -- but 데이터 분석에 있어서 무의미함
                                
select department_id dept_id, job_id, avg(salary) 
from employees 
group by dept_id, job_id; -- 오류! (논리 상 처리 순서에 위배 <- group by절이 select문보다 더 먼저 실행)
                          -- 그룹함수에는 열 별칭 사용할 수 없음! 

select department_id dept_id, job_id, avg(salary) 
from employees 
group by department_id, job_id; -- group by절에는 컬럼명 그대로 표현해야 함! 

select department_id, sum(salary)
from employees
group by department_id; -- 부서별 총액 급여

select department_id, sum(salary)
from employees
where department_id!=10 -- where절: 행을 제한하는 절(group 함수의 결과를 제한하는 게 아님)
group by department_id; -- group by절은 where절 뒤에 와야!(where절이 먼저 수행됨)

select department_id, sum(salary)
from employees
where sum(salary)>100000 -- 오류!(논리 순서 상 group by절이 더 나중에 수행되기 때문)
                         -- group 함수의 결과를 제한할 수는 없음
group by department_id;



-- having절 <- where절 대신 사용, group 함수의 결과를 제한할 때 사용
select department_id, sum(salary)
from employees
having sum(salary)>100000 -- 그룹함수(sum())의 결과 제한
group by department_id;

select department_id, sum(salary)
from employees
group by department_id
having sum(salary)>100000; -- having절을 group_by절 뒤에 위치시켜도 상관 없음

select department_id, sum(salary)
from employees
where department_id in (20,30,40,50) -- where절과 having절을 혼용
group by department_id
having sum(salary)>1000; -- HASH GROUP BY 실행 <- 결과물이 정렬되서 나오지 않음

select department_id, sum(salary)
from employees
where department_id in (20,30,40,50) 
group by department_id
having sum(salary)>1000
order by department_id; -- order by절: 최종 결과를 가지고 sorting <- 오버헤드가 크지 않음



/*
실행 순서(GHO)

4. select department_id, sum(salary)
1. from employees
2. where department_id in (20,30,40,50) 
3. group by department_id
5. having sum(salary)>1000
6. order by department_id; <- 최종 결과를 정렬
*/



select max(avg(salary))
from employees
group by department_id;

select department_id, max(avg(salary)) -- 오류! 
                                       -- 그룹함수를 중첩하면 다른 컬럼을 넣을 수 없음
                                       -- 서브쿼리(select문 안에 또다른 select문) 사용해야!
from employees
group by department_id;



-- 행 단위로 제한할 때 having 쓰면 안 됨! 
select department_id, sum(salary)
from employees
where department_id in (10,20)
group by department_id; -- by index rowid scan

select department_id, sum(salary)
from employees
having department_id in (10,20)
group by department_id; -- full scan
                      -- having은 index에 상관없이 group by절, select절 다음에 실행
                      





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # JOIN

desc employees
desc departments

-- JOIN: 두 개 이상의 table에서 데이터를 가져오는 방법
-- 1:M 관계 <- 1쪽 집합(departments) vs. M쪽 집합(employees)
select last_name, department_name
from employees, departments; 
-- Cartesian Product
-- - Join 조건이 생략된 경우
-- - Join 조건이 잘못된 경우
-- - 첫번째 table의 모든 행이 두번째 table의 모든 행에 join된다



-- 해결 방법(유효한 join의 유형) <- where절: join 조건을 만듬!
-- 1. equi join(inner join, simple join, 등가 join)
-- 2. self join: 자기 자신의 table 대상 <- 자기 자신을 참조
-- 3. outer join(+) <- key값이 일치되지 않는 데이터(NULL)도 추출
-- 4. non equi join(비등가 join) <- range로 일치되는 걸 찾음! (between and)
-- 건수 검증(1쪽 집합, M쪽 집합) <- 튜플 개수가 모자라면 outer join 수행!



-- 1. equi join(inner join, simple join, 등가 join)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- column 정의의 모호성 해결(접두어!)
                                    -- table명 전체를 접두어로 쓰면 메모리 사용 증가!
                                    -- key값이 일치되는 데이터 추출 <- equi join
                                    -- 106건 추출(1건 누락 <- NULL값)
                                    -- join 조건 술어

-- cfi) semantic error
select last_name, department_name
from employees, departments 
where department_id = department_id; -- 양 쪽 table에 이 column이 존재 <- semantic

-- cfii) syntax error
selec last_name, department_name
from employees, departments 
where department_id = department_id;

-- cfiii) column ambiguously defined
select last_name, department_name
from employee, departments -- from절의 object들 체크
where department_id = department_id;

-- cfiv) column ambiguously defined
select last_nam, department_name
from employees, departments 
where department_id = department_id;

-- cfv) column ambiguously defined
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = department_id; -- column의 모호성
                                       -- from절에 d라고 지정했으니 써야! 

-- select문 수행하면 parsing 작업을 한다.
-- 순서 1. 문법 check(cfii)
-- 순서 2. column check(cfiii, cfiv)
-- 순서 3. 의미 분석(cfi)



-- 두 table의 연결고리가 없는 경우
desc locations
select *
from employees;
select *
from departments; -- dept_id는 중복성 없음, location_id는 중복성 있음
select *
from locations; -- location_id는 중복성, NULL값 없음 <- PRIMARY KEY

select e.last_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id; -- join 조건 술어
                                   -- 결과값이 제대로 나왔는지 항상 검증! 
                                   -- Key값, 데이터 품질 등등 <- 정제 작업
                                   
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id -- join 조건 술어
and e.department_id=10; -- 비join 조건 술어



-- join 조건 술어 vs. 비join 조건 술어
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id -- 비교하는 작업 <- 성능 나빠질 수 있음! 
and e.department_id=10;

select e.last_name, d.department_name
from employees e, departments d
where d.department_id=10 
and e.department_id=10; -- Cartesian Product
                        -- 바로 위의 구문과 실행 계획이 같음
                        -- 성능 향상을 위해 자동적으로 이 구문으로 전환! 
                        
-- 2. self join: 자기 자신의 table 대상 <- 자기 자신을 참조
select employee_id, last_name, manager_id
from employees;

select w.employee_id, w.last_name, m.employee_id, m.last_name
from employees w, employees m
where w.manager_id = m.employee_id; -- w: worker // m: manager
                                    -- 1건 추출 안 됨(NULL값)



-- SQL Command Line
-- l: 실행했던 구문 다시 보여줌
-- /: 이전 구문 다시 실행

-- Command Line 상의 열폭 조절 
-- <- col 컬럼명 format a20 
-- <- Developer는 자동으로 해줌!



-- 3. outer join(+) <- equi join의 제약 해결 가능! 
--                  <- key값이 일치되지 않는 데이터들도 추출
--                  <- (+): Oracle에서만 쓰임(다른 DBMS에서는 안 됨!)

-- cf) equi join <- e.department_id = d.department_id 제약에 위배되는 
--                  row들은 추출 안 됨
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- equi join(NULL값이 포함된 row들 제외)
                                         -- key값이 일치되는 데이터만 추출

select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- (+) <- NULL값이 있는 column
-- employees 테이블에 있는 데이터 모두 추출하고 싶으면, "반대 편에" (+) 입력! 
-- 어느 부서에도 소속되지 않는 사원들의 데이터까지 추출

select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- 유령부서들(departments)까지 추출! 
                                            -- 양쪽에 (+) 넣으면 안 됨!
                                            
-- outer join의 제약 <- 양쪽에 (+) 넣을 수 없음!
--                  <- 집합함수 사용!!



-- union 연산자
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
union -- set 연산자 <- 부하가 심함!(중복을 없애기 위해 sort 행위 발생) <- tuning!
select e.last_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- 두 query문의 실행 결과를 하나로 합침! 
-- union: 중복 제거
-- union all: 중복된 결과도 포함

select e.last_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+); -- (+)를 2번 넣어줌!
-- 3개의 table(e,d,l)을 join하는 경우
-- e와 d를 먼저 join하고, 그 결과물을 메모리에 저장해서, 그걸 l과 join
-- d와 l에 (+)를 넣어서 연결해야! 




-- F5 <- 위에서부터 한 번씩 수행

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
commit; -- DB에 영구히 저장

select * from job_grades;



-- 4. non equi join(비등가 join) <- range로 일치되는 걸 찾음! 
-- between and 연산자 사용
-- 정확한 값으로 일치되진 않지만, 범위적으로 일치하는 경우
select last_name, salary
from employees;
select * from job_grades; -- 두 table을 join <- key값으로 일치되는 column이 없음! 

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
and w.department_id = d.department_id(+); -- w와 m을 join하고, 그 다음 d를 join!

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
-- e.department_id, d.department_id, d.location_id <- M쪽집합
-- l.location_id <- 1쪽집합
-- M x 1 <- M개의 튜플! 
-- 건수 검증 <- 107개가 나와야 하는데, 실제로는 106개만 나옴
-- outer join!! 
order by 2,3;

select e.last_name, e.department_id, 
d.department_id, d.department_name, d.location_id, 
l.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+) 
-- e와 d를 먼저 join하고, 그 결과를 다시 l과 join
-- l.location_id에 또 (+) 넣어야 함!
order by 2,3;

------------------------------------------------------------------------------



-- ANSI Standard(문법 표준화!) <- 다른 DBMS에서도 통용
-- (JOIN 연산 <- 다른 table의 동일한 column명을 찾아보기) <- natural join

-- # Cartesian Product (의도치 않은 곱(N x M)) <- cross join
select last_name, department_name
from employees e, departments d;

select last_name, department_name
from employees e cross join departments d;



-- 1. natural join
--    - 두 테이블에서 이름이 같은 모든 컬럼을 기반으로 조인한다
--    - 장점: join 조건 술어 안 만들어도 됨
--    - 단점1: 동일한 컬럼명이 하나일 때만 제대로 작동됨
--    - 단점2: 동일한 이름을 가진 컬럼이 서로 다른 데이터 타입을 가지면 오류
select last_name, department_name
from employees natural join departments; -- join 조건 술어 따로 입력할 필요 없음!
                                         -- 추출된 튜플 수가 너무 적음!
                                         -- dept_id 이외에 manager_id까지 적용됨! 
                                         -- 동일한 컬럼명이 1개일 때만 사용하기!! 
                                         
select department_name, city
from departments natural join locations;



-- 2. join using절을 사용하는 join
--    join에 사용할 컬럼을 지정! 
--    using절의 컬럼이 어느 table에 지정된다고 접두어를 표현하면 안 됨!(모호성 해결 못함)
select last_name, department_id, department_name
from employees join departments 
using(department_id); -- join에 사용할 컬럼을 따로 지정

select e.last_name, department_id, d.department_name
from employees e join departments d
using(department_id)
where d.department_id=80; 

select e.last_name, e.department_id, d.department_name -- 오류!(접두어 쓰면 안 됨)
from employees e join departments d
using(department_id); 

select e.last_name, department_id, d.department_name
from employees e join departments d
using(e.department_id); -- 오류!(접두어 쓰면 안 됨)

select e.last_name, department_id, d.department_name
from employees e join departments d
using(department_id)
where department_id in (20,30); -- where 절에도 alias 별칭 접두어 쓰면 안 됨



-- 3. join on절을 사용하는 join <- from절에 사용!(where절이 아님)
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id; -- on절 기반!
                                      -- where절에 join 조건 술어 쓰면 안 됨
                                      -- where절은 행을 제한하는 절
                                      
select e.last_name, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e join departments d -- 3중 join은 안 됨
on e.department_id = d.department_id;

-- 3중 join
select e.last_name, d.department_name, l.city
from employees e join departments d 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id; -- e와 d를 먼저 join하고, 그 다음 l을 join

select e.last_name, d.department_name, l.city
from employees e join departments d 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where e.department_id in (20,30); -- where절은 행을 제한할 때만 씀!

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal
and j.highest_sal;

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.department_id = 20; -- on으로 join한 다음, where로 행 제한

select e.employee_id "Emp ID", e.last_name "Name", 
to_char(e.salary,'$999g999') "Salary", j.grade_level "Grade"
from employees e join job_grades j
on e.salary between j.lowest_sal and j.highest_sal
where e.department_id = 20
and e.salary > 10000;



-- oracle과 ansi 표준 비교
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



-- 4. left outer join, right outer join, full outer join <- from절에 사용!
select e.last_name, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e left outer join departments d -- M쪽 방향으로! 
                                               -- oracle의 (+)와 반대 방향!
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id; -- ansi는 union 쓸 필요 없음!! 
                                      -- cf) oracle은 양쪽에 (+) 못 씀
                                      -- 이게 union보다 성능이 더 좋음!!!



-- oracle과 ansi 표준 비교(3개의 table을 join)
-- oracle
select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);

-- ansi
select e.last_name, d.department_name, l.city
from employees e left outer join departments d
on e.department_id = d.department_id
left outer join locations l -- left outer 써야 d의 NULL 튜플도 추출 가능! 
on d.location_id = l.location_id; 



select *
from employees; -- 처음에는 50개의 행만 인출 <- 스크롤을 내릴 수록 그 수가 점점 늘어남
                -- 페이징 처리(건수 검증할 때는 count() 사용!)





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- subquery(서브쿼리)
-- 비교해야 될 값을 모를 때 씀

-- SQL문 안에 select문이 있는 query를 subquery라고 한다.

-- single row subquery(단일행 서브쿼리)
-- multiple row subquery(여러행 서브쿼리)
-- multiple column subquery(다중열 서브쿼리)

select job_id -- 여기서 해당되는 job_id 하나 추출
from employees
where employee_id = 141;

select job_id
from employees
where job_id = ?; -- 141번 사원의 job_id를 모르는 경우
                  -- 위의 구문을 실행한다음, 그 결과를 기억하고, 이걸 실행해야!
                  -- 이 두 구문을 하나로 수행 <- subquery



-- # 중첩 subquery(nested subquery)      
-- select문 안에 select문이 있는데, 
-- subquery 먼저 수행되고, 그 값을 이용해 main query 수행

-- single row subquery(단일행 subquery)의 유형 <- subquery에 의해 추출된 값이 하나! 
-- 단일행 subquery <- 비교 연산자도 단일행!(=, <, >, <=, >=, <>, !=, ^=)
select job_id
from employees
where job_id = (select job_id
from employees
where employee_id = 141); -- ? 안에 첫번째 구문을 그대로 집어넣음(괄호 표시)
                  -- () 안의 subquery 먼저 수행하고, 그 값을 이용해서 main query 실행
                  -- subquery가 먼저 실행되고, 그 다음 main query 실행! 
                  -- 순서가 다른 케이스도 존재! 

-- ex. 141번 사원보다 급여를 많이 받는 사원들의 튜플 추출                  
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

-- cf1. 중복 튜플
select *
from employees
where salary > (select salary
from employees
where last_name = 'King'); -- 오류!
                           -- 단일행 subquery 절이 될 수 없음(사내에 King 사원이 2명)
                           -- multiple row subquery 사용! 

-- cf2. column 수 일치                          
select *
from employees
where salary > (select job_id, salary -- 오류!(salary > job_id, salary)
from employees
where employee_id = 141); -- where절 좌우의 column 수를 맞춰야 함! 
                          -- multiple column subquery(다중행 subquery)

-- ex1. AND 연산                         
select *
from employees
where job_id = (select job_id
                from employees
                where employee_id = 141)
and salary > (select salary
              from employees
              where employee_id = 141); -- AND를 통해 subquery를 쭉 연결할 수 있음!

-- ex2. 그룹함수          
select *
from employees
where salary = (select min(salary)
                from employees); -- group function을 where절에 이용하려고 할 때!
                
-- ex3. having절
select job_id, avg(salary)
from employees
group by job_id -- group by절 순서 주의!
having avg(salary) = (select min(avg(salary)) -- having절에서도 subquery 사용!
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
                  
                           


-- multiple row subquery(다중 행 subquery)
-- 여러행 비교 연산자를 사용(in, not in, > any, < any, = any, > all, < all)

select d.department_name, e.last_name
from employees e join departments d
on e.department_id = d.department_id
where salary in (select min(salary) -- in 사용! (리턴값이 여러 행)
                 from employees
                 group by department_id); -- correlated subquery 이용해야! 



select salary
from employees
where job_id = 'IT_PROG'; -- 여러 개의 값 리턴



-- 여러 행들을 비교(any, all) <- group function과 같이 씀
-- any: OR의 범주(> any: 최소값보다 큼 // 
--               < any: 최대값보다 작음 // 
--               = any: in 연산자)
-- all: AND의 범주(> all: 최대값보다 큼 // 
--                < all: 최소값보다 작음 // 
--                = all: NULL <- 공집합!)



-- any: OR의 범주 
--      ex. {100,200,300} <- WHERE sal>100 OR sal>200 OR sal>300
--                        <- 이 세 범주 중에 하나만 포함되면 됨
--                        <- (최소값(100)보다 큰 거만 표현하면 됨) <- sal>100
--                        <- "> any": 최소값보다 큼
--      cf. WHERE sal<100 OR sal<200 OR sal<300
--          <- 최대값보다 작음!

-- 여러 행 "> any" = 단일 행 "> min()"
select *
from employees
where salary > any (select salary -- "> any" <- 여러 행 subquery 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary > (select min(salary) -- min()을 써서 단일 행으로 바꿈
                       from employees
                       where job_id = 'IT_PROG'); -- 바로 위 구문과 결과 같음
                                                  -- "> any" = "> min()"

-- 여러 행 "< any" = 단일 행 "< max()"                                   
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

-- "= any" = in 연산자                  
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



-- all: AND의 범주
--      ex. {100,200,300} <- WHERE sal>100 AND sal>200 AND sal>300
--                        <- 3개의 조건 모두 만족시켜야!(교집합) <- sal>300
--                        <- 최대값보다 크면 됨!

-- 여러 행 "> all" = 단일 행 "> max()"
select *
from employees
where salary > all (select salary -- "> all" <- 여러행 subquery 
                    from employees
                    where job_id = 'IT_PROG');
                    
select *
from employees
where salary > (select max(salary) -- max()를 써서 단일 행으로 변환
                       from employees
                       where job_id = 'IT_PROG');
                    
-- 여러 행 "< all" = 단일 행 "< min()"
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
where employee_id in ( -- OR 범주 <- NULL도 포함되서 계산
select manager_id
from employees
);

-- NAND(True + NULL = NULL) <- subquery에 NULL값 제거해줘야!
select *
from employees
where employee_id not in ( 
select manager_id
from employees
where manager_id is not null -- NULL값 제거!
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
-- 상호관련서브쿼리, 상관서브쿼리
-- 메인쿼리의 컬럼이 서브쿼리 안에 들어가 있는 경우
-- 지금까지 배웠던 건 중첩 서브쿼리(nested subquery)! 

select o.*
from employees o
where o.salary > (
select avg(salary)
from employees 
where department_id = o.department_id 
)
order by o.department_id;

-- 중첩 서브쿼리: 서브쿼리가 먼저 실행되고 그 다음에 메인쿼리가 실행되도 문제 없음
-- cf. 상관 서브쿼리: 서브쿼리를 먼저 수행할 수 없음(메인쿼리의 변수가 들어가 있기 때문)
-- correlated subquery는 main query부터 먼저 수행! 

-- # Correlated Subquery 수행 방식
-- 첫번째 row를 후보행으로 고정시키는 작업 수행
-- 첫번째 row의 해당 변수(department_id)가 후보값이 되서, 
-- subquery의 변수(o.department_id)에 들어감

-- Active Set(main query절의 결과 집합) 만듬
-- => 첫번째 row를 후보행으로 지정, 고정
-- => 후보행의 변수값을 subquery에 전달 
-- => 후보행값으로 인해 리턴된 값으로 main query의 where절 비교
-- => 두번째, 세번째, 네번째 row들을 후보행으로 만들어서 계속 값을 추출
-- 집계값을 main query절의 row의 수만큼 구함(row 수만큼 subquery 수행!)
-- <- CPU 성능 저하! <- Oracle이 알아서 transforming! 



-- # exists 'x'
-- boolean 연산자(True/False) <- 좌측에 column 쓰면 안 됨!

-- manager_id(기준) = o.employee_id 
select *
from employees o
where exists ( -- exists: boolean 연산자 <- true/false 리턴(양쪽에 변수 쓰면 안 됨)
select 'x' -- 문법 오류 방지용(다른 값 입력해도 됨)
from employees 
where manager_id = o.employee_id 
); -- 1쪽 집합(employee_id)을 이용해서 M쪽 집합(manager_id)에 비교 <- 성능 개선!
   -- 후보행 값(employee_id)이 manager_id에 존재하면, 
   -- 더 이상 manager_id값과 비교하지 않음 <- exists의 기능! 

-- cf. employee_id(기준) = manager_id
select *
from employees
where employee_id in ( 
select manager_id
from employees
); -- subquery의 M쪽 집합(manager_id)을 이용해서 1쪽 집합(employee_id)과 비교
   -- 데이터 끝까지 비교해야 함 <- 성능 저하



-- # not exists
-- 관리자가 아닌 사원(not in, is not null) <- not exists!
select *
from employees o
where not exists ( 
select 'x' 
from employees 
where manager_id = o.employee_id 
); -- not exists: 존재하지 말아야, 우리가 찾는 데이터
   -- 후보행을 쭉 검색해서 데이터가 있으면 다른 후보행을 비교함 <- not exists의 기능!
   -- Oracle이 is not null 구문에서 이걸로 주로 변환해서 수행



select * from employees where department_id = 30; 
select * from employees where department_id = 50; 



-- inline view: 가상테이블 <- subquery의 일종! 
-- 부분집합을 만듬으로서 CPU 이용 효율 높임! 
-- from절 안에 select문 집어넣음!
select e2.*
from (select department_id, round(avg(salary),0) avgsal from employees
      group by department_id) e1, -- 가상 테이블에 JOIN 이용
      employees e2
where e1.department_id = e2.department_id
and e1.avgsal < e2.salary;

-- cf. 기존의 방법
select o.*
from employees o
where o.salary > (
select avg(salary)
from employees e2
where department_id = o.department_id 
)
order by o.department_id; -- 모든 절을 반복해서 집계값(avg())을 구해야 한다
                          -- DBMS가 group by절을 멋대로 씀 <- CPU 낭비
                          -- JOIN을 이용하는 게 나음(가상 테이블 이용!)
                          -- INLINE VIEW: 가상 테이블! 
                          -- 알아서 위의 것으로 변환됨
                          


-- Inline View를 이용해 JOIN 할 데이터 양을 줄임!
select d.department_id, d.department_name, e.cnt
from departments d,
     (select department_id, count(*) cnt -- count(*)를 alias 별칭으로 지정해야!
     from employees
     group by department_id
     having count(*) < 3) e -- 3미만인 데이터만 뽑아내서 JOIN(부분집합) <- CPU 절약!
where d.department_id = e.department_id;

select d.department_id, d.department_name, count(*)
from employees e join departments d -- join 이용 
                                    -- <- 모든 데이터를 JOIN하기 때문에 CPU 낭비! 
                                    -- Inline View가 더 효율적!
on e.department_id = d.department_id
group by d.department_id, d.department_name -- group by절에 명시
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





-- multiple column subquery(다중 열, 다중 행 subquery)

-- 다중 열 subquery(비교해야 될 column이 여러 개!)
select *
from employees
where (manager_id, department_id) in 
(select manager_id, department_id from employees where first_name = 'John');

-- cf. 단일 열 다중 행 subquery
select *
from employees
where manager_id in (select manager_id from employees 
                     where first_name = 'John')
and department_id in (select department_id from employees 
                      where first_name = 'John'); -- 위와 다른 결과값!
                                                  -- 비교 방식 자체가 다름!
                      
-- 다중 열 <- 쌍비교 방식
-- 다중 행 <- 비쌍비교 방식

-- 다중 열(쌍비교)
-- (manager_id, department_id) <- 이 2개가 하나의 column처럼 묶여서 움직임(비교됨)
-- cf. 다중 행(비쌍비교)
-- manager_id AND department_id <- 각각의 목록을 따로 비교
-- 쌍비교에는 안 나오지만 비쌍비교에는 나오는 데이터가 존재!

select *
from employees
where (manager_id, department_id, job_id) in -- 3개의 변수에 대한 쌍비교
(select manager_id, department_id, job_id from employees 
                                          where first_name = 'John');
                                          


-- INLINE VIEW의 제약
select d.department_name, e.sumsal
from (select department_id, sum(salary) sumsal
      from employees
      group by department_id
      having sum(salary) > (select avg(sumsal)
                            from (select sum(salary) sumsal
                                  from employees
                                  group by department_id))) e, departments d
where e.department_id = d.department_id;
-- 부서별 총액(sum(salary))을 2번 집계하고 있음 
-- 동일한 결과 set을 2번 만들고 있음 <- CPU 낭비!
-- inline view는 기존의 결과 set을 다시 호출해서 쓸 수 없음! (제약)
-- WITH절을 이용해서 해결! 



-- WITH AS절 <- Oracle RDBMS에서만 제공
-- 복합 query문 안에서 동일한 select문을 두번이상 반복할 경우에 
-- 그 query block을 만들어서 사용하면 성능이 향상된다.
-- query block <- ex. dept_cost, avg_cost
-- 통신사의 billing 업무 시 많이 사용(Oracle RDBMS)

-- with 안에다 가상 테이블을 만듬
-- inline view의 제약(호출 불가능) 극복
with 
dept_cost -- dept_cost라는 가상 테이블을 만듬
as (select d.department_name, sum(e.salary) as sumsal -- sumsal: 가상 column
                                                      -- 여기서 as는 alias 아님!
    from employees e, departments d
    where e.department_id = d.department_id(+) -- equi join <- null값 제외!
                                               -- (+)를 입력해줘야! (outer join)
    group by d.department_name), -- 가상 테이블은 ,로 구분지음(dept_cost, avg_cost)
avg_cost as (select sum(sumsal)/count(*) as deptavg
             from dept_cost) -- 위의 가상 테이블(dept_cost) 호출 가능
                             -- (inline view는 불가능)
select *
from dept_cost
where sumsal > (select deptavg
                from avg_cost);
                
                
                
-- # 집합연산자(union, intersect, minus) <- 사용하지 않으면 않을 수록 좋음!
-- 합집합
-- 교집합 <- equi join
-- 차집합 <- not exists

-- 1. 구문들의 개수, 타입 일치시키기!
-- 2. union, intersect, minus는 자동으로 sort 수행(order by절이 추가된 거나 마찬가지)
-- 3. 여러 집합연산자 사용할 때는 괄호를 사용해서 구분하기
-- 4. order by절은 제일 밑에 표현하기!(order by의 컬럼명은 첫번째 query의 표현식을 씀)
--    헷갈리니까 위치 표기법(1,2)을 쓰는 습관을 가지기!
-- 5. union, intersect, minus는 가급적이면 쓰지 말기!
--    union <- union all + not exists
--    intersect <- exists
--    minus <- not exists



-- 합집합
-- union, union all + not exists
select employee_id, job_id -- 첫번째 결과 set
from employees
union -- 합집합이면서 중복된 데이터는 제거
      -- 자동으로 sort operation이 작동됨
      -- 정렬하면서 중복 체크
      -- 정렬하는 과정에서 CPU 낭비(성능에 영향)
      -- 정형 데이터를 다룰 때는 sorting 하지 않는 것이 좋음 <- union 사용을 자제하기!
select employee_id, job_id -- 두번째 결과 set <- 중복 제거!
from job_history;

-- cf. union all 
-- union = union all + not exists
-- union은 자동으로 sorting되기 때문에 성능 향상을 위해 union all + not exists를 쓰기!
select employee_id, job_id 
from employees
union all -- sort operation이 작동되지 않음 <- 중복 제거 안 함
select employee_id, job_id 
from job_history;

select employee_id, job_id 
from employees 
union all -- union을 쓰지 않고 union all + not exists로 해결 <- 중복 제거!
select employee_id, job_id 
from job_history j
where not exists 
(select 'x'
from employees
where employee_id = j.employee_id
and job_id = j.job_id); -- where절에 2개의 column들을 모두 넣어야 함!

-- union, union all의 규칙
-- 첫번째 select문의 column 개수, 타입(employee_id, job_id)을 
-- 두번째 select문의 그것들(employee_id, job_id)과 일치시키기!

select employee_id, job_id, salary -- 오류! (column의 개수가 안 맞음
                                   -- but job_history 테이블에는 salary가 없음
from employees
union all 
select employee_id, job_id 
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, null -- null을 이용해서 개수 맞춤!
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, 0 -- 0 넣어도 됨
from job_history;

select employee_id, job_id, salary 
from employees
union all 
select employee_id, job_id, x -- 오류! (타입이 안 맞아서)
from job_history;



-- 교집합
-- intersect, join, exists
select employee_id, job_id -- 첫번째 결과 set
from employees
intersect -- 이것도 sort 수행 <- 성능 저하
          -- join이나 exists 연산자를 사용해서 해결
select employee_id, job_id 
from job_history; -- 부서 이동을 여러 번해서 과거의 job으로 다시 돌아온 경우

select e.employee_id, e.job_id 
from employees e join job_history j
on e.employee_id = j.employee_id
and e.job_id = j.job_id; -- sort 안 함 <- 성능 문제 해결!

select employee_id, job_id 
from employees e
where exists 
(select 'x'
from job_history
where employee_id = e.employee_id
and job_id = e.job_id); -- sort 안 함 <- 성능 문제 해결!
                        -- 되도록이면 1쪽 집합을 M쪽 집합에 비교하기! (검색 속도 향상)
                        


-- 차집합
-- minus, not exists
select employee_id, job_id 
from employees
minus -- 이것도 sort operation 수행 <- 성능 저하 <- 쓰지 말기!
select employee_id, job_id 
from job_history; -- 부서 이동 이력에 있는 사원들 제거
                  -- 순수하게 첫번째 결과 set에 있는 것만 추출

select employee_id, job_id 
from employees e
where not exists 
(select 'x'
from job_history
where employee_id = e.employee_id
and job_id = e.job_id); -- 성능 향상!



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
AND d.location_id = l.location_id; -- 문제점 1. 정렬
                                   -- 문제점 2. countries 테이블 이용 반복
                                   --          <- not exists 연산자 사용!

SELECT country_id,country_name
FROM countries c
WHERE NOT EXISTS(
        SELECT 'x'
        FROM locations l , departments d
        WHERE d.location_id=l.location_id
        AND l.country_id = c.country_id); -- countries는 join할 필요 없음!!!
                                        -- countries 테이블을 한 번만 사용(tuning)

-- 2개의 부분으로 나뉨
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
from employees; -- 단점: employees 테이블을 4번 엑세스해야함!



-- rollup 연산자
-- group by 절에서 지정한 열 리스트를 오른쪽에서 왼쪽으로 
-- 한 방향으로 이동하여 그룹화를 만든다. (방향 못 바꿈)
select department_id, job_id, manager_id, sum(salary)
from employees
group by rollup(department_id, job_id, manager_id); 



-- cube 연산자
-- group by 절 지정된 가능한 모든 그룹화를 한다.
select department_id, job_id, manager_id, sum(salary)
from employees
group by cube(department_id, job_id, manager_id); 

-- group by rollup(a,b,c) <- 한 방향!
-- sum(sal) = {a,b,c}
-- sum(sal) = {a,b}
-- sum(sal) = {a}
-- sum(sal) = {} <- 전체 합

-- cf1. group by cube(a,b,c) <- 그룹 가능한 모든 조합!
-- sum(sal) = {a,b,c}
-- sum(sal) = {a,b}
-- sum(sal) = {b,c}
-- sum(sal) = {a,c}
-- sum(sal) = {a}
-- sum(sal) = {b}
-- sum(sal) = {c}
-- sum(sal) = {} <- 전체 합



-- cf2. grouping sets 연산자
-- 내가 직접 원하는 그룹을 만들 때 사용
select department_id, manager_id, job_id, sum(salary)
from employees
group by grouping sets((department_id, manager_id),
                       (department_id, job_id),()); -- 부분집합 일부 추출
                                                    -- () <- 전체 sum(salary)
                                                    


-- 계층검색
-- Tree 모양으로 query의 결과를 리턴
select employee_id, last_name, manager_id
from employees
order by 1;
-- 100번 사원을 기점으로 나뭇가지처럼 뻗어나감(manager - employee)
-- ex. 100번 -> 101번 -> 108번 -> 109번 -> 부하직원 없음 -> 다시 108번으로 올라감 ...
-- 계층적 검색 질의

select employee_id, last_name, manager_id
from employees
start with employee_id = 100
connect by prior employee_id = manager_id;

select employee_id, last_name, manager_id
from employees
start with employee_id = 101 -- 101번의 조직도만 프린트(primary key 이용!)
connect by prior employee_id = manager_id; -- 연결고리(top down)
-- 첫번째 단계: employee_id = 101에 해당되는 사원 리턴
-- 두번쨰 단계: 첫번째 employee_id를 manager_id로 삼고 있는 놈 리턴
-- 세번쨰 단계: 두번째 employee_id를 manager_id로 삼고 있는 놈 리턴
-- 만약 그 단계에 해당되는 값이 없으면 전 단계로 올라감

-- cf. prior를 다른 항으로 이동
select employee_id, last_name, manager_id
from employees
start with employee_id = 101
connect by employee_id = prior manager_id; -- (bottom up)
-- 101번 사원을 관리하는 manager(상관) 리턴

select employee_id, last_name, manager_id
from employees
start with employee_id = 109
connect by employee_id = prior manager_id;

select employee_id, last_name, manager_id
from employees
start with last_name = 'King' -- 중복값도 리턴(but 결과가 애매해짐)
connect by prior employee_id = manager_id;



-- level(가상 column)
select level, last_name -- 해당 데이터가 몇 번째의 계층에 속해 있는 지 보여줌!
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by 1;



-- depth
select level, lpad(' ', 2*level-2, ' ') || last_name -- 시각적으로 보기 쉽게 구분!
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by 1;

select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order by last_name; -- 계층이 다 깨짐

select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
order siblings by last_name; -- 계층이 어긋나지 않는 선에서 정렬



-- where절로 행 제한
select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
where employee_id != 101 -- start절 위에 where절 위치
                         -- 하나의 행만 제한되고 이 부하 직원은 그대로 나옴
start with employee_id = 100
connect by prior employee_id = manager_id
order siblings by last_name;

-- cf. connect에 딸린 and로 제한
select level, lpad(' ', 2*level-2, ' ') || last_name 
from employees
start with employee_id = 100
connect by prior employee_id = manager_id
and employee_id != 101 -- 이 경우에는 101번 밑의 조직도가 싸그리 없어짐
order siblings by last_name;





-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





/*
ㅁ유저생성

  ㅇ권한(privilege) : 특정한 SQL 문을 수행할 수 있는 권리
  
    -시스템권한 : DBMS에 영향을 줄 수 있는 권리
      CREATE USER : 유저를 생성할 수 있는 권한
      CREATE SESSION : 접속할 수 있는 권한
      CREATE (OBJECT) : (OBJECT)를 생성할 수 있는 권한
      ...
*/
select * from session_privs;  --시스템권한을 확인 : DBA가 개발자가 들어 올 때마다 권한을 부여하기 번거로워서 덩어리로 해놓고 부여하는 권한

select * from user_sys_privs; --DBA로 부터 직접받은 시스템권한 확인

select * from session_roles;  --DBA로 부터 받은 ROLE에 대한 정보 확인
                              --ROLE : 권한을 편리하게 관리하기위한 객체/권한의 집합

select * from role_sys_privs; --각각의 ROLE 안에 들어있는 권한 확인
/*
    -객체권한 : 객체에다가 영향을 줄 수 있는 권리
*/
select * from user_tab_privs; --내가 받은 객체권한과 내가 부여한 객체권한에 대한 정보를 확인
                              --Ex) SYS로 부터 EXCUTE(통계)권한을 받았다.

select * from role_tab_privs; --내가 받은 ROLE 안에 들어 있는 객체권한에 대한 정보를 확인
/*
(DBA 계정)

    -DBA에서 확인방법
      접속 -> 초록 +
      접속 이름 dba
      사용자 이름 sys
      비밀번호 oracle
      롤 SYSDBA
*/
select * from session_privs;  
select * from dba_sys_privs;  --시스템권한을 어떤 유저에게 부여했는지 정보
select * from dba_tab_privs;  --객체권한을 어떤 유저한테 부여했는지 정보
select * from dba_roles;       --DB에 ROLE에 대한 정보
select * from dba_role_privs; --ROLE을 어떤 유저한테 부여했는지 정보
/*
      SQL> conn sys/oracle as sysdba

  ㅇ물리적 저장공간 정보 확인
  
    -DB에 생성되어 있는 유저 정보 확인
      Ex) HR의 DEFAULT_TABLESPACE USERS : HR은 USERS에 테이블을 생성한다.
(DBA 계정)
*/
select * from dba_users;
/*
    -TABLESPACE 정보 확인
      SYSTEM, SYSAUX, UNDO, TEMP 필수
      TEMP : 
      UNDO : 이전 값을 저장해 놓은 공간
      STSTEM : 지금까지 SELECT해서 본거 다 저장되어 있음 
      SYSAUX : 스스로 튜닝하기 위해서 악성 코드들을 
*/
select * from dba_tablespaces;--tablespace 정보를 확인
/*
    -물리적인 저장공간 정보 확인
      Ex) USERS의 FILE_NAME
      DATABASE(논리적)              OS(물리적)
      tablespace      (1 : m)      data file
      segment(table)
      extent
      block           (1 : m)      os block(대부분512byte)
*/
select * from dba_data_files;
/*
    -예제 : HR 계정의 물리적 저장공간을 확인해보자.
(HR 계정)
*/
select * from user_tables;      --HR의 TABLESPACE는 USERS임을 확인한다.
/*
(DBA 계정)
*/
select * from dba_data_files;   --DBA에서 USERS의 물리적 저장공간을 확인할 수 있다.
/*
  ㅇ유저생성
  
    -SYS계정에서 유저생성
(DBA 계정)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -유저수정
*/
alter user olap
identified by oracle          --바꾸고 싶은 절만 넣으면 된다.
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -권한부여
*/
select * from dba_users;
select * from dba_ts_quotas;
/*
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap;                         --권한 부여하는 방법

select * from dba_sys_privs where grantee = 'OLAP';   --권한 부여한 정보를 확인하는 방법
/*
SQL> conn olap/oracle
Connected.
SQL> select * from session_privs;
*/
revoke create session from olap;                      --권한을 회수하는 방법
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

      테이블을 생성하려면 두가지 권한이 필요하다.
      1.시스템권한 : CREATE TABLE

SQL> select * from session_privs;

      2.tablespace를 사용할 수 있는 권한(저장공간)
*/
select * from user_ts_quotas;
grant create table to olap;
/*
SQL> select * from session_privs;
SQL> select * from user_users;
/*
(olap 계정)
    -
      접속 -> 초록 +
      접속 이름 olap
      사용자 이름 olap
      비밀번호 oracle
      롤 default

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
ㅁINSERT
  ㅇ새로운 ROW를 저장하는 명령문
*/
desc emp

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));
select * from emp;

rollback;

select * from emp;    --insert는 했지만 영구저장한 것은 아니기 때문에 취소할 수 있다.

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));

select * from emp;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --영구히 저장하지 않았기 때문에 볼 수 없다.
*/
commit;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --영구히 저장했기 때문에 볼 수 있다.

    -commit이든 rollback이든 하면 transaction은 종료된다.
*/
insert into emp(id, name, day)
values(2,'박찬호',sysdate);

select * from emp;
rollback;                  --박찬호에만 영향을 준다.

insert into emp(id, name, day)
values(2,'박찬호',sysdate);

select * from emp;
/*
    -NULL을 넣는 방법
*/
insert into emp(id, name, day)
values(3,'박지성',NULL);

commit;
/*
SQL> select * from emp;
*/
insert into emp(id, name)
values(4,'차두리');

select * from emp;

commit;

insert into emp
values(5, '손흥민', sysdate);

commit;
/*
ㅁ유저삭제
  ㅇSYS계정
*/
drop user olap;   --ERROR: 이미 실행중이거나 이미 오브젝트를 생성했을 경우

select * from v$session where username = 'OLAP';
/*
  ㅇSESSION KILL 방법
*/
alter system kill session '113,57' immediate;    --'SID값,SERIAL#'
alter system kill session '49,19' immediate;

drop user olap;
drop user olap cascade; -- object들까지 삭제해줌!
/*
      (다시 olap생성한다음 행 5개 부여)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;

grant create session to olap; 
grant create table to olap;
/*
      접속 -> 초록 +
      접속 이름 olap
      사용자 이름 olap
      비밀번호 oracle
      롤 default
*/
create table emp(id number(4), name varchar2(20), day date)
tablespace users;

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));
insert into emp(id, name, day)
values(2,'박찬호',sysdate);
insert into emp(id, name, day)
values(3,'박지성',NULL);
insert into emp(id, name)
values(4,'차두리');
insert into emp
values(5, '손흥민', sysdate);

select * from emp;

commit;
/*
ㅁ복제

(olap 계정)

  ㅇ테이블의 row 복제
*/
create table emp_new(id number(4), name varchar2(20), day date)
tablespace;

select * from emp;
select * from emp_new;
 
insert into emp_new(id, name, day)    --두 table의 뼈대가 똑같으면 ()생략해도 된다.
select * from emp;

select * from emp_new;

commit;

drop table emp_new purge;
/*
  ㅇ테이블의 구조와 row 모두 복제
*/
create table emp_new
as select * from emp;   --rollback소용없다. 지우고 싶으면 drop해야한다.

select * from emp_new;

commit;

drop table emp_new purge;
/*
  ㅇ테이블의 구조만 복제
*/
create table emp_new
as select * from emp where 1=2;   --1=2인 행이 존재하지 않아 row는 복제되지 않는다.

select * from emp_new;







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- 함수, 기능은 RDBMS마다 명칭들이 조금씩 다름



-- dba로 실행
select * from dba_users; -- Dictionary Table view(간접 액세스를 위한 view)
                         -- OBJECT_NAME: 실제 object 이름
select * from user$; -- Dictionary Table view 

-- 롤: 권한 관리 편리하게 하기 위한 하나의 object
--     권한이 들어있는 object
-- hr 계정으로는 sysdba롤 실행 못 함
-- 권한: 특정한 sql 문장을 수행할 수 있는 권리
-- priviledge

select * from dba_data_files; 
-- tablespace: DB 안의 논리적인 집합
-- file_name: tablespace가 저장되어 있는 물리적 구조
-- 실제 데이터는 다 디스크로 저장되어 있음(파일 구조)
-- binary 형식으로 되어 있어서 파일을 열어볼 수는 없음
-- system tablespace
-- SYSTEM file_ID: #1
-- SYSTEM tablespace 삭제하면 DB 전체가 날라감!
-- 그 외 성능을 관리하는 tablespace들을 나눠서 생성
-- UNDOTBS1 <- rollback 기능 수행
-- SYSTEM, UNDOTBS1, SYSAUX <- 이 3개는 필수!
-- USERS <- 필수는 아님, 교육 목적으로 만들어짐

select * from dba_temp_files;
-- sort(order by, 집합 연산, distinct, group by(이전 버젼))
-- <- 한정된 메모리로는 작업에 한계가 있음
-- <- 조각을 내서 디스크에 저장해야 함 <- temp files

select * from dba_objects where owner = 'HR'; -- hr은 문자로 저장되어 있음!
                                           -- hr유저가 관리하는 object 정보 확인가능
                                           
select * from dict; -- 우리가 볼 수 있는 dictionary table에 대한 정보

create user ora10 
identified by oracle; -- user id: ora10 // pw: oracle

select * from dba_users where username = 'ORA10'; -- 해당 row 추출
-- DEFAULT_TABLESPACE: 일반 user가 object를 SYSTEM tablespace에 생성하는 건 자제!

alter user ora10 default tablespace users;
-- alter user 유저이름 default tablespace 테이블스페이스이름;
-- DEFAULT_TABLESPACE의 정보를 SYSTEM에서 USERS로 바꿈

select * from dba_ts_quotas; -- 데이터 조작 시 공간이 없으면 오류 남!
alter user ora10 quota 1m on users; -- 공간 지정(quota값 조정) -- 1k, 1m, ...
                                    -- MAX_BYTES값 변경됨
alter user ora10 quota unlimited on users; -- MAX_BYTES가 -1로 설정됨
                                           -- -1: 무한이라는 뜻
                                           -- BYTES: 현재 사용하고 있는 바이트 수

alter user ora10 identified by ora10; -- pw 변경(oracle => ora10)

-- 계정을 만들었다고 해서 함부로 그 DB에 들어갈 수는 없음!
-- run command line 상에 conn ora10/ora10을 입력해도 오류!

grant create session to ora10; -- 권한 부여(run command line 상에 연결 가능)
select * from dba_sys_privs where grantee = 'ORA10';

alter user ora10 account lock; -- 계정 잠금(ACCOUNT_STATUS에서 LOCKED로 설정됨)
                               -- run command line 상에 연결 불가능
select * from dba_users where username = 'ORA10';

alter user ora10 account unlock; -- 다시 계정 품(ACCOUNT_STATUS에서 OPEN으로 설정됨)
                                 -- run command line 상에 연결 가능
select * from dba_users where username = 'ORA10';

/* run command line
create table test(id number); <- 오류!(create table에 대한 권한이 없기 때문)
                              <- 권한을 부여 받아야 함(grant) */
grant create table to ora10; -- 권한 부여는 dba 창에서만 수행!
select * from dba_sys_privs where grantee = 'ORA10';
-- # table 생성할 때 필요한 권한
-- 1. create table
-- 2. quota값(tablespace)
select * from user_ts_quotas;

/* run command line
create table test(id number); 
create table test_1(id number) tablespace users; <- 이렇게 tablespace를 지정해야!
                                                 <- 이렇게 안 하면 default로 저장됨
*/

-- 데이터를 저장하는 object는 table이다.
-- 테이블 이름, 컬럼의 이름 규칙, 유저이름, object 이름
-- - 문자로 시작
-- - 길이는 1~30자
-- - 영문자(대소문자 구분 안 함), 숫자, _, #, $
-- - 테이블명을 한국어로 만들 수는 있음(다른 나라에서는 못 만듬)
-- - 동일한 유저가 소유한 다른 객체의 이름과 중복되면 안 된다.
-- - 오라클 서버의 예약어는 사용할 수 없다. (ex. sysdate, select, ...)

-- 컬럼의 데이터 유형
-- varchar2(4000): 가변길이 문자데이터 최소값 1, 최대값 4000 <- 사이즈 표현 안하면 오류
-- char: 고정길이 문자데이터 최소값 1, 최대값 2000 <- 사이즈 표현 안하면 최소값(default)
-- number(p,s): 숫자 자릿수가 p이고 소숫점 이하 자릿수가 s
--              p는 자릿수 1~38, 자릿수 표현 안 하면 가변으로 설정됨!
-- date: 날짜 데이터 타입
-- long: 가변 문자 데이터, 최대 2G <- clob으로 대체
-- clob: 가변 문자 데이터, 최대 4G
-- blob: 이진 데이터, 최대 4G <- image file
-- bfile: 외부 파일에 저장된 이진 데이터, 최대 4G
create table emp
(id number(4),
name varchar2(10),
day date default sysdate
)
tablespace users;

-- ora10으로 수행

-- # 삽입
insert into emp(id,name,day)
values(1,'홍길동',to_date('2018-06-10','yyyy-mm-dd'));

select * from emp;
-- command line에서는 안 나옴(세션이 다르기 때문)
-- commit을 실행해서 디스크에 저장해야 함!(commit 하면 취소 못 함!)
commit; -- transaction

insert into emp(id,name,day)
values(2,'박찬호',default); -- default값 넣음
select * from emp;

insert into emp(id,name)
values(3,'박지성'); -- day 부분에 자동으로 default값이 들어감
                   -- (하지만 되도록이면 위의 방법을 이용하기)
select * from emp;

insert into emp(id,name,day)
values(4,'차두리',null); -- null이 default보다 우선 순위
select * from emp;

insert into emp(id,name,day)
values(5,default,default); -- name에 null값이 들어감
select * from emp;

commit; -- 이 시점까지의 모든 변경 사항 영구히 반영

-- # 수정
update emp
set day = sysdate - 10; -- 모든 row들이 업데이트됨
select * from emp; -- 이전 값들은 undo에 임시로 가지고 있음 <- rollback에 대비

rollback; -- 이전 값으로 되돌아옴

update emp
set day = sysdate - 10
where id = 4; 
select * from emp;

commit;

update emp
set name = '손흥민'
where id = 5; 
select * from emp;

commit;

insert into emp(id, name, day)
values(6,null,null);
commit;
select * from emp;

update emp
set name = '나얼', day = default -- 여러 필드값 수정 <- ,로 구분
where id = 6;
select * from emp;

commit;

delete from emp;
select * from emp; -- 모든 row들이 삭제됨

rollback;

delete from emp 
where id = 6;
select * from emp;
-- insert, delete: row 단위 조작
-- update: 필드 단위 조작

commit;

-- transaction: 논리적으로 DML을 하나로 묶어 처리하는 작업 단위
-- commit, rollback
-- savepoint a, savepoint b: rollback을 도와주는 기능(commit은 해당되지 않음)
-- savepoint a를 2번 표시하면, 이전의 것은 무시됨
-- savepoint a, savepoint b ~ rollback to b <- savepoint b 밑의 transaction만 취소
--                                          <- 위의 부분은 취소 안 됨
-- ~ commit <- savepoint와 rollback to를 반영한 다음 결과를 저장

select * from emp;
delete from emp where id = 5;

create table emp_new
(id number, name varchar2(20), day date)
tablespace users; -- commit을 하지 않았는데도 트랜잭션이 종료됨(위의 변경 사항이 반영됨)
                  -- autocommit(나도 모르게 commit 발생)
                  -- create 안에 commit 기능이 숨어 있음 <- 앞의 트랜잭션에 영향
rollback; -- 롤백해도 소용 없음

-- # autocommit이 발생하는 경우
-- 1. DDL, DCL 문장을 수행하는 경우 <- DDL, DML, DCL은 같은 공간에서 작업하면 안 됨!
-- 2. 정상적인 종료(exit 입력)를 했을 때
-- 3. 다른 세션으로 connect를 수행할 때 <- ex. conn ora10/ora10 => conn hr/hr

-- cf. 자동 rollback이 발생할 때
--     자동 rollback하게 되면 변경 사항이 디스크에 반영되지 않음
--     autocommit만 주의하면 됨!
-- 1. 비정상적인 종료가 발생할 때(ex. 창닫기, PC 종료, 네트워크 장애)

select * from hr.employees; -- hr 사용자가 가지고 있는 table을 검색하려고 함
                            -- 하지만 오류 뜸
                            -- table이 없는 게 아니라 권한을 받지 않은 것
                            -- table 소유자로부터 항상 권한을 부여 받아야 함
select * from user_tab_privs; -- 받은 권한이 없음! (이 구문으로 확인하기)
                              -- object 소유자, DBA가 권한 부여
                              -- hr한테 권한 받으면 목록에서 체크 가능
                              
select * from hr.employees; -- hr 사용자가 grant를 통해 권한 부여하면 볼 수 있음
select * from hr.departments;
select e.last_name, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id;

-- # insert subquery
insert into emp(id,name,day)
select employee_id, last_name, hire_date
from hr.employees
where department_id = 30; -- 다른 사용자(hr)의 table에 필드값 입력
                          -- 30번 부서 사원들의 정보를 table에 입력
                          -- 변수들의 수와 타입 일치시켜야!
                          -- transaction 발생!
rollback;

select * from emp;
commit;

-- # as subquery <- create, insert문 이용할 때 subquery 쓸 수 있음
create table emp_copy
as select * from hr.employees where 1 = 2; -- table의 뼈대만 복제(1=2 <- false)

select * from emp_copy; -- no data

insert into emp_copy -- employees 테이블의 데이터 복제
select * from hr.employees;
rollback;

-- department 테이블의 데이터도 복제
create table dept_copy
as select * from hr.departments where 1 = 2; -- 테이블 구조부터 만듬
insert into dept_copy 
select * from hr.departments; -- 데이터 복제
select * from dept_copy; -- hr의 테이블을 ora10으로 복제했음

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
as select * from hr.departments where 1=2; -- c.t.as /시타스/ <- create subquery

-- # 컬럼 추가
desc emp
alter table emp add job_id varchar2(10); -- job_id 컬럼 추가
                                         -- 맨 밑에 추가(순서 바꿀 수 없음)
                                         -- 순서 바꾸고 싶으면 새로 생성해야 

-- # 컬럼 수정 column modification
alter table emp modify job_id varchar2(20); -- 데이터 타입 수정
-- 그 컬럼에 데이터가 없으면 컬럼의 타입을 바꿀 수 있음
-- 이미 데이터가 있는 경우에는 타입 못 바꿈
-- char <-> varchar는 수정 가능
-- 사이즈를 늘리는 건 가능하지만, 줄이는 건 안 되는 경우가 있음(데이터 종속)

-- # 컬럼 삭제
alter table emp drop column job_id; -- drop column 같이 입력해줘야!
-- 컬럼을 삭제할 때는 그 안의 데이터가 중요한 지의 여부도 생각해야 함
-- alter <- DML <- autocommit 기능(rollback 수행 안 됨)

desc emp
alter table emp set unused(salary); -- salary 컬럼 안 보임 but 삭제하는 건 아님
                                    -- 일단 set unused 걸어놓고, 
                                    -- 사용자들이 안 볼 때 삭제

select * from user_unused_col_tabs; -- unused 중인 컬럼 개수 표시(컬럼명은 안 나옴)

alter table emp drop unused columns; -- unused 걸린 컬럼들 다 삭제됨 







desc emp
desc dept

insert into emp(employee_id, last_name, department_id)
values(1, 'hong', 10);
insert into emp(employee_id, last_name, department_id)
values(1, 'kim', 10); -- employee_id는 중복되면 안 됨(데이터의 품질이 나빠짐)
                      -- 제약조건: 중복, null값 배제
insert into emp(employee_id, last_name, department_id)
values(null, 'kim', 10);
                      
delete from emp;
                      
-- # 제약조건
--   1. primary key
--   2. foreign key <- null 허용
--   3. check <- sal>500
--   4. unique <- null 허용
--   5. not null <- alter modify 이용, 열 레벨 정의 only

--   primary key: 테이블의 대표키 설정
--   - 유일한 값, null값 체크
alter table emp 
add constraint emp_id_pk primary key(employee_id); 
-- 새로운 제약조건 설정
-- 동일한 키 값, null 못 들어오게 함
-- 데이터가 이미 들어가 있는 상태에서 제약조건을 추가하면 오류가 나올 수 있음!
/*
alter table emp 
add constraint 제약조건이름 primary key(컬럼이름); 
- 제약조건 이름 만들 때 고유한 이름으로 만들기!
*/

select * from user_constraints
where table_name = 'EMP'; -- 제약조건에 대한 정보를 확인하는 구문

alter table dept
add constraint dept_id_pk primary key
(department_id); -- dept 테이블에 제약조건 추가
select * from user_constraints
where table_name = 'DEPT';
-- department_id <- foreign key(dept 테이블의 "값"을 참조)

desc emp
desc dept

-- # foreign key(외래키)
--   - primary key에 값을 참조하는 제약조건
alter table emp
add constraint emp_dept_id_fk
foreign key(department_id)
references dept(department_id); -- parent keys not found(참조 테이블에 값이 없음)

drop table dept purge;
create table dept
as select * from hr.departments;
alter table dept
add constraint dept_id_pk primary key
(department_id); -- dept 테이블에 제약조건 추가
alter table emp
add constraint emp_dept_id_fk
foreign key(department_id)
references dept(department_id); -- foreign key 제약조건 추가
                                -- foreign key는 중복, null 허용 
                                
select *
from user_constraints
where table_name = 'EMP'
order by 2;
-- 제약조건 거는 이유
-- - 데이터 품질 높임
-- - emp와 dept 간의 종속 관계 유지(foreign key)

-- # 제약 조건 삭제
alter table emp drop primary key;
alter table dept drop primary key; -- foreign key 때문에 삭제 안 됨
alter table dept drop primary key cascade; -- pk, fk 동시에 삭제!
alter table dept drop constraint dept_id_pk; -- 제약 조건 이름 가지고 삭제
alter table dept drop constraint dept_id_pk cascade;

drop table emp purge;
drop table dept purge;

create table emp
(id number constraint emp_id_pk primary key,
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_sal_ck check(sal > 500)); -- check 제약 조건
 
create table emp
(id number constraint emp_id_pk primary key, -- 열 레벨 정의
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_sal_ck check(sal > 500)); -- 테이블 레벨 정의
 
create table emp
(id number,
 name varchar2(20),
 sal number,
 dept_id number,
 constraint emp_id_pk primary key(id) -- 테이블 레벨 정의
 constraint emp_sal_ck check(sal > 500)); -- 테이블 레벨 정의 

insert into emp(id,name,sal,dept_id)
values(1,'홍길동',500,10); -- check 제약조건 위반
                          -- 1. 중복값 체크 // 2. null값 체크 // 
                          -- 3. check 제약조건(sal>500) 체크
                          
insert into emp(id,name,sal,dept_id)
values(1,'홍길동',5000,10); -- 실행됨!

insert into emp(id,name,sal,dept_id)
values(1,'박찬호',1000,10); -- pk 위반(중복값)

insert into emp(id,name,sal,dept_id)
values(null,'박찬호',1000,10); -- pk 위반(null값)

select * from emp; 
-- # 명령문 레벨 rollback
--   이후에 insert 되는 row(박찬호)들이 pk 위반되어도, 
--   기존의 row(홍길동)들에 영향을 주지 않음

insert into emp(id,name,sal,dept_id)
values(1,'홍길동',5000,10); -- insert the first row

select * from emp;

insert into emp(id,name,sal,dept_id)
values(null,'박찬호',1000,10); -- 명령문 레벨 rollback
                              -- applied to the second row only
                              
rollback;
                              
insert into emp(id,name,sal,dept_id)
values(1,'홍길동',null,10); -- check 제약조건은 null값 허용!
                           -- check 제약조건: DML 문장을 실행하는 순간 수행됨
                           -- select문에서는 제약조건 적용되지 않음
                           -- <- Pl/SQL에서 trigger 기능 배워야!
                           
rollback;

select * from emp;

-- dept 테이블 만듬
create table dept
(dept_id number constraint dept_id_pk primary key,
 dept_name varchar2(20) constraint dept_name_uk unique);
-- primary key: 중복, null 체크
-- unique: 중복만 체크(null 허용)
-- foreign key: 이것도 null 허용
 
select *
from user_constraints
where table_name = 'DEPT';

insert into dept(dept_id, dept_name)
values(10,'총무부');
insert into dept(dept_id, dept_name)
values(20,'총무부'); -- unique constraint(중복 허용 안 됨)
insert into dept(dept_id, dept_name)
values(20,null); -- unique constraint(null은 허용)

rollback;

insert into dept(dept_id, dept_name)
values(20,'데이터분석팀');

commit;

insert into emp(id,name,sal,dept_id)
values(1,'홍길동',1000,30); -- foreign key를 써서 30번 부서에 들어가지 않게 해야 함
                           -- (outer join 방지)
                           -- 아래 제약조건 걸고 실행시키면 오류 나옴!
insert into emp(id,name,sal,dept_id)
values(1,'홍길동',1000,null); -- foreign key 제약조건은 null 허용함
                           
alter table emp
add constraint emp_dept_id_fk
foreign key(dept_id)
references dept(dept_id);

select * from emp;
select * from dept;

-- # Not null 제약조건: modify로 설정해야 함!
alter table emp modify name constraint emp_name_nn not null;

insert into emp(id,name,sal,dept_id)
values(1,null,1000,20); -- name에 not null 제약 조건이 걸림 <- 오류!

alter table emp modify name constraint emp_name_nn null; -- null 쓸 수 있게 허용
alter table emp drop constraint emp_name_nn; -- 이거 써도 됨!

create table emp
(id number,
 name varchar2(20) constraint emp_name_nn not null, 
 -- not null 제약조건은 열 레벨 정의로만 가능, table 레벨 정의로는 안 됨
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
 -- foreign key를 table 정의로 지정
 
create table emp
(id number,
 name varchar2(20) constraint emp_name_nn not null, 
 sal number,
 dept_id number constraint emp_dept_id_fk references dept(dept_id), 
 -- foreign key를 열 레벨로 정의(references 절만 나오면 됨)
 constraint emp_id_pk primary key(id),
 constraint emp_sal_ck check(sal > 500));
 
-- hr로 실행

select * from user_tab_privs; -- dictionary view
                              -- 내가 부여받은 권한 + 내가 가진 권한 동시에 보여줌
grant select on hr.employees to ora10;
grant select on hr.departments to ora10;

select * from user_tab_privs; -- ora10한테 부여한 권한 확인 가능







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





/*
ㅁ유저생성

  ㅇ권한(privilege) : 특정한 SQL 문을 수행할 수 있는 권리
  
    -시스템권한 : DBMS에 영향을 줄 수 있는 권리
      CREATE USER : 유저를 생성할 수 있는 권한
      CREATE SESSION : 접속할 수 있는 권한
      CREATE (OBJECT) : (OBJECT)를 생성할 수 있는 권한
      ...
*/
select * from session_privs;  --시스템권한을 확인 : DBA가 개발자가 들어 올 때마다 권한을 부여하기 번거로워서 덩어리로 해놓고 부여하는 권한

select * from user_sys_privs; --DBA로 부터 직접받은 시스템권한 확인

select * from session_roles;  --DBA로 부터 받은 ROLE에 대한 정보 확인
                              --ROLE : 권한을 편리하게 관리하기위한 객체/권한의 집합

select * from role_sys_privs; --각각의 ROLE 안에 들어있는 권한 확인
/*
    -객체권한 : 객체에다가 영향을 줄 수 있는 권리
*/
select * from user_tab_privs; --내가 받은 객체권한과 내가 부여한 객체권한에 대한 정보를 확인
                              --Ex) SYS로 부터 EXCUTE(통계)권한을 받았다.

select * from role_tab_privs; --내가 받은 ROLE 안에 들어 있는 객체권한에 대한 정보를 확인
/*
(DBA 계정)

    -DBA에서 확인방법
      접속 -> 초록 +
      접속 이름 dba
      사용자 이름 sys
      비밀번호 oracle
      롤 SYSDBA
*/
select * from session_privs;  
select * from dba_sys_privs;  --시스템권한을 어떤 유저에게 부여했는지 정보
select * from dba_tab_privs;  --객체권한을 어떤 유저한테 부여했는지 정보
select * from dba_roles;       --DB에 ROLE에 대한 정보
select * from dba_role_privs; --ROLE을 어떤 유저한테 부여했는지 정보
/*
      SQL> conn sys/oracle as sysdba

  ㅇ물리적 저장공간 정보 확인
  
    -DB에 생성되어 있는 유저 정보 확인
      Ex) HR의 DEFAULT_TABLESPACE USERS : HR은 USERS에 테이블을 생성한다.
(DBA 계정)
*/
select * from dba_users;
/*
    -TABLESPACE 정보 확인
      SYSTEM, SYSAUX, UNDO, TEMP 필수
      TEMP : 
      UNDO : 이전 값을 저장해 놓은 공간
      STSTEM : 지금까지 SELECT해서 본거 다 저장되어 있음 
      SYSAUX : 스스로 튜닝하기 위해서 악성 코드들을 
*/
select * from dba_tablespaces;--tablespace 정보를 확인
/*
    -물리적인 저장공간 정보 확인
      Ex) USERS의 FILE_NAME
      DATABASE(논리적)              OS(물리적)
      tablespace      (1 : m)      data file
      segment(table)
      extent
      block           (1 : m)      os block(대부분512byte)
*/
select * from dba_data_files;
/*
    -예제 : HR 계정의 물리적 저장공간을 확인해보자.
(HR 계정)
*/
select * from user_tables;      --HR의 TABLESPACE는 USERS임을 확인한다.
/*
(DBA 계정)
*/
select * from dba_data_files;   --DBA에서 USERS의 물리적 저장공간을 확인할 수 있다.
/*
  ㅇ유저생성
  
    -SYS계정에서 유저생성
(DBA 계정)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -유저수정
*/
alter user olap
identified by oracle          --바꾸고 싶은 절만 넣으면 된다.
default tablespace users
temporary tablespace temp
quota 10m on users;
/*
    -권한부여
*/
select * from dba_users;
select * from dba_ts_quotas;
/*
SQL> conn olap/oracle
ERROR:
*/
grant create session to olap;                         --권한 부여하는 방법

select * from dba_sys_privs where grantee = 'OLAP';   --권한 부여한 정보를 확인하는 방법
/*
SQL> conn olap/oracle
Connected.
SQL> select * from session_privs;
*/
revoke create session from olap;                      --권한을 회수하는 방법
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

      테이블을 생성하려면 두가지 권한이 필요하다.
      1.시스템권한 : CREATE TABLE

SQL> select * from session_privs;

      2.tablespace를 사용할 수 있는 권한(저장공간)
*/
select * from user_ts_quotas;
grant create table to olap;
/*
SQL> select * from session_privs;
SQL> select * from user_users;
/*
(olap 계정)
    -
      접속 -> 초록 +
      접속 이름 olap
      사용자 이름 olap
      비밀번호 oracle
      롤 default

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
ㅁINSERT
  ㅇ새로운 ROW를 저장하는 명령문
*/
desc emp

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));
select * from emp;

rollback;

select * from emp;    --insert는 했지만 영구저장한 것은 아니기 때문에 취소할 수 있다.

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));

select * from emp;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --영구히 저장하지 않았기 때문에 볼 수 없다.
*/
commit;
/*
SQL> conn olap/oracle
SQL> select * from emp;   --영구히 저장했기 때문에 볼 수 있다.

    -commit이든 rollback이든 하면 transaction은 종료된다.
*/
insert into emp(id, name, day)
values(2,'박찬호',sysdate);

select * from emp;
rollback;                  --박찬호에만 영향을 준다.

insert into emp(id, name, day)
values(2,'박찬호',sysdate);

select * from emp;
/*
    -NULL을 넣는 방법
*/
insert into emp(id, name, day)
values(3,'박지성',NULL);

commit;
/*
SQL> select * from emp;
*/
insert into emp(id, name)
values(4,'차두리');

select * from emp;

commit;

insert into emp
values(5, '손흥민', sysdate);

commit;
/*
ㅁ유저삭제
  ㅇSYS계정
*/
drop user olap;   --ERROR: 이미 실행중이거나 이미 오브젝트를 생성했을 경우

select * from v$session where username = 'OLAP';
/*
  ㅇSESSION KILL 방법
*/
alter system kill session '113,57' immediate;    --'SID값,SERIAL#'
alter system kill session '49,19' immediate;

drop user olap;
drop user olap cascade; -- object들까지 삭제해줌!
/*
      (다시 olap생성한다음 행 5개 부여)
*/
create user olap
identified by oracle
default tablespace users
temporary tablespace temp
quota 10m on users;

grant create session to olap; 
grant create table to olap;
/*
      접속 -> 초록 +
      접속 이름 olap
      사용자 이름 olap
      비밀번호 oracle
      롤 default
*/
create table emp(id number(4), name varchar2(20), day date)
tablespace users;

insert into emp(id, name, day)
values(1,'홍길동',to_date('2018-06-11','yyyy-mm-dd'));
insert into emp(id, name, day)
values(2,'박찬호',sysdate);
insert into emp(id, name, day)
values(3,'박지성',NULL);
insert into emp(id, name)
values(4,'차두리');
insert into emp
values(5, '손흥민', sysdate);

select * from emp;

commit;
/*
ㅁ복제

(olap 계정)

  ㅇ테이블의 row 복제
*/
create table emp_new(id number(4), name varchar2(20), day date)
tablespace;

select * from emp;
select * from emp_new;
 
insert into emp_new(id, name, day)    --두 table의 뼈대가 똑같으면 ()생략해도 된다.
select * from emp;

select * from emp_new;

commit;

drop table emp_new purge;
/*
  ㅇ테이블의 구조와 row 모두 복제
*/
create table emp_new
as select * from emp;   --rollback소용없다. 지우고 싶으면 drop해야한다.

select * from emp_new;

commit;

drop table emp_new purge;
/*
  ㅇ테이블의 구조만 복제
*/
create table emp_new
as select * from emp where 1=2;   --1=2인 행이 존재하지 않아 row는 복제되지 않는다.

select * from emp_new;









-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- insa로 실행

/*
[문제95]  insa 유저는 테이블논리적설계.pdf에 ERD(Entity Relationship Diagram)을 
확인 한후 table instance chart를  보면서 테이블을 구성하세요.
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
where table_name = 'EMP'; -- 어떤 제약 조건이 걸려 있는 지 확인

select * from user_constraints
where table_name = 'DEPT'; -- Dictionary view



/*
[문제96] hr.departments 테이블의 department_id, department_name, manager_id 데이터를 
insa 유저의 dept 테이블로 insert 한후 영구히 저장하세요. (데이터 이행, 이관)
*/
select * from hr.employees;
select * from hr.departments;
insert into dept(dept_id, dept_name, mgr)
select department_id, department_name, manager_id
from hr.departments;

/*
[문제97] hr.employees 테이블의 employee_id, last_name, hire_date, salary, 
manager_id, department_id 데이터를 insa 유저의 emp 테이블로 insert 한후 
영구히 저장하세요.
*/
insert into emp(id, name, hire_date, sal, mgr, dept_id)
select employee_id, last_name, hire_date, salary, manager_id, department_id
from hr.employees;

commit;
rollback;

/*
[문제98] insa유저의 dept 테이블의 부서정보 중에 소속사원이 없는 부서정보를 삭제한 후 
영구히 저장하세요.
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
-- where exists, where dept_id = ## <- 삭제 안 됨!(foreign key 제약조건 때문)

select * from dept;

desc emp

select *
from user_constraints
where table_name = 'EMP';

-- # 제약 조건 변경
alter table emp 
modify dept_id constraint emp_dept_id_nn not null; -- 오류!(dept_id에 null값)

-- # 이후에 들어오는 데이터에만 제약 조건이 적용되게 설정
alter table emp 
modify dept_id constraint emp_dept_id_nn not null
enable novalidate; -- 만들어짐!
                   -- 무조건 다 되는 건 아님!
                   
create table test(id number not null disable novalidate);
insert into test(id) values(null);

select *
from user_constraints
where table_name = 'TEST';

rollback;

/*
disable novalidate: disable의 default(그냥 disable로 입력하면 novalidate로 인식!)
                    제약조건 비활성화(대용량 데이터 이행 속도 ↑)
                    제약조건을 만들어 놓되, 활성화하지는 않겠다는 뜻
disable validate: 제약조건 만들어 놓되, 해당 table에 대한 DML 작업 불허
                  DML 작업이 아예 안 됨!(주의!)
enable novalidate: 제약조건을 활성화시키면서, 기존 데이터는 검증하지 않겠다는 뜻
enable validate: 기본값(default)

enable 했을 때 오류나면 활성화 안 됨 => disable로 작업한다음 추후 작업
*/

alter table test modify id null; -- 제약 조건 없어짐(not null은 modify로 삭제 가능)
alter table test modify id constraint test_id_nn not null disable validate;
insert into test(id) values(null); -- 오류!(disable validate)

drop table test purge;

create table test(id number not null disable validate);
insert into test(id) values(null); -- 오류!

rollback;
drop table test purge;

create table test(id number, name char(10), sal number);
insert into test(id,name,sal) values(1,'a',1000);
insert into test(id,name,sal) values(2,'b',100);
insert into test(id,name,sal) values(1,'a',2000);
commit;
select * from test;
-- 제약조건 추가
alter table test add constraint test_id_pk primary key(id); -- pk 위반!
-- enable validate <- 기존 데이터 체크(id값에 중복값이 있어서 pk로 못 만듬!)
alter table test add constraint test_id_pk primary key(id) enable novalidate;
-- enable novalidate <- pk는 기존 데이터 검증 안 하게 설정할 수 없음!(오류!)
-- pk 설정할 때는 disable로 만들기!
alter table test add constraint test_id_pk primary key(id) disable;
-- disable (novalidate) <- 제약조건 만들어놓긴 했지만 적용되는 건 아님



-- # 제약조건에 위반되는 데이터 찾는 법
/*
SQL COMMAND LINE
윈도우즈:
@%ORACLE_HOME%\rdbms\admin\utlexpt1 <- 레지스트리
리눅스:
@$ORACLE_HOME/rdbms/admin/utlexpt1
@%ORACLE_HOME% = C:\oraclexe\app\oracle\product\11.2.0\server
*/
select * from tab; 
-- EXCEPTIONS <- 제약조건 활성화할 때 문제되는 데이터 발생할 때 이 table로 로드됨
desc exceptions

alter table test enable constraint test_id_pk exceptions into exceptions;
-- enable <- enable validate(기존 데이터까지 체크)
-- exceptions into exceptions: 제약조건에 위반되는 데이터를 exceptions에 옮김

select * from exceptions; -- 이거 가지고 rowid 확인

select * from test where rowid = 'AAAE+HAAEAAAAG+AAC';
select * from test where rowid = 'AAAE+HAAEAAAAG+AAA';

update test set id = 3 where rowid = 'AAAE+HAAEAAAAG+AAA'; -- 문제되는 row 수정

select * from test order by 1;

commit;

alter table test add constraint test_sal_ck check(sal > 1000); -- Error!
alter table test add constraint test_sal_ck check(sal > 1000)
enable novalidate; -- 이렇게 만들어 놓고 수정

insert into test(id,name,sal) values(4,'c',500); -- Error!(check constraint)

-- 제약조건에 위반되는 데이터 수정
select distinct * from exceptions;

select * from test where rowid = 'AAAE+HAAEAAAAG+AAB';
update test set sal = 1500 where rowid = 'AAAE+HAAEAAAAG+AAB';
select * from test where rowid = 'AAAE+HAAEAAAAG+AAA';
update test set sal = 3500 where rowid = 'AAAE+HAAEAAAAG+AAA';

alter table test enable constraint test_sal_ck exceptions into exceptions;

-- 다른 방법
alter table test add constraint test_sal_ck check(sal > 1000) enable novalidate;
delete from exceptions; -- 이 테이블에 있는 데이터 없애고 수정

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



-- # 다중테이블 insert
--   1. 무조건 insert all
--   2. 조건 insert all(when into)
--   3. 조건 first insert(insert first ~ else) <- if와 비슷하게 수행

-- 1. 무조건 insert all
create table sal_history -- target
as select employee_id, hire_date, salary
from employees where 1=2; -- 복제

desc sal_history

create table mgr_history -- target
as select employee_id, manager_id, salary
from employees where 1=2;

-- 무조건 insert all
insert all 
into sal_history(employee_id, hire_date, salary)
          values(employee_id, hire_date, salary) -- values: 소스의 컬럼 지정
into mgr_history(employee_id, manager_id, salary)
          values(employee_id, manager_id, salary)
select employee_id, hire_date, manager_id, salary -- 소스 테이블
from employees;

insert all 
into sal_history(employee_id, hire_date, salary)
          values(id, hdate, sal) -- alias 썼으면 values절에도 alias 쓰기!
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

-- 2. 조건 insert all(when into)
create table emp_history
as select employee_id, hire_date, salary
from employees where 1=2;

create table emp_sal
as select employee_id, commission_pct, salary
from employees where 1=2;

insert all 
when hire < to_date('2005-01-01','yyyy-mm-dd') then -- when 조건!
into emp_history(employee_id, hire_date, salary)
          values(id, hire, sal)
select employee_id id, hire_date hire, salary sal, commission_pct comm
from employees;

insert all 
when hire < to_date('2005-01-01','yyyy-mm-dd') then 
into emp_history(employee_id, hire_date, salary)
          values(id, hire, sal)
when comm is not null then -- 하나의 데이터가 양쪽 when에 들어갈 수 있고, 
                           -- 한쪽에만 들어갈 수도 있고 아예 안 들어갈 수도 있음
                           -- if와 다르게, 첫번째 when이 맞아도 그 다음 when도 체크
into emp_sal(employee_id, commission_pct, salary)
      values(id, comm, sal)
select employee_id id, hire_date hire, salary sal, commission_pct comm
from employees;

select * from emp_history;
select * from emp_sal;

-- 3. 조건 first insert(insert first ~ else)
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
into sal_low(employee_id, last_name, salary) -- salary가 5000 미만이면 sal_low
      values(employee_id, last_name, salary)
when salary between 5000 and 10000 then
into sal_mid(employee_id, last_name, salary) 
      values(employee_id, last_name, salary)
else                                         -- 그 외(else)
into sal_high(employee_id, last_name, salary) 
       values(employee_id, last_name, salary)
select employee_id, last_name, salary
from employees; -- if문처럼 하나의 조건에만 걸리게 만듬!

select * from sal_low;
select * from sal_mid;
select * from sal_high;







-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # csv파일 만드는 법
-- 도구 -> 데이터베이스 익스포트 -> hr접속, 모두 토글 해제(테이블만 선택)
-- -> 데이터 지정(컬럼 선택)
-- 익스터널 테이블
-- 외부파일 받았을 경우 -> 논리적인 디렉터리 생성 -> read, write 권한 생성(DBA 담당)
-- 외부파일의 날짜 부분 주의!

select sysdate from dual;

/*
# external table의 단점
1. DML 작업 안 됨(read만 가능한 table)
2. index 설계 못 함

select * from empext where hire_date like '2002%'; <- 형 변환!

select * from empext 
where hire_date  >= to_date('20020101','yyyymmdd')
and hire_date < to_date('20030101','yyyymmdd');

* external table 상에서는 위의 2개 중에 어느 걸 돌려도 성능 상 차이 없음! 

* 몇 건만 검색하고자 할 때는 external table이 비효율적!
*/



-- # object
-- 1. table: data가 저장(rows & columns)
-- 2. user
-- 3. VIEW

-- view
-- - 하나 이상의 table에 있는 data를 논리적으로 처리하는 object이다. 
-- - select문만 가지고 있다. 

-- 시타스(create table as)
create table dept_20
as select * from employees where department_id = 20;
create table dept_30
as select * from employees where department_id = 30;
-- 부서원들은 소속 부서에 대한 정보만 봐야 함! 
-- 전체 사원, 부서 내의 사원을 각각 따로 검색
-- 이 경우 중복되는 데이터를 2개씩 가지게 됨 
-- 유지 관리 불편해짐, 저장 공간 낭비
-- 개별 부서 사원에 대한 정보는 table이 아닌 view를 만들어서 중복 방지
-- view <- 간접 엑세스

-- view <- select문장만 가능(데이터를 논리적으로만 가지고 있음)
-- cf. table <- 물리적으로도 가지고 있음
create view dept_v20
as select * from employees where department_id = 20;
create view dept_v30
as select * from employees where department_id = 30;
select * from dept_v20; -- 20번 부서의 사원 정보
select * from dept_v30; -- 30번 부서의 사원 정보

create view emp_vw
as select employee_id, last_name, department_id
from employees; -- 해당 column들만 볼 수 있도록 설정

select * from emp_vw;

grant select on hr.emp_vw to ora10; 
-- user(ora10)에게 이 view만 select할 수 있는 권한 부여
-- 간접 엑세스(해당 column들만 볼 수 있게 함)
-- cf. 직접 엑세스 <- 직접 table 건드릴 수 있음

select * from user_views where view_name = 'EMP_VW';
-- 내가 만든 view에 대한 내용 확인
-- TEXT 컬럼 <- view를 호출한 select문이 보임!

select * from user_objects where object_name = 'EMP_VW';
-- 내가 만든 object들 확인
-- OBJECT_TYPE 컬럼 <- VIEW
-- view를 select하는 순간, view가 가진 select문을 호출해서 다시 수행(recursive)

-- view는 수정 못 함! 
-- 수정하려면, drop view한다음, 다시 create해야 함!(alter 수행 못 함)
-- create or replace: drop/create 이 2개를 한 번에 수행
create or replace view emp_vw
as select employee_id, last_name || first_name 
from employees; -- 오류!(연결 연산자(||) 쓸 때는 alias 사용해야 함!)

create or replace view emp_vw
as select employee_id, last_name || first_name name
from employees;

select * from emp_vw;

-- 단순 view
-- 복합 view

-- # 단순 view
drop table emp_new purge;
create table emp_new
as select employee_id, last_name, salary, department_id
from employees
where department_id = 20;
select * from emp_new;

create view emp_vw2
as select * from emp_new; 
-- 단순 view(subquery절 안에 그룹함수, group by, join 없음)
-- 그것들이 있으면 복합 view!
-- 단순 view는 참조하고 있는 table에 대해 DML 작업하는 것이 가능
-- view를 통해서 보고 있는 row들만큼은 DML 작업(insert, update, delete) 가능
-- table과 view 모두 수정됨!(단순 view의 이점)
update emp_vw2
set department_id = 200; -- view를 통해 DML 작업!(table과 view 모두 수정됨!)

select * from emp_vw2; -- view(간접 액세스)
select * from emp_new; -- 실제 table

rollback;

delete from emp_vw2; -- table과 view 모두 수정됨!

insert into emp_vw2(employee_id, last_name, salary, department_id)
             values(1,'james',1000,10); -- view를 통해 insert
                                        -- (table과 view 모두 수정됨!)

select * from emp_vw2;
select * from emp_new;

desc emp_vw2

insert into emp_vw2(employee_id, last_name, salary, department_id)
             values(2,null,2000,20); 
-- insert 안 됨(not null 제약조건 때문)
-- not null 제약조건이 걸려 있는 column에 대해서는 null값 insert 안 됨!
-- 단순 view라도 제약조건이 걸려 있으면 table에 대한 DML 작업 안 됨!

rollback;

create or replace view emp_vw2 -- 기존의 view를 drop하고 새로운 view로 대체
as select employee_id, salary, department_id
from emp_new;

update emp_vw2
set last_name = 'james'; -- 오류!(이 view에는 last_name 컬럼이 없기 때문!)

insert into emp_vw2(employee_id, salary, department_id)
values(3,2000,10); -- 오류!(view가 참조하는 컬럼 중에 not null 걸렸을 경우)

create or replace view emp_vw2 
as select employee_id, salary*12 sal, department_id -- 여전히 단순 view
from emp_new;
-- delete 가능, insert 안 됨(표현식으로 되어 있기 때문)
-- update 안 됨(표현식으로 되어 있기 때문)

-- # 복합 view
-- view 안에 그룹함수, group by, join 문이 들어있는 view는 복합 view이다. 
-- DML 할 수 없다. (단, 가능하려면 pl/sql trigger 만들면 해결할 수 있다)

create or replace view empvu20
as select *
from employees
where department_id = 20 -- check 제약조건의 조건식
with check option constraint empvu20_ck; -- view에도 check 제약조건 걸 수 있음
                                         -- 조건식 없음(where절이 조건식이 됨!)
                                         -- 다른 제약조건은 추가 못 시킴

select * from empvu20;
select * from user_constraints where table_name = 'EMPVU20';
-- CONSTRAINT_TYPE <- V

update empvu20
set department_id = 30
where employee_id = 201; -- update 안 됨!(check 제약조건의 조건식에 위반되기 때문)

-- cf.
create or replace view empvu20
as select *
from employees
where department_id = 20;

drop trigger HR.UPDATE_JOB_HISTORY; -- 트리거 삭제

update empvu20
set department_id = 30
where employee_id = 201;

select * from empvu20;

rollback;

-- 단순 view의 DML 작업을 불허하고 싶을 때(with read only)
create or replace view empvu20 -- 단순 view
as select *
from employees
where department_id = 20 
with read only;

-- # sequence
select * from session_privs;
select * from user_sys_privs; -- create view <- view 생성 권한
-- create sequence <- 자동 일련번호 생성 가능

-- sequence
-- - 자동 일련번호를 생성하는 object
-- - create sequence 시스템 권한이 필요하다
-- - insert 시에 많이 씀

create table emp_seq
(id number,
name varchar2(20),
day timestamp default systimestamp);

create sequence emp_id_seq -- sequence 생성(맨 위 문장만 입력해도 됨!)
increment by 1 -- default
start with 1
maxvalue 50 -- 10^27까지 표현 가능 cf. minvalue
cache 20 -- 성능 관련, no cache 설정 가능(LAST_NUMBER 설정이 중요해짐)
nocycle; -- 순환 안 함
         -- cf. cycle: maxvalue에 도달하고 다시 순환

select * from user_sequences where sequence_name = 'EMP_ID_SEQ';

drop sequence emp_id_seq; -- sequence 삭제

alter sequence emp_id_seq; -- start with는 수정 못 함!

insert into emp_seq(id, name, day)
             values(emp_id_seq.nextval, user, default);
                -- sequence이름.가상컬럼 <- 다음 사용 가능한 번호를 리턴(가상 컬럼)

select * from emp_seq; -- 위의 insert문을 수행할 때마다 row들이 추가됨!
select emp_id_seq.currval from dual; -- 현재 몇 번까지 썼는 지 리턴
                                     -- cf. nextval: 새로운 번호 생성!(gap 생김)

rollback; -- insert문 다 취소됨 <- select문의 1,2,3번 데이터 없어짐
          -- insert, select문 다시 실행하면 4번이라고 리턴!
          -- 한 번 사용한 번호는 rollback 하더라도 영구결번!
          -- sequence값에 gap이 생길 수 있음!
          -- gap 없애려면 maxvalue 조정!
          
select * from user_sequences where sequence_name = 'EMP_ID_SEQ';
-- LAST_NUMBER <- 21(CACHE 기능을 통해 1번부터 20번까지는 메모리에 미리 집어넣은 것!)
-- CACHE <- insert 속도 빨라짐!(CACHE 작으면 속도 떨어짐!)
-- 이 dictionary view 가지고는 다음 일련번호를 확인할 수 없음!
-- currval 사용할 것!






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
-- v$sql: shared pool 안에 library cache(DBA만 확인 가능)
-- shared pool 안에 library cache 안에 만들어져 있는 LCO의 SQL문 정보 확인 중
-- (이 query문을 실행해서 나온 결과가 LCO!)
-- hr session에서 수행했던 select문 조회 가능
-- 대소문자, 공백문자, comment, 상수/literal값 모두 일치해야!

-- hr session에서 drop table 해도 LCO는 남아 있음! (OBJECT_STATUS: INVALID)
-- hr session에서 다시 create table하고 select하면 기존의 LCO를 이용함!
-- FIRST_LOAD_TIME: 이전 시간 // OBJECT_STATUS: VALID // LAST_LOAD_TIME: 현재 시간

select * 
from v$sql
where sql_text like '%emp%' 
and sql_text not like '%v$sql%';
-- emp가 들어있는 모든 select문 확인 가능
-- semantic 체크할 때 사용하는(실제로 user가 입력하지는 않은) query문들도 볼 수 있음

select * from v$sql; 
-- library cache에 있는 거 다 보여줌

alter system flush shared_pool; 
-- 회사가 열받게 할 때 씀(버그 방지를 위해 총 3번 씀)
-- shared_pool 안의 내용 모두 날림! 
-- 이거 수행하면, 실행 계획 모두 없어짐
-- 이제부터 들어오는 sql문은 모두 hard parsing
-- 4031 오류 발생 시 사용(free memory 부족) <- just like 디스크 조각 모음
-- 너무 hard parsing 많이 하면 memory chunk 부족해져서 hard parsing이 불가능 <- flush!

-- SQL문마다 SQL_ID 만들어짐
-- INVALIDATIONS <- 무효화 발생 건수
-- PARSE_CALLS <- parse calls 횟수
-- PARSING_SCHEMA_NAME <- 이 SQL문을 던진 user가 누군지 파악할 수 있음
-- OBJECT_STATUS <- LCO에 대한 상태 정보(VALID) 
-- FIRST_LOAD_TIME vs LAST_LOAD_TIME

select * 
from v$sql_plan
where sql_id = '0t028xxgcphg0';
-- 실제 실행 계획!
-- OPERATION, OBJECT_NAME, OPTIONS, COST <- F10 실행 계획 정보를 여기서 확인 가능!
-- F10은 user들이 보기 편하게 바꿔준 것!
-- v$ 계열은 본래 DBA만 보는 것!

select * from table(dbms_xplan.display_cursor('0t028xxgcphg0'));
-- 실행 계획을 보기 편하게 들여쓰기 제공!(이것도 DBA만 볼 수 있음)
-- 조건부 술어(where) 입력했을 때, optimiser가 어떻게 실행 계획을 짰는 지 파악 가능
-- dbms_xplan: 패키지 // display_cursor: 함수
-- Hash value <- plan 정보에 대한 hash value 고유값
-- depth가 가장 깊은 쪽부터 해석
-- ex. 0번 select보다 1번 table이 더 들여쓰기 되어 있으니 이것부터 해석!
-- 1 - filter(): 위의 1번과 mapping시켜서 보기!
-- filter 술어: filter는 정확이 이 값("EMPLOYEE_ID"=100)이 
--             사원 table이 어느 위치에 있는 지 모를 때, 
--             table의 모든 필드를 scan해야 함(값을 찾았어도 모두 scan)
-- cf. access: rowid를 가지고 바로 찾아감(block의 정확한 위치를 아는 경우)
-- dynamic sampling: 실행 계획을 위한 통계 정보(모집단)를 모를 때, 
--                   일부 block에 대한 "표본(sampling)" 제공(예측치)

-- hr session에서 INDEX 생성 후 select문 실행
-- => 실행 계획이 2. INDEX RANGE SCAN으로 바뀌어 있음!!(access)
-- PARSE_CALLS <- hr session에서 select문 실행할 때마다 계속 증가! 
--             <- 이게 많으면 많을 수록 자주 사용하는 SQL문
--             <- memory가 부족해도 이 LCO는 없애지 않을 거임!
-- access: rowid를 가지고 바로 찾아감(block의 정확한 위치를 아는 경우)
-- rowid는 index가 가지고 있고, index의 leaf block에 저장 <- INDEX RANGE SCAN 과정
-- 2번(deepest)에서 index에서의 rowid를 찾은 다음,
-- 1번에서 실제 위치로 찾아감(access 술어 부분에서 확인!)
-- 번호 앞에 * 붙어 있는 것들은 밑에 조건부 술어가 표현되어 있음

-- # EXPLAIN PLAN <- F10으로 실행 계획을 확인할 수 없는 경우!(ex. SQL Plus 실행)
-- - optimiser가 sql문 실행에 사용하는 실행 계획 정보를 확인할 수 있다.
-- - plan_table에 저장
-- - plan_table을 만드는 방법
--   @%ORACLE_HOME%\rdbms\admin\utlxplan.sql
-- - 10g 버젼부터는 자동 설치가 되어 있다. (굳이 바로 위에 껄 따로 설치할 필요 없음)
select *
from all_synonyms
where synonym_name = 'PLAN_TABLE';
-- all_synonyms: 사용자가 만들지 않은 synonyms까지
-- user_synonyms: 사용자가 만든 synonyms 리스트
-- dba_synonyms: DBA가 만든 synonyms 리스트
-- PLAN_TABLE$ <- Dictionary Table
--             <- 구 버젼에서는 이게 없으면 F10 누를 때마다 오류가 났었음
-- SQL>set linesize 200 <- 간격 조정

-- # Synonyms
select * from sys.plan_table$;
select * from plan_table;
-- plan_table <- sys.plan_table$의 synonym(DBA가 제작)

select * from dba_segments where segment_name = 'EMP';
-- BLOCKS 8개 // EXTENTS 1개 <- 하나의 EXTENT에 들어 있는 BLOCK의 수
-- INITIAL_EXTENT <- 하나의 EXTENT의 크기(64K)
-- 실제 현업에서는 숫자가 틀릴 수도 있음!
show parameter db
-- db자가 포함된 parameter들 표시
-- db_file_multiblock_read_count: 1번의 I/O query를 수행할 때 load할 수 있는 block의 수(128)
-- <- EXTENT 안에 들어있는 BLOCK의 수에 종속!(128개를 한꺼번에 불러들이진 못 함)
-- EXTENT의 크기가 크면 클 수록 full scan할 때 유리(작으면 I/O 더 많이 발생)
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
-- 통계 정보 확인(about user)
-- cf. DBA: dba_tables
-- num_rows(전체 row의 수), blocks(#block), avg_row_len(한 row의 길이)
-- 이거 모르면(null), dynamic sampling해서 실행 계획 만듬!
-- 실행 계획 만들면 통계 정보를 여기에 저장하지 않고, 바로 purge함!

-- # 통계 정보 수집
-- 통계 수집하는 이유 <- dynamic sampling하는 수고로움을 덜기 위해
select * from user_tab_privs;
-- 현재 user가 받은 object 권한
-- DBMS_STATS <- 통계 수집을 위한 권한

exec dbms_stats.gather_table_stats('hr', 'emp')
-- exec 패키지.함수('사용자', '테이블')
-- 이거 실행하고 위에 select num_rows, blocks, avg_row_len 수행하면 값이 생김!
-- 통계 수집하면 실행 계획 무효화! 
-- DBA에서 select * from v$sql... 실행하면, OBJECT_STATUS가 invalidated로 바껴야 함!
-- but 아직 valid로 남아 있음
-- 이유: SQL의 latch 기능(검색 효율을 위해 잠시 무효화 보류)

exec dbms_stats.gather_table_stats('hr', 'emp', no_invalidate=>False)
-- latch 기능 해제(no_invalidate=>False: 즉시 무효화)
-- DBA에서 select * from v$sql... 실행하면, OBJECT_STATUS가 INVALID로 바뀜!
-- but 즉시 무효화를 수행하는 순간, 다른 부서의 SQL문 수행에 악영향
-- 통계 수집을 최대한 자제하고, 꼭 해야될 때는 latch 기능을 통해 천천히 무효화해야 함! 
-- 무효화된 실행 계획은 다시 못 씀(또 만들어야 함)

-- DBA에서 select * from v$sql... 실행
-- => LAST_LOAD_TIME: 지금 시간대 아님
-- => select * from emp where employee_id = 100; 실행
-- => OBJECT_STATUS가 VALID로 바뀌고, LAST_LOAD_TIME이 최신 시간으로 바뀜
-- => 이전 시간은 FIRST_LOAD_TIME로 가지고 있음 
-- => 실행 계획의 무효화가 발생해도 LCO는 버리지 않음!(메모리 할당되는 수고를 줄이기 위해)

-- # INDEX 생성
create index emp_id_idx
on emp(employee_id);
-- non-unique index
-- index 생성 => 실행 계획 무효화!

-- # EXPLAIN PLAN
explain plan for select * from emp where employee_id = 100;
select * from plan_table;
-- explain plan에 실행된 걸 plan_table에 저장 <- but 보기 불편함
select * from table(dbms_xplan.display(null,null,'typical'));
-- user들이 보기 편하게 변경(규격화)
-- 이건 DBA 뿐만 아니라, user들도 볼 수 있음!
-- 내용은 맨 위 select문에 F10 누른 거하고 같음!
select * from table(dbms_xplan.display(null,null,'basic'));
-- 일부 정보 누락(typical 쓰는 걸 권장)

drop index emp_id_idx;
explain plan for select * from emp where employee_id = 100;
select * from table(dbms_xplan.display(null,null,'typical'));
-- filter 술어(employee_id = 100가 어느 위치에 있는 지 모름)

-- # full table scan
-- - 많은 양의 데이터를 검색할 때 유용하다.
-- - 집계함수를 쓸 때 full scan이 더 유리.
-- - Multiblock I/O 발생 <- 여러 데이터를 한꺼번에 buffer cache에 올려서 I/O 수 줄임
--   <- 여러 block을 한꺼번에 load 하려면 인접해 있어야 함 <- extent

alter session set db_file_multiblock_read_count = 128;
-- 내 session level에서 load할 수 있는 block 수 변경
select * from emp;
-- full scan

-- # Hint
-- /*+ full(테이블명 or alias) */
select /*+ full(e) */ * from emp e;
-- full scan 하겠다고 명시
select /*+ full(e) */ employee_id, last_name from emp e;
select /*+ full(e) parallel(e,2) */ * from emp e;
-- full parallel
-- 1. 2개의 processor를 띄워서 block들을 반띵해서 처리(병렬 처리)
-- (CPU가 하나일 때는 소용 없음) <- CPU의 개수에 종속
-- 2. direct lead 방식(속도 up)
-- cf. full: buffer cache 거침
-- Oracle이 자발적으로 full scan을 수행하지 않는 경우가 있음
-- full scan으로 유도하는 법 <- index scan 못 하게 막음 <- 형 변환 함수 이용!

-- direct lead: 데이터를 buffer cache를 거치지 않고 
--              바로 cursor에 direct하게 active set 만듬
--              but 그래도 memory(buffer cache)에 올려서 작업하는 게 효율적!
-- cf. 본래는 disk에 있는 block들을, buffer cache를 거쳐 cursor로 보냄(serial 방식)

-- # rowid scan
-- - by user rowid scan, by index rowid scan을 이용하여 
--   소량의 데이터를 검색할 때 유용하다. 
-- - Single Block I/O <- block 한 개씩 불러들임 
--   cf. full scan: Multiblock I/O <- db_file_multiblock_read_count
select rowid, employee_id from emp;
select * from emp where rowid = 'AAAE//AAEAAAAJDAAH';
-- #object id #file id #block id #rowslot
--  6          3        6         3

-- # index scan
select * from user_ind_columns where table_name = 'EMP';
-- index 생성
-- 1. index unique scan
--    - column에 유일한 값으로 index가 구성되어 있을 때
--    - 비교연산자는 =만 사용할 때
alter table emp add constraint emp_id_pk primary key(employee_id);
-- 제약 조건 생성(수정) => 위에 select문 다시 수행 => unique index 생성
-- primary key, unique <- unique index 자동 생성
select * from user_ind_columns where table_name = 'EMP';
select * from user_indexes where table_name = 'EMP';
-- UNIQUENESS <- UNIQUE: unique index가 걸려 있다는 뜻
-- 보통 user_ind_columns와 user_indexes를 join해서 많이 봄
select * from emp where employee_id = 100; -- unique index scan
select * from emp where employee_id >= 100; -- full scan
select * from emp where employee_id <= 100; -- range scan
-- index: 통계 정보 자동 생성(최소값, 최대값 알 수 있음)
-- 100이 최소값이라는 정보를 가지고 있으므로 <= 100는 range scan
explain plan for select * from emp where employee_id = 100; -- index unique scan
explain plan for select * from emp where employee_id >= 100; -- table access full
-- full table scan으로 유도된 이유
-- 이걸 index range scan으로 수행하면 문제되는 이유
-- - employee_id 이외의 column에 대해서는 정보가 없음
-- - index range scan는 single block I/O
-- - 모든 행을 검색하는 것에 대해 I/O 발생(성능 저하)
explain plan for select employee_id from emp where employee_id >= 100; -- INDEX RANGE SCAN
-- index range scan의 이유 
-- - employee_id 컬럼만 보면 되기 때문
explain plan for select employee_id, last_name from emp where employee_id >= 100; -- TABLE ACCESS FULL
-- select절에 쓸데없는 컬럼명을 기입하지 말 것!(full scan으로 바뀜)
explain plan for select * from emp where employee_id <= 100; -- index range scan
select * from table(dbms_xplan.display(null,null,'typical'));

-- 2. index range scan
--    - index의 leaf block에서 필요한 범위만 스캔하는 방식
--    - non-unique index를 걸면 무조건 index range scan
--      <- = 연산자를 쓰더라도 무조건 index range scan
--    - one plus one scan 방식(leaf block은 마지막으로 한 번씩 건드림)
explain plan for select * from emp where department_id = 10; -- full table scan
select * from table(dbms_xplan.display(null,null,'typical')); 
-- index 만들기
create index emp_dept_idx
on emp(department_id);
-- unique index는 못 만듬(기존의 데이터에 중복값이 포함되어 있기 때문)
explain plan for select * from emp where department_id = 10; -- index range scan
select * from table(dbms_xplan.display(null,null,'typical')); 
-- index range scan: department_id = 10에 해당되는 값을 찾았더라도 계속 scanning
-- "vertical(root->leaf) to horizontal(range(neighboring leaves))" scanning
select * from user_indexes where table_name = 'EMP';
-- 이 select문으로 non-unique index 걸려 있는 지 확인(NONUNIQUE)

-- 3. inlist iterator <- index scan의 하나의 방식
--    - in, or 연산자 이용 => set 연산자로 transforming
--    - set operator: 실행 계획 분리
--    - index를 반복한다. (root-branch-leaf를 반복)
--    - 값의 범위가 떨어져 있을 때는, in 연산자를 써서 inlist iterator를 유도
--    - 값의 분포도 <- 히스토그램으로 표현
explain plan for 
select * from emp where employee_id in (100, 200);
select * from table(dbms_xplan.display(null,null,'typical')); 
select * from emp where employee_id = 100
union
select * from emp where employee_id = 200;
select * from emp where employee_id = 100
union all
select * from emp where employee_id = 200;
-- 위 3개의 select문은 같은 의미를 가짐(in, union, union all)

-- cf. 값이 인접해 있는 경우
select * from emp where employee_id in (100, 101, 102); -- inlist iterator
select * from emp where employee_id = 100
union all
select * from emp where employee_id = 101;
union all
select * from emp where employee_id = 102;
-- 값이 인접해 있음에도 inlist iterator 실행(I/O 낭비) => range scan으로 바꿔야 함!
select * from emp where employee_id between 100 and 102; -- range scan

explain plan for
select * from emp where employee_id = 100
union
select * from emp where employee_id = 200;
select * from table(dbms_xplan.display(null,null,'typical')); 



select * from user_tables;
-- NUM_ROWS <- 있는 것도 있고 없는 것도 있음
-- LAST_ANALYZED <- 날짜 정보 없으면 통계 수집 안 된 거
-- 통계 수집: DBA들이 수행(user들이 요청, Hint 이용)
--           저용량 데이터 -> range scan // 대용량 데이터 -> full scan
--           union all, hint를 통해 위 2개의 select문을 다른 방식으로 수행






-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





select * from hr.emp where dept_id = 10;
-- unique index에는 histogram 안 만듬
-- non-unique index 중에 histogram 만듬!
-- => histogram이 만들어지고, 데이터의 분포도가 불균등한 것은 변수 처리 하면 안 됨
--    (상수로 놔둬야 함!)
-- 실행 계획은 parsing 단계에서 만듬 => 데이터의 분포도를 모름
-- => 분포도가 고르다는 전제 조건으로 만듬
-- cf. 11G 버젼 => Machine Learning을 통해 해결!(Adaptive Cursor Sharing)
--             => 이제 변수 처리 해도 됨!

-- filter 술어를 쓰면 full scan이 되서 성능이 저하되므로, index를 검!

-- full parallel 발생 => Disk에서 읽어들일 수 없음(Memmory)에서 읽어들임
-- => 중간에 gap이 포함되어 있으면 Multiblock I/O가 성립 안 됨
-- => 모두 singleblock으로 load함 => 성능 저하!

alter system flush buffer_pool;
-- buffer cache를 flush!

-- buffer pinning <- leaf block을 pinning => I/O 줄어듬!









-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- # JOIN <- Loop문!(서브루프가 메인루프(dept_id)에 종속, 메인루프절의 row 수만큼 서브루프 수행)
--   조인의 방법, 순서 신경써야!

-- # 실행계획
-- 1. 데이터를 처리하는 방법을 결정
--    1) table full scan
--    2) rowid scan
--       a. by user rowid
--       b. by index rowid
-- 2. join 방법
--    1) nested loop
--    2) sort merge
--    3) hash
-- 3. join의 순서

-- 서브쿼리 튜닝, 분석함수, 정규식 표현식



-- # nested loop join
--   - join되는 건수가 적을 때 유리하다.
--   - access 방식 사용!(block의 위치를 알고 찾아가는 방법 <- rowid, pk index)
--   - 인덱스 설계가 잘 되어 있어야 한다. <- 그렇지 않으면 full table scan 발생
--   - 힌트(optimiser에게 실행 계획을 이렇게 만들라고 요청)
--     : user_nl(nested loop에 대한 힌트), ordered(join의 순서), leading

alter session set statistics_level = all;

select /*+ use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;
-- nested loop, table access(2개의 레벨이 같음 => 위에서 밑으로 해석! cf. depth가 다르면 아래에서 위로) <- F10: 예측된 거!

select /*+ gather_plan_statistics use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

alter session set statistics_level = all; -- gather_plan_statistics의 수고로움을 줄임!
                                          -- 그냥 맨 위의 select문을 실행해도 실행 계획 확인 가능
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
-- 2번과 4번은 같은 레벨 => 위에서 아래로 해석(TABLE ACCESS BY INDEX ROWID)
-- 2번: outer/driving table
-- 4번: inner/driven table
-- <- Join의 순서!(join은 하나씩 수행)
-- Outer table을 뭐로 할 지가 Join tuning의 핵심!
-- (Outer 100번 나오면 Inner도 100번 수행됨)
-- * 부분(3번, 5번): 비 join 조건 술어 부분 관련
-- 3번 오퍼레이션을 제일 먼저 수행하고, 그 값으로 2번 수행 
-- => active set 만듬(e.department_id: 2번에서 만든 active set 결과)
-- => 5번으로 이동
-- 3번 오퍼레이션을 제일 먼저 수행하는 이유: e.employee_id = 100에 해당하는 rowid를 찾기 위해

-- # driving table 
--   1. 인덱스가 없는 쪽 
--   2. 작은 table

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and e.employee_id = 100;  -- nested loop
                          -- join 결과가 작을 때만 사용!
                          -- 데이터 양이 많으면 비효율적(row 수만큼 random I/O 발생)

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id; -- merge join
                                         -- 비join 조건 술어 제외
                                         
-- # 조합 인덱스
-- 비join 조건 술어가 늘상 사용된다면, "조합 인덱스" 거는 것도 하나의 방법!
-- cf. clustering table: join된 결과를 아예 저장해놓음



select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 1500; -- d.location_id와 e.department_id에 인덱스가 걸려있는 게 좋음(좌항)
                          -- d.location_id을 찾은 다음, table emp로 건너가 e.department_id를 찾음
                          
                          -- 두 테이블을 비교해보기(table emp에는 비 join 조건이 없으니 dept가 더 작은 테이블!)
                          -- dept를 먼저 스캔한다음, 인덱스를 통해 emp로 가는 게 더 효율적(dept가 driving table)
                          -- 각각 count(*)를 계산해서 어떤 걸 driving table로 할 지 정하기!
                          
                          -- 비 join 조건 술어가 포함된 table을 driving하기!

select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.department_id = 10; -- and절의 컬럼에 인덱스를 걸고 d.department_id를 통해 table emp로 접근
                          -- e.department_id에 인덱스 걸려 있어야!
        
select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and e.department_id = 10; 
-- oracle이 and절 컬럼을 자동적으로 d.department_id로 변환
-- f10 확인해보면 내가 쓰지 않은 d.department_id=10이 자동적으로 들어가 있음
-- nested loop join을 했더라도, 실제로는 emp와 dept의 테이블을 merge한 것과 같이 실행됨

select e.*, d.*, l.*
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto'; -- 비 join 조건 술어는 access 술어로 만들 것!(index 설계)
                        -- 1. and절의 컬럼(l.city)에 index 걸고, 그 rowid를 가지고 table loc로 가서 l.location_id 체크
                        -- 2. l.location_id를 가지고 table dept로 가서 d.location_id 확인(d.location_id에 인덱스 걸려 있어야!)
                        -- 3. d table의 d.department_id를 가지고 table emp에 접근(e.department_id에 인덱스 걸려 있어야!)
                        -- 4. 다시 leaf block으로 돌아와서 다른 rowid로 위와 동일하게 range scan 수행(셋 다 non-unique index)
                        -- 5. 다 끝났으면 active set 결과를 user에게 전달
                        -- join의 순서: l => d => e
                        -- nested join은 index 설계가 잘 되어 있어야!(l.city, d.location_id, e.department_id)
                        -- 우항의 컬럼은 인덱스 걸려 있어도 이용 안 함!
                        -- 인덱스 설계는 무슨 컬럼을 driving 하느냐에 따라 달라짐(l => d => e)
                        -- 비 join 조건 술어가 없으면 nested loop join 하면 안 됨!(성능 저하)
                        
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



select /*+ use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';
-- nested loop가 2번 나옴(Oracle의 새로운 기능!)



-- # ordered: from절에 나열되어 있는 table의 순서대로 join 수행
select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- nested loop(큰 테이블을 driving, 작은 테이블을 driven)

select /*+ ordered use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from departments d, employees e
where e.department_id = d.department_id; -- 테이블의 순서를 바꿈!(buffer 줄어듬)

-- # leading(join의 순서 결정): from절의 순서와는 상관 없이, leading을 통해 순서 제어!
--   use_nl() <- 여기의 순서는 실제 join의 순서와 상관 없음
--   ordered보다 쓰기 편함
select /*+ leading(e,d) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select /*+ leading(e,d) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id; -- nested loop(큰 테이블을 driving, 작은 테이블을 driven)

select /*+ leading(d,e) use_nl(e,d) */ e.last_name, e.salary, e.job_id, d.department_name
from departments d, employees e
where e.department_id = d.department_id; -- 테이블의 순서를 바꿈!(buffer 줄어듬)

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



-- 3개의 변수
select /*+ leading(l, d, e) use_nl(d) use_nl(e) */ e.*, d.*, l.* -- use_nl()는 inner 쪽만 적음!
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto';



-- nested loop가 2번 나온 이유

-- # table prefetch 기법
--   - 디스크 I/O가 발생하게 되면, 비용이 많이 들기 때문에, 
--     한 번에 I/O call이 필요한 필요한 시점에 곧이어 읽을 가능성이 있는 block을 
--     data buffer cache에 미리 적재해 두는 기능
select /*+ optimizer_features_enable('10.2.0.5') leading(d,e) use_nl(e,d) */ -- 구 버젼
       e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- 버젼을 낮춤 => 실행 계획 변경!(nested loop가 한 개로 바뀜)
                          -- inner table이 1번에 올라가 있음, 3,4번이 outer
                          -- prefetch 기법: physical I/O의 수를 줄여서 성능이 좋아짐
                          -- <- inner table이 range scan할 때 수행됨(unique scan 때는 안 됨)
                          -- 메모리에 없는 걸 확인하면, 데이터를 각 블록에 검색해서 "한꺼번에" 꺼냄
                          -- 일반적인 기법: 하나씩 하나씩 끄집어냈음
                          -- clustering factor가 나쁜 경우, 성능 향상에 도움이 됨
                          -- 개선할 점: inner의 leaf 블록만 가지고(rowid를 가지고) 일단 join 수행

-- # batch I/O 기법
--   - inner 쪽 인덱스와 조인하면서 중간 결과 집합(active set) 만든 후에 
--     inner 테이블과 일괄(batch) 처리한다. 
select /*+ optimizer_features_enable('11.2.0.1.1') leading(d,e) use_nl(e,d) */ 
       e.last_name, e.salary, e.job_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- 신 버젼: nested loop가 연달아 나옴
                          -- 2번을 제일 먼저 수행, 3번(outer), 5번(inner)이 같은 레벨
                          
select /*+ leading(d,e) use_nl(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500;  -- batch I/O 기법으로 수행

-- nlj_batching()
select /*+ leading(d,e) use_nl(e) nlj_batching(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500;  

select /*+ leading(d,e) use_nl(e) no_nlj_batching(e) */ e.*, d.*
from employees e, departments d
where e.department_id = d.department_id
and d.location_id = 2500; -- 위와 다르게 나옴

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));



-- 2. Sort Merge Join
--    - join되는 건수가 많을 때 유리
--    - BUT sort에 대한 성능 문제가 발생할 수 있다
--    - 힌트: use_merge()
--    - driving/outer table로 1쪽 집합이면서 작은 테이블을 설정하기!
--    - 단점: 자동적으로 order by절을 수행하기 때문에 성능 저하!
--    - outer = first // inner = second <- 용어 체크!

select e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id;
-- F10: SORT MERGE JOIN
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
-- 두 테이블 전체를 바라봐야 함(건수가 많음)
-- => nested join은 부적절(range가 너무 넓어짐)
-- => sort join이나 hash join 사용!
-- 대용량 테이블이고, 비 join 조건 술어가 없으면 optimiser가 sort join이나 hash join 수행!

-- sort merge join: 두 테이블을 아래처럼 2개의 select문으로 나눠서 실행한다음, merge!
--                  (메모리에서 수행되는 거!)
select last_name, salary, department_id
from emp
order by 3; -- 오름차순 정렬(sorting)
select department_id, department_name
from dept
order by 1; -- 오름차순 정렬(sorting)
-- driving table: DEPT(1쪽을 가지고 M쪽을 스캔!)
-- sort merge join: join의 순서가 중요(driving/outer로 1쪽 집합을 설정하기!)
-- 10번 부서의 사원들을 쭉 스캔한 다음, 표시자를 설정해 놓은 다음, 20번 부서의 사원들을 스캔 <- sort가 되어 있기 때문에 가능
-- (무작정 처음부터 끝까지 스캔하지는 않음!)
-- LOC <- 3개로 만들어짐

-- 단점: 자동적으로 order by절을 수행하기 때문에 성능 저하!
-- order by 작업을 수행할 컬럼에 index가 걸려 있는 경우

-- 실행 계획의 3번이 index full scan인 이유 => 순서대로 봐야 하기 때문 => single block I/O
-- I/O가 27번(index 수)이 아닌 6번 발생한 이유 <- buffer pinning
-- 1번이 sort join이 아닌 이유 <- index를 사용하기 때문(작은 테이블이라서 가능)
-- cf) 5번 => index를 이용하게 되면 random I/O가 107번 발생 
--        => 용량이 큰 table은 index가 있어도 그냥 sort 작업 발생(sort join)
--        => 성능 저하!(4번의 메모리 사용량 체크!)
-- 작은 테이블을 driving/first table로 설정!(실행 계획의 앞에 놓음)

-- 힌트를 사용하여 sort merge join 수행
select /*+ use_merge(e,d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id;
-- e.department_id(M쪽 집합의 key) // d.department_id(1쪽 집합의 key)
select /*+ leading(d,e) use_merge(e) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
-- leading을 통해 driving table 설정(use_merge()에는 driven table만 적음!)
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
select /*+ leading(d,e) use_merge(e) full(d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; -- second(driven) table은 무조건 sorting!

-- cf. M쪽 집합을 driving으로 설정하는 경우(wrong!)
select /*+ leading(e,d) use_merge(d) */ e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
select /*+ leading(e,d) use_merge(d) index(e emp_dept_id) */ 
       e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 
-- 작은 테이블을 sorting 하니까 4번의 메모리 사용량은 줄었음
-- BUT 보편적으로 oracle은 driving table을 sort 작업하지 않음(index scan) 
--     => 작은 테이블을 driving 하면 random I/O 발생해도 별 문제 없음
-- cf. 큰 테이블을 driving하면 random I/0가 상당히(row의 전체 건수만큼) 많이 발생
--     => clustering factor가 나쁠 경우 성능 저하가 심각해질 수 있음
--     => 이 경우 index 안 쓰고 자동적으로 full scan이 수행될 수 있음(CPU 성능 저하)
--     ** 양쪽 테이블을 sort join한 경우(밑의 select문) => buffer는 줄어들었지만, 메모리 사용량 증가 
--        <- 테이블의 크기가 커지면 문제가 될 수 있음
select /*+ leading(e,d) use_merge(d) full(e) full(d) */ 
       e.last_name, e.salary, d.department_name
from emp e, dept d
where e.department_id = d.department_id; 



-- ### 대용량 데이터!(buffer 수가 확연히 차이나는 것을 확인하는 것이 가능!)
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






select * from user_ind_columns where table_name = 'EMPLOYEES'; -- 각 컬럼에 걸려 있는 인덱스 확인
select * from user_indexes where table_name = 'EMPLOYEES';








-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------





-- ## 분석함수

-- # 누적합을 구하는 법 <- over!

select employee_id, 
       salary,
       department_id,
       sum(salary) over (order by department_id asc rows between unbounded preceding and current row) as total
from employees
where department_id = 20;

-- self join 이용
select e.employee_id, e.salary, e.department_id, sum(t.salary) as total
from employees e, employees t
where e.department_id = 20
and t.department_id = 20
and e.employee_id >= t.employee_id -- cummulative
group by e.employee_id, e.salary, e.department_id -- select에서 그룹 함수를 제외한 모든 컬럼은 group by절에 들어가야!
order by 1;
-- 큰 테이블을 2번 액세스하고 있음(조건절이 없음) => 성능 저하!(분석 함수 이용하기!)



-- 일반적인 그룹 함수의 select문에 over를 써서 누적합 구함!
select employee_id, salary, department_id, sum(salary) over (order by employee_id) as total
from employees
where department_id = 20;

select employee_id, salary, department_id, sum(salary) over (order by employee_id) as total
from employees;

-- cf1. order by 제외 => 그냥 총액만 리턴해줌!
select employee_id, salary, department_id, sum(salary) over () as total
from employees
where department_id = 20;

-- cf2. average 함수 사용
select employee_id, salary, department_id, avg(salary) over (order by employee_id) as average
from employees
where department_id = 20;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

-- partition by
select employee_id, salary, department_id, 
       sum(salary) over (partition by department_id) as dept_total, -- 부서 별 총합이 row 단위로 리턴
       sum(salary) over (partition by department_id order by employee_id) as total -- 부서 별로 나눈 다음 누적합(partition by 안 쓰면 그냥 전체 row를 대상으로 누적합을 구함!)
from employees;



-- # top-n 분석
-- rank(): 2등이 2명이면 그 다음은 4등!
-- dense_rank(): 연이은 순위(1223456678...)
-- rank 함수에도 partition by해서 부서 별로 랭크하는 거 가능!
select employee_id, salary, 
       rank() over(order by salary desc), -- 급여를 desc 정렬하고 순위를 매김
       dense_rank() over(order by salary desc)
from employees;

select employee_id, salary,
       sum(salary) over(order by employee_id rows between unbounded preceding and current row) rank1, -- row 단위로 계산
       sum(salary) over(order by employee_id) rank2, -- rank1과 같음(default)
       sum(salary) over(order by employee_id rows between unbounded preceding and unbounded following) rank3, -- 총합(처음부터 끝까지)
       sum(salary) over() rank4 -- rank3와 같음
from employees;

-- rows between unbounded preceding and current row: 정렬 결과의 처음부터 "현재행"까지를 대상 <- current row
-- rows between unbounded preceding and unbounded following: 정렬 결과의 처음과 "끝"을 대상(전체합) <- unbounded following

select department_id, salary, 
       first_value(salary) over (partition by department_id order by salary rows between unbounded preceding and unbounded following) first_value,
       last_value(salary) over (partition by department_id order by salary rows between unbounded preceding and unbounded following) last_value
from employees;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));