select * from employees;

select department_id from employees;
select department_name from departments;

-- employees 테이블에 department_name 컬럼을 생성
desc employees;

select department_id, department_name from departments;

EMPLOYEE_ID NOT NULL NUMBER(6)    
EMP_NAME NOT NULL VARCHAR2(80) 
EMAIL VARCHAR2(50) 
PHONE_NUMBER VARCHAR2(30) 
HIRE_DATE NOT NULL DATE         
SALARY NUMBER(8,2)  
MANAGER_ID NUMBER(6)    
COMMISSION_PCT NUMBER(2,2)  
RETIRE_DATE DATE         
DEPARTMENT_ID NUMBER(6)    
JOB_ID VARCHAR2(10) 
CREATE_DATE DATE         
UPDATE_DATE DATE ;        

desc departments;

select emp_name,a.department_id, department_name 
from employees a, departments b
where a.department_id = b.department_id
;


------------------------------------
------- equi join을 사용하지않고 테이블에 각각 내용을 넣은 경우
create table emp1(
EMP_NAME VARCHAR2(80),
DEPARTMENT_ID NUMBER(6),
DEPARTMENT_NAME VARCHAR2(80),
SALARY NUMBER(8,2)  
);

insert into emp1 values('홍길동',10,'총무기획부','100');
insert into emp1 values('유관순',20,'마케팅','200');
insert into emp1 values('이순신',30,'구매/생산부',200);

create table depart1(
DEPARTMENT_ID NUMBER(6),
DEPARTMENT_NAME VARCHAR2(80)
);

insert into depart1 values(10,'총무기획부');
insert into depart1 values(20,'마케팅');
insert into depart1 values(30,'구매/생산부');


update emp1 set department_name = '전략기획부' 
where department_id =10;

select * from emp1; -- 내용이 바뀜
select * from depart1;  -- 내용이 바뀌지 않음

commit;

--------------------------------------
--------------------------------------

select count(*) from board;


select * from board;

select * from member;

aaa Flori
bbb Holt
ccc Byrom
eee Austin
fff Allard

update member set id='aaa' where id='Flori';
update member set id='bbb' where id='Holt';
update member set id='ccc' where id='Byrom';
update member set id='eee' where id='Austin';
update member set id='fff' where id='Allard';

commit;

select bno, btitle,name
from member a, board b
where a.id=b.id;

select * from scoregrade;
select * from stuscore;
alter table stuscore add grade char(1) default 'C' not null;

alter table stuscore rename column grade to sgrade;

-- scoregrade, stuscore 테이블 non-equi join
select sno, name,total,avg,rank,a.grade
from scoregrade a,stuscore b
where avg between minscore and maxscore;

-- 구매리스트 정보 1달 별로 총 구매 금액 출력, 회원등급을 기준으로 등급 입력시킬 때 
-- non-equi join 을 사용
-------

-- department_id - 그룹함수, sum(salary) 일반함수는 group by로 묶어서 사용해야함
select sum(salary) from employees;

select a.department_id,department_name,
count(salary),round(avg(salary),2),sum(salary) 
from employees a, departments b
where a.department_id = b.department_id
group by a.department_id,department_name
order by sum(salary) desc;

select * from stuscore;

select * from stuscore2;
update stuscore2 set rank=0;
commit;

select * from stuscore;

-- rank() 함수를 사용해서 등수를 입력
수정
update stuscore a
set rank=

(select ranks from (select sno,rank() over(order by total desc) ranks from stuscore) b
where a.sno=b.sno);

select sgrade from stuscore order by total desc;



-------------------------------------------------------------------
select sno,avg,grade
from stuscore2, scoregrade
where avg between minscore and maxscore;

select * from scoregrade;
update scoregrade set maxscore = 59.999 where grade='F';
update scoregrade set maxscore = 69.999 where grade='D';
update scoregrade set maxscore = 79.999 where grade='C';
update scoregrade set maxscore = 89.999 where grade='B';
update scoregrade set maxscore = 100 where grade='A';

desc scoregrade;

alter table scoregrade modify (maxscore number(6,3));

select * from stuscore2;
alter table stuscore2 add sgrade char(1) default 'F';


update stuscore2 a
set sgrade =
(
select grade from
(
select sno,avg,grade
from stuscore2, scoregrade
where avg between minscore and maxscore
) b
where a.sno=b.sno
)
;

select * from stuscore2;

update stuscore2 a
set rank = (
select ranks from(select sno,avg,rank() over(order by total desc)as ranks from stuscore2) b
where a.sno=b.sno 
);

commit;

select * from scoregrade;
select * from stuscore;

--drop table stuscore;
update stuscore set rank=0;

create table stuscore as select * from stuscore2;

create table stuscore3 as select * from stuscore where 1=2;

--alter table stuscore2 drop column rank;

select * from(select a.*,rank() over(order by total desc) ranks from stuscore2 a) 
order by sno desc;


select * from member;
alter table member add total number(3) default 0;
alter table member add no number(4);

update member set total =(
select total from stuscore2
);

insert into member(total) select total from stuscore;
select * from member;

desc stuscore;

select * from member;
insert into member(no,total) select sno,total from stuscore;
update member set no=(select sno from stuscore), total=(select total from stuscore);

delete from member where id is null;

commit;

select rownum, no from member;

update member set no=(select rownum from member);

select * from stuscore;

update stuscore set sgrade = 'F';

commit;

-- 등급처리
update stuscore a set sgrade =(
select grade from 
(select sno,avg,grade from stuscore, scoregrade
where avg between minscore and maxscore)b
where a.sno=b.sno
);

select grade from
(select grade from stuscore, scoregrade
where avg between minscore and maxscore)
where grade in('A','B','C');

select * from scoregrade;   -- grade,minscore,maxscore
select * from stuscore;     -- avg

---- inner join
-- equi-join : 서로다른 2개 테이블에서 같은 컬럼을 가지고 검색
-- non equi-join: 서로다른 2개 테이블에서 같은 컬럼이 없는 경우 검색
-- self join: 같은 테이블 2개에서 검색
---------
-- outer join - null값이 있을때, null 값도 포함해서 검색

같은 테이블 2개 가지고 조인: 셀프조인
select a.employee_id,a.emp_name,a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id and b.emp_name like '%Steven%';

셀프조인 -106명, null 검색이 안됨
-- (+) 를 해주면 null 값도 검색 가능
-- outer join - null값이 있을때, null 값도 포함해서 검색
select sum(a.salary),a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id= b.employee_id(+)
group by a.employee_id,a.manager_id,b.emp_name;

manager_id null
select * from employees where manager_id is null;

107명
select count(*) from employees;

-- ansi cross join
select * from employees cross join departments;
-- 기본 sql 구문
select * from employees,departments;

-- 기본 sql 구문 equi-join
select emp_name,a.department_id, department_name from employees a, departments b
where a.department_id = b.department_id
;

-- ansi 조인 equi-join
select * from employees a inner join departments b
on a.department_id=b.department_id
;

select department_id,department_name 
from employees join departments
using(department_id);

select department_id,department_name 
from employees inner join departments
using(department_id);

-- 기본 sql 구문 outer join
select a.manager_id,b.emp_name 
from employees a, employees b
where a.manager_id = b.employee_id
;

-- ansi 조인 구문: outer-join
select a.manager_id,b.emp_name
from employees a
left outer join employees  b
on a.manager_id = b.employee_id;

union: 2개의 검색된 결과에서 중복된 결과값은 제거해서 출력(중복제거) 2개의 테이블을 출력시킬 때 사용
select * from departments;

select department_id,manager_id
from departments
where manager_id is not null
union 
select department_id, manager_id
from employees
where department_id>80;

employees 테이블에서 부서번호가 50 이상 검색
employees 테이블에서 없는 departments의 부서검색
2개를 union

employees 테이블에서 없는 departments의 부서검색 - 12개
select distinct department_id
from employees order by department_id;

employees 테이블에서 부서번호가 50 이상 검색 -- 6개
select distinct a.department_id, department_name
from employees a, departments b 
where a.department_id = b.department_id and a.department_id>50

union

select department_id, department_name
from departments a
where not exists
(select * from employees b where a.department_id = b.department_id);

-- union(중복제거해서 출력), union all(중복 포함 출력)

select * from employees;

-- view : 가상테이블 생성
create or replace view emp
as select employee_id, emp_name,email,phone_number from employees;

select * from emp;
select * from emp1;
select * from employees;

-- 가상테이블 update, select 가능 insert 불가 가상테이블에 없는 데이터는 변경 불가
update employees set phone_number='650.507.9834' where employee_id=198;

--drop view emp;

select * from member;
select * from stuscore;

select sno, id, b.name,phone, avg, rank, sgrade
from member a, stuscore b
where a.no = b.sno
;



