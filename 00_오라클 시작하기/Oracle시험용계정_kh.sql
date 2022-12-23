-- 먼저 저장
-- 1208 데이터베이스 구현 테스트 (KH 계정)
-- =============================================================================
-- 사용자 계정 생성은 관리자 계정에서 해야 한다.
-- SQL문에서 비밀번호 작성 구문이 빠져있다.
-- 최소한의 권한 부여가 필요하다.

-- 관리자계정에서 해야 한다.
-- CREATE USER SAMPLE IDENTIFIED BY 1234;
-- GRANT CONNECT, RESOURCE TO SAMPLE;

-- =============================================================================
SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND SALARY >= 3000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 1. OR 연산자와 AND 연산자가 같이 있는 경우 AND 연산자에 우선순위가 주어지므로, 문제에서 제시한 DEPT_CODE 비교를 위해서는 OR 연산자 부분을 괄호로 묶어줘야 한다.
-- 2. SALARY가 300만원 이상이라 했으므로, >가 아닌 >=로 작성해야 한다.
-- 3. BONUS가 있다는 것은 NULL값이 아니라는 것이므로 IS NULL이 아닌 IS NOT NULL로 작성해야 한다.
-- 4. 문제에서 주어진 남자라는 조건이 누락되었다. 조건을 추가해줘야 한다.
-- 5. EMAIL 비교시 새로운 와일드카드를 제시함으로써 네번째 _문자를 데이터로 읽어들이고, 이를 ESCAPE로써 구분지어줘야 한다.

-- =============================================================================
SELECT * FROM EMPLOYEE WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;

-- NULL값은 일반 비교연산자를 통해 비교할 수 없다. NULL값은 IS NULL / IS NOT NULL과 같은 연산자를 통해 비교해야만 한다.

-- =============================================================================
SELECT TO_CHAR(TO_DATE('210505'), 'YYYY"년" FMMM"월" DD"일"') FROM DUAL;

-- =============================================================================
CREATE TABLE EMP(
    EMAIL VARCHAR2(50) CONSTRAINT EMP_EMAIL_NN NOT NULL
);

SELECT * FROM EMP;

DROP TABLE EMP;
-- =============================================================================
-- 1215 SQL 활용 테스트
SELECT DEPT_CODE, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2800000
ORDER BY 1 ASC;

SELECT * FROM EMPLOYEE;

-- 그룹함수의 조건식은 WHERE절이 아닌 HAVING절로 비교해야 한다.
-- 그냥 월급(SALARY)이 아닌 평균 월급을 비교해야하므로 AVG(SALARY)로 기술해야 한다.
/*
SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
FROM EMP
GROUP BY DEPT
HAVING AVG(SALARY) > 2800000
ORDER BY DEPT ASC;
*/

DROP TABLE MEMBER_KH;

CREATE TABLE MEMBER_KH(
    MNO NUMBER PRIMARY KEY,             -- 회원번호
    MNAME VARCHAR2(300) NOT NULL,       -- 회원명
    ADDRESS VARCHAR2(1000),             -- 주소
    TEL VARCHAR2(13) UNIQUE             -- 연락처
);

INSERT INTO MEMBER_KH VALUES(1, '홍길동', '서울시 강남구', '011-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '고길동', '부산시 해운대구', '010-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '김갑환', '인천시 연수구', '019-0000-0000');

-- 현재 MNO 컬럼은 제약조건이 PRIMARY KEY로 식별자의 역할을 한다.
-- PRIMARY KEY는 자동적으로 UNIQUE + NOT NULL 제약조건을 갖는데, 위의 INSERT문을 보면 MNO 컬럼의 값이 1로 중복되는 것을 확인할 수 있다.
-- 따라서 각 INSERT문은 MNO 컬럼에 NULL값이 아닌 서로 다른 값을 가져야 한다.

-- 아래와 같이 NULL값이 아니고, 중복되지 않은 값이 들어가야 한다.
INSERT INTO MEMBER_KH VALUES(1, '홍길동', '서울시 강남구', '011-0000-0000');
INSERT INTO MEMBER_KH VALUES(2, '고길동', '부산시 해운대구', '010-0000-0000');
INSERT INTO MEMBER_KH VALUES(3, '김갑환', '인천시 연수구', '019-0000-0000');

-- =============================================================================
-- 내부조인, 연결시키는 컬럼값이 일치하는 행들만 조인되서 조회

-- 외부조인, 기준 테이블 제시하여 일치하지 않는 행들도 포함해 조회 가능

-- 테이블 : 데이터를 일종의 표 형태로 표현하는 것

-- TRIM() : 문자열의 앞 LEADING / 뒤 TRAILING / 양쪽 BOTH 에서 지정 문자들을 제거한 문자열을 반환하는 함수(생략시 공백 제거, 끼여있는 가운데 공백은 제거 못함)

-- ROLLUP() : 그룹별 산출된 결과값에 중간집계를 계산해주는 함수, GROUP BY절에 기술

SELECT EMPNAME AS "직원명", JOBCODE AS "직급코드", SALARY AS "급여",
       DECODE(JOBCODE, 'J7', SALARY * 1.08, 'J6', SALARY * 1.07, 'J5', SALARY * 1.05, SALARY * 1.03) AS "인상급여"
FROM EMP;

SELECT EMP_NAME AS "직원명", JOB_CODE AS "직급코드", SALARY AS "급여",
       DECODE(JOB_CODE, 'J7', SALARY * 1.08, 'J6', SALARY * 1.07, 'J5', SALARY * 1.05, SALARY * 1.03) AS "인상급여"
FROM EMPLOYEE;

-- =============================================================================
-- 2022.12.23 SQL 응용

-- 문제해결과 시나리오

-- 관리자 계정
-- 관리자 계정에서 계정 생성만 하고, 접속 권한 부여를 하지 않았기 때문에 위와 같은 에러가 발생했다.
CREATE USER EMP IDENTIFIED BY EMP0123;
GRANT CONNECT, RESOURCE TO EMP;

DROP USER EMP CASCADE;

-- NULL은 일반비교연산자를 사용하여 비교할 수 없다. 해당 조건에서는 IS NOT NULL로 비교해줘야 한다.
-- EMPNAME이 GROUP BY절에 기술되지 않았다. 그룹으로 묶인 경우, SELECT 문에 있는 컬럼은 GROUP BY절에 기술하거나 그룹함수로 씌워져 있어야 한다.?
SELECT EMPNAME, JOBCODE, COUNT(*) AS 사원수
FROM EMP
WHERE BONUS IS NOT NULL
GROUP BY EMPNAME, JOBCODE
ORDER BY JOBCODE;

-- 서술형
-- 뷰: 논리적인 가상 테이블로 실질적인 데이터를 담고 있지 않으며 SELECT문(쿼리문)을 저장해둘 수 있는 객체
--     DML로 뷰 조작시, 베이스테이블이 변경되나 안되는 경우가 더 많고 서브쿼리에 산술연산식이나 함수식 사용한 경우 반드시 별칭을 지정해야 함.

-- 삭제 제한옵션
-- ON DELETE CASCADE : 부모 삭제시 자식데이터 같이 삭제


-- 서브쿼리 : 메인 SQL문을 위해 보조 역할하는 쿼리문, 하나의 SQL문 안에 포함된 또 다른 SELECT문
-- 	    서브쿼리를 수행한 결과에 따라 단일행, 다중행, 다중열, 다중행 다중열 서브쿼리로 나뉜다.

-- DDL 데이터 정의 언어 : 객체 만들고 수정, 삭제하는 구문 CREATE, ALTER, DROP

-- NOT NULL : 해당 컬럼에 반드시 값이 존재해야되는 경우 사용(NULL값 불가), 컬럼레벨 방식만 사용가능
-- UNIQUE : 해당 컬럼에 중복값을 허용하지 않는 제약조건
-- PRIMARY KEY : 테이블에서 각 행을 식별하기 위해 사용될 컬럼에 부여하는 제약조건, 자동으로 NOT NULL + UNIQUE 제약조건, 한 테이블당 하나만 설정 가능
-- FOREIGN KEY : 다른 테이블을 참조하여 그 테이블의 값만 들어와야 되는 컬럼에 부여하는 제약조건, 컬럼명 생략시 참조 테이블의 pk로 매칭한다.

-- 예시
ALTER TABLE EMP
	ADD CONSTRAINT EID_PK  PRIMARY KEY(EID)
	ADD CONSTRAINT EPW_UQ UNIQUE(EPW)
	MODIFY LNAME CONSTRAINT NN_LNAME NOT NULL;

-- 문제
DROP TABLE memberTb;

CREATE TABLE memberTb(
    id VARCHAR2(10),
    pass VARCHAR2(20),
    name VARCHAR2(10),
    age NUMBER
);

INSERT INTO memberTb VALUES('0100', '1234', '이지은', 25);
INSERT INTO memberTb VALUES('0101', 'kimleechoi', '강한나', 30);
INSERT INTO memberTb VALUES('0102', 'snsd', '서주현', 28);

