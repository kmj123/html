-- 실행 단축키 : ctrl+enter, F9

alter session set "_ORACLE_SCRIPT"=true;    -- userid ## 생략가능

create user ora_user identified by 1111;    -- ora_user, 1111 계정 생성

grant connect, resource, dba to ora_user;   -- 접속권한, 자원할당, db명령어 사용권한 할당

create user ora_user2 identified by 1111;

grant connect,resource, dba to ora_user2;