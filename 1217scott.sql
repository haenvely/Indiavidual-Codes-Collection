--index
--����: �˻�, ����, ����..�������Ϸ��� / ����: �������
--where���� �����̳� join�� ���� ���Ǵ� �÷�
-- �ſ� ū ���̺��� 2~4% ���ڵ常 ������ ��
-- ���� ������ �پ��� ��. �׷��� Ʈ�� �������� ������ ���� (��. ����?ó�� �پ缺�� ���� �� ���ɿ� ������)
-- ���� ������� ���� ��

create index idx_emp_ename on emp(ename);
drop index idx_emp_ename;

--dictionary���� ã��
select * from user_indexes;
select * from user_ind_columns;

--synonym : =alias���� ����
--���� �����ڰ� ����

--Oracle SQL1_ep.pdf
-- SQL: RDBM�� ���� Ansi ǥ�ؾ��
--�ߺ�����
select distinct job from emp;

--��ü �ο� ������ q
SELECT department_name || q'[ Department's Manager Id: ]' || manager_id AS "Department and Manager" FROM dept;

SELECT  sal*12 "yearly sal" FROM emp;


