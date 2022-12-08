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































































