-- ���� ����
CREATE TABLE TEST(
    TEST_ID NUMBER,
    TEST_NAME VARCHAR2(10)
);

-- CREATE TABLE �� �� �ִ� ������ ��� ���� �߻�!
-- 3_1. CREATE TABLE ���� �ޱ�
-- 3_2. TABLE SPACE �Ҵ� �ޱ�

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '�ȳ�');                                              -- ROLLBACK �� ���̹Ƿ� ������ �ʿ� ����.
--------------------------------------------------------------------------------

-- KH������ �ִ� EMPLOYEE ���̺� ����
SELECT * FROM KH.EMPLOYEE;                                                       -- �����ڰ������� ���Ѻο� �� Ȯ���غ���, ��ȸ ������.
-- ��ȸ ������ ����

INSERT INTO KH.DEPARTMENT
VALUES('D0', 'ȸ���', 'L1');                                                     -- �����ڰ������� ���Ѻο� �� Ȯ���غ���, �����Ͱ� �Է� ������. ROLLBACK �� ���̹Ƿ� ������ �ʿ� ����.

SELECT * FROM KH.DEPARTMENT;                                                     -- ���� ���Ѹ� �־����Ƿ� ��ȸ�� �Ұ���.

ROLLBACK;                                                                        -- ���� ������ ���� ROLLBACK

