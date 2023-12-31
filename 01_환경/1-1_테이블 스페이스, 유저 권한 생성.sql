
/*
1. 테이블스페이스 생성
2. 유저 생성
3. 권한 부여
*/
-- sys 계정으로 해야함

-- 12c 이후 버전
-- ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;            -- 기존 방식으로 계정생성(12c 이상 버전에서 실행)

-- ALTER SYSTEM SET SEC_CASE_SENSITIVE_LOGON = FALSE;  -- 대소문자 구분 안함(필요시 실행)

select * from tab;

-- 테이블 스페이스 생성
CREATE TABLESPACE MY_DATA DATAFILE '/u01/app/oracle/oradata/XE/MY_DATA01.dbf' SIZE 10G AUTOEXTEND ON;
-- CREATE TABLESPACE MY_DATA DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\MY_DATA01.dbf' SIZE 10G AUTOEXTEND ON;

-- 유저 생성, 아이디 비번 설정, 디폴트 테이블 스페이스 설정
-- CREATE USER [id] IDENTIFIED BY [pw]
CREATE USER dev IDENTIFIED BY "tester"
DEFAULT TABLESPACE MY_DATA
PROFILE DEFAULT
QUOTA UNLIMITED ON MY_DATA;

-- 권한설정
GRANT connect, RESOURCE, DBA TO dev;    --> 모든 권한 주기


ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;    -- 비밀번호 만료기간을 무제한으로 변경(필요시 실행)


-- 전체 테이블 스페이스 경로 및 용량 조회
SELECT
A.TABLESPACE_NAME "테이블스페이스명",
A.FILE_NAME "파일경로",
(A.BYTES - B.FREE)    "사용공간",
B.FREE                "여유 공간",
A.BYTES               "총크기",
TO_CHAR( (B.FREE / A.BYTES * 100) , '999.99')||'%' "여유공간"
FROM
(
    SELECT FILE_ID,
    TABLESPACE_NAME,
    FILE_NAME,
    SUBSTR(FILE_NAME,1,200) FILE_NM,
    SUM(BYTES) BYTES
    FROM DBA_DATA_FILES
    GROUP BY FILE_ID,TABLESPACE_NAME,FILE_NAME,SUBSTR(FILE_NAME,1,200)
)A,
(
    SELECT TABLESPACE_NAME,
    FILE_ID,
    SUM(NVL(BYTES,0)) FREE
    FROM DBA_FREE_SPACE
    GROUP BY TABLESPACE_NAME,FILE_ID
)B
WHERE A.TABLESPACE_NAME=B.TABLESPACE_NAME
AND A.FILE_ID = B.FILE_ID;