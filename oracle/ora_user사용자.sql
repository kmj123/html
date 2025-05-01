-- create table: 테이블생성
create table member(
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
phone varchar2(20)
);

-- insert into : 입력 임시서장
insert into member(id, pw, name, phone) values(
'aaa','1111','홍길동','010-1111-1111'
);
Insert into member values(
'bbb','1111','유관순','010-2222-2222'
);

insert into member(id, pw,name) values(
'ccc','1111','이순신'
);

-- ddd,강감찬,3333
-- eee,김구,4444
-- fff, 김유신, 5555
insert into member values(
'ddd','1111','강감찬','010-3333-3333'
);
insert into member values(
'eee','1111','김구','010-4444-4444'
);
insert into member values(
'fff','1111','김유신','010-5555-5555'
);


-- select 검색
select id,pw,name,phone from member;

select * from member;

select id, name from member;


-- update 수정
update member set phone='010-1234-1234' where id='ccc';

-- delete 삭제
delete member where id='aaa';
delete member where name ='유관순';
delete member where name like '%김%';

select * from member;

-- commit 후엔 되돌리수 없다.
rollback;

drop table member;

-- create member 5명 저장
create table member(
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
phone varchar2(20)
);

insert into member values(
'aaa','1111','홍길동','010-111-1111'
);
insert into member values(
'bbb','1111','유관순','010-2222-2222'
);
insert into member values(
'ccc','1111','이순신','010-1234-1234'
);
insert into member values(
'ddd','1111','강감찬','010-3333-3333'
);
insert into member values(
'eee','1111','김구','010-4444-4444'
);
insert into member values(
'fff','11111','김유신','010-5555-5555'
);

select * from member;

update member set phone='010-1234-1234' where name='이순신';

commit; -- 저장완료가 됨/ 꼭 commit 해서 저장해야함



-- varchar : 자료형 
create table stuscore(
sno number(4) primary key,
name varchar2(100),
kor number(3),
eng number(3),
math number(3),
total number(3),
avg number(4),
rank number(3)
);

