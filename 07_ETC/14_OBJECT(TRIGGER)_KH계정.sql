-- ���� ����
/*
    < Ʈ���� TRIGGER >
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX)
    ȸ��Ż��� ������ ȸ�����̺��� �����͸� DELETE �� �� ��ٷ� Ż�� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���ؾߵȴ�!
    �Ű�Ƚ���� ���� ���� �Ѿ��� �� ����������(�ڵ�������) �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾ� �� ��
    
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
      > BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ����
      > AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
      > STATEMENT TRIGGER (����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �� ���� Ʈ���� ����
      > ROW TRIGGER (��Ʈ����) : �ش� SQL�� ������ �� ���� �Ź� Ʈ���� ����
                                (FOR EACH ROW �ɼ� ����ؾߵ�)
                                > :OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)                   -- BEFORE INSERT �� ����. �߰��� �ڷ� ��ü�� ���� �ȵ�.
                                > :NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)                     -- AFTER DELETE �� ����. ������ �ڷ� ��ü�� ���� �ȵ�.
    * Ʈ���� ��������
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER        INSERT|UPDATE|DELETE  ON ���̺��
    [FOR EACH ROW]                                                               -- :OLD, :NEW �� ����ϱ� ���ؼ��� �ݵ�� �־�� �Ѵ�.
    �ڵ����� ������ ����;
     �� [DECLARE
            ��������]
        BEGIN
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ���������� (�ڵ�����) ������ ����)
        [EXCEPTION
            ����ó������;]
        END;
        /


*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�!');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(500, '�̼���', '111111-2222222', 'D7', 'J7', 'S2', SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(501, '�ָ�', '222222-2222222', 'D8', 'J7', 'S2', SYSDATE);

--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� ������ ����

-- 1. ��ǰ�� ���� ������ ������ ���̺� (TB_PRODUCT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,               -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,            -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,            -- �귣��
    PRICE NUMBER,                           -- ����
    STOCK NUMBER DEFAULT 0                  -- ������
);

-- ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������20', '�Ｚ', 1400000, DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������14', '����', 1300000, 10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 600000, 20);

SELECT * FROM TB_PRODUCT;
COMMIT;

-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,               -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT,     -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                    -- ��ǰ�������
    AMOUNT NUMBER NOT NULL,                 -- ��������
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�', '���')) -- ����(�԰�/���)
);

-- �̷� ��ȣ�� �Ź� ���ο� ��ȣ �߻����Ѽ� �� �� �ְ� �����ִ� ������ (SEQ_DCODE)
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���� ��¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');
-- 200�� ��ǰ�� �������� 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT; -- �ش� Ʈ������ Ŀ��

-- 210�� ��ǰ�� ���� ��¥�� 5�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 5, '���');
-- 210�� ��ǰ�� �������� 5 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

COMMIT;
-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');
-- 205�� ��ǰ�� �������� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 200;                                                               -- 205�� ��ǰ�ε� 200������ �߸� �Է���.

ROLLBACK;                                                                        -- ������ Ŀ�� �������� ���ư��鼭 TB_PRODETAIL�� �԰� �̷¸��� ����� / �߸��� ���� ����� �ٽ� �Է��ϱ� ���� �ѹ�.
-- 205�� ��ǰ�� ���� ��¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');                              -- TB_PRODETAIL�� DCODE���� 3�� �ƴ� 4�� �Ǿ��� => �����ߴ��� ������ ���� 3�� ���� �̹� ����߱� ����. 
-- 205�� ��ǰ�� �������� 20 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;

COMMIT;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ������ UPDATE �ǰԲ� Ʈ���� ����

/*
    - ��ǰ�� �԰�� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + �����԰�ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �����԰�Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE��);
    
    - ��ǰ�� ���� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - �������ȼ���(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �������Ȼ�ǰ��ȣ(INSERT�� �ڷ��� PCODE��);
*/

-- :NEW �����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� => ������ ����
    IF(:NEW.STATUS = '�԰�')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    -- ��ǰ�� ���� ��� => ������ ����
    IF(:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/

-- 210�� ��ǰ�� ���� ��¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 210, SYSDATE, 7, '���');                               -- ������ Ʈ���Ÿ� �����صξ��⿡ TB_PRODUCT�� �ڵ� ����ȴ�.

-- 200�� ��ǰ�� ���� ��¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');

--------------------------------------------------------------------------------
/*SET SERVEROUTPUT ON;*/
DROP TABLE TB_ABSENCE;
DROP TABLE TB_STU;

DROP SEQUENCE SEQ_STU_NO;
DROP SEQUENCE SEQ_ABS_NO;

-- �л� ���̺� ����
-- TB_STU
-- �÷� : �й�, �̸�, ����(M,F), ��ȭ��ȣ, ��������(����Ʈ ����, ����, ����, ����)
-- STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS
CREATE TABLE TB_STU(
    STU_NO NUMBER PRIMARY KEY,
    STU_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK (GENDER IN('M', 'F')),
    PHONE VARCHAR2(13),
    STU_STATUS VARCHAR2(6) DEFAULT '����' CHECK (STU_STATUS IN('����', '����', '����', '����'))
);

-- �й������� ����(SEQ_STU_NO)
-- 900������ �����ϰ� (900,901)
CREATE SEQUENCE SEQ_STU_NO
START WITH 900
INCREMENT BY 1
NOCACHE;

-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) => DEFAULT Y
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
CREATE TABLE TB_ABSENCE(
    ABS_NO NUMBER PRIMARY KEY,
    STU_NO NUMBER REFERENCES TB_STU /*ON DELETE CASCADE*/,
    ABS_DATE DATE DEFAULT SYSDATE,
    ABS_STATUS CHAR(1) DEFAULT 'Y' CHECK (ABS_STATUS IN('Y', 'N'))
);

-- ���� ������ ����(SEQ_ABS_NO)
-- 1������ �����ϰ�
CREATE SEQUENCE SEQ_ABS_NO
NOCACHE;


CREATE OR REPLACE TRIGGER TRG_STU_01
AFTER INSERT ON TB_STU
FOR EACH ROW
BEGIN
    -- �л��� ������ ��쿡 => �л����̺��� �������θ� ������ ���
    -- ���� ���̺� INSERT ��Ű��
    IF(:NEW.STU_STATUS = '����')
        THEN
            INSERT INTO TB_ABSENCE
            VALUES(SEQ_ABS_NO.NEXTVAL, :NEW.STU_NO, DEFAULT, DEFAULT);
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TRG_STU_02
AFTER INSERT ON TB_ABSENCE
FOR EACH ROW
BEGIN
    -- ���� ���̺� ���п��ΰ� N���� �ٲ�� ���
    -- �л� ���̺��� �������� �������� ����
    IF(:NEW.ABS_STATUS = 'N')
        THEN
            UPDATE TB_STU
            SET STU_STATUS = '����'
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
    
    -- ���� ���̺� ���п��ΰ� Y�� �ٲ�� ���
    -- �л� ���̺��� �������� �������� ����
    IF(:NEW.ABS_STATUS = 'Y')
        THEN
            UPDATE TB_STU
            SET STU_STATUS = '����'
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/


-- ������ 5�� �����
INSERT INTO TB_STU(STU_NO, STU_NAME, GENDER, PHONE)
VALUES(SEQ_STU_NO.NEXTVAL, '�����', 'M', '010-5049-9858');
INSERT INTO TB_STU(STU_NO, STU_NAME, GENDER, PHONE/*, STU_STATUS*/)
VALUES(SEQ_STU_NO.NEXTVAL, '�ȼ���', 'M', '010-4254-7845'/*, '����'*/);
INSERT INTO TB_STU(STU_NO, STU_NAME, GENDER, PHONE)
VALUES(SEQ_STU_NO.NEXTVAL, '�Ѽ���', 'F', '010-2648-4841');
INSERT INTO TB_STU(STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS)
VALUES(SEQ_STU_NO.NEXTVAL, '�ֿ���', 'M', '010-4312-9922', '����');
INSERT INTO TB_STU(STU_NO, STU_NAME, GENDER, PHONE, STU_STATUS)
VALUES(SEQ_STU_NO.NEXTVAL, '���̽�', 'F', '010-4275-4573', '����');  

--------------------------------------------------------------------------------
