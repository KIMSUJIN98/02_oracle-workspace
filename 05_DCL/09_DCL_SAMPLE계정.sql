-- 먼저 저장
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

-- CREATE TABLE 할 수 있는 권한이 없어서 문제 발생!
-- 3_1. CREATE TABLE 권한 받기
-- 3_2. TABLE SPACE 할당 받기

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '안녕');                                              -- ROLLBACK 할 것이므로 수행할 필요 없음.
--------------------------------------------------------------------------------

-- KH계정에 있는 EMPLOYEE 테이블에 접근
SELECT * FROM KH.EMPLOYEE;                                                       -- 관리자계정에서 권한부여 후 확인해보니, 조회 가능함.
-- 조회 권한이 없음

INSERT INTO KH.DEPARTMENT
VALUES('D0', '회계부', 'L1');                                                     -- 관리자계정에서 권한부여 후 확인해보니, 데이터값 입력 가능함. ROLLBACK 할 것이므로 수행할 필요 없음.

SELECT * FROM KH.DEPARTMENT;                                                     -- 삽입 권한만 주었으므로 조회는 불가함.

ROLLBACK;                                                                        -- 원본 복구를 위한 ROLLBACK

