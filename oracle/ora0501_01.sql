select * from employees;

select * from employees where emp_name like '%n%';

select count(*) from employees where emp_name like '%n%';

select * from stuscore order by rank desc;

select * from stuscore order by kor desc;

-- 입사일 가장 일찍인 사원순으로 정렬
select * from employees order by hire_date asc;

-- 숫자함수
-- abs: 절대값, round(): 반올림, ceil(): 올림, floor(): 버림, trunc(): 특정자리수를 잘라내기
-- mod(): 입력받은 수를 나눈 나머지값 반환
-- power (m,n) m의 n승을 반환

select -10 from dual;
select -10 ,abs(-10) from dual;

select kor,eng,kor-eng,abs(kor-eng) from stuscore order by abs(kor-eng) desc;

-- rownum: 조회된 순서대로 순번을 다시 매김
select rownum, name from stuscore;

select rownum, sno, name,total from stuscore where total>=250 and rownum <=10;

-- stuscore 테이블 1-10 등 까지 학생을 출력하시오
select * from stuscore order by rank desc;

select rownum, a.* from stuscore a where rank <= 10 order by rank;

select rownum, a.* from (select * from stuscore where rank<=10 order by rank)a;

-- 국어점수 80점 이상인 학생 5명 출력
select rownum, a.* from(select * from stuscore where kor >= 80 order by kor desc) a
where rownum <= 5;

select sno, a.* from stuscore a
where sno<=5;

-- 국어점수와 영어점수 차이가 가장큰 10명의 학생을 출력하시오
-- select rownum, a.* from 쿼리문 다 써도 되고, 별칭을 쓰는것도 가능
select rownum,kor,eng,abs(kor-eng) from(   
select kor,eng,abs(kor-eng)ke from stuscore order by ke desc
)
where rownum <= 10;

-- floor() 버림
select 12.5, floor(12.5) from dual;

-- ceil() 올림
select 11.1, ceil(11.1) from dual;

-- round() 반올림 - (m,3): 소수점 3자리까지 표시
select 12.1257, round(12.125754,4) from dual;
select 34.5678, round(35.5678,-1) from dual;

-- trunc() 지정한 자리 버림 소수점을 제거
select 34.5678, trunc(34.5678,-1) from dual;

-- mod() 나눈 나머지, mod(5,2) 1 == 5%2
select mod(27,2), mod(27,5), mod(27,7) from dual;

-- stuscore sno에서 짝수만 출력하시오
select * from stuscore where mod(sno,2)=0;

-- 시퀀스 테이블내의 유일한 숫자를 자동으로 생성하는 자동 번호 발생기
-- 수를 증가시켜줌
select stu_seq.nextval from dual;
-- 수를 확인만 시켜줌
select stu_seq.currval from dual;

create sequence s_seq
start with 1
increment by 1
minvalue 1
maxvalue 9999
nocache
nocycle
;

select s_seq.nextval from dual;
select s_seq.currval from dual;

-- primary key 기본키 중복값 불가
create table board (
bno number(4) primary key,  -- 게시글 번호
btitle VARCHAR2(1000),      -- 제목   varchar2 - 4000byte
bcontent clob,              -- 대용량 문자 varchar2(무한대)
id varchar2(100),           -- 회원가입 id 연결
bgroup number(4),           -- 답변달기 부모그룹
bstep number(4),            -- 답변달기 순서
bindent number(4),          -- 답변달기 들여쓰기
bhit number(4),             -- 조회수
bfile varchar2(100),        -- 파일첨부
bdate date               -- 입력날짜
);

insert into board values(
board_seq.nextval,'게시글을 등록합니다.','홈페이지를 오픈합니다. 많은 이용 바랍니다.',
-- board_seq = 답변달기용
'aaa',board_seq.currval,0,0,0,'',sysdate
);
insert into board values(
board_seq.nextval,'이벤트 등록', '이벤트를 등록합니다. 꼭 당첨 기대!!',
'bbb',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'이벤트 등록2','이벤트를 등록합니다.222',
'ccc',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'이벤트 등록3','이벤트 등록3333',
'ddd',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'이벤트 등록4','이벤트 등록4444',
'eee',board_seq.currval,0,0,0,'',sysdate
);

insert into board values(
board_seq.nextval,'이벤트 등록5','이벤트 등록5555',
'fff',board_seq.currval,0,0,0,'',sysdate
);

select * from board;

commit;

select * from stuscore;

insert into stuscore values(
stuscore_seq.nextval, '정진아', 100, 100, 99, 100+100+99, (100+100+99)/3, 0
);

select stuscore_seq.currval from dual;

-- delete stuscore where sno in(101,102,103);

-- drop table stuscore3;

-- table stuscore4;

select * from stuscore;

update stuscore set kor=100, total=100+eng+math, avg=(100+eng+math)/3 where sno=104;

-- 이름 김 학생을 검색
select * from stuscore where name like '%김%'; 

-- 형변환
-- number, varchar2, char, date
-- 숫자: 사칙연산 가능
select 1+2 from dual;
-- 문자열 숫자는 자동으로 숫자로 변경됨.
select 1+'2' from dual;

-- 문자는 사칙연산 불가
-- ||, concat() 문자열을 더하기해서 출력
select 1+ 'a' from dual;
select 'a'+'b' from dual;

-- 날짜는 덧셈뺄셈 가능
select sysdate-1, sysdate, sysdate+1 from dual;

select hire_date from employees;

select sysdate from dual;

-- 근무일 알수있음
select sysdate-hire_date from employees;

select hire_date,round(hire_date),to_char(hire_date,'yyyy-mm-dd hh:mi:ss') from employees;

select bdate, to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board;

insert into board values (
board_seq.currval, 0,0,0,'sysdate'
);

select * from board;
desc board;

-- 한주가 시작되는 날짜기준으로 반올림
select bdate,to_char(round(bdate,'day')) from board;

-- 분을 반올림
select mdate,to_char(bdate*'yyyy-mm-dd hh:mi:ss'),round(mdate,'month') from member;

-- 16일을 기준으로 월을 반올림 month
select mdate,to_char(mdate,'yyyy-mm-dd hh:mi:ss'),trunc(mdate,'month' )from board;

-- trunc 절사
select mdate,to_char(mdate,'yyyy-mm-dd hh:mi:ss'),trunc(mdate,'month') from member;

select mdate, trunc(mdate,'month');

-- 현재일 입사일의 개월수 계산
select emp_name,hire_date,sysdate,round(months,between(mdate))||'개월' from employee;

-- 학생성적이 현재일부터, 등록된 달이 4개월된 학생들을 출력하시오
select name,mdate,sysdate,round(months_between(sysdate,mdate)) from member
where round (months_between(sysdate,mdate))=4;

-- substr()
select mdate,substr(to_char(mdate),4,2) from member;

-- 파이썬 substring() [3:7]

select name from stuscore;
select emp_name from employees;

-- emp_name 3,4 3번째부터 4개의 글자를 가지고 와 출력하시오
select emp_name,substr((emp_name),3,4) from employees ;

-- round(달을 기준) - 16일 이상이면 월 +1, 16일 미만 일을 절사
select mdate from member;
select mdate, round(mdate,'month') from member;
select 1.5,round(1.5), trunc(1.5) from dual;

-- trunc(달을 기준) 일을 절사
select mdate, trunc(mdate,'month') from member;h

-- round(년을 기준) round(mdate,'year')
select mdate,round(mdate, 'year') from member;

-- months_between (두 날짜 사이의 달수를 계산)
select sysdate,mdate,sysdate-mdate from member;
select sysdate,mdate,trunc(months_between(sysdate,mdate),1) from member;

-- add_months (날짜에 달을 더해줌)
-- 지금 1년 청약
select sysdate,mdate,add_months(mdate,3)-1 from member;

-- 다음 요일 찾기
select sysdate,next_day(sysdate,'월') from dual;

-- 마지막 날 찾기
select sysdate,last_day(sysdate) from dual;
select mdate,last_day(mdate) from member;
select * from employees;
select hire_date,last_day(hire_date) from employees;

-- 날짜를 문자타입으로 변경
select sysdate, to_char(sysdate,'yyyy') from dual;

-- member 테이블에서 5,6,7월 회우너가입한 회원을 출력

-- employees 테이블 hire_date 5,6,7 입사한 사원을 출력하시오
select hire_date, to_char(hire_date,'mm') mm from employees
where to_char(hire_date,'mm') in ('05','06','07') order by mm;

-- mm: 숫자월, mon: 영문, 한글월
select sysdate, to_char(sysdate, 'mon') from dual;
select mdate, to_char(mdate,'mon') from member;
-- day 요일
select mdate, to_char(mdate,'day') from member;

-- 일요일에 가입한 사람 출력
select name,mdate,to_char(mdate,'day') mday from member where to_char(mdate,'day')='일요일';

select bdate,to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board;

-- 숫자타입을 문자타입으로 변경
-- L 국가통화표시, $달러표시, . 소수점을 표시, 천단위 0 빈자리 0표시, 9 빈자리 공백표시
select 1230000000, to_char(1230000000,'$00999,999,999,999.9') from dual;

-- salary 달러표시, 1438 곱해서 원화표시와 천단위 표시 소수점 2자리 넣어 출력하시오
select salary, to_char(salary,'$999,999'), to_char(salary*1438,'L999,999,999'), to_char(salary,'999,999,999.00') from employees;

-- 날짜형 타입 변환
select 20221231, to_date(20221231,'yyyy-mm-dd')from dual;
select '20221231'-1,to_date('20221231','yyyy-mm-dd') from dual;
select '20221231'-1, add_months(to_date('20221231','yyyy-mm-dd'),3) from dual;

-- 09/01/01 날짜 타입으로 변경해서, 현재 날짜 기준으로 몇개월이 지났는지 출력하시오
select sysdate,'09/01/01', months_between(sysdate,'09/01/01')||'개월' from dual;

-- 숫자형 변환 to_number(); 정석 ;
select to_number('20,000','999,999,999')-1 from dual;

-- 특정문자를 대체함 replace()
select '***,111', replace('***,111','*','0') from dual; 
select '20,000', replace('20,000',',','')-1 from dual;


select '    123111  11111 1111       ' from dual;
-- trim: 바깥의 공백만 제거
select trim('    1231111 11111 1111       ') from dual;
-- replace: 모든 공백 없애기 가능
select replace('   123111 111 111 ',' ','')-1 from dual;

to_date() 날짜 변환 - 문자,숫자를 날짜로 변경해서 날짜형태를 +,- 날짜함수를 사용해서 계산
to_char() 문자 변환 - 숫자를 문자로 변경해서 천단위, 0표시, 통화표시 
to_number() 숫자 변환 - 천단위 표시된 문자를 숫자변환해서 사칙연산을 할수 있는 장점

commision_pct 커미션 부분 월급* 커미션을 더해서 계산
select salary,commission_pct,salary*nvl(commission_pct,0) "실제월급" from employees;

select manager_id from employees;
- 10 null
- CEO null ceo
-- 숫자형인 manager_id를 문자형으로 변형시킨 후 CEO 문자 입력가능
select manager_id,nvl(to_char(manager_id),'CEO') nvl from employees;

desc employees;

-- 그룹함수
max,min,sum,avg,count,median
select max(salary) from employees;
select min(salary) from employees;
select sum(salary) from employees;
select avg(salary) from employees;
select count(salary) from employees;
select median(salary) from employees;

select count(*) from employees
where salary >= (select avg(salary) from employees);

select emp_name,avg(salary) from employees;


select min(salary) from employees;
select * from employees where salary =2100;
select * from employees
where salary = (select min(salary) from employees;

select max(salary),min(salary),avg(salary),count(salary),sum(salary) from employees;

select * from employees;
-- 부서번호가 50번인 사원들의 합계
select sum(salary),count(salary),avg(salary) from employees
where department_id = 50;

-- 그룹함수 경우 null 제외
select count(*) from employees; --107명
select count(manager_id) from employees;

select manager_id from employees where manager_id is null;
select count(*) from employees where manager_id is null;

-- 문자열 함수
initcap, lower, upper
select emp_name,upper(emp_name)대문자,lower(emp_name)소문자,initcap(emp_name)initcap from employees;

-- lpad : 자리수만큼 우측에 특정문자를 대체
select kor,lpad(kor,10,' ') from stuscore;

-- trim, ltrim, rtrim 빈공백 제거
select '   aaa   aaa   ' ,
ltrim('   aaa aaa   '),
rtrim('   aaa aaa   '),
trim('   aaa aaa   ') 
from dual;

-- substr() 해당하는 만큼 문자열을 분리해서 가져옴
select name, substr(name,2,2) from stuscore;
select name, substr(name,0,1) from stuscore;

-- replace: 문자열 대체
select '111222333aaa', replace('111222333aaa','a','0') from dual;

-- length: 문자열 길이
select kor from stuscore;
select length(kor) from stuscore;
select length(name) from stuscore;
select max(length(name)) from stuscore;

-- 이름 마지막 글자만 제외 후 출력하시오
select name,substr(name,0,length(name)-1) from stuscore;

create table test (
ch1 char(30),
ch2 varchar2(30)

);


insert into test values(
'12345','12345'
);

commit;

select * from test;
select length(ch1),length(ch2) from test;













