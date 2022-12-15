-- ���� ����
-- 1208 �����ͺ��̽� ���� �׽�Ʈ (KH ����)
-- =============================================================================
-- ����� ���� ������ ������ �������� �ؾ� �Ѵ�.
-- SQL������ ��й�ȣ �ۼ� ������ �����ִ�.
-- �ּ����� ���� �ο��� �ʿ��ϴ�.

-- �����ڰ������� �ؾ� �Ѵ�.
-- CREATE USER SAMPLE IDENTIFIED BY 1234;
-- GRANT CONNECT, RESOURCE TO SAMPLE;

-- =============================================================================
SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6') AND SALARY >= 3000000
AND EMAIL LIKE '___$_%' ESCAPE '$' AND BONUS IS NOT NULL
AND SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 1. OR �����ڿ� AND �����ڰ� ���� �ִ� ��� AND �����ڿ� �켱������ �־����Ƿ�, �������� ������ DEPT_CODE �񱳸� ���ؼ��� OR ������ �κ��� ��ȣ�� ������� �Ѵ�.
-- 2. SALARY�� 300���� �̻��̶� �����Ƿ�, >�� �ƴ� >=�� �ۼ��ؾ� �Ѵ�.
-- 3. BONUS�� �ִٴ� ���� NULL���� �ƴ϶�� ���̹Ƿ� IS NULL�� �ƴ� IS NOT NULL�� �ۼ��ؾ� �Ѵ�.
-- 4. �������� �־��� ���ڶ�� ������ �����Ǿ���. ������ �߰������ �Ѵ�.
-- 5. EMAIL �񱳽� ���ο� ���ϵ�ī�带 ���������ν� �׹�° _���ڸ� �����ͷ� �о���̰�, �̸� ESCAPE�ν� ����������� �Ѵ�.

-- =============================================================================
SELECT * FROM EMPLOYEE WHERE BONUS IS NULL AND MANAGER_ID IS NOT NULL;

-- NULL���� �Ϲ� �񱳿����ڸ� ���� ���� �� ����. NULL���� IS NULL / IS NOT NULL�� ���� �����ڸ� ���� ���ؾ߸� �Ѵ�.

-- =============================================================================
SELECT TO_CHAR(TO_DATE('210505'), 'YYYY"��" FMMM"��" DD"��"') FROM DUAL;

-- =============================================================================
CREATE TABLE EMP(
    EMAIL VARCHAR2(50) CONSTRAINT EMP_EMAIL_NN NOT NULL
);

SELECT * FROM EMP;

DROP TABLE EMP;
-- =============================================================================
-- 1215 SQL Ȱ�� �׽�Ʈ
SELECT DEPT_CODE, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2800000
ORDER BY 1 ASC;

SELECT * FROM EMPLOYEE;

-- �׷��Լ��� ���ǽ��� WHERE���� �ƴ� HAVING���� ���ؾ� �Ѵ�.
-- �׳� ����(SALARY)�� �ƴ� ��� ������ ���ؾ��ϹǷ� AVG(SALARY)�� ����ؾ� �Ѵ�.
/*
SELECT DEPT, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMP
GROUP BY DEPT
HAVING AVG(SALARY) > 2800000
ORDER BY DEPT ASC;
*/

DROP TABLE MEMBER_KH;

CREATE TABLE MEMBER_KH(
    MNO NUMBER PRIMARY KEY,             -- ȸ����ȣ
    MNAME VARCHAR2(300) NOT NULL,       -- ȸ����
    ADDRESS VARCHAR2(1000),             -- �ּ�
    TEL VARCHAR2(13) UNIQUE             -- ����ó
);

INSERT INTO MEMBER_KH VALUES(1, 'ȫ�浿', '����� ������', '011-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '��浿', '�λ�� �ؿ�뱸', '010-0000-0000');
INSERT INTO MEMBER_KH VALUES(1, '�谩ȯ', '��õ�� ������', '019-0000-0000');

-- ���� MNO �÷��� ���������� PRIMARY KEY�� �ĺ����� ������ �Ѵ�.
-- PRIMARY KEY�� �ڵ������� UNIQUE + NOT NULL ���������� ���µ�, ���� INSERT���� ���� MNO �÷��� ���� 1�� �ߺ��Ǵ� ���� Ȯ���� �� �ִ�.
-- ���� �� INSERT���� MNO �÷��� NULL���� �ƴ� ���� �ٸ� ���� ������ �Ѵ�.

-- �Ʒ��� ���� NULL���� �ƴϰ�, �ߺ����� ���� ���� ���� �Ѵ�.
INSERT INTO MEMBER_KH VALUES(1, 'ȫ�浿', '����� ������', '011-0000-0000');
INSERT INTO MEMBER_KH VALUES(2, '��浿', '�λ�� �ؿ�뱸', '010-0000-0000');
INSERT INTO MEMBER_KH VALUES(3, '�谩ȯ', '��õ�� ������', '019-0000-0000');

-- =============================================================================
-- ��������, �����Ű�� �÷����� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ

-- �ܺ�����, ���� ���̺� �����Ͽ� ��ġ���� �ʴ� ��鵵 ������ ��ȸ ����

-- ���̺� : �����͸� ������ ǥ ���·� ǥ���ϴ� ��

-- TRIM() : ���ڿ��� �� LEADING / �� TRAILING / ���� BOTH ���� ���� ���ڵ��� ������ ���ڿ��� ��ȯ�ϴ� �Լ�(������ ���� ����, �����ִ� ��� ������ ���� ����)

-- ROLLUP() : �׷캰 ����� ������� �߰����踦 ������ִ� �Լ�, GROUP BY���� ���

SELECT EMPNAME AS "������", JOBCODE AS "�����ڵ�", SALARY AS "�޿�",
       DECODE(JOBCODE, 'J7', SALARY * 1.08, 'J6', SALARY * 1.07, 'J5', SALARY * 1.05, SALARY * 1.03) AS "�λ�޿�"
FROM EMP;

SELECT EMP_NAME AS "������", JOB_CODE AS "�����ڵ�", SALARY AS "�޿�",
       DECODE(JOB_CODE, 'J7', SALARY * 1.08, 'J6', SALARY * 1.07, 'J5', SALARY * 1.05, SALARY * 1.03) AS "�λ�޿�"
FROM EMPLOYEE;

-- =============================================================================




















































