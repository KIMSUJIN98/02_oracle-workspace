-- 1 문제해결 시나리오
SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- JOB_CODE가 그룹 바이로 묶여있지 않고, SALARY가 그룹 바이로 묶여있지 않으면서 그룹함수로도 씌워져 있지 않음.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- 그룹으로 묶은것은 반드시 SELECT절에 나오거나, 그룹함수로 묶여야 한다.