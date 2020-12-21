select * from tab;
select * from employees;

conn hr
--# DB ���� data�� ��ҹ��ڸ� �����ϹǷ� ����� ��Ȯ�� ���¸� ���� ���ϴ� ��� Function�� �̿��Ͽ� data�� ������Ų �� ���ϱ⵵ �Ѵ�.
select department_id, department_name from departments where department_name = 'SALES';
SELECT department_id, department_name FROM departments?where UPPER(department_name) = 'SALES'; --�����߻�

--#CHAR, ASCII
SELECT CHR(79)||CHR(114)||CHR(97)||CHR(99)||CHR(108)||CHR(101) FROM dual; -- Oracle
SELECT ASCII('O'),ASCII('r'),ASCII('a') FROM dual;-- 79, 114, 97
--# ���ڿ� ġȯ
SELECT REPLACE('Oracle DB System','DB','Database') FROM dual; --db�� database��
--# ���ڿ� �Ϻ� ����
select substr('Oracle DB System', 2, 4) from dual; --racl
--# �� ���� ������ ��ȯ A->1, B->2, ...
select translate('Oracle DBMS', 'ABCD', '1234') from dual; --Oracle 42MS
--# ó�� ������ ��ġ?
select instr('Oracle DBMS', 'a') from dual; --3
--#����
select length('Oracle DBMS') from dual; --11

--#substr ���ڿ� �Ϻ� ����
SELECT department_name, SUBSTR(department_name, 1,3) FROM departments;
SELECT department_name, SUBSTR(department_name, 1) FROM departments;
SELECT department_name, SUBSTR(department_name, -5, 3) FROM departments;

