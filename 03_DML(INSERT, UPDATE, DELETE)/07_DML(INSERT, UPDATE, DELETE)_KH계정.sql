-- ���� ����
-- ��������� ���� ����

/*
    DQL (QUERY ������ ���� ���) : SELECT
    
    DML (MANIPULATION ������ ���� ���) : [SELECT], INSERT, UPDATE, DELETE
    DDL (DEFINITION ������ ���� ���) : CREATE, ALTER, DROP
    DCL (CONTROL ������ ���� ���) : GRANT, REVOKE, [COMMIT, ROLLBACK]
    
    TCL (TRANSACTION Ʈ������ ���� ���) : COMMIT, ROLLBACK

    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���� ����(INSERT) �ϰų�, ����(UPDATE) �ϰų�, ����(DELETE) �ϴ� ����
*/

/*
    1. INSERT
       ���̺� ���ο� ���� �߰��ϴ� ����
       
       [ǥ����]
       1) INSERT INTO ���̺�� VALUES(��1, ��2, ....);
          ���̺� ��� �÷��� ���� ���� ���� �����ؼ� �� �� INSERT �ϰ��� �� �� ���
          �÷� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!!
          
          �����ϰ� ���� �������� ��� => not enough value ����!
          ���� �� ���� �������� ��� => too many values ����!
*/

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE
VALUES(900, '������', '900101-1234567', 'cha_00@kh.or.kr', '01011112222',
        'D1', 'J7', 'S3', 4000000, 0.2, 200, SYSDATE, NULL, DEFAULT);
        
SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO ���̺��(�÷���1, �÷���2, ..) VALUES (��1, ��2, ...);
       ���̺� ���� ������ �÷��� ���� ���� INSERT �� �� ���
       ������ �ȵ� �÷��� �⺻�����δ� NULL�� ��
       => NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �� �����ؾߵ�!!
       ��, DEFAULT ���� �ִ� ���� NULL�� �ƴ� DEFAULT�� ����!

*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(901, '������', '880202-1111111', 'J2', 'S2', SYSDATE);

SELECT * FROM EMPLOYEE;
-- ENT_YN�� ����Ʈ������ ������!!

INSERT
 INTO EMPLOYEE
     (
          EMP_ID
        , EMP_NAME
        , EMP_NO
        , JOB_CODE
        , SAL_LEVEL
        , HIRE_DATE
     )
VALUES
    (
          901
        , '������'
        , '880202-1111111'
        , 'J2'
        , 'S2'
        , SYSDATE
    );
--------------------------------------------------------------------------------
/*
    3) INSERT INTO ���̺�� (��������)
       VALUES�� �� ���� ����ϴ°� ��ſ�
       ���������� ��ȸ�� ������� ��°�� INSERT ����!! (������ INSERT ����!!)
*/

CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 (
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
);

SELECT * FROM EMP_01;




































































