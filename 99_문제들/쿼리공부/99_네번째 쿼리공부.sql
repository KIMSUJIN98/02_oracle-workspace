-- 1. �����ذ� �ó�����
SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- ����
-- JOB_CODE�� GROUP BY�� �������� �ʰ�, SALARY�� GROUP BY�� �������� �����鼭 �׷��Լ��ε� ���� ���� ����.
-- SELECT ����� GROUP BY�� ��ġ���� �����Ƿ�, ������ �ʿ���.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- �ذ���
-- �׷����� �������� �ݵ�� SELECT���� �����ų�, �׷��Լ��� ������ �Ѵ�.