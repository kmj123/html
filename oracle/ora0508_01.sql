select * from employees;

select rownum,emp_name,manager_id from employees;

select rownum,a.* from employees a 
order by emp_name;

-- 테이블로 사용가능
(select * from employees order by emp_name);

select rownum, a.* from
(select*from employees order by emp_name) a;

-- 이름에 a를 포함하면서 salary 4800이상이면서 manager_id 103번
select * from ( 
select * from employees where emp_name like '%a%')
where salary >= 4800 and manager_id=103
;

-- rownum 순차적인 번호를 매기는 함수
select rownum, a.*from member a
order by id;

-- 순차적인 번호를 다시 매겨서 출력하시오
select * from
(select rownum rnum, a.* from 
(select * from member order by id) a
)
where rnum between 11 and 20
;

select * from (
select rownum rnum, a.* from member a)
where rnum between 11 and 20;

select row_number() over(order by id asc) rnum,a.*
from member a;

select rownum,a.* from
(select * from member order by id asc)a;

-- 5등 5등 7등 
select * from stuscore;
select rank() over(order by total desc),total from stuscore;

-- 5등 5등 6등  
select dense_rank() over(order by total desc),total from stuscore;

----

select * from stuscore;

update stuscore set rank=0, sgrade='F';

commit;

-- rank, sgrade 값에 맞게 입력하시오
rank() over()
sgrade non-equi join을 해서 해당되는 값을 입력하시오. -  scoregrade 테이블 사용

select * from scoregrade;
select * from stuscore;

update stuscore a set rank = 
(select rank from
(select sno ,rank() over(order by total desc)as rank from stuscore)b 
where a.sno=b.sno);

update stuscore a set sgrade =
(select grade from
(select sno,avg,grade from stuscore, scoregrade where avg between minscore and maxscore)b
where a.sno=b.sno);

select mdate,substr(mdate,4,2) from member;

03~08월까지 출력하시오
select mdate,to_number(substr(mdate,4,2)) from member
where to_number(substr(mdate,4,2)) not between 3 and 8;

select mdate,to_number(substr(mdate,4,2)) from member
where to_number(substr(mdate,4,2)) in (3,4,5,6,7,8);

select mdate,substr(mdate,4,2) from member
where substr(mdate,4,2) between '03' and '08';

뒤에 3글자 출력
select emp_name from employees;

select emp_name,substr(emp_name,1,3), substr(emp_name,-3) from employees;

select replace(emp_name,' ') from employees;

select ' aaa   bbbb  cccc   ' from dual;
trim 앞뒤 공백 제거
select trim(' aaa   bbbb  cccc   ') from dual;

replace 특정 문자 변경
select replace(' aaa   bbbb  cccc   ',' ') from dual;

select phone_number from employees;

phone - char(13) // 남은 4자리를 * 로 채워준다
select rpad(phone,17,'*') from member;

전화번호 뒤 4자리를 **** 출력
select rpad(substr(phone,1,8),12,'*') from member;

뒤에 1글자를 *로 표시해서 출력하시오
select name from member;
select name,length(name), rpad(substr(name,1,length(name)-2),length(name),'*') from member;

뒤에 2글자를 * 표시
select emp_name from employees;
select id from member;

select emp_name, length(emp_name), rpad(substr(emp_name,1,length(emp_name)-2),length(emp_name),'*') from employees;
select id,length(id),rpad(substr(id,1,length(id)-2),length(id),'*') from member;

select id,pw from member;

id 모두를 * 표시
select pw,rpad(substr(pw,1,length(pw)-2),length(pw),'*') from member;
select id,rpad('*',length(id),'*') from member;

952-***-6953 phone 컬럼을 출력하시오
select phone from member;
select substr(phone,1,4)||'***'||substr(phone,8,12) from member;

select mdate from member;

그달의 첫번째 일, 마지막 일을 출력하시오
select trunc(mdate,'mm'),last_day(mdate) from member;

-- 날짜 형태
yyyy-mm-dd hh:mi:ss 형태로 변경하시오 24시간으로 표시
select to_char(mdate,'yyyy-mm-dd hh:mi:ss') from member;

select emp_name,department_id from employees;

select * from departments;

select emp_name,department_id,
decode
(department_id,
10, '총무기획부',
20, '마케팅',
30,	'구매/생산부',
40,	'인사부',
50,	'배송부'
) as depart_name
from employees;

select mdate from member;

12,1,2 -> 겨울
3,4,5 -> 봄
6,7,8 -> 여름
9,10,11 -> 가을

select mdate,
decode
(to_char(mdate,'mm'),
12, '겨울',
1, '겨울',
2, '겨울',
3, '겨울',
4, '봄',
5, '봄',
6, '여름',
7, '여름',
8, '여름',
9, '가을',
10, '가을',
11, '가을'
)as season
from member;

select mdate,substr(mdate,4,2),
decode
(substr(mdate,4,2),
12, '겨울',
1, '겨울',
2, '겨울',
3, '겨울',
4, '봄',
5, '봄',
6, '여름',
7, '여름',
8, '여름',
9, '가을',
10, '가을',
11, '가을'
)as season
from member;

select mdate,substr(mdate,4,2),
case 
when substr(mdate,4,2) in ('12','01','02') then '겨울'
when substr(mdate,4,2) in ('03','04','05') then '봄'
when substr(mdate,4,2) in ('06','07','08') then '여름'
when substr(mdate,4,2) in ('09','10','11') then '가을'
end season
from member;


select avg from stuscore;

90점 이상이면 VVIP, 80점 VIP, 70점 GOLD, 60점 SILVER, 그외 BRONZE
select avg,
case
when avg>=90 then 'VVIP'
when avg>=80 then 'VIP'
when avg>=70 then 'GOLD'
when avg>=60 then 'SILVER'
when avg<60 then 'BRONZE'
end grade
from stuscore;

-- 그룹함수의 조건문 입력하는 부분: having
select department_id, round(avg(salary),2) from employees
where department_id < 50
group by department_id
having avg(salary)>5000
;

부서이름을 출력
select emp_name,a.department_id, department_name, salary from employees a,departments b
where a.department_id= b.department_id and salary in(
select max(salary) from employees 
group by a.*department
);

select employee_id, emp_name, a.department_id, department_name, salary from employees a, departments c
where salary in (
select max(slaary) from employees b
where a.department_id = b.department_id
group by department_id
) and a.department_id = c.department_id
;

select department_id, max(salary) from employees
group by department_id;

select * from stuscore;

alter table stuscore add sclass number(2) default 0;


----------------------------------------------------------------------
-- github 필요

update stuscore set sclass=1;

1-10 1반 11-20 2반 3반 4반 ... 11반



select sno,total,avg,sclass,
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
end sclass
from stuscore;

update stuscore 
set sclass= 
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
else 11
end;

update stuscore set sclass = sno;

--alter table stuscore modify sclass number(3);

select rownum from stuscore;

-- alter table stuscore rename column scalss to sclass;

update stuscore2 a set sclass = (
select rnum from(
select rownum rnum, sno from stuscore
)b 
where a.sno=b.sno
);

select * from stuscore2;

----------------------------------------------------------------------

sclass 반별로 가장 성적이 높은 학생들을 출력하시오
select * from stuscore a
where total in(
select max(total) maxtotal from stuscore b
where a.sclass=b.sclass 
group by sclass
)
;

sclass 반별로 가장 성적이 낮은 학생들을 출력하시오

-- 부서별 가장 월급이 높은 사원 출력
select emp_name,salary, department_id,department_name from employees a, departments c
where salary in (
select max(salary) from employees b
where a.department_id=b.department_id
group by department_id
)
where a.department_id=c.department_id
;

부서 12개
select department_id from employees
order by department_id;

부서 27개
select department_id from departments;

employees 없는 부서를 출력하시오
select department_id, department_name from departments a
where not exists
(select * from employees b where a.department_id = b.department_id)
;

-- 
member 테이블에 이름이 존재하는 stuscore 학생성적을 출력하시오
select * from stuscore a
where exists
(select * from member b where a.name = b.name)
;

select * from employees
where (department_id,salary) in 
(select department_id, max(salary) from employees group by department_id)
;

create table stuscore3 as select * from stuscore;
테이블 생성 및 데이터 복사

create table stuscore3 as select * from stuscore where 1=2;
테이블 생성만 됨 데이터는 없음

select * from stuscore3;

insert into stuscore3(sno,kor) select sno,kor from stuscore;

create table stuscore2 as select * from stuscore;

select * from stuscore2;

update stuscore2 set sclass=0;
commit;

-- 학반별 최고등수 출력 
select * from stuscore2 a
where total in(
select max(total) maxtotal from stuscore2 b 
where a.sclass=b.sclass
group by sclass
)
;

-- 학반별 최하등수 출력
select * from stuscore2 a
where total in(
select min(total) from stuscore2 b
where a.sclass=b.sclass
group by sclass
);

select * from employees;
-- 부서별 최고 연봉
select * from employees a
where salary in(
select max(salary) from employees b
where a.department_id=b.department_id
group by department_id
)
order by department_id;

-- 학반 부여
update stuscore2 set sclass = 
case
when sno between 1 and 10 then 1
when sno between 11 and 20 then 2
when sno between 21 and 30 then 3
when sno between 31 and 40 then 4
when sno between 41 and 50 then 5
when sno between 51 and 60 then 6
when sno between 61 and 70 then 7
when sno between 71 and 80 then 8
when sno between 81 and 90 then 9
when sno between 91 and 100 then 10
else 11
end;



commit;