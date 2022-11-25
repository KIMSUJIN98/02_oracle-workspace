SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL;

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '_', 1, 1) AS "_위치", INSTR(EMAIL, '@') AS "@위치"
FROM EMPLOYEE;

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 7번째부터 끝까지 출력 => THEMONEY
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL; -- 5번째부터 2개만 출력 => ME
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- 처음부터 6개만 출력  => SHOWME
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- 뒤에서 8번째부터 3개만 출력 => THE
SELECT SUBSTR('KIM SU JIN', 5) FROM DUAL; -- SU JIN

SELECT EMP_NAME, EMP_NO, SUBSTR(EMP_NO, 8, 1) AS "성별" -- 주민번호 8번째부터 1개만 출력
FROM EMPLOYEE;

SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = '1' OR SUBSTR(EMP_NO, 8, 1) = '3';
--WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3);
WHERE SUBSTR(EMP_NO, -7, 1) IN (1, 3)
--ORDER BY EMP_NAME;
ORDER BY 1;

SELECT EMP_NAME, EMAIL, EMP_NO, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) AS "아이디"
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, ' ')
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

SELECT RPAD('850101-2', 14, '*')
FROM EMPLOYEE;

SELECT EMP_NAME AS "성명", RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') AS "주민번호(보안)"
FROM EMPLOYEE;