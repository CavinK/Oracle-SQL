-- HR session

select * from employees where employee_id = 100;
select * from employees where employee_id = 101;
select * from employees where employee_id = 102;
-- 상수값이 다름 => 다른 실행 계획으로 인식 => 각각 다른 LCO 생성
-- => 변수 처리로 해결!(PLSQL)

/*
# SQL Plus
------------------
conn hr/hr
var b_id number         <- b_id: 바인드 변수(number 타입), number 타입에는 size를 적지 않음
print b_id              <- bind variable에 사용!!!

execute :b_id := 100    <- 변수 할당(: 사용)
select * from employees where employee_id = :b_id;  <- 바인드 단계

exec :b_id := 200       <- 다른 변수 할당
------------------
var b_name varchar2(30) <- b_name: 바인드 변수(char 타입), size 안 적으면 1바이트로 자동 설정(default)
exec :b_name:='King'
print b_name 
select * from employees where last_name = :b_name;

exec :b_name:='Grant'
print b_name
select * from employees where last_name = :b_name;

var v_id number(1)      <- to figure out each type
*/
-- 바인드 변수: 세션창이 열려있는 동안은 계속 유지됨
--             (세션 데이터 정보에 바인드 변수가 만들어짐)
-- 실제값: 바인드 단계에 들어감(:b_id에서 employee_id로)

-- 메뉴 -> 보기 -> DBMS출력 -> hr 접속
-- SQL Plus에서 실행할 때는, set serveroutput on을 먼저 실행하고 수행하기
-- SQL Plus: l 수행 => 이전 명령어 // / 수행 => 출력된 결과

-- PL/SQL <- 블록 구조 형식!!!
begin
      dbms_output.put_line('곽윤신');
      dbms_output.put_line('오늘도 행복하다!!');
end;
/

declare
        /* scalar data type(단일값만 보유하는 변수) */
        v_a number(7); -- 해당 프로그램 안에서만 사용되는 변수(지역변수) <- 변수 선언 뒤에는 꼭 ;로 닫아주기, 무조건 "하나씩만" 선언하기!
        v_b number(3) := 100; -- 초기값 할당 // '100'라고 해도 오류 나지는 않음!(but 형 변환 수행)
        v_c varchar2(10) not null := 'plsql'; -- not null 제약조건 추가, 여기에 초기값 설정 안 하면 오류!(exception)
        v_d constant date default sysdate; -- 할당연산자(:=)와 default는 같은 의미!
                                           -- constant: 상수를 선언하는 키워드(다른 값은 넣을 수 없고, 초기값만 사용 가능) => 상수를 선언했을 때는 무조건 초기값 설정!
begin
        v_a := 200; -- 변수값은 언제든지 대체 가능!
        v_b := 300;
        dbms_output.put_line('v_a 변수에 있는 값은 :' || v_a); -- 문자 연결 연산자 + NULL은 문자!
                                                            -- 실행하면, v_a는 NULL, v_b는 초기값 리턴
        dbms_output.put_line('v_b 변수에 있는 값은 :' || v_b);
        dbms_output.put_line('v_c 변수에 있는 값은 :' || v_c);
        dbms_output.put_line('v_d 변수에 있는 값은 :' || v_d);
        
        v_a := 200; 
        v_b := 300;
        v_d := sysdate+1; -- exception!(상수 선언 했기 때문 cf. 그 외: 변수 선언)
        dbms_output.put_line('v_a 변수에 있는 값은 :' || v_a); 
        dbms_output.put_line('v_b 변수에 있는 값은 :' || v_b);
        dbms_output.put_line('v_c 변수에 있는 값은 :' || v_c);
        dbms_output.put_line('v_d 변수에 있는 값은 :' || v_d);
        
        v_a := 200; 
        dbms_output.put_line('v_a 변수에 있는 값은 :' || v_a); 
        dbms_output.put_line('v_b 변수에 있는 값은 :' || (v_b+100)); -- 괄호 없애면 exception!(우선순위 발생, 문자에다 숫자를 더 할 수 없으니 numeric or value error 발생)
        dbms_output.put_line('v_c 변수에 있는 값은 :' || v_c);
        dbms_output.put_line('v_d 변수에 있는 값은 :' || (v_d+10)); -- 상수는 이렇게 변경!
end;
/

-- 변수를 프로그램 바깥으로 전달하고 싶은 경우, 바깥에 있는 변수를 안으로 들여와야 하는 경우
-- bind variable: global variable, public variable, 전역변수

declare
        v_sal number := 1000;
        v_comm number := 100;
        v_total number;
begin
        v_total := v_sal + v_comm;
        dbms_output.put_line(v_total);
end;
/
select * from employees where salary > v_total; -- v_total은 지역 변수라서 프로그램 밖에선 실행 안 됨(로컬 변수의 제약)

-- bind variable 3개 선언
var b_total number -- var에서는 number에 사이즈 적용하지 않음!(char는 명시)
var b_sal number
var b_comm number -- ; 안 써도 됨(bind variable은 프로그램 바깥에서 선언해야!)
                  -- bind variable: session이 끝날 때까지 저장됨

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
select * from employees where salary > :b_total; -- SQL Plus에서 실행!
-- global variable: 입력/리턴 가능 BUT declare절에는 선언할 수 없음!(bind variable 이용해야!)
-- bind variable(host variable <- 프로그램 바깥에서 선언된 변수) <- SQL 툴에 종속(SQL Plus, SQL Developer)
-- => package를 만들어야!



-- # 변수 선언 시 주의해야 할 점
-- 변수 이름
-- - 문자로 시작해야 한다.
-- - 문자, 숫자, 특수문자(_, $, #) 포함할 수 있다.
-- - 문자 길이는 30자 이하의 문자로만 사용해야 한다.
-- - 예약어는 사용 못 한다(ex. declare, begin, end, exception, select, insert, ...)

-- 변수를 선언할 시에 not null, constant로 지정된 변수에는 초기값을 무조건 할당해야 한다.
-- 할당연산자(:=, default)
-- 한 줄에 하나씩만 선언!

declare
        v_name varchar2(20); -- local, private 변수
begin
        dbms_output.put_line('my name is : ' || v_name); -- 문자 || null => 문자
        v_name := 'james';
        dbms_output.put_line('my name is : ' || v_name);
        v_name := '홍길동';
        dbms_output.put_line('my name is : ' || v_name);
end;
/



-- # subblock(중첩 수행)
declare
        v_sal number(8,2) := 60000; -- number(8,2): 8자리 중에 2자리는 소수
                                    -- 변수 선언할 때는 중복 못 함!!!(변수 하나만 선언)
                                    -- subblock에서는 선언 가능
        v_comm number(8,2) := v_sal * 0.20;
        v_message varchar2(100) := ' eligible for commission';
begin
        declare
                v_sal number(8,2) := 50000; -- block이 다르기 때문에, 다른 변수나 마찬가지 // 자기 블록에 있는 변수값을 메인 블록의 그것보다 우선시!
                v_comm number(8,2) := 0;
                v_total number(8,2) := v_sal + v_comm;
        begin
                dbms_output.put_line(v_total);
        end;
        
        declare
                -- v_sal number(8,2) := 50000; -- 주석 처리 => 일단 자기 블록에 해당 변수를 찾고 그 다음에 메인 블록을 검색
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
                v_message := 'clerk not ' || v_message; -- 메인블록의 변수와 붙여서 overriding 가능!
                dbms_output.put_line(v_total); -- 서브블록의 값을 리턴
                dbms_output.put_line(v_sal);
                dbms_output.put_line(v_comm);
                dbms_output.put_line(v_message);  -- 메인블록을 참조!
        end;
        dbms_output.put_line(v_sal); -- 메인블록의 값을 리턴
        dbms_output.put_line(v_comm);
        dbms_output.put_line(v_message);
        dbms_output.put_line(v_total); -- 오류!(서브블록에서는 메인블록을 참조할 수 있지만, 그 반대는 안 됨) // 서브블록의 변수는 서브블록에서만 사용 가능
                                       -- v_total을 계속 쓰고 싶으면, global variable 이용!
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
                outer.v_sal := 70000; -- 해당 label(outer)의 변수값을 아예 새로 지정 // outer 안 쓰면 서브블록의 v_sal을 수정
                v_message := 'clerk not ' || v_message; 
                dbms_output.put_line(v_total);
                dbms_output.put_line(v_sal);
                dbms_output.put_line(outer.v_sal); -- 바깥 블록의 변수라는 뜻
                                                   -- 메인블록과 서브블록의 변수명이 동일할 경우, label을 씀!
                dbms_output.put_line(v_comm);
                dbms_output.put_line(v_message); 
        end;
        dbms_output.put_line(v_sal); -- 이것도 70000으로 리턴(순서상 서브블록에서 넘어오는 것이기 때문)
        dbms_output.put_line(v_comm);
        dbms_output.put_line(v_message);
end;
/

-- # 변수
-- 어떤 값을 임시로 저장한 후 재사용 목적으로 변수를 선언해서 사용한다
/*
## scalar data type 변수: 단일값을 보유하는 변수
- 익명블록: oracle db 안에 이 프로그램이 저장되어 있지 않음 <- 내가 수동적으로 가지고 있으면서 매번 이 소스 가지고 수행 
           <- 수행할 때마다 매번 compile해야 함(shared pool에 내가 수행한 프로그램이 들어가 있음 => library cache에 있는 지 확인 => 없으면 실행 계획 따로 만듬)
           <- 오래된 것들은 aging out됨(v$sql에서 executions 숫자 확인) 
           => hard parsing의 우려!(object 단위의 프로그램을 만들 필요가 있음 => reparsing 감소)
- 익명블록: object(select, DML) 권한만 있으면 됨!
- 익명블록의 단점 1. reparsing 우려
                2. share 안 됨(oracle db 안에 이 프로그램이 저장되어 있지 않기 때문) => 다른 사람들도 각자 소스를 가지고 있어야 함 => object 단위의 프로그램!(시스템 권한 필요) <- select * from user_sys_privs;
                3. 입력값(:b_id) 처리 시 tool에서 지원하는 거(bind variable) 밖에 사용 못 함
*/
select * from user_sys_privs; -- user가 가지고 있는 권한 확인
select * from user_tab_privs; -- object 권한
-- create procesure: procedure 함수 패키지에 대한 권한
-- 제약조건들은 트리거로 짜여져 있음(자동 수행)

/*
declare
          변수 선언;
          임시적 커서 선언;
          사용자가 정의한 예외사항 선언;
begin
          로직구현;
          select;
          dml;
          commit, rollback, savepoint;
exception
          실행부분에서 발생한 오류 처리하는 부분;
end;
/
*/

-- PL/SQL은 절차적 언어
-- => 하나가 틀리면 밑의 logic들이 전부 수행 안 됨
-- => 문제가 발생하더라도 꼭 수행해야 할 logic이 있는 경우
-- => subblock 사용!!!
declare
        v_name varchar2(20) := '홍길동';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('학생 이름은 ' || v_name);
        dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name varchar2(20) := '박찬호';
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '손흥민'; -- 서브블록의 데이터만 업데이트됨
                dbms_output.put_line('학생 이름은 ' || v_name);
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
        end; -- 메인블록과 서브블록의 데이터는 다른 공간에 저장됨!(서브블록의 데이터는 수행되는 순간 없어지고 메인블록의 데이터 사용)
end;
/

<<outer>>
declare
        v_name varchar2(20) := '홍길동';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('학생 이름은 ' || v_name);
        dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
        declare
                -- v_name varchar2(20) := '박찬호'; <- 주석처리 => 메인블록의 데이터를 찾음 => 없으면 오류!
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '손흥민';
                dbms_output.put_line('학생 이름은 ' || v_name);
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('학생 이름은 ' || outer.v_name); -- outer label에 있는 데이터를 갖다 씀 => 그 label의 데이터 리턴
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(outer.v_date,'yyyymmdd'));
        end; 
                dbms_output.put_line('학생 이름은 ' || v_name);
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
end;
/

=================================================================================================================

<<outer>>
declare
        v_name varchar2(20) := '홍길동';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('학생 이름은 ' || v_name);
        dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name2 varchar2(20) := '박찬호';
                v_date date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name := '손흥민';
                dbms_output.put_line('학생 이름은 ' || v_name);
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('학생 이름은 ' || v_name2); 
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(outer.v_date,'yyyymmdd'));
        end; 
                dbms_output.put_line('학생 이름은 ' || v_name2); -- 메인블록에서는 서브블록의 변수 사용 못 함
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
end;
/

<<outer>>
declare
        v_name varchar2(20) := '홍길동';
        v_date date := to_date('2018-01-01','yyyy-mm-dd');
begin
        dbms_output.put_line('학생 이름은 ' || v_name);
        dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
        declare
                v_name2 varchar2(20) := '박찬호';
                v_date2 date := to_date('2017-01-10','yyyy-mm-dd');
        begin
                v_name2 := upper('james'); -- procedure문 <- 이거 말고도 밑에 구문들도 전부 procedure문이라고 부름
                                           -- procedure문에 쓸 수 없는 함수들이 존재!
                dbms_output.put_line('학생 이름은 ' || v_name);
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
                dbms_output.put_line('학생 이름은 ' || v_name2); 
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date2,'yyyymmdd'));
        end; 
                dbms_output.put_line('학생 이름은 ' || v_name); -- 메인블록에서는 서브블록의 변수 사용 못 함
                dbms_output.put_line('학생이 수강한 날짜는 ' || to_date(v_date,'yyyymmdd'));
end;
/
-- # procedure문(begin, declare절)에 쓸 수 없는 함수들
-- 1. decode() 함수 <- BUT case는 가능
-- 2. 그룹함수: avg(), sum(), mas(), min(), count(), stddev(), variance()



select last_name
from employees
where employee_id = 100; -- 이 select문을 프로그램에 넣어보기!

begin
      select last_name
      from employees
      where employee_id = 100; -- 오류!
                               -- 기존의 select문을 프로그램에 넣으려면, 나름대로의 규칙을 생각해야!
                               -- 데이터를 변수에 load!
end;
/

-- # select into
-- into절: fetch절
-- 암시적 cursor: 이 안에서 select ... into ..., dml(insert, update, delete, merge)가 수행됨
-- - select into: 반드시 1개의 row만 fetch해야 한다!(where절로 제한)
--                0개: no_data_found
--                1개 초과: too_many_rows => 해결방법: 명시적 cursor 사용!(여러 개의 rows를 fetch)
-- - dml <- 몇 건이 manipulate되던 상관 없음!
declare
        v_lname varchar2(20); -- 사이즈 <- 실제 데이터의 길이에 맞게 설정하기!(hard coding 방식: 내가 실제 데이터의 타입과 사이즈를 직접 확인해서 설정하는 거)
                              -- hard coding 방식의 단점 1. 귀찮음 2. 타입, 사이즈가 modify될 경우 다 유지보수해야 함
begin
        select last_name
        into v_lname -- fetch 단계(내가 필요한 정보만 cursor에 넣어서 user에 전달 => 변수에 load 시켜야!)
                     -- into절의 변수는 select의 컬럼 개수만큼 있어야!(각각 대응되게!)
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
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); -- 이 select문 <- "암시적 cursor"라고 부름!(oracle이 자동적으로 만드는 cursor)
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
        where employee_id = 300; -- no data found <- select into에는 1개의 row만 fetch해야 하는데, 이 경우는 0개의 row를 fetch => exception!
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
        where department_id = 10; -- 실행됨(10번 부서에 속한 사원은 1명이기 때문)
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
        where department_id = 20; -- 오류(20번 부서에 속한 사원은 여러 명(multiple rows)이기 때문)
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

-- cf. 명시적 cursor: 여러 개의 rows를 fetch!



-- # hard coding 방식: 내가 실제 데이터의 타입과 사이즈를 직접 확인해서 설정하는 거
-- 단점 1. 귀찮음
-- 단점 2. 해당 컬럼의 타입, 사이즈가 modify될 경우, 전부 유지보수해줘야!

-- solution) soft coding(%type)
-- 테이블.컬럼%type // 변수%type
declare
        v_lname employees.last_name%type; -- 해당 컬럼의 타입과 사이즈를 그대로 땡겨 쓰겠다는 뜻
        v_fname v_lname%type; -- 위 변수의 타입과 사이즈를 그대로 가져다 쓰겠다는 뜻
        v_sal employees.salary%type;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 100;
        dbms_output.put_line(v_lname || ' ' || v_fname || ' ' || v_sal); 
end;
/

-- bind variable 이용
declare
        v_lname employees.last_name%type; 
        v_fname v_lname%type; 
        v_sal employees.salary%type;
begin
        select last_name, first_name, salary
        into v_lname, v_fname, v_sal
        from employees
        where employee_id = 101; -- 위(emp_id = 100)와 다른 익명 블록 구조!(다른 상수값이기 때문) 
                                 -- => 다시 compiling해야 함(LCO가 2개 만들어짐)
                                 -- => 변수 처리로 해결!(bind variable 이용)
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
create table test(id number, name varchar2(20), day date); -- default tablespace에 저장(user_users)
desc test

-- i) insert 작업 수행
insert into test(id, name, day)
values(1, '홍길동', to_date('2018-01-01', 'yyyy-mm-dd')); -- transaction(아직 영구히 저장된 건 아님)
                                                         -- parse - bind - execute (fetch는 되지 않음)
select * from test; -- 본인은 변경 사항 확인 가능

rollback;

-- ii) 프로그램 안에서 insert
begin
        insert into test(id, name, day)
        values(1, '홍길동', to_date('2018-01-01', 'yyyy-mm-dd')); 
        -- 몇 개가 insert/update/delete가 됐는지 스크립트에 안 나옴 => 불편!
        -- 프로그램 끝나도 진행 중인 상태로 남아 있음 => update/delete의 경우, 해당 row에 대해 lock이 걸림! 
        -- => 다른 user들이 확인 못 함!!(wait 단계) 
        -- 트랜잭션을 끝낼 지 말 지를 판단해야!(lock 충돌 상태는 DBA가 해결 가능하지만, user가 프로그램 작성 시 해결하는 습관 갖기)
end;
/
select * from test;

var b_id number
var b_name varchar2(20)
var b_day number(10) -- date 타입이 없음! => char로 만들어야!
var b_day varchar2(30)

exec :b_id := 1
exec :b_name := '홍길동'
exec :b_day := '20180101'
exec :b_id := 2
exec :b_name := '곽윤신'
exec :b_day := '20180705'

print b_id b_name b_day

begin
        insert into test(id, name, day)
        values(:b_id, :b_name, to_date(:b_day,'yyyymmdd'));
end; -- 바인드 변수에 새로운 값 넣고 계속 수행 => BUT 이 데이터는 영구히 저장된 것들이 아님(다른 session에서는 확인 불가능) => commit/rollback으로 확정!
/
select * from test; 

commit;

begin
        insert into test(id, name, day)
        select employee_id, last_name, hire_date -- values절 대신 subquery => subquery의 데이터가 모두 insert 됨
        from employees;
end;
/

rollback;

begin 
        update test
        set name = '박찬호'
        where id = 1;
end; -- 몇 개의 row가 update되었다고는 나오지 않음
/
select * from test; 

rollback;

var b_id number
var b_name varchar2(20)
exec :b_id := 1
exec :b_name := '박찬호'

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
exec :b_name := '박찬호'

begin
        update test
        set name = :b_name
        where id = :b_id; -- 0번 사원(:b_id = 0)은 존재하지 않음(update 안 됨) 
                          -- => BUT 스크립트에서는 성공했다고 나옴(수정이 된 게 있는 지 없는 지 알 수 없음) 
                          -- => 암시적 cursor의 속성으로 판단 <- dbms_output.put_line(sql%rowcount);
end;
/
select * from test; 

rollback;

begin
        update test
        set name = :b_name
        where id = :b_id; 
        dbms_output.put_line(sql%rowcount); -- update된 건수 리턴
end;
/
select * from test; 

rollback;

var b_id number
var b_name varchar2(20)
exec :b_id := 1
exec :b_name := '박찬호'

begin
        update test
        set name = :b_name
        where id = :b_id; 
        dbms_output.put_line(sql%rowcount || q'[개의 row가 수정되었습니다!]'); -- update된 건수 리턴
end;
/
select * from test; 

begin
        insert into test(id, name, day)
        select employee_id, last_name, hire_date 
        from employees;
        dbms_output.put_line(sql%rowcount || q'[개의 row가 insert 되었습니다!]');
end;
/

rollback;

drop table emp purge;

create table emp as select * from employees;

begin
        update emp
        set salary = salary * 1.1
        where department_id = 30;
        dbms_output.put_line(sql%rowcount || ' 행이 수정');
end;
/
select * from emp; 

rollback;

begin
        delete from emp where department_id = 20; -- 암시적 cursor에서 수행
        
        update emp
        set salary = salary * 1.1
        where department_id = 30; -- 암시적 cursor에서 수행
        
        dbms_output.put_line(sql%rowcount || ' 행이 수정'); -- update에 대한 속성(바로 전 꺼)
end;
/
select * from emp; 

begin
        delete from emp where department_id = 20; 
        dbms_output.put_line(sql%rowcount || ' 행이 삭제'); -- 바로 전 꺼에 대한 속성을 보여줌
        update emp
        set salary = salary * 1.1
        where department_id = 30;         
        dbms_output.put_line(sql%rowcount || ' 행이 수정'); 
end;
/
select * from emp; 

rollback;



-- # sql%found
-- update에 영향 받은 row가 있으면 true, 없으면 false를 리턴(boolean)
-- ** 조건제어문에서 Null은 false!
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 100;
        
        if sql%found then
                dbms_output.put_line('수정됨');
        else
                dbms_output.put_line('수정안됨');
        end if;
        rollback;
end;
/

begin
        update emp
        set salary = salary * 1.1
        where employee_id = 00; -- 영향을 입은 row가 없음 => 수정안됨
        
        if sql%found then
                dbms_output.put_line('수정됨');
        else
                dbms_output.put_line('수정안됨');
        end if;
        rollback;
end;
/

-- # sql%notfound(위와 반대)
-- 수정된 게 없을 경우 true
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 00;
        
        if sql%notfound then
                dbms_output.put_line('수정됨');
        else
                dbms_output.put_line('수정안됨');
        end if;
        rollback;
end;
/
-- merge도 그대로 넣어주면 됨

-- 이렇게 하면 안 됨
declare
        v_name varchar2(20);
        v_sal number;
begin
        select last_name, salary
        into v_name, v_sal
        from employees
        where employee_id = 100;
        
        if sql%found then
                dbms_output.put_line('결과=> '||'사원번호:'||:v_id||', '||'사원이름: '||v_name||', '||'사원급여: '||v_sal);
        else
                dbms_output.put_line('사원이 없습니다.');
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
                dbms_output.put_line('수정됨');
        else
                dbms_output.put_line('수정안됨');
        end if;
        rollback;
end;
/



-- # 튜닝(returning절 사용)
var b_id number
execute :b_id := 100
declare
        v_sal emp.salary%type;
begin
        select salary
        into v_sal
        from emp
        where employee_id = :b_id;
        
        dbms_output.put_line(q'[수정 전 월급 : ]' || v_sal);
        
        update emp
        set salary = salary * 1.1
        where employee_id = :b_id
        returning salary into v_sal; -- returning절: 수정된 salary값을 바로 조회(fetch) 가능 
                                     -- => select문을 추가적으로 쓰지 않아도 됨
                                     -- => 성능 향상
        
        dbms_output.put_line(q'[수정 후 월급 : ]' || v_sal);
        
        rollback;
end;
/



-- # 조건 제어문(if)
-- - true/false
-- - boolean(data type)
declare
        v_flag boolean := true; -- true는 상수값처럼 이용('' 쓰지 않음!)
begin
        if v_flag then
              dbms_output.put_line('True');
        end if;
end;
/

declare
        v_flag boolean := false; -- 그냥 end if로 빠져나옴(return nothing)
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
              dbms_output.put_line('False'); -- else는 optional => v_flag 조건이 false면 else절 수행
        end if;
end;
/



-- # if문(if ~ elsif ~ end if)
/*
if 조건 then
        참값
elsif 조건 then
           참값
elsif 조건 then
           참값
else
           기본값
end if;
*/

-- # 비교 연산자
-- x < y : x가 y보다 작다
-- x > y 
-- x = y
-- x != y
-- x >= y
-- x <= y

-- # 논리 연산자
-- and, or, not

-- # null 비교
-- is null, is not null
-- cf. x = null (wrong!)

/*
ex. 
x := 1
y := null

** 조건제어문 => true/false
*** 위 경우에는 false이므로, else절 수행

if x = y then
         ....
else
         ....
end if;
*/



-- # case 표현식
/*
* decode(), 그룹함수는 procedure에서 사용 못 함
v_a := upper('a'); <- procedure문에서 사용 가능
v_sal := sum(v_salary); <- procedure문에서 사용 불가능하다.
v_flag := decode(....); <- 사용 불가

cf.
v_flag := case(...); <- 사용 가능하다
                     <- 혼자서 사용 못 함!(DML 이용)
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
        dbms_output.put_line('등급은 ' || v_grade || ' 평가는 ' || v_appraisal);
end;
/
-- 경우에 따라서는 case문을 if문으로 써도 됨

declare
        v_grade char(1) := upper('c');
        v_appraisal varchar2(30);
begin
        v_appraisal := case when v_grade = 'A' then 'Very good'
                            when v_grade in ('B', 'C') then 'Good'
                            when v_grade = 'D' then 'Good effort'
                            else 'You''re not a human!!'
                       end;
        dbms_output.put_line('등급은 ' || v_grade || ' 평가는 ' || v_appraisal);
end;
/

-- # case문 <- case 표현식과는 다름!!
/*
case 조건
     when 비교1 then 참값1
     when 비교2 then 참값2
     else
          기본값
end case;
*/



-- # 반복문
-- 1. 기본 loop 구조 <- 무조건 계속 반복 => 무한 루프에 빠질 우려! => 멈춤 기능을 꼭 표현해야!
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1; -- 이렇게 놔두면 무한루프(overflow)
        end loop;
end;
/

declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1;
              exit; -- Loop 구조(반복문 형식)에서만 사용할 수 있는 구문 => 다른 데서 사용하면 안 됨!
        end loop;
end;
/

-- exit를 if문과 같이 쓰면서 조건 부여
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              i := i + 1;
              if i > 10 then
                        exit; -- 10번 반복하고 종료
              end if;
        end loop;
end;
/

-- cf. count 변수(i := i + 1;)를 if문 밑에 둠
declare
        i number := 1;
begin
        loop
              dbms_output.put_line(i);
              if i > 10 then
                        exit; 
              end if;
              i := i + 1; -- 11번 반복!
        end loop;
end;
/



-- 2. while loop문
-- while절에 먼저 조건 부여 => 무한 루프 방지!
-- 아예 loop가 수행되지 않는 경우를 만들고 싶을 때 사용!
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
        i number := 11; -- 아예 loop가 수행되지 않음
                        -- cf. 기본 loop 구조: 적어도 한 번은 수행됨
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
                              exit; -- exit는 어느 반복문에서든 사용 가능!
                    end if;
        end loop;
end;
/



-- 3. for문 <- 반복 횟수를 알고 있을 경우 사용
-- 카운트 변수(i)는 자동으로 만들어짐 <- 따로 declare할 필요 없음!
-- for 변수 in 작은값..큰값 loop
-- 변수는 implicit하게 1씩 증가하도록 설정되어 있음
-- 변수 i는 그냥 사용만 해야 함 <- 할당(i := i + 1;)해서는 안 됨! <- 3씩 증가, 5씩 증가 이렇게 만들지 못 한다는 뜻!!
begin
      for i in 1..10 loop -- 카운트 변수 i <- for문 안에서만 사용하는 지역 변수!(암시적으로 지정 => 따로 선언할 필요 없음)
              dbms_output.put_line(i);
      end loop;
end;
/

begin
      for i in 1..10 loop
              dbms_output.put_line(i);
              i := i + 3; -- 오류!(변수는 사용만 할 수 있고 할당은 못 함)
      end loop;
end;
/

declare
        v_start number := 1;
        v_end number := 10;
begin
        for i in v_start..v_end loop -- range에 변수 설정 가능!
              dbms_output.put_line(i);
        end loop;
end;
/

-- cf1. 변수에 null값 설정 => 오류!(범위는 꼭 지정해야!)
declare
        v_start number := 1;
        v_end number; -- null값
begin
        for i in v_start..v_end loop 
              dbms_output.put_line(i);
        end loop;
end;
/

-- cf2. 큰 값에서 작은 값 순으로 반복하고 싶은 경우 => in reverse!
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
-- 기본 loop, while, for 섞어서 쓸 수 있음
-- nested loop join(main loop의 row의 개수만큼 subloop가 수행됨)
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



-- # dbms_output.put() <- 데이터를 메모리에 "가로"로 쭉 쌓아놓고 후에 출력하는 거
-- # dbms_output.new_line <- 위에 껄 다음 행으로 떨어뜨리는 기능
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



-- # continue when: for문에서 조건이 true이면, 다시 위로 올라감(밑의 로직은 수행하지 않음)
-- subloop에서 main loop로 올라갈 수 있는 기능!
-- cf. exit: 아예 loop 구문을 빠져 나가는 것
-- continue 기능이 없으면 subloop 써야 함!(복잡)
declare
        v_total number := 0;
begin
        for i in 1..10 loop
            v_total := v_total + i;
            dbms_output.put_line('Total is : ' || v_total);
            
            continue when i > 5; -- 10번 반복하되, 6번째부터는 아래의 로직이 수행되지 않음
            
            v_total := v_total + i;
            dbms_output.put_line('Out of loop total is : ' || v_total);
        end loop;
end;
/

-- label 이용
declare
        v_total number := 0;
begin
        <<toploop>> -- main loop의 label
        for i in 1..10 loop
            v_total := v_total + i;
            dbms_output.put_line('Total is : ' || v_total);
        
        for j in 1..10 loop
            continue toploop when i+j > 5; -- i+j > 5이면, toploop로 올라가라는 뜻!(main loop로 가라는 의미) => sub loop는 수행되지 않음
            v_total := v_total + j;
            dbms_output.put_line('Out of loop total is : ' || v_total);
            end loop;
        end loop;
end;
/



-- # select절에서 * 를 fetch
-- ##조합 데이터 TYPE <- * 으로 테이블의 모든 열을 검색할 때, 변수 선언을 보다 심플하게 함
-- 1. 레코드 TYPE: 도시락의 칸막이 같은 거

-- a. 로컬 변수
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

-- b. 레코드 변수
-- 굳이 레코드 변수를 만들어야 하는 이유? 
-- oracle이 레코드 변수를 쉽게 만드는 법 제공
declare
        type dept_record_type is record
        (dept_id number, -- record의 내부 구성 요소의 필드명, 타입을 정함 
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number); -- user defined type(유저가 직접 내부 구성 요소의 타입 선언) => 4가지의 구성 요소를 받을 수 있는 모양으로 만들어짐(4개의 칸막이)
         v_rec dept_record_type; -- 변수 선언
begin
        select *
        into v_rec -- simpler
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.dept_id); -- (레코드변수명.필드명)
        dbms_output.put_line(v_rec.dept_name);
        dbms_output.put_line(v_rec.dept_mgr);
        dbms_output.put_line(v_rec.dept_loc);
end;
/

-- soft coding도 가능
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

-- c. %rowtype 속성
-- 타입 설정을 자동으로 하게 해줌
-- 레코드 타입을 손쉽게 만듬
declare
        v_rec departments%rowtype; -- 암시적으로(oracle이 알아서) 타입 선정
begin
        select *
        into v_rec
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.department_id); -- 컬럼 이름이 필드명이 됨!
        dbms_output.put_line(v_rec.department_name);
        dbms_output.put_line(v_rec.manager_id);
        dbms_output.put_line(v_rec.location_id);
end;
/

-- 레코드 안에 또 레코드
declare
        type dept_record_type is record
        (dept_id departments.department_id%type, 
         dept_name varchar2(30),
         dept_mgr number,
         dept_loc number,
         dept_rec departments%rowtype); -- 필드 안에다 레코드 형식의 필드를 또 만들 수 있음! 
         v_rec dept_record_type; 
begin
        select *
        into v_rec.dept_rec -- 메인필드.서브필드
        from departments
        where department_id = 10;
        dbms_output.put_line(v_rec.dept_rec.department_id); -- 메인 필드(v_rec) 안에 서브 필드(dept_rec) 안에 컬럼
        dbms_output.put_line(v_rec.dept_rec.department_name);
        dbms_output.put_line(v_rec.dept_rec.manager_id);
        dbms_output.put_line(v_rec.dept_rec.location_id);
end;
/

declare
        type dept_record_type is record
        (dept_id departments.department_id%type not null := 10, -- not null => 초기값 할당! 
                                                                -- %type는 타입만 물려 받고, 제약 조건은 이어 받지 않음!!
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

-- ## 조합데이터 유형
-- 스칼라 유형과는 달리 다중값을 보유할 수 있다

-- 1. 레코드 타입의 유형: 서로 다른 데이터 type의 값을 저장(꼭 select * 일때만 쓰는 거 아님) 
--    => scalar 데이터 유형을 모아놓은 거(단일값만 보유하는 변수들)
-- 2. 배열: "동일"한 데이터 type의 값을 저장 => 다른 type의 데이터를 저장하고 싶으면, 레코드와 같이 이용!
--    a. index by table(연관 배열)
--    b. nested table(중첩 테이블)
--    c. varray

-- # 배열 <- 변수 선언하고 거기에 값들을 쌓아놓음(실행 계획 공유)
begin
        update emp
        set salary = salary * 1.1
        where employee_id = 100;
        
        update emp
        set salary = salary * 1.1
        where employee_id = 200; -- 단점: 실행계획 2개를 따로 만들어야 함
                                 -- 배열을 통해 해결!(하나의 구문에 변수들을 쌓아놓음)
        
        rollback;
end;
/

-- 배열 => 1차원 배열만 가능(table of number, date <- 이런 식은 불가능(레코드 타입도 같이 이용해줘야 함!)
declare
        type table_id_type is table of number index by binary_integer; -- table_id_type: 배열 타입 이름
                                                                       -- index by: 요소 번호를 의미
                                                                       --           1. binary_integer: -2G ~ 2G, 총 4G의 크기
                                                                       --           2. pls_integer: 사이즈는 같음 + 부호 비트까지 가지고 있음 => 처리 속도 빠름
                                                                       --           3. varchar2: 32767까지 입력 가능 => integer가 더 나음
                                                                       --           cf. number 타입은 못 씀
        v_tab table_id_type;
begin
        v_tab(1) := 100; -- v_tab(요소번호) := 배열값 <- 음수값으로도 표현 가능
        v_tab(2) := 200;
        
        update emp
        set salary = salary * 1.1
        where employee_id = v_tab(1);
        
        update emp
        set salary = salary * 1.1
        where employee_id = v_tab(2); -- update문을 2개 썼더라도 실행 계획은 하나를 sharing
                                      -- BUT 여전히 긴 문장 => loop로 해결!
        
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

-- 변수.first: 배열에서 가장 작은 요소 번호가 뭔지 알려주는 메소드(첫번째 방이 아님!)
-- 변수.last
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
        v_tab(3) := 200; -- 오류!(no data found) => 1, 2, 3번 방을 확인해야 하는데, 2번 방에 데이터가 없기 때문
                         -- 없는 배열 값을 참조하려고 하면 무조건 오류
        
        for i in v_tab.first..v_tab.last loop -- i in 1..3 => 1, 2, 3
            update emp
            set salary = salary * 1.1
            where employee_id = v_tab(i);
        end loop;
        
        rollback;
end;
/

-- 변수.exists(): 몇 번째 방이 존재하는 지 안 하는 지의 여부를 확인하는 메소드
declare
        type table_id_type is table of number index by binary_integer; 
        v_tab table_id_type;
begin
        v_tab(1) := 100; 
        v_tab(3) := 200; 
        
        for i in v_tab.first..v_tab.last loop 
            if v_tab.exists(i) then -- v_tab.exists(2): 2번 방이 존재하면 true, 존재하지 않으면 false
                update emp
                set salary = salary * 1.1
                where employee_id = v_tab(i)
                returning employee_id into v_tab(i);
            else
                dbms_output.put_line(i || '번 방의 요소번호가 없습니다.');
            end if;
        end loop;
        
        rollback;
end;
/



-- 1차원 배열
declare
        type num_type is table of number index by pls_integer;
        v_num num_type;
begin
        for i in 100..110 loop
                  v_num(i) := i; -- for문을 이용해서 배열 방 번호와 값을 설정
        end loop;
        for i in v_num.first..v_num.last loop
                  dbms_output.put_line(q'[v_num(]' || i || q'[) = ]' || v_num(i));
        end loop;
end;
/

-- # 2차원 배열 <- record, table 혼합
-- record type 먼저 선언하고, 이를 배열의 타입(v_rec%type)으로 지정
declare
        type dept_rec_type is record(id number, name varchar2(30), mgr number, loc number);
        v_rec dept_rec_type;
        type dept_tab_type is table of v_rec%type index by pls_integer;
        v_tab dept_tab_type;
        
        /*
        type 레코드타입 is record(id number, name varchar2(30), mgr number, loc number);
        v_rec dept_rec_type;
        type dept_tab_type is table of 레코드타입 index by pls_integer;
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
                  dbms_output.put_line(i || '번 방에는 ' || v_tab(i).id || '번 부서의 정보');
        end loop;
end;
/

declare
        type dept_rec_type is record(id number, name varchar2(30), mgr number, loc number);
        
        type dept_tab_type is table of dept_rec_type index by pls_integer; -- record type을 따로 변수 지정할 필요는 없음!
        v_tab dept_tab_type;
begin
        for i in 1..5 loop
                  select *
                  into v_tab(i)
                  from departments
                  where department_id = i * 10;
        end loop;
        
        for i in v_tab.first..v_tab.last loop
                  dbms_output.put_line(i || '번 방에는 ' || v_tab(i).id || '번 부서 ' || v_tab(i).name || '의 정보'); -- v_tab(i).id <- 방번호.필드이름
        end loop;
end;
/

declare
        type dept_tab_type is table of departments%rowtype index by pls_integer; -- 레코드 변수 없이 그냥 테이블에서 가져와도 됨
        v_tab dept_tab_type;
begin
        for i in 1..5 loop
                  select *
                  into v_tab(i)
                  from departments
                  where department_id = i * 10;
        end loop;
        
        for i in v_tab.first..v_tab.last loop
                  dbms_output.put_line(i || '번 방에는 ' || v_tab(i).department_id || '번 부서 ' || v_tab(i).department_name || '의 정보'); -- 이 경우, 컬럼 이름이 필드명이 됨
        end loop;
end;
/



-- 2. 배열: "동일"한 데이터 type의 값을 저장 => 다른 type의 데이터를 저장하고 싶으면, 레코드와 같이 이용!
--    a. index by table(연관 배열)
--    b. nested table(중첩 테이블)
--    c. varray



--    a. index by table(연관 배열)
--       배열 값 일일히 넣어줘야 함 => nested table로 해결!
declare
        type tab_char_type is table of varchar2(10) index by pls_integer; -- 배열 type 선언
    --  type    타입 이름                 타입        요소 번호(pls_integer에 종속)
        v_city tab_char_type;
begin
        v_city(1) := '서울';
        v_city(2) := '대전';
        v_city(3) := '부산';
        v_city(4) := '광주'; -- 위의 varchar2(10) 타입에 맞게 값 입력
                             -- 요소 번호는 pls_integer 타입에 맞게!
        dbms_output.put_line(v_city.count); -- 블록(배열) 안의 개수 <- 여기서는 4개
        dbms_output.put_line(v_city.first);
        dbms_output.put_line(v_city.last);
        dbms_output.put_line(v_city.next(1)); -- 1번 array 다음(next) 번호
        dbms_output.put_line(v_city.prior(2)); -- 2번 array 이전(prior) 번호
        
        v_city.delete(3); -- 3번 array 삭제 => exception!(no data found)
        -- cf1. v_city.delete; <- 모든 array 삭제!
        -- cf2. v_city.delete(1,3); <- 1번 array부터 3번 array 삭제(1번과 3번 2개만 삭제하고 싶으면 코드 2번 실행해야!)
        
        for i in v_city.first..v_city.last loop
            if v_city.exists(i) then -- exception 방지
                dbms_output.put_line(v_city(i)); -- 배열 안의 값들을 하나씩 끄집어냄
            else
                dbms_output.put_line(i||' 요소는 존재하지 않습니다.');
            end if;
        end loop;
        
        dbms_output.put_line(''); 
        
        for i in v_city.first..v_city.prior(4) loop
            dbms_output.put_line(v_city(i)); 
            -- 3번 array 삭제하고 v_city.prior(4) 하면, 2번 array 지정! 
        end loop;

end;
/



--    b. nested table(중첩 테이블)
--       declare에서 index by절 없앰!(요소 번호가 자동으로 1번부터 표현 => 2G까지만 저장)
--       v_city tab_char_type := tab_char_type('서울','대전','부산','광주');

--       2G를 넘겨야 할 때는 index by table 써야 함(그 외에는 index by table과 별 차이 없음)
--       ex. 배열값들을 미리 알고 있을 경우, nested table을 이용하는 게 더 편함!

--       중간에 새로운 배열값을 넣을 수 없음!
--       dynamic하게 쓰고 싶으면 그냥 index by table 쓰기!

--       bulk collect into에도 사용!
declare
        type tab_char_type is table of varchar2(10); -- 배열 type 선언     
        v_city tab_char_type := tab_char_type('서울','대전','부산','광주');
    --    변수        type            type(값 쭉 나열)
begin
        dbms_output.put_line(v_city.count); -- 블록(배열) 안의 개수 <- 여기서는 4개
        dbms_output.put_line(v_city.first);
        dbms_output.put_line(v_city.last);
        dbms_output.put_line(v_city.next(1)); -- 1번 array 다음(next) 번호
        dbms_output.put_line(v_city.prior(2)); -- 2번 array 이전(prior) 번호
        
        -- v_city.delete(3); -- 3번 array 삭제 => exception!(no data found)
        -- v_city.delete; -- 모든 array 삭제!
        -- v_city.delete(1,3); -- 1번 array부터 3번 array 삭제(1번과 3번 2개만 삭제하고 싶으면 코드 2번 실행해야!)
        
        -- v_city(5) := '대구'; -- 오류!(index by table은 프로그램에서 자동으로 확장되지만, nested table은 배열이 고정됨!)
                             -- => 확장(v_city.extend()) 필요!
        
        -- v_city.extend(1); -- 배열 확장부터 하고 배열값 추가(2G까지)
        -- v_city(5) := '대구';
        
        -- v_city.delete(3);
        -- v_city(3) := '대구'; -- 삭제한 다음 그 자리에 배열값 업데이트 가능!!!
        
        
        for i in v_city.first..v_city.last loop
            if v_city.exists(i) then -- exception 방지
                dbms_output.put_line(v_city(i)); -- 배열 안의 값들을 하나씩 끄집어냄
            else
                dbms_output.put_line(i||' 요소는 존재하지 않습니다.');
            end if;
        end loop;
        
        dbms_output.put_line(''); 
        
        for i in v_city.first..v_city.prior(4) loop
            dbms_output.put_line(v_city(i)); 
            -- 3번 array 삭제하고 v_city.prior(4) 하면, 2번 array 지정! 
        end loop;

end;
/



-- c. varray()
--    nested table처럼 배열값을 알고 있을 경우 사용
--    BUT 요소의 개수를 미리 제한!(들어갈 값의 개수 고정)
--    nested table처럼 기존에 값을 넣으면 그걸로 고정 => 더 넣고 싶으면 extend 사용해야 함!
declare
        type tab_char_type is varray(5) of varchar2(10); -- varray(5) <- 이 변수에는 5개만 넣을 수 있음
        v_city tab_char_type := tab_char_type('서울','부산','대전'); -- BUT 3개만 입력 => 따로 추가 안 됨!!!
begin
        -- v_city.extend(3); -- 오류!(5개 이내에서 확장해야!)
        v_city.extend(2);
        v_city(4) := '광주';
        v_city(5):= '대구';
        for i in v_city.first..v_city.last loop
                dbms_output.put_line(v_city(i));
        end loop;
end;
/

-- # cursor: SQL 실행 메모리 영역 
--           메모리에 대한 포인터(마우스 포인터 같은 거)
-- # implicit cursor(암시적 커서)
--   - 커서를 오라클이 생성, 관리한다
--   - select ... into ... (반드시 1개의 row만 fetch해야 한다.) => 명시적 커서: 커서 관리를 내가 스스로 하자!
--   - DML(insert, update, delete, merge)
--   - 암시적 커서 속성 <- sql%rowcount, sql%found, sql%notfound <- DML의 결과를 판단하는 속성으로서 사용!



-- # explicit cursor(명시적 커서)
--   - 여러 개의 row를 (변수에) fetch해야 한다면 명시적 커서를 사용
--   - 프로그래머가 커서를 생성, 관리해야 한다(parse-bind-execute-fetch 과정을 구문에 직접 표현해야 한다)
--   - 구문에 꼭 커서 이름이 들어가야 한다
--   - select문을 날려서 cursor로 받는 거! 

--   - joined table에 이용!!

select * from employees where employee_id = 100; -- pk, 하나의 row => implicit cursor
select * from employees where department_id = 20; -- (prospective) multiple rows => explicit cursor

declare
        /* 1. 커서 선언 */
        cursor emp_cur is select last_name from employees where department_id = 20; -- 서버 프로세스 안에 커서가 만들어짐!
     -- cursor 커서이름 is select문
        v_lname varchar2(20);
begin
        /* 2. 커서 open: 메모리 할당, 
              메모리에 위의 select문을 담아 parse(syntax, semantic 권한 체크, 실행 계획 만듬), 
              bind, execute(pinned), fetch(active set) */
        open emp_cur;
        /* 3. fetch: 커서에 있는 active set 결과를 변수에 로드하는 단계
                     데이터를 변수에 load 시키는 작업 => loop 구조 안에서 수행해야! */
        loop
        fetch emp_cur into v_lname;
              exit when emp_cur%notfound; -- 커서명%notfound: fetch한 게 없을 경우, true(exit)
              dbms_output.put_line(v_lname);
              end loop;
        /* 4. close: 메모리 해지 */
        close emp_cur; -- 메모리에 남아 있는 커서 정리
end;
/

-- multiple variables declared
-- 암시적 cursor처럼 컬럼 개수에 맞게 변수 대응!
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

-- select * => record 사용!!!
declare
        cursor emp_cur is select * from employees where department_id = 20;
        v_rec emp_cur%rowtype; -- 커서명(emp_cur 꼭 넣어줘야!, 레코드명%rowtype 안 됨 <- joined table에 대비)
begin
        open emp_cur;
        loop
        fetch emp_cur into v_rec;
              exit when emp_cur%notfound; 
              dbms_output.put_line(v_rec.last_name || ', $' || v_rec.salary); -- 커서명.컬럼명
              end loop;
        close emp_cur; 
end;
/

-- ### joined table
declare
        cursor emp_cur is select e.last_name, e.salary, d.department_name -- 얘네 세 컬럼이 자동으로 레코드 변수의 필드가 됨!
                                                                          -- alias를 쓸 경우 => alias가 필드명!
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

-- record 안 쓰고 explicit cursor 이용 => 일일히 변수 선언!
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

-- # explicit cursor를 쉽게 구현하는 방법
-- begin절에 open, fetch, close 작업이 포함되어 있지 않음
-- record(emp_rec) 변수는 자동으로 만들어짐!(cursor를 기반으로!)
-- open, fetch, close 작업을 자동으로 해줌!
-- 그냥 마음껏 for문을 쓸 수 있음!!

-- open 시점에 active set이 없으면 for loop는 수행되지 않음!(이 경우에는 매뉴얼 대로 작업해야 함)
-- ex. 없는 사원 번호를 검색하는 경우

-- ## for문 이용 <- 레코드 선언, open, close 제외!
declare
        cursor emp_cur is select * from employees where department_id = 20;
begin
        for emp_rec in emp_cur loop -- for 레코드변수 in 커서 loop
                                    -- emp_rec는 for문 안에서만 쓸 수 있음
                                    -- cf. v_rec <- begin절 안에서 다 쓸 수 있음 <- 유동적으로 쓰고 싶으면 매뉴얼하게 작성해야 함
              dbms_output.put_line(emp_rec.last_name);
        end loop;
end;
/


/*
## 명시적 속성 정리

명시적커서이름%notfound : fetch한게 없으면 true 있으면 false
명시적커서이름%found : fetch한게 있으면 true 없으면 false
명시적커서이름%rowcount : fetch한 건수
명시적커서이름%isopen : 명시적 커서가 open이 되어 있으면 true, 아니면 false
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
        and job_id = 'ST_MAN'; -- 2개의 select문의 구조는 같은데 상수만 다름 => 똑같은 실행 계획을 sharing하게 하고 싶음! => 변수 처리!
        
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

-- # parameter를 갖는 cursor
-- declare절의 select문을 변수 처리
-- 이거 쓰는 이유: 실행 계획을 공유하기 위해서
-- parameter cursor에 변수 만들 때는 size 쓰면 안 됨
-- 실제값이 없는 상태(형식 매개변수)에서 실행 계획을 만듬 <- 변수가 어떤 데이터가 올 지 모름 
-- => optimiser는 데이터의 분포도가 고르다는 전제 조건을 바탕으로 실행 계획을 만듬
-- 컬럼에 index가 걸려 있어도 데이터의 분포도가 균등하지 못 하면 full scan이 더 나음 => 이 경우에는 위에 꺼 사용!
-- 코드 짜기 전에 꼭 select문의 히스토그램(통계 수집)을 확인할 것!!(버젼 11G부터는 oracle이 자발적으로 adaptive하게 적용)
declare
        cursor parm_cur(p_id number, p_job varchar2) is 
     -- cursor 커서명(변수명 변수타입) is <- 여기에는 변수 size를 절대 쓰면 안 됨!
     --              형식 매개변수 <- 형식만 지정
     --          cf. 80,'SA_MAN' -> 실제 매개변수
                select employee_id, last_name, job_id
                from employees
                where department_id = p_id
                and job_id = p_job;
        v_rec1 parm_cur%rowtype;
begin
        open parm_cur(80,'SA_MAN');
        -- cf. open parm_cur(50,'ST_MAN'); <- 중복 open은 안 됨! <- exception
        --                                 <- open-fetch-close한 다음에 다시 open할 것!
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



-- # PK 추출
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
               where last_name = emp_rec.last_name; -- wrong!(중복되는 이름이 있을 경우 문제됨)
               */
               
               update employees
               set salary = salary *1.1
               where employee_id = emp_rec.employee_id; -- PK를 print하지 않더라도, declare절의 cursor에서 컬럼 추출해서 여기로 가지고 와야!
        end loop;
end;
/
rollback;

-- # cursor 선언 시에 rowid를 추출
-- PK 대신 rowid 사용 => 성능 향상!
declare
        cursor sal_cur is 
               select e.rowid, e.last_name, e.salary, d.department_name
            -- employee_id 대신 rowid를 가져옴
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
               where rowid = emp_rec.rowid; -- index scan 시 I/O를 하나라도 더 줄이기 => rowid scan(by user rowid)으로 유도(I/O 1번)
                                            -- cf. employee_id <- by index rowid(I/O 4번)
        end loop;
end;
/

select rowid
from employees 
where employee_id = 100;

update employees
set salary = salary *1.1
where employee_id = 100; -- unique index scan(I/O 4번)

update employees
set salary = salary *1.1
where rowid = AAAEAbAAEAAAADNAAA; -- by index rowid scan(I/O 1번)

declare
        cursor sal_cur is 
               select e.rowid, e.last_name, e.salary, d.department_name
            -- employee_id 대신 rowid를 가져옴
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

읽기 일관성: 한 세션에서 DML 작업을 하고 있으면 다른 세션에서 변경 사항을 확인하지 못 하고, 
            DML 작업도 못 함 => wait 단계에 빠짐(Lock 기능)
            <- salary 정보만 수정하더라도, 필드값에만 lock이 걸리는 게 아니라, row 단위로 적용됨
            
            => 해당 세션에서 transaction을 완료하면 wait 단계가 풀리고 DML 수행됨
            
undo: 이전 값을 저장해놓는 mechanism <- 한 세션에서 transaction을 완료하지 않았을 경우, 
                                     다른 세션에서는 undo에 저장된 데이터 확인 가능
                                     
양쪽 세션에서 read-read는 가능 // write-write는 불가능

select salary from employees where employee_id = 100 for update; 
<- 해당 세션에는 문제 없음 BUT 다른 세션에서는 wait 상태에 빠짐
<- for update: 미리 lock을 선점!
<- 본래 select는 lock을 걸지 않지만, for update를 사용하면 걸 수 있음

cf. 누군가가 DML 작업을 할 때 for update를 수행하면, 이번에는 내가 wait해야 함!

** DBA들이 모니터링 하면서 lock 충돌 관리(lock 조정, kill)
*/



-- # PK, rowid 없이 작업하는 방법
-- for update, where current of <- 이 2개는 같이 써야 함
-- update/delete 시에만 씀!
-- 이건 open 시점에 lock 선점
-- -> 해당 테이블의 모든 row들을 조작하는 거면 괜찮지만, 
--    조건을 걸어서 일부의 row들을 조작하는 경우에는 lock 충돌의 우려 => 이 경우에는 위의 rowid 직접 쓰는 방식이 나음
--    joined table의 경우, 양쪽 row들이 다 lock이 걸림!
declare
        cursor sal_cur is 
               select e.last_name, e.salary, d.department_name
               from employees e, departments d
               where e.department_id = 20
               and d.department_id = 20
               for update of e.salary wait 3; -- rowid를 선언한 것과 같은 기능
                           -- ** 주의 사항: join table의 경우 rowid가 e.rowid인지, d.rowid인지 구분 못 해서 작업이 제대로 안 되는 수가 있음!
                           -- for update of 뒤에 해당 테이블의 아무 column의 이름을 적어놓기
                           -- wait 3: 3초 동안 wait를 기다리겠다는 뜻(본인 시간 기준)
                           -- cf. for update of e.salary nowait; <- 안 기다리겠다는 것                          
begin
        for emp_rec in sal_cur loop
               dbms_output.put_line(emp_rec.last_name);
               dbms_output.put_line(emp_rec.salary);
               dbms_output.put_line(emp_rec.department_name);
               dbms_output.put_line('');
               
               update employees
               set salary = salary *1.1
               where current of sal_cur; -- rowid로 scan하는 것과 같음
           --  where current of 커서;
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
              dbms_output.put_line(v_rec.last_name); -- active set 결과가 2개이면, fetch문을 2번 만들어야 함 => loop문 이용!
                                                     -- 레코드: overwriting(하나를 작업하면, 이전 꺼는 없어짐)
                                                     -- cf. 배열: 데이터를 계속 누적시켜서 작업 가능
        close emp_cur;
end;
/

-- # 문맥 전환
-- 암시적 cursor: 한 번 fetch하면 끝
-- 명시적 cursor: 문맥전환(context switch) <- PL/SQL과 SQL 엔진 사이에 제어의 이전
declare
        cursor emp_cur is select * from employees where department_id = 20; -- 문맥 전환 1번 발생
        v_rec emp_cur%rowtype;
begin
        open emp_cur; -- active set 결과 <- SQL 엔진이 가지고 있음
        loop
              fetch emp_cur into v_rec; -- fetch: 변수에 load <- PL/SQL 엔진이 담당(문맥 전환 필요)
                                        -- fetch 단계에서 문맥 전환 발생(row 개수에 따라 문맥 전환의 횟수가 정해짐)
                                        -- row의 수가 많아질 수록, 성능 저하!
                                        -- row 여러 개를 한 번에 받을 수 있도록 변수가 설계되어 있어야 함 <- Array!!!
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



-- # bulk collect into <- 대량의 row들을 변수에 한 번에 던짐!!
-- into 뒤에는 array 모양으로!(2차원 배열)
declare
        type tab_type is table of employees%rowtype; -- nested table(용량이 2G 넘어가면 조각내서 수행해야 함! => paging 처리)
        v_tab tab_type;
begin
        select *
        bulk collect into v_tab -- 문맥 전환을 1번으로 끝냄
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
        returning last_name, salary bulk collect into v_tab; -- update 후 해당 데이터를 추출
                                                             -- bulk collect 없애면 exception!
        
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
     -- where department_id = 20 <- exception!(too many rows) => bulk collect into 사용!
        returning last_name, salary into v_tab; 
        
        dbms_output.put_line(v_tab.name || ' ' || v_tab.sal);
end;
/



-- # delete문에 배열 이용
-- case 1.
drop table emp purge;
create table emp as select * from employees;

begin
      delete from emp where department_id = 10;
      delete from emp where department_id = 20;
      delete from emp where department_id = 30; -- 실행 계획 sharing 못 함!
      rollback;
end;
/

-- case 2. 배열
declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        delete from emp where department_id = v_num(1);
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        delete from emp where department_id = v_num(2);
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        delete from emp where department_id = v_num(3); -- delete문을 3개 썼더라도 실행 계획은 하나!
        dbms_output.put_line(sql%rowcount || ' rows deleted.');
        rollback;
end;
/

-- case 3. 코드 문장을 하나로 개선(for문)
-- 실제로는 case 2와 같음(코드만 심플하게 바꾼 거)
-- 배열 변수 안에 있는 값을 가지고 DML(insert, update, delete) 작업을 수행하는 경우 => 문맥 전환 줄여야!
declare
        type numlist is table of number;
        v_num numlist := numlist(10,20,30);
begin
        for i in v_num.first..v_num.last loop
            delete from emp where department_id = v_num(i); -- 문맥 전환 발생!
                                                            -- delete는 "SQL 엔진"이 담당
                                                            -- 실행 계획은 1번이더라도, 문맥 전환은 3번 일어남!
                                                            -- cf. select의 문맥 전환은 SQL 엔진과 PL/SQL 엔진 사이의 문맥 전환(방향에 유의)
                                                            -- 문맥 전환을 한꺼번에 하는 법(전환 수를 줄이는 법)?
            dbms_output.put_line(sql%rowcount || ' rows deleted.');
        end loop;
        rollback;
end;
/

-- case 4. 개선
-- forall문: "DML"의 튜닝을 위해 존재!(loop문이 아님)
-- delete문은 forall문 적용 // print 구문은 for문 사용 => sql%bulk_rowcount(i)
-- => 문맥 전환 줄여줌!
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
            
        dbms_output.put_line(sql%rowcount || ' rows deleted in total.'); -- 전체 건수가 리턴됨
        
        for i in v_num.first..v_num.last loop
            dbms_output.put_line(sql%bulk_rowcount(i) || ' rows deleted.');
        end loop;
        rollback;
end;
/


/*
Exception
- 실행중에 발생한 pl/sql 오류이다.
- 오류에 따른 exception처리를 각각 해야 한다.
- 오류 번호 대신 오류 이름으로 exception처리를 해주어야 한다.
- oracle에 의해 암시적(자동)으로 발생할 때, 유저가 의도하여 프로그램에 의해 명시적으로 발생시키고 싶을 때 exception 처리를 한다.
*/

-- 없는 사원번호를 입력하여서 예외사항을 발생시켜보겠다.

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

-- ORA-01403(단일행 SELECT 데이터를 반환하지 않을 때, 없는 배열 요소를 참조하려고 할 때 발생하는 오류)가 발생하였다. 
-- 오류 번호에 따른 이름으로 exception처리를 해준다.

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
  when no_data_found then --오류 번호(ORA-01403)에 따른 이름(no data found)
    dbms_output.put_line('해당 사원은 존재하지 않습니다.');
end;
/
```

-- 다른 오류를 발생시켜 exception처리를 해보자.

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

-- 오류에 따른 exception처리를 추가해주어야 한다.

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
    dbms_output.put_line('해당 사원은 존재하지 않습니다.');
  when too_many_rows then
    dbms_output.put_line('부서에 사원들은 여러명이니 명시적커서를 사용');
end;
/
```

-- begin절에서 오류가 발생하면 exception으로 trap이 발생한다. 
-- 공통적으로 수행하고 싶은 logic이 있다면 sub-block에서 exception처리를 해주고 해당 logic은 main-block에서 수행하도록 한다.


---------오후----------------------------------------------


-- Transaction가 발생했을 때 에러로 비정상적인 종료가 된다면 transaction은 자동 rollback이 된다.

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
  --오류발생으로 자동 rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
  
  rollback;
end;
/
```


-- 오류가 발생했지만 exception handling으로 transaction은 살아있게 된다. 
-- 그래서 TCL문을 사용하여 transaction을 끝내주어야 한다.


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
  --오류발생으로 자동 rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
 
exception
  when too_many_rows then -- 오류 내용(오류 번호 확인 ORA-01403)
    rollback; -- transaction이 살아 있으니, rollback 해줘야 함! <- 이거 안 하면 lock 걸림!
    dbms_output.put_line('여러 건의 row를 fetch할 수 없습니다.');
  when others then -- 다 정의하고 마지막에 기술!
    dbms_output.put_line('꿈을 꾸자');
    dbms_output.put_line(sqlcode); -- 현재 발생한 오류 코드 리턴(sqlcode -> 0: 오류 아님, 1: 유저가 정한 exception 상황, +100: no data found, 기타 오류는 음수로 나옴))
    dbms_output.put_line(sqlerrm); -- 오류 코드 + 메시지 리턴
end;
/

-- 아래의 프로그램으로 오류 코드 확인!
declare
  v_rec employees%rowtype;

begin
  UPDATE employees
  SET salary = salary * 1.1
  WHERE department_id = 20;
  --오류발생으로 자동 rollback 

  SELECT *
  INTO v_rec
  FROM employees
  WHERE department_id = 20;
  
  dbms_output.put_line(v_rec.last_name);
 
exception
  when others then 
    dbms_output.put_line('꿈을 꾸자');
    dbms_output.put_line(sqlcode); 
    dbms_output.put_line(sqlerrm); 
end;
/

rollback;



-- child record found
-- ORA-02292 <- 이 오류 번호에 대한 이름이 없음! => exception 걸 수 없음 => 어쩔 수 없이 when other 사용해야 함
-- => 이 오류만 딱 짚어서 exception 걸고 싶은 경우?
delete from employees where department_id = 20; -- foreign key constraint(ORA-02292)
delete from departments where department_id = 20; -- primary key constraint(ORA-02292)
delete from departments where department_id = 270; -- 제약 조건이 걸려 있더라도 참조되는 실제 값이 없으면 오류 안 뜸!

-- 정상적인 종료(exception 처리) 
begin
          delete from departments where department_id = 20;
exception
          when others then
               dbms_output.put_line(sqlcode);
               dbms_output.put_line(sqlerrm);
          rollback;
end;
/

-- cf. 비정상적인 종료
begin
          delete from departments where department_id = 20;
end;
/

-- 2. exception 변수, pragma
-- 오류에 대한 이름이 없는 경우 사용!(exception 이름을 따로 선언)
-- oracle 내에 이름이 붙지 않은 exception들이 많음
-- exception의 이름에 대한 표준화를 위한 패키지 필요!(패키지는 전부 PL/SQL로 짠 거) <- DBA의 STANDARD 패키지 확인해볼 것!
declare
          pk_error exception; -- exception 이름을 따로 선언(예외이름 exception;)
          pragma exception_init(pk_error, -2292); -- 위 변수와 오류를 connect하는 작업(pragma exception_init(예외변수이름, 오류번호);)
                                                  -- 오류 번호 맨 앞의 0은 넣어도 되고 안 넣어도 됨
begin
          delete from departments where department_id = 20;
exception
          when pk_error then -- exception 이름(pk_error)
               dbms_output.put_line('이 값을 참조하는 row들이 있습니다.');
          when others then
               dbms_output.put_line(sqlcode);
               dbms_output.put_line(sqlerrm);
          rollback;
end;
/



-- 3. 사용자가 정의한 예외 사항 => raise 예외이름
-- 사용자가 명시적으로 예외 사항 유발(oracle은 예외가 아니라고 해도, 사용자가 예외 처리하고 싶은 경우)
-- ex. 회사 내에 절대 조회하지 말아야 할 사원 번호를 검색하는 경우 => if sql%found then raise 예외이름
-- i) DML문
update employees
set salary = salary * 1.1
where employee_id = 300; -- 수정된 row가 없지만 exception이 아님!

-- ii) 프로그램
begin
      update employees
      set salary = salary * 1.1
      where employee_id = 300; -- 수정된 row가 없지만 exception이 아님! => 이걸 예외 처리하고 싶음!
end;
/

begin
      update employees
      set salary = salary * 1.1
      where employee_id = 300; -- 수정된 row가 없지만 exception이 아님! => 이걸 예외 처리하고 싶음!
      
      if sql%notfound then
            dbms_output.put_line('수정된 값이 없습니다.');
      else
            dbms_output.put_line(sql%rowcount || '개의 row가 수정되었습니다.');
      end if;
      
      rollback;
end;
/

-- # raise 예외이름
-- raise를 만나는 순간, 무조건 exception절로 trap
declare
        e_invalid exception;
begin
        update employees
        set salary = salary * 1.1
        where employee_id = 300; 
      
        if sql%notfound then
            raise e_invalid; -- 사용자가 정의한 예외 사항
        end if;
exception
        when e_invalid then
            dbms_output.put_line('수정된 값이 없습니다.');
        rollback;
end;
/

-- 예외 처리 시 아무 작업도 안 하고 싶은 경우 => null;
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

-- # raise_application_error() procedure(object 단위의 프로그램)
-- 무조건 오류가 나면서 "비정상적인 종료" 처리하고 싶은 경우
-- cf. 위에 것들은 모두 "정상적인 종료"
-- 오류 번호의 범위: -20000 ~ -20999
-- 오류 메시지의 범위: 2G byte(한글은 한 글자에 3 byte)
-- begin절에서 써도 되고, exception절에서 써도 됨
begin
        update employees
        set salary = salary * 1.1
        where employee_id = 300; 
      
        if sql%notfound then
            raise_application_error(-20000, '수정된 데이터가 없습니다');
         -- raise_application_error(오류번호, '오류메시지');
        end if;
end;
/

-- 오류 코드, 메시지 확인할 때는 SQL Plus 이용!
-- true: 오류 코드와 메시지가 내 꺼랑 oracle 꺼랑 같이 리턴
-- false: 내 것만 나옴 <- default
declare
        v_rec employees%rowtype;
begin
        SELECT *
        INTO v_rec
        FROM employees
        WHERE employee_id = 300; 
exception
        when no_data_found then
              raise_application_error(-20000, '조회 데이터가 없습니다', true);
              -- true: 오류 코드와 메시지가 내 꺼랑 oracle 꺼랑 같이 리턴
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
              raise_application_error(-20000, '조회 데이터가 없습니다', false);
              -- false: 내 것만 나옴
rollback;
end;
/



-- 7/13
-- # 사원번호를 입력값으로 받아서 그 사원의 정보를 출력하는 프로그램
-- select * from employees where employee_id = 입력변수; 
-- <- 명시적, 암시적 둘 다 상관 없지만, exception logic을 구현하기에는 암시적 cursor가 더 편리
var b_id number
execute :b_id := 100

-- 익명 블록(not object)
declare
          v_rec employees%rowtype;
begin
          select * 
          into v_rec -- 레코드변수
          from employees 
          where employee_id = :b_id; -- 입력변수 <- declare절에서 선언할 방법이 없음 => bind variable!
          dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
exception
          when no_data_found then
                  dbms_output.put_line(:b_id || ' 사원은 존재하지 않습니다');
end;
/

/*
- 익명블록의 단점 1. reparsing 우려(매번 compiling해야 함)
                2. share 안 됨(oracle db 안에 이 프로그램이 저장되어 있지 않기 때문) => 다른 사람들도 각자 소스를 가지고 있어야 함 => object 단위의 프로그램!(시스템 권한 필요) <- select * from user_sys_privs;
                3. 입력값(:b_id) 처리 시 tool에서 지원하는 거(bind variable) 밖에 사용 못 함

=> object!(테이블 생성하듯이 객체 생성) <- 권한(특정 SQL문을 수행할 수 있는 권리) 필요!
*/
select * from user_sys_privs; -- user가 가지고 있는 권한 확인
select * from user_tab_privs; -- 내가 부여한/부여받은 object 권한 같이 볼 수 있음
select * from session_privs; -- 권한 리스트 확인 => CREATE PROCEDURE(함수, 패키지, procedure 만들 수 있음)

-- # Procedure 생성
-- 형식매개변수
-- 1. in mode
-- 2. out mode
-- 3. in out mode

-- ## in mode <- 입력값 처리, 상수로 동작(초기값)
-- commit/rollback <- 프로그램에 넣어놓을 지, 아니면 호출하는 사람이 자발적으로 판단하게 할 지는 알아서 정할 것
create or replace procedure emp_proc(p_id number)
                        -- 프로시져이름(형식매개변수 타입) <- size 쓰면 안 됨(쓰면 compilation error)
                        -- 프로시져이름(p_id in number default 0) <- in mode: 입력값 처리, default 0: exec 시 아무 값도 입력하지 않으면 default값인 0으로 자동 설정
                        -- bind variable 사용 못 함!(그냥 이 입력값 처리 기능 사용하면 됨)
                        -- local variable처럼 작동!(상수로 동작! <- 초기값 넣어줘야 함!)
-- or replace 옵션: 기존에 같은 procedure가 있을 경우, 이미 있는 걸 지우고 새로 생성하겠다는 뜻(굳이 따로 drop 안 해도 됨)
is -- 익명 블록의 declare절과 같은 기능(declare절은 필수가 아니지만, is절은 필수! <- 선언할 변수가 없더라도 is는 써놔야 함!) => 안 쓰면 compilation error
   -- is 대신 as 써도 됨
          v_rec employees%rowtype;
begin
       -- p_id := 200; (오류: 이유는 한번 받은 값에 대해서만 사용(상수이기 때문))
          select * 
          into v_rec -- 레코드변수
          from employees 
          where employee_id = p_id; -- 입력변수 <- procedure 만들면서 선언(bind variable 안 쓰고 procedure의 입력변수를 씀)
          dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
exception
          when no_data_found then
                  dbms_output.put_line(p_id || ' 사원은 존재하지 않습니다');
end;
/

-- # Procedure 수행
exec emp_proc(100) -- exec emp_proc(실질매개변수) <- 실질매개변수(100)를 형식매개변수(p_id)에 집어넣음
-- 소스 코드, 컴파일(execute 시점)된 코드값이 저장됨! => 수행 속도가 빠름!
exec emp_proc(300)
exec emp_proc() -- in mode는 상수로 동작! <- 초기값 넣어줘야 함!
                -- default 0

-- # program에서 procedure를 호출
begin
      emp_proc(100); -- exec 명령어는 제외
end;
/

-- 작성된 procedure에 대한 소스 확인
select text
from user_source
where name = 'EMP_PROC';
/*
select text
from user_source
where name = '프로시져이름';
*/

-- Procedure 삭제
drop procedure emp_proc;



-- ## out mode
-- 변수를 프로그램 바깥으로 전달하는 기능
create or replace procedure emp_proc(p_id in number default 0, p_name out varchar2, p_sal out number)
                         -- emp_proc(형식매개변수명 in 타입, 형식매개변수명 out 타입) <- out mode: 변수를 밖에서도 쓸 수 있게 만듬
is 
begin
          select last_name, salary
          into p_name, p_sal -- 이 두 변수를 프로그램 외부로 전달하고 싶은 경우(cf. 익명 블록은 bind variable을 쓰면 됨)
          from employees 
          where employee_id = p_id; 
          dbms_output.put_line(p_name || ' ' || p_sal);
exception
          when no_data_found then
                  dbms_output.put_line(p_id || ' 사원은 존재하지 않습니다');
end;
/

-- desc 프로그램이름
desc emp_proc -- 변수의 이름, 타입, in/out 확인 가능



-- cf. 바깥에서 변수를 받을 때 -> bind variable 이용!(실질매개변수에 상수 말고 bind variable 집어넣으면 됨)
var b_name varchar2(30)
var b_sal number

exec emp_proc(101, :b_name, :b_sal) 
-- exec emp_proc(실질매개변수)  
-- 인수값: 200(p_id <- in mode)
-- :b_name, :b_sal <- out mode 되어 있는 애들을 받아옴!
-- 200을 프로그램에 집어넣어서, p_name, p_sal을 추출한다음, 밖에서 :b_name, :b_sal로 받음
-- in mode: 상수로 동작(특정값 설정) // out mode: 변수로 동작(프로그램 바깥으로 리턴)

print b_name b_sal
select * from employees where salary > :b_sal;



-- cf. 익명 블록
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
-- in, out 기능 혼합
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
print b_phone_no -- 값이 형식에 맞게 수정됨

exec format_phone('01012345678') 
-- 오류!(상수값은 받을 수 없음)
-- in/out mode의 실질매개변수는 초기값이 있는 "변수 형태"여야 함!

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
                  dbms_output.put_line(d_id || ' 부서 존재하지 않습니다');
end;
/

var d_name varchar2(30)
var m_id number
exec :d_name := 'Marketing'
exec :m_id := 101

exec dept_proc(10, :d_name, :m_id) 



/*
# SQL Plus

* 다른 유저에게 procedure 이용 권한 부여하는 방법
  - grant execute on query_emp to happy;
  - grant execute on 프로시져 to 유져;
  - select * from user_tab_privs; <- 이걸 통해 권한 부여 받았는 지 확인 가능
  
  - exec hr.query_emp(101) <- 다른 유저가 hr의 procedure 사용 가능(간접 access) <- ex. 은행 창구 직원
                           <- 직접 select해도 되지만, 보안 문제 때문에 procedure를 통해 간접 access 유도
                           <- 사용자명 꼭 써줘야 함!(hr)
    cf. grant select on employees to happy; <- table에 대한 직접 access 권한 부여
        grant select, insert, update, delete on employees to happy;
                           
  - revoke execute on query_emp from happy; <- 권한 회수(오브젝트에 대한 execute 권한을 뺏음)
  
  - revoke하고 exec하면 실행 안 되는데, 그에 적합한 오류 메시지가 뜨지 않음!
  
  - hr이 다른 유져에 update 권한 부여하고 hr에서 update 수행하면 wait 단계에 빠짐
    => transaction을 종료하는 습관 갖기!
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
-- 여기에 사이즈가 보이더라도, 형식매개변수에 사이즈 명시하면 안 됨!

select text from user_source where name = 'SP_COMM'; -- 소스 확인

var g_name varchar2(30)
var g_sal number
var g_comm number
exec :g_comm := 0.1
print g_name g_sal g_comm
exec sp_comm(145, :g_name, :g_sal, :g_comm)
-- in mode의 값(145)에 따라 out mode의 값이 결정됨!
-- in out mode는 초기값이 들어있는 변수의 형태로 있어야 함!
print g_name g_sal g_comm

var g_id number
exec :g_id := 145
exec :g_comm := 0.1
exec sp_comm(:g_id, :g_name, :g_sal, :g_comm)
-- :g_id, :g_name, :g_sal, :g_comm <- 실질매개변수(형식매개변수의 위치에 대응되게!)
-- 이렇게 바인드 변수 처리해도 상관 없음!
print g_name g_sal g_comm



-- table에 insert하는 프로그램
create table sawon(id number, name varchar2(30), day date, deptno number);
create or replace procedure sawon_in_proc
(p_id in number,
p_name in varchar2,
p_day in date default sysdate,
p_deptno in number default 0) -- p_deptno in number := 0 <- 이렇게 써도 됨
is
begin
        insert into sawon(id, name, day, deptno)
        values(p_id, p_name, p_day, p_deptno);
end sawon_in_proc;
/

execute sawon_in_proc(1, '홍길동', to_date('2018-01-01', 'yyyy-mm-dd'), 10)
select * from sawon; -- procedure를 통해 insert 작업 수행!(아직 commit/rollback 되지는 않음)

desc sawon_in_proc
-- desc로는 default 확인 불가능 <- 소스로 확인해야! 

-- # 이름 지정 방식
-- 세번째 매개변수(p_day in date default sysdate)에는 아무 값도 안 넣고 default하게 설정하고 싶은 경우
-- => 실질매개변수는 순서대로 해야 하기 때문에 불가능
-- => "변수명 => 값"의 형태로 일일이 지정! <- 순서 바뀌어도 상관 없음!!
execute sawon_in_proc(p_id => 2, p_name => '박찬호', p_deptno => 20)
select * from sawon; -- 이름 지정 방식을 통해 procedure 수행!

-- # 조합 방식
-- 포지션 지정 + 이름 지정의 2가지 방식을 조합해서 쓸 수 있음!
execute sawon_in_proc(3, '손흥민', p_day => to_date('2017-01-01', 'yyyy-mm-dd'))
select * from sawon; -- 입력하지 않은 매개변수는 0으로 나옴?

execute sawon_in_proc(p_id => 4, '제임스', p_day => to_date('2016-01-01', 'yyyy-mm-dd'))
-- 오류!(첫번째 매개변수를 이름 지정 방식으로 했으면, 쭉 이름 지정 방식을 써야 함!)
-- 되도록이면 조합 방식 쓰지 말고 포지션, 이름 지정 둘 중에 하나 선택해서 쓸 것!



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



-- 신규 부서 입력하는 procedure
-- 호출 단위 프로그램 => procedure 내에서 exception 발생 => 오류(자동 rollback)

-- # exception of procedure
-- 1번째 경우
-- 아예 exception절을 쓰지 않음
-- 3개의 구문 모두 안 들어감!(자동 rollback)
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
      add_dept('경영지원', 100, 1800);
      add_dept('데이터분석', 99, 1800); -- emp table에 99번 사원이 없음! => 외래키 제약조건
      add_dept('자금관리', 101, 1500);
end; -- 오류 발생!
/
select * from dept;

-- 2번째 경우
-- 호출한 곳에만 exception절 작성
-- main procedure에 exception이 없으면, 호출한 곳으로 돌아옴
-- 첫번째 구문(경영지원)은 들어가고, 문제 있는 구문(데이터분석) 이후부터는 안 들어감
begin
      add_dept('경영지원', 100, 1800);
      add_dept('데이터분석', 99, 1800); 
      add_dept('자금관리', 101, 1500);
exception
      when others than
            dbms_output.put_line(sqlerrm);
end; 
/
select * from dept;

-- 3번째 경우
-- main procedure에 exception절 표현
-- => 첫번째 구문(경영지원)과 세번째 구문(자금관리) 모두 수행됨!
-- 될 수 있는 대로 main procedure에 exception 처리할 것!
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
      add_dept('경영지원', 100, 1800);
      add_dept('데이터분석', 99, 1800); 
      add_dept('자금관리', 101, 1500);
end; 
/
select * from dept;



-- # 함수
-- 기능의 프로그램
-- 표현식의 일부로서 호출해야 함!(변수 연산자 우측에 위치)
-- cf. procedure: sql문에서는 호출 못 함

-- 함수 function
-- return number(return절) => return v_sal;(return문)
create or replace function get_sal (p_id in number) -- 입력값 처리할 거 없으면 타입 쓸 필요 없음(Java의 void 같은 거)
return number -- return 데이터타입 <- 필수!(cf. procedure: 필요 없음) <- 타입의 사이즈, 세미콜론 쓰면 안 됨
              -- procedure의 out mode의 역할!
is
      v_sal number := 0;
begin 
      select salary into v_sal from employees where employee_id = p_id;
      return v_sal; -- 변수의 값 리턴(null이라도 리턴) <- cf. procedure의 return => 종료!
                    -- return 문을 여러 개 쓸 수 있지만, 그 중 하나만 return!
exception
      when no_data_found then
            return v_sal;
end get_sal;
/

-- 함수 사용 => 표현식의 일부로서 호출(procedure는 이렇게 사용 못 함)
exec dbms_output.put_line(get_sal(100))

declare
        v_sal number;
begin
        v_sal := get_sal(100); -- 표현식의 일부로서 함수 호출 <- procedure는 불가능
        dbms_output.put_line(v_sal);
end;
/

-- select절에서 함수 이용
select employee_id, get_sal(employee_id) from employees; 

-- 함수의 잘못된 예
begin
        get_sal(100); -- 이건 procedure를 호출할 때 쓰는 거!(함수는 이렇게 쓰면 안 됨)
end;
/



-- # deterministic 힌트
create or replace function dept_name_func(p_dept_id number)
return varchar2
deterministic -- function에서만 쓰는 힌트 => scalar subquery의 기능을 수행하게 함!(cache 기능)
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
               return '알수없는 부서';
end;
/



-- ## Package <- 파이썬의 Class와 비슷
-- 관련성 있는 서브 프로그램(프로시저, 함수), 변수(global variable), 타입(ex. 레코드, 배열)을 모아놓은 프로그램
-- 바인드 변수가 아닌 다른 방식으로 global variable 표현(프로그램 안에서 변수 선언) // function, procedure를 상호 교환하면서 사용 <- 높은 유연성
-- begin절이 없음!

-- 굳이 두 프로그램을 하나의 패키지로 묶는 이유
-- 1. 글로벌 변수 사용
-- 2. 종속 관계를 다루기 더 쉬움

-- Package는 두 덩어리(spec, body)로 만들어야 함! 
-- spec(글로벌 생성자)부터 컴파일하고, body를 컴파일하기!
-- 1. spec(public)을 먼저 만들어야 함! <- 선언만 하는 곳(로직 구현 안 함)
create or replace package comm_pkg 
is
    g_comm number := 0.1;
    procedure reset_comm(p_comm in number); -- 패키지 안에 procedure 선언(create or replace 필요 없음)
                                            -- 함수일 경우, return data type까지!
end comm_pkg;
/
exec dbms_output.put_line(comm_pkg.g_comm) -- 프로그램 밖에서도 변수 사용 가능!(global variable!) <- 패키지명.변수명
-- 2. body(private) <- 실제 소스 기록
--                  <- 패키지 안에서 수행되는 로직 구현
create or replace package body comm_pkg
is
    function validate_comm(v_comm in number) -- 패키지 내에서만 사용!(밖에서는 사용 못 함)
                                             -- 오픈하지 말아야 할 로직은 body에서 정의!
                                             -- spec에서는 reset_comm()만 선언되어 있는 거 확인할 것!
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
          if validate_comm(p_comm) then -- validate_comm() 함수 <- 바로 위에 정의(뒤에 정의되어 있으면 안 됨!)
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
    procedure reset_comm(p_comm in number); -- 패키지 안에 procedure 선언(create or replace 필요 없음)
                                            -- 함수일 경우, return data type까지!
end comm_pkg;
/
exec dbms_output.put_line(comm_pkg.g_comm) -- 프로그램 밖에서도 변수 사용 가능!(global variable!)



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

-- 두 프로그램을 따로따로 만들어도 상관 없음! BUT g_comm은 못 만듬! // 유지 관리할 프로그램이 2개가 됨! 
-- => 종속 관계!(ex. select문 컬럼의 타입과 사이즈를 바꾸면, validate()과 reset()가 실행 불가능 상태에 빠짐 => 다시 컴파일!)
-- => 패키지로 묶어 놓으면, 다시 컴파일할 때 더 수월함!
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

패키지명.함수명() <- 이렇게 사용!
exec dbms_output.put_line(comm_pkg.g_comm)
exec comm_pkg.reset_comm(0.2)

*** 한 세션에서 패키지 수행한 결과가 다른 세션에 영향을 미치지 않음 => 변경값은 세션이 끝날 때까지 지속
    => 똑같은 패키지를 사용해도, 세션이 다르면, 결과값도 다를 수도 있음
    <- global variable의 특징!
*/



-- # overloading
-- 동일한 이름의 프로시저, 함수를 만들 수 있다. 
-- 새로운 타입이 생겼을 때, 굳이 새로운 함수 만들 필요 없이 overloading 기능을 이용하면 됨!
-- 평소에 쓰는 함수들도 전부 standard 패키지에 있는 거!

-- to_char(입력변수, 입력변수) <- 패키지 안에서 overloading 수행
--                           <- 형식매개변수의 개수, mode 또는 타입이 달라야 함 ex. to_char(날짜, 문자) // to_char(숫자, 문자)
--                           <- 객체 지향 프로그램의 장점!
create or replace package pack_over
is
      type date_tab_type is table of date index by pls_integer; -- spec에서 선언한 type도 프로그램 바깥에서 사용 가능!(global type)
      type num_tab_type is table of number index by pls_integer;
      
      procedure init(tab out date_tab_type, n number); -- init()이라는 procedure 이름은 동일 but 타입이 다름!(overloading)
      procedure init(tab out num_tab_type, n number);
end pack_over;
/
create or replace package body pack_over
is
      -- 같은 이름의 init()를 두 번 만듬!(overloading)
      -- 날짜/숫자 배열로 입력했으니, 실질매개변수도 날짜/숫자 배열 타입으로 받아야 함!
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
        pack_over.init(date_tab, 5); -- 입력변수에 어떤 타입의 값을 넣느냐에 따라 작동하는 procedure가 달라짐!
        pack_over.init(num_tab, 5); -- 같은 init()라도, 다르게 작동됨!
        for i in 1..5 loop
              dbms_output.put_line(date_tab(i));
              dbms_output.put_line(num_tab(i));
        end loop;
end;
/



-- ## 패키지 커서 지속상태
<瘤加惑?-菩虐瘤 目?>

CREATE OR REPLACE PACKAGE pack_cur
IS	
  	PROCEDURE open;
	PROCEDURE next(p_num number);
	PROCEDURE close;
END pack_cur;
/

-- 밑에 프로그램의 문제점 => 하나씩 fetch => 성능 저하!
-- 아래의 지속상태_패키지 커서_FETCH_BULK_LIMIT 확인!! 
CREATE OR REPLACE PACKAGE BODY pack_cur -- cursor에 대한 open(), next(), close() 작업 일일히 설정
IS
	CURSOR c1 IS  -- private cursor(body 안에서만 볼 수 있음)
		SELECT  employee_id, last_name
		FROM    employees
		ORDER BY employee_id DESC;
	v_empno NUMBER;
	v_ename VARCHAR2(10);

  PROCEDURE open 
  IS  
	BEGIN  
	 IF NOT c1%isopen then
           OPEN c1; -- fetch, close의 과정 생략!(패키지에서는 한 번 오픈한 커서는 close할 때까지 계속 열려 있음! => 커서의 지속 상태)
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
<<Package 角?>>

SQL> SET SERVEROUTPUT ON 
         
SQL> EXECUTE pack_cur.open
c1 cursor open

PL/SQL procedure successfully completed.
   
SQL> EXECUTE pack_cur.next(3) -- 3개의 row를 fetch
Id :206  Name :Gietz
Id :205  Name :Higgins
Id :204  Name :Baer

PL/SQL procedure successfully completed.


SQL> EXECUTE pack_cur.next(6) -- 포인터가 4번째에 위치 => 4번째부터 시작!(누적)
-- EXECUTE pack_cur.next(3) 한 번 더 입력 => 리턴 안 됨!(이미 3보다 크기 때문) <- EXIT WHEN c1%ROWCOUNT >= p_num;
Id :203  Name :Mavris
Id :202  Name :Fay
Id :201  Name :Hartstein

PL/SQL procedure successfully completed.

SQL> EXECUTE pack_cur.close
c1 cursor close

PL/SQL procedure successfully completed.



-- ### 지속상태_패키지 커서_FETCH_BULK_LIMIT
-- fetch 부분에 레코드 배열 변수 이용해서 limit라는 키워드 사용
-- 위 프로그램의 성능 문제 해결!
-- BUT 한꺼번에 fetch 하면 2G라는 용량 제한에 걸릴 수 있음 => limit 이용!
-- limit는 select into문에서는 사용 못 함 => open fetch close 과정을 표현해야!
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
	  dbms_output.put_line('데이터가 없습니다.');
	  return; -- exit;와 동일한 역할
	ELSE
		FETCH c1 BULK COLLECT INTO v_tab limit p_num; -- limit: bulk해야 할 대상의 수 조정! 
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
<<Package 실행>>

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

SQL> EXECUTE pack_cur.next(50) -- 3번째 구문 => 7개의 row만 출력
SQL> EXECUTE pack_cur.next(50) -- 4번째 구문 => 모든 row들이 fetch되었으니, 데이터가 없다는 메시지가 나옴

PL/SQL procedure successfully completed.

SQL> EXECUTE pack_cur.close
c1 cursor close

PL/SQL procedure successfully completed.

/*
### Trigger 

 이벤트(DML)성 프로그램을 의미한다. 이떤 이벤트가 발생하면 자동으로 실행되는 프로그램이다. 트리거를 만들려면 시스템권한(`session_privs`테이블에서 `create trigger`)이 필요하다. 트리거에서 `타이밍(before/after)`과 `DML행위`, `BEGIN`절은 **필수**이다. 혹시 선언을 해야할 필요가 있으면 `DECLARE`를 사용한다. 트리거를 확인하는 방법은 다음과 같다.
 
 
```sql
*/
SELECT * FROM user_triggers;
/*
```


 트리거는 크게 문장트리거와 행트리거가 있다. **문장트리거**는 **영향을 입은 row가 입든 없든 무조건 돌아가는 트리거**이다. **행트리거**는 **영향을 입은 row가 있을 경우**에만 돌아간다. 간단한 문장을 보고 이해해보자. <BR>

BEFORE/AFTER의 문장트리거

```sql
*/
SELECT * FROM session_privs; --시스템 권한 확인

drop table dept purge;

CREATE TABLE dept
AS SELECT * FROM departments;

desc dept


--BEFORE 문장 트리거
--insert on 하기 전에 trigger를 수행하라는 의미
CREATE OR REPLACE TRIGGER dept_before
BEFORE --프로그램 수행 시점을 의미
INSERT ON dept


BEGIN
  dbms_output.put_line('insert하기 전에 문장트리거수행');
end;
/

--AFTER 문장트리거
--insert on한 후 trigger를 수행하라는 의미
CREATE OR REPLACE TRIGGER dept_after
AFTER --프로그램 수행 시점을 의미
INSERT ON dept


BEGIN
  dbms_output.put_line('insert한 후에 문장트리거수행');
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
insert하기 전에 문장트리거수행
insert한 후에 문장트리거수행
```

<BR>

BEFORE/AFTER의 행트리거

```sql
...

BEFORE 행트리거
CREATE OR REPLACE TRIGGER dept_row_before
BEFORE INSERT ON dept
FOR EACH ROW

BEGIN
  dbms_output.put_line('insert하기 전에 행트리거수행');
end;
/

AFTER 행트리거
CREATE OR REPLACE TRIGGER dept_row_after
AFTER INSERT ON dept
FOR EACH ROW

BEGIN
  dbms_output.put_line('insert한 후에 행트리거수행');
end;
/
*/
INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
insert하기 전에 문장트리거수행
insert하기 전에 행트리거수행
insert한 후에 행트리거수행
insert한 후에 문장트리거수행
```

출력되는 순서를 확인해서 언제 출력이 되는지 타이밍을 익히자.

<br>

#### 문장트리거

14시부터 15시사이의 insert 작업을 불가하는 등과 같은 경우에 쓴다.

```sql
*/
CREATE OR REPLACE TRIGGER secure_dept
BEFORE INSERT ON dept

BEGIN
  if to_char(sysdate,'hh24:mi') between '14:00' and '15:00' then
    raise_application_error(-20000,'insert 시간이 아닙니다.');
  end if;
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);
/*
```
```
ERROR at line 1:
ORA-20000: insert 시간이 아닙니다.
ORA-06512: at "HR.SECURE_DEPT", line 3
ORA-04088: error during execution of trigger 'HR.SECURE_DEPT'
```

 dept 테이블에 trigger를 걸었기 때문에 `insert`작업이 불가능하다. 이 트리거는 `insert`문을 수행하고 있는 session에서 돌아간다. 그래서 `insert`문을 수행하는 순간(수행하기 직전에) 트리거(`secure_dept`에서의 `raise_application_error`가 발생하여 자동 rollback 된다.

<br>
*/

/*
#### DML작업에 따른 제한

 `타이밍(BEFORE)` 뒤에 `OR`로 DML을 연결시키고, `inserting`,`updating`,`deleting`이란 키워드를 사용하여 조건부 술어에 사용할 수 있다.

```sql
*/
CREATE OR REPLACE TRIGGER secure_dept
BEFORE INSERT OR UPDATE OR DELETE ON dept

BEGIN
  if to_char(sysdate,'hh24:mi') between '14:00' and '16:00' then
    if inserting then --trigger내에서는 inserting.(insert는 sql문)
      raise_application_error(-20000,'insert 시간이 아닙니다.');
      
    elsif updating then
      raise_application_error(-20001,'update 시간이 아닙니다.');
      
    elsif deleting then
      raise_application_error(-20002,'delete 시간이 아닙니다.');
    end if;
  end if;
end;
/

INSERT INTO dept(department_id, department_name, manager_id, location_id)
VALUES(300,'it',100,1500);

/*
```

<BR>

#### 행트리거 

 DML작업에 영향을 입은 row가 있을 경우에만 돌아간다. 
 그래서 데이터에 대한 감사, 복제 행위를 할 경우 행트리거를 사용하면 좋다. 
 아래 트리거를 보고 이해해보자.

```sql
*/
CREATE TABLE copy_emp 
AS 
SELECT employee_id, last_name, salary, department_id
FROM employees;

CREATE OR REPLACE TRIGGER copy_emp_trigger
BEFORE DELETE OR INSERT OR UPDATE OF salary ON copy_emp
--OF 컬럼(salary)를 사용하여 필드단위로 조작하려고 한다.
FOR EACH ROW
--행트리거로 가겠다.(영향을 입은 row가 있을 경우에만 trigger사용)

WHEN (new.department_id = 20 OR old.department_id = 10)
--when이라는 조건절을 사용하여 제한하겠다.(행트리거에서만 사용 가능)
--when절에는 수식자 앞에 콜론(:) 사용 불가(begin절에서는 반드시 사용)
--old 는 이전, new는 새로운 값을 의미
--20번사원을 insert시, 10번사원에 대한 delete시, 10번과 20번사원의 update시에 트리거 작동

DECLARE 
  v_sal number;

BEGIN
  if deleting then
    dbms_output.put_line('old salary : ' || :old.salary);
    --delete시에는 이후 값은 의미가 없으므로 이전값인 old를 사용
  elsif inserting then
    dbms_output.put_line('new salary : ' || :new.salary);
    --insert시에는 이전 값은 의미가 없으므로 이후값인 new를 사용
  else
    v_sal := :new.salary - :old.salary;
    dbms_output.put_line('사원번호 : ' || :new.employee_id ||    
                         ' 이전급여 : ' || :old.salary || 
                         ' 수정된급여 : ' || :new.salary || 
                         ' 급여 차이 : ' || v_sal);
  end if;
END;
/
/*
```

 만약 `OF salary`를 쓰지 않았으면, 다음과 같이 if절에서 salary를 제한에서 사용해야 한다. 또한 다른 컬럼들도 조건부 술어에 기술하여서 제한할 수 있다.

```sql
*/
CREATE TABLE copy_emp 
AS 
SELECT employee_id, last_name, salary, department_id
FROM employees;

CREATE OR REPLACE TRIGGER copy_emp_trigger
BEFORE DELETE OR INSERT OR UPDATE ON copy_emp
--OF 컬럼(salary) 삭제
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
  --updating에 컬럼(salary)를 제한시켜 주어야한다.
  
    v_sal := :new.salary - :old.salary;
    dbms_output.put_line('사원번호 : ' || :new.employee_id ||    
                         ' 이전급여 : ' || :old.salary || 
                         ' 수정된급여 : ' || :new.salary || 
                         ' 급여 차이 : ' || v_sal);
  end if;
END;
/
/*
```

<br>

DELETE 수행

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

10번 부서의 사원을 삭제하니 trigger가 작동한다.(old)

```sql
*/
DELETE FROM copy_emp
WHERE department_id = 20;
/*
```
```
1 row deleted.
```

20번 부서의 사원을 삭제하니 trigger는 작동하지 않았다.(new)

<br>

INSERT 수행

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

20번 부서의 사원을 `INSERT`하니 trigger가 작동한다.(new)

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
