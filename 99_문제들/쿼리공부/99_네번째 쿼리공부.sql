-- 1. 문제해결 시나리오
SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 원인
-- JOB_CODE가 GROUP BY로 묶여있지 않고, SALARY가 GROUP BY로 묶여있지 않으면서 그룹함수로도 씌여 있지 않음.
-- SELECT 목록이 GROUP BY와 일치하지 않으므로, 수정이 필요함.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- 해결방안
-- 그룹으로 묶은것은 반드시 SELECT절에 나오거나, 그룹함수로 묶여야 한다.