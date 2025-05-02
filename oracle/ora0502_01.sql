-- 날짜함수
-- 달의 첫일, 마지막 일을 출력하시오
-- 첫 일, mdate, 마지막일 출력
select mdate from member order by mdate desc;
select trunc(mdate,'month'),mdate,last_day(mdate) from member;
select mdate,to_char(mdate,'mm') from member where to_char(mdate,'mm')='07';


-- 홍길동 가입일: 2024년 07월 14일 화요일
select name, to_char(mdate,'yyyy"년" mm"월" mm"일" day') from member;

-- 현재일에서 이달의 최초일, 이달의 마지막일을 출력하시오
select sysdate, trunc(sysdate,'month'), last_day(sysdate) from dual;

select * from stuscore;

select * from stuscore 
where avg>=80 
and rownum <=5
order by avg desc;

-- rownum 검색된 것에 일련번호를 다시 붙이는것을 말함
select rownum, stuscore.* from stuscore where kor >= 80;

select rownum,stuscore.* from stuscore where name like '%s%';

-- 국어점수와 영어점수 차이가 가장 큰 10명의 학생을 출력하시오
-- 그리고 rownum을 붙여서 출력하시오
select rownum, a.* 
from (select rownum, kor, eng, abs(kor-eng) dif from stuscore order by dif desc) a
where rownum <=10 ;

-- 년 월 일 시 분 초 요일
select sysdate from dual;
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss day') from dual;

select next_day(sysdate,'금요일') from dual;

-- min 가장 낮은 사원 검색
select min(salary), max(salary), avg(salary),count(salary), sum(salary) from employees;

-- 현재 날짜에서 3일전의 날짜, 3달 전의 날짜를 출력하시오
select sysdate, sysdate-3, add_months(sysdate,-3) from dual;

-- ABC좋은나라DEF 
-- 좋은 나라만 출력 substr 사용해서 출력하시오
select 'ABC좋은나라DEF',substr('ABC좋은나라DEF',4,4)냠 from dual;

select mdate from member;

-- 월만 분리해서 출력하되, 05,06,07 인 회원만 출력하시오
select mdate,to_char(mdate,'month') from member where  in(05,06,07);
select mdate, substr(mdate,4,2)subs from member where substr(mdate,4,2) in (05,06,07);

desc stuscore;

create table stuscore4 (
sno number(4),
name varchar2(100),
KOR NUMBER(3),     
ENG NUMBER(3),     
MATH NUMBER(3) 
);


select * from stuscore3;
-- 테이블과 함께 데이터를 모두 복사
insert into stuscore3 select * from stuscore;

select * from stuscore4;
-- 기존테이블이 존재시, 데이터 모두 복사
create table stuscore4 as select * from stuscore;

desc stuscore5;
-- 컬럼이 다른 경우, 컬럼을 부여한후 데이터 모두 복사
insert into stuscore5(sno,name,kor,eng,math) select sno,name,kor,eng,math from stuscore;
select * from stuscore5;


-- 컬럼추가 add
alter table stuscore5 add total number(3);
-- 컬럼삭제 drop
alter table stuscore5 drop column total;

alter table stuscore5 add total number(2);

-- 컬럼 변경 - 타입변경 modify
alter table stuscore5 modify total number(3);
-- 기존에 들어가있는데 데이터 3자리가 있는데, 2자리 변경을 하려고 하면 변경되지 않음
-- 기존에 문자가 들어가 있는데, 숫자형으로 변경하려면 변경되지 않음

-- 컬럼 변경 - 이름변경 rename column
alter table stuscore5 rename column total to tot;

-- 테이블명 변경
alter table stu2 rename to stuscore2;

desc stuscore5;


-- 컬럼순서 변경
alter table stuscore5 modify name invisible;
alter table stuscore5 modify kor invisible;
alter table stuscore5 modify eng invisible;
alter table stuscore5 modify math invisible;

alter table stuscore5 modify name visible;
alter table stuscore5 modify kor visible;
alter table stuscore5 modify eng visible;
alter table stuscore5 modify math visible;

select * from stuscore5;

--drop table stuscore3;
--drop table stuscore4;
--drop table stuscore5;



create table mem (
    id varchar2(30) primary key,    -- null, 중복 X
    name varchar2(100) not null,    -- null X, 중복은 O
    phone varchar2(20) unique,      --  null O, 중복 X
    gender nchar(2) check(gender in('남성','여성')), -- check: 뒤에 기재한 값 이외에는 안됨
    kor number(3) check(kor between 0 and 100)
);

insert into mem values(
'aaa','홍길동','010-1111','남성',100
);

insert into mem values(
'bbb','유관순','null','여성',99
);

insert into mem values(
'ccc','유관순','010-2222','여성',99
);

insert into mem values(
'ddd','이순신',null,'남자',100
);

insert into mem values(
'eee','이순신',null,'남자',100
);

select * from mem;

-- mem 테이블 primary key = id

-- ### 기본키 설정
sno number(4) primary key;

-- 기본키 삭제
alter table score drop constraint SYS_C008355;

-- 기본키 설정
alter table score add constraint pk_score_sno primary key(sno);


-- constraint 별칭 fk_score_id) foreign key(현재테이불의 컬럼)references pk테이블(컬럼)
--constraint fk_score_id foreign key(id) references mem(id)

-- ### 외래키 설정
create table score (
sno number(4) primary key,
id varchar2(30),
kor number(3),
constraint fk_score_id foreign key(id) references mem(id)
);

-- 기본키: 중복 X, null X
-- 외래키: 기본키없는 데이터를 입력하면 입력이 되지 않게함.

-- 외래키 조건 등록
alter table score add constraint fk_score_id foreign key(id) references mem(id);
-- 외래키 조건 삭제
alter table score drop constraint fk_score_id;


select * from mem;

insert into score values(1,'aaa',100);
insert into score values(2,'bbb',90);
insert into score values(3,'bb2',90);

delete score where sno = 2;

select * from mem;
delete mem where id='bbb';

commit;

-- 조인
select * from employees;
select department_id from employees;
cross join - 테이블 2개 선택해서 출력 
-- 컬럼수 : (13+6) = 19개
-- 데이터 개수: 107*27 = 2889개
select * from employees,departments;
107*27  = 2889개
select * from departments;

desc employees; -- 컬럼 13개
desc departments;   -- 컬럼 6개

equi join: 같은 컬럼을 가지고 조인
select emp_name, a.department_id,department_name,salary 
from employees a,departments b
where a.department_id = b.department_id
;
select department_id,department_name from departments;

select * from member;
select * from stuscore;

select id,gender,phone,a.name,sno, total, avg,rank
from member a, stuscore b
where a.name = b.name
;

select emp_name,salary,job_id from employees;
select min_salary, max_salary from jobs;
select * from departments;

select emp_name, a.job_id, a.department_id, department_name, salary, min_salary, max_salary
from employees a, jobs b, departments c
where a.job_id = b.job_id and a.department_id = c.department_id
;

desc board;
select * from board;
alter table board add bfile3 varchar2(100);

alter table board modify bdate invisible;
alter table board modify bdate visible;

create table bfile(
bno number(4),
bfile varchar2(100)
);

select * from board;
insert into bfile values(
1,'1.jpg'
);

insert into bfile values(
1,'2.jpg'
);

insert into bfile values(
2,'b1.jpg'
);

insert into bfile values(
3,'c3.jpg'
);
insert into bfile values(
4,'d1.jpg'
);

commit;

select * from bfile;
--alter table board drop column bfile;
--alter table board drop column bfile2;
--alter table board drop column bfile3;

desc board;

select * from board a, bfile b where a.bno=b.bno and a.bno=1;

select * from board where bno=1;
select * from bfile where bno=1;



select * from board;
-- bno, btitle,bcontent,id,bgroup,bstep,bindent,bhit,bdate
bno: board_seq.nextval
bgroup: board_seq.currval
bdate: sysdate

insert into board values(
board_seq.nextval,'2번째 게시글', '파이썬에서 글쓰기 테스트','aaa',board_seq.currval,
0,0,0,sysdate
);

commit;


select * from bfile;    
select * from board;

desc board;

cross join -> equi join, non-equi join, inner join, outer join

non-equi join

create table scoreGrade(
grade char(1),
minscore number(3),
maxscore number(3)
);

insert into scoregrade values('F',0,59);
insert into scoregrade values('D',60,69);
insert into scoregrade values('C',70,79);
insert into scoregrade values('B',80,89);
insert into scoregrade values('A',90,100);

select * from scoreGrade;
select * from stuscore;

-- non-equi join
-- stuscore테이블 avg가지고 scoreGrade 테이블의 grade를 출력할수있게 구성
select sno,name,avg,grade 
from stuscore,scoreGrade
where avg between minscore and maxscore
;

-- 부서별 연봉평균
select department_id, sum(salary) from employees
group by department_id;

-- 28,17,15,30,45,49,37,35,32,12,19,27

-- 생일 나이로 환산해서 출력하시오
select trunc(to_char(sysdate,'yyyy') - to_char(hire_date,'yyyy'),-1) tyear, count(*) 
from employees
group by trunc(to_char(sysdate,'yyyy') - to_char(hire_date,'yyyy'),-1);

-- 부서별 평균 월급 출력
select a.department_id, department_name, round(avg(salary),2)
from employees a, departments b
where a.department_id = b.department_id
group by a.department_id,department_name;










