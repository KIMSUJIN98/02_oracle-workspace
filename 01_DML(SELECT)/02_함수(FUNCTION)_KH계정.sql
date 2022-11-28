-- ���� ����
/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о�鿩�� N���� ������� ���� (�� �� ���� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT���� ������ �Լ��� �׷��Լ��� �Բ� ��� ����!!
       ��? ��� ���� ������ �ٸ��� ����!!!
       
    >> �Լ����� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
    
*/

/*
    < ���� ó�� �Լ� >
    
    * LENGTH / LENGTHB      => ����� NUMBER Ÿ��
    
    LENGTH(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ���ڼ� ��ȯ
    LENGTHB(�÷�|'���ڿ���') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��', '��', '��' �ѱ��ڴ� 3BYTE    ��ÿ� 9����Ʈ
    ������, ����, Ư�� �ѱ��ڴ� 1BYTE
    
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺�! ���̺� ���� ���� �� ���� ��!

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- ���ึ�� �� ����ǰ� ����! => ������ �Լ�

/*
    * INSTR
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ
    
    INSTR(�÷�|'���ڿ�', 'ã�����ϴ¹���', ['ã����ġ�� ���۰�', [����]])     => ������� NUMBER Ÿ��!!
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�.
    -1 : �ڿ������� ã�ڴ�.
    
*/

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ã�� ��ġ�� ���۰��� 1�� �⺻�� => �տ������� ã��. ������ 1 �⺻��                     -- INSTR('���ڿ�', 'ã�����ϴ¹���')�� �����
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;                                                                             -- ���� ������ ����� 3
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;                                                                            -- �ٸ� ����� 10, �ڿ������� ã�� ù��° B ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;                                                                          -- �ٸ� ����� 9, �տ������� ã�� �ι�° B ��ġ��
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;                                                                         -- �ٸ� ����� 3, �ڿ������� ã�� ����° B ��ġ��

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_��ġ", INSTR(EMAIL, '@') AS "@��ġ"
FROM EMPLOYEE;
--------------------------------------------------------------------------------------
/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹٿ��� subString() �޼ҵ�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => ������� CHARACTER Ÿ��
    - STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITION : ���ڿ��� ������ ������ġ��
    - LENGTH : ������ ���� ���� (������ ������ �ǹ�)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;                                       -- THEMONEY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;                                    -- ME
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;                                    -- SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;                                   -- THE (������ �ڿ������� �о ��ġ�� ������ / LENGTH�� �����̹Ƿ� ������ �� �� ����)

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "����"
FROM EMPLOYEE;

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���� ����鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3) -- ���������� �ڵ� ����ȯ                          -- ������� CHARACTER Ÿ������ �������ֱ⿡ �ڵ� ����ȯ��
--ORDER BY EMP_NAME;
ORDER BY 1; -- �⺻�����δ� ��������                                                    -- �����ټ����� ����

-- �Լ� ��ø���
SELECT EMP_NAME, EMAIL, EMP_NO, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "���̵�"
FROM EMPLOYEE;

---------------------------------------------------------------------------------------
/*
    * LPAD / RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ� ��ȯ
*/

-- 20��ŭ�� ���� �� EMAIL �÷����� ���������� �����ϰ� ������ �κ��� �������� ä����
SELECT EMP_NAME, LPAD(EMAIL, 20) -- �����̰��� �ϴ� ���� ������ �⺻���� ����!!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850101-2****** ������ ��ȸ => �� ���ڼ� : 14
SELECT RPAD('850101-2', 14, '*')
FROM DUAL;

/* SELECT EMP_NAME, RPAD(�ֹι�ȣ������ ���� �ڸ����� ������ ���ڿ�, 14, '*')
FROM EMPLOYEE; */

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*')
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM / RTRIM (STRING, ['������ ���ڵ�'])         => �����ϸ� ���� ��������
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/
SELECT LTRIM('   K H ') FROM DUAL; -- ���� ã�Ƽ� �����ϰ� ����ƴ� ���ڳ����� �׳� ����      -- 'K H ' : ���� ������ ���ŵ�
SELECT LTRIM('123123KH123', '123') FROM DUAL;                                       -- KH123
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;                                         -- KH : ������ ���ڿ��� �ִ� ���ڵ��̸� ���� �������ش�

SELECT RTRIM('5782KH123', '0123456789') FROM DUAL;                                  -- 5782KH : ������ 0~9������ ���ڵ��� ���ŵ�

/*
    * TRIM
    ���ڿ��� �� / �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM([[LEADING|TRAILING|BOTH] �����ϰ��� �ϴ� ���ڵ� FROM]STRING)
    
*/
SELECT TRIM('   K H   ') FROM DUAL;                                                 -- K H
-- SELECT TRIM('ZZZKHZZZ', 'Z') FROM DUAL;                                          -- ���� �߻� : �߸��� ǥ����
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;                                         -- KH

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- LEADING : �� => LTRIM�� ����         -- KHZZZ
SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- TRAILING : �� => RTRIM�� ����       -- ZZZKH
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; -- BOTH : ���� => ������ �⺻��              -- KH

---------------------------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP (STRING)        => ����� CHARACTER Ÿ��
    
    LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toLowerCase() �޼ҵ�� ����)
    UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� toUpperCase() �޼ҵ�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcome To My World!') FROM DUAL;                                     -- welcome to my world!
SELECT UPPER('Welcome To My World!') FROM DUAL;                                     -- WELCOME TO MY WORLD!
SELECT INITCAP('welcome to my world!') FROM DUAL;                                   -- Welcome To My World!
--------------------------------------------------------------------------------
/*
    * CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)          => ����� CHARACTER Ÿ��
*/

SELECT CONCAT('ABC', '���ݸ�') FROM DUAL;
SELECT 'ABC' || '���ݸ�' FROM DUAL;

-- SELECT CONCAT('ABC', '���ݸ�', '�԰�ʹ�') FROM DUAL; -- �����߻�!! : 2���� ���� �� ����
SELECT 'ABC' || '���ݸ�' || '�԰�ʹ�' FROM DUAL;

--------------------------------------------------------------------------------------
/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)         => ������� CHARACTER Ÿ��                    -- STRING�� STR1�� STR2�� �ٲٰڴ�!
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

--------------------------------------------------------------------------------------
/*
    < ���� ó�� �Լ� >
    
    * ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)         => ������� NUMBER Ÿ��!!
*/

SELECT ABS(-10) FROM DUAL;                                                          -- 10
SELECT ABS(-5.7) FROM DUAL;                                                         -- 5.7

--------------------------------------------------------------------------------------
/*
    * MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER, NUMBER)         => ����� NUMBER Ÿ��
*/
SELECT MOD(10,3) FROM DUAL;                                                         -- 1
SELECT MOD(10.9, 3) FROM DUAL;                                                      -- 1.9

--------------------------------------------------------------------------------------
/*
    * ROUND
    �ݿø��� ����� ��ȯ
    
    ROUND(NUMBER , [��ġ])    => ������� NUMBER Ÿ��
    ��ġ ������ 0��° �ڸ����� �ݿø�                                                     -- default���� ��ġ�� 0
*/

SELECT ROUND(123.456) FROM DUAL; -- ��ġ ������ 0                                     -- 123
SELECT ROUND(123.456, 1) FROM DUAL;                                                 -- 123.5
SELECT ROUND(123.456, 5) FROM DUAL; -- ��ġ���� ū �� �Է½� �״�� ����                  -- 123.456
SELECT ROUND(123.456, -1) FROM DUAL;                                                -- 120
SELECT ROUND(123.456, -2) FROM DUAL;                                                -- 100
--------------------------------------------------------------------------------
/*
    * CEIL
    �ø�ó�� ���ִ� �Լ�
    
    CEIL(NUMBER)
*/
SELECT CEIL(123.152) FROM DUAL; -- 5�̻� �ƴϾ ������ �׳� �ø�! ��ġ���� �Ұ�
--------------------------------------------------------------------------------
/*
    * FLOOR
    �Ҽ��� �Ʒ� ����ó���ϴ� �Լ�
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.152) FROM DUAL; -- ������ ����. ��ġ ���� �Ұ�
SELECT FLOOR(123.952) FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TRUNC(�����ϴ�)
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL; -- ��ġ���� ���ϸ� FLOOR�̶� ������                       -- 123
SELECT TRUNC(123.456, 1) FROM DUAL; -- �Ҽ��� �Ʒ� ù°�ڸ� ���� ǥ���ϰ� �ʹ�.              -- 123.4
SELECT TRUNC(123.456, -1) FROM DUAL; -- �ش���ġ �ڷ� ������                             -- 120
--------------------------------------------------------------------------------
/*
    < ��¥ ó�� �Լ�>
*/

-- * SYSDATE : �ý��� ��¥ �� �ð� ��ȯ(���� ��¥ �� �ð�)
SELECT SYSDATE FROM DUAL; -- Ŭ���ؼ� Ȯ���غ��� �ð��� Ȯ���� ����

-- * MONTHS_BETWEEN (DATE1, DATE2) : �� ��¥ ������ ���� �� => ���������� DATE1 - DATE2 �� ������ 30, 31 �� �����.
-- => ������� NUMBER Ÿ��
-- EMPLOYEE���� �����, �ٹ��ϼ�, �ٹ�������
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) || '��' AS "�ٹ��ϼ�",
CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "�ٹ�������"
FROM EMPLOYEE;

-- * ADD_MONTHS(DATE, NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ����
-- => ����� : DATE Ÿ��
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;                                            -- 22/11/28�� ����ð� ���� 23/05/28 ����ð� ���

-- EMPLOYEE���� �����, �Ի���, �Ի� �� 6������ �� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6) AS "������ ���� ��¥"
FROM EMPLOYEE;

-- * NEXT_DAT(DATE, ����(����|����)) : Ư����¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�
-- => ������� DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;                               -- 22/11/28�� ���� ����� �ݿ����� 22/12/02�� ���
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- 1. �Ͽ���, 2. ������, ...... , 7. �ݿ���
SELECT SYSDATE, NEXT_DAY(SYSDATE, 6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;                             -- ���� ��ü�� �ѱ��̶� �Ұ����� >> ���� ������ �ʿ�

-- ��� ����
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
-- => ������� DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;                                                -- ���� ��¥�� �ش� ���� ������ ��¥�� ��ȯ��. 22/11/28 ���� 22/11/30�� ��ȯ

-- EMPLOYEE ���� �����, �Ի���, �Ի��Ѵ��� ��������¥, �Ի��� �޿� �ٹ��� �ϼ�
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE) - HIRE_DATE
FROM EMPLOYEE;

/*
    * EXTRACT : Ư�� ��¥�κ��� �⵵|��|�� ���� �����ؼ� ��ȯ�ϴ� �Լ�
    
    EXTRACT(YEAR FROM DATE) : �⵵�� ����
    EXTRACT(MONTH FROM DATE) : ���� ����
    EXTRACT(DAY FROM DATE) : �ϸ� ����
*/

-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME AS "�����",
EXTRACT(YEAR FROM HIRE_DATE) || '��' AS "�Ի�⵵",
EXTRACT(MONTH FROM HIRE_DATE) || '��' AS "�Ի��",
EXTRACT(DAY FROM HIRE_DATE) || '��' AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";                                                -- ORDER BY 2, 3, 4; �� �����ϴ�!  

--------------------------------------------------------------------------------

/*
    < ����ȯ �Լ� >
    
    * TO_CHAR() : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_CHAR(����|��¥, [����])        => ������� CHARACTER Ÿ��!!
*/

-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL; -- '1234' �� �ٲ������
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ¥�� ���� Ȯ��, ����������, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- ��ĭ 0���� ä���.
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, '$99999') FROM DUAL;

SELECT TO_CHAR(1234, 'L99,999') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(SALARY, 'L999,999,999')                                   -- ���ڿ� ������ ������� �¾ƾ� �Ѵ�.
FROM EMPLOYEE;

-- ��¥Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- Ŭ���غ��� �ٸ�! ��¥Ÿ���� �ð� ����               -- Ŭ�������� �޷��� ������ �ʴ´�.
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL; -- HH : 12�ð� ����                -- YY,MM,DD�� ��������!
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- HH24 : 24�ð� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON, YYYY') FROM DUAL;

SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- EX) 1990�� 02�� 06�� ��������
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') -- ���� ���� ������ ���� "" �̰ŷ� ����           -- SQL���� �����ϴ� ���˿� ���°� ""�� ��� ó���Ѵ�.
FROM EMPLOYEE;

-- �⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY'),                                                    -- 2022 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'YY'),                                                      -- 22 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'RRRR'),                                                    -- 2022 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'RR'),                                                      -- 22 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'YEAR')                                                     -- TWENTY TWENTY-TWO (���� : 2022/11/28/������)
FROM DUAL;

-- ���� ���õ� ����
SELECT TO_CHAR(SYSDATE, 'MM'),                                                      -- 11 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'MON'),                                                     -- 11�� (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'MONTH'),                                                   -- 11�� (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'RM')                                                       -- �θ��ڷ� 11�� ��� (���� : 2022/11/28/������)
FROM DUAL;

-- �Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), -- ���� �������� ������ ��ĥ°����                        -- 332 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'DD'), -- �� �������� ������ ��ĥ°����                          -- 28 (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'D') -- �� �������� ��ĥ°����                                  -- 2 (���� : 2022/11/28/������)
FROM DUAL;


-- ���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DAY'),                                                     -- ������ (���� : 2022/11/28/������)
       TO_CHAR(SYSDATE, 'DY')                                                       -- �� (���� : 2022/11/28/������)
FROM DUAL;

--------------------------------------------------------------------------------
/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����, [����])        => ����� : DATE Ÿ��
*/

SELECT TO_DATE(20100101) FROM DUAL;                                                 -- DATE Ÿ���� Ŭ���� �޷��� ����
SELECT TO_DATE(100101) FROM DUAL;

-- SELECT TO_DATE(070101) FROM DUAL; -- �����߻�
SELECT TO_DATE('070101') FROM DUAL; -- ù���ڰ� 0�ΰ��� ����Ÿ������ �����ϰ� �ؾ���       -- 1 2 3 4 01 02 03 04 => ��ǻ�Ͱ� 70101�� �޾Ƶ鿩 �����߻�

-- SELECT TO_DATE('041030 143000') FROM DUAL; -- �����߻�
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;                       -- SELECT TO_DATE('041030 143000', 'YYMMDD HHMISS') FROM DUAL; �ð� ���� 24�ð� �������� ��⿡ �����߻�

SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL; -- 2014��
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- 2098�� => ������ ���� ����� �ݿ�

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL; -- 2014��
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- 1998��
-- RR : �ش� ���ڸ� �⵵ ���� 50 �̸��� ��� ���� ���� �ݿ�, 50 �̻��� ��� �������� �ݿ�
--------------------------------------------------------------------------------
/*
    * TO_NUMBER : ���� Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�

    TO_NUMBER(����, [����])     => ������� NUMBER Ÿ��
*/
SELECT TO_NUMBER('05123475') FROM DUAL; -- 0 ������ ����Ÿ������ �����

SELECT '1000000' + '55000' FROM DUAL; -- ����Ŭ������ �ڵ�����ȯ�� �� ������!

SELECT '1,000,000' + '55,000' FROM DUAL; -- ������! �ȿ� ���ڸ� �־�� �ڵ� ����ȯ �ȴ�!!!

SELECT TO_NUMBER('1,000,000', '9,999,999') + TO_NUMBER('55,000', '99,999') FROM DUAL; -- ���� ����ȯ         -- ������ �־�߸� õ���� ���б�ȣ ,�� �ִ�ä�� ����ȯ�Ǿ� ����� �����ϴ�.
--------------------------------------------------------------------------------
/*
    < NULL ó�� �Լ� >
*/
-- NVL(�÷�, �ش� �÷����� NULL�ϰ�� ��ȯ�� ��)
SELECT EMP_NAME, BONUS, NVL(BONUS, 0)
FROM EMPLOYEE;

-- ��ü ����� �̸�, ���ʽ� ���� ����
SELECT EMP_NAME, (SALARY + SALARY * BONUS)*12, (SALARY + SALARY * NVL(BONUS, 0))*12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�μ�����')
FROM EMPLOYEE;

-- NVL2(�÷�, ��ȯ��1, ��ȯ��2)
-- �÷����� ������ ��� ��ȯ��1 ��ȯ
-- �÷����� NULL�� ��� ��ȯ��2 ��ȯ

SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '�μ�����')
FROM EMPLOYEE;

-- ���ʽ��� �ִ� : 0.7 / ���� : 0.1 / EMP_NAME, BONUS
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.1)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ��ġ�ϸ� NULL ��ȯ
-- �� ���� ���� ��ġ���� ������ �񱳴��1 ���� ��ȯ
SELECT NULLIF('123', '123') FROM DUAL;
SELECT NULLIF('123', '456') FROM DUAL;

-- ��� ���� ������ ? ����� // ������
--------------------------------------------------------------------------------
/*
    < ���� �Լ� >
    * DECODE(���ϰ����ϴ� ���(�÷�|�������|�Լ���), �񱳰�1, �����1, �񱳰�2, �����2, ....)
    
    SWITCH(�񱳴��){
    CASE �񱳰�1 : BREAK;
    CASE �񱳰�2 : BREAK;
    ...
    DEFAULT :
    }
    
*/
-- ���, �����, �ֹι�ȣ
SELECT
EMP_ID, EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1),
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '3', '��', '4', '��') AS "����"
FROM EMPLOYEE;

-- ������ �޿� ��ȸ�� �� ���޺��� �λ��ؼ� ��ȸ
-- J7�� ����� �޿��� 10% �λ� (SALARY * 1.1)
-- J6�� ����� �޿��� 15% �λ� (SALARY * 1.15)
-- J5�� ����� �޿��� 20% �λ� (SALARY * 1.2)
-- �� ���� ����� �޿��� 5% �λ� (SALARY * 1.05)

SELECT EMP_NAME, JOB_CODE, SALARY,
       DECODE(JOB_CODE, 'J7', SALARY * 1.1,
                        'J6', SALARY * 1.15,
                        'J5', SALARY * 1.2,
                        SALARY * 1.05) AS "�λ�� �޿�"
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ...
         ELSE �����
    END

*/

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '��� ������'
            WHEN SALARY >= 3500000 THEN '�߱� ������'
            ELSE '�ʱ� ������'
       END AS "����"
FROM EMPLOYEE;

