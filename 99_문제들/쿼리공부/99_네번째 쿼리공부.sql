-- 1 �����ذ� �ó�����
SELECT DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- JOB_CODE�� �׷� ���̷� �������� �ʰ�, SALARY�� �׷� ���̷� �������� �����鼭 �׷��Լ��ε� ������ ���� ����.

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE;
-- �׷����� �������� �ݵ�� SELECT���� �����ų�, �׷��Լ��� ������ �Ѵ�.