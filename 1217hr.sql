select * from employees where department_id = 90;

SELECT last_name
FROM employees
WHERE last_name LIKE '_o%' ;

SELECT last_name, manager_id FROM employees WHERE manager_id IS NULL ;
SELECT last_name, manager_id FROM employees WHERE manager_id IS NOT NULL ;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%' ;

select last_name, department_id, salary
from employees
order by 2 desc, salary desc;

--top n query
select * from employees order by employee_id;

--offset n rows, fetch n norws only
--OFFSET �ڸ����� ���ϴ� row limits ������ �̱� ������ ��ŵ�ϰ� ���� row ������ ���� �ÿ� ���ָ� �ȴ�.
--OFFSET�� ������ ���� ��� Oracle�� 0���� �ν� / NULL �� ���ų� ���ϵǴ� row �������� ���� ���� �� ��� �ƹ� �൵ ���ϵ��� �ʴ´�.

select employee_id, first_name from employees order by employee_id offset 5 rows fetch next 5 rows only;
SELECT employee_id, first_name FROM employees ORDER BY employee_id FETCH FIRST 5 ROWS ONLY;

select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num; --employ num�� ���� ���� �Է��ϵ��� ��

--�����Ҷ����� �÷����� �ٲ㼭 ȣ���� �� �ִ� ����
select employee_id, last_name, salary, department_id, &a 
from employees
where employee_id = &employee_num;

select last_name, department_id, salary*12
from employees
where job_id = '&job_title'; --���� �ְ���� �� ����ǥ �ȿ��� & �� �� ����

SELECT employee_id, last_name, job_id,&column_name 
FROM employees WHERE &condition ORDER BY &order_column ;
--���� &�ڿ��� ���� â�� ���� ���� ��� ������ �̸����� ���� ��..

--���� ���ۻ��� ġȯ ���� ���
--�̰��, ù��° ���ۻ����� ����� �������� �����ؼ� �ι�° ���ۻ��忡�� �˾Ƽ� ���
--��, �ι�° ���ۻ��忡�� ����� �������� ����� ����
select employee_id, last_name, job_id, &&column_name
from employees
order by &column_name;

--<define ��ɾ�>
define employee_num = 200

select employee_id, last_name
from employees
where employee_id = &employee_num;

undefine column_name;
undefine employee_num

--<verify ��� ���>
--��� ����� ������ � ���� ���� ��µǾ����� �˷���
--set verify on: ���泻�� �ڼ��ϰ�, set verify off: �����丮���� �����ϰ�
set verify on
select employee_id, last_name, salary
from employees
where employee_id = &employee_num;

--��ҹ��� ��ȯ
--��ҹ��� �����ϴ°� Ȭ����ǥ �ȿ� �ִ� �͸�!!!!! ������ ����
--upper, lower

--<substr>
select substr('HelloWorld', 1, 5) from dual;
select substr('HelloWorld', -1) from dual;
--���� �ε������� �ް�����.
--�ް� ������ ������ ������.
--�ε����� 1���� ����
select employee_id, CONCAT(first_name, last_name) NAME,
LENGTH (last_name), INSTR(last_name, 'a') "Contains 'a'?"
FROM employees
WHERE SUBSTR(last_name, -1, 1) = 'n';

SELECT CONCAT(CONCAT(last_name, '''s job category is '), job_id) "Job" 
FROM employees WHERE SUBSTR(job_id, 4) = 'REP';

--�Լ� ��ø: ���� ���ʿ� �ִ� �Լ����� ���ʷ� ����.
SELECT last_name,
UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US'))
FROM employees
WHERE department_id = 60;

select to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') from dual;
select sysdate from dual;

--������ ���� �ȵ�� �ٲܼ�����..�ϴ� �Ķ���͵��� �ѷ����� ����
select * from v$NLS_PARAMETERS;
alter session set NLS_Date_format = 'RRRR-MM-DD';
alter session set NLS_Date_format = 'YYYY/MM/DD';

--CURRENT TIME
SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;
SELECT SESSIONTIMEZONE, CURRENT_TIMESTAMP FROM DUAL;

--��¥ �Լ�
SELECT MONTHS_BETWEEN('2020-01-02', '2020-05-02') FROM DUAL;
SELECT ADD_MONTHS('2020-01-02', 4) FROM DUAL; --��¥�� �� �߰�
SELECT NEXT_DAY('2020-01-02', FRIDAY) FROM DUAL; --������ ��¥�� ����? �̰� ����
SELECT ROUND(SYSDATE , 'MONTH') FROM DUAL;  --#�ݿø�
SELECT ROUND(SYSDATE, 'YEAR') FROM DUAL;
SELECT TRUNC(SYSDATE, 'MONTH') FROM DUAL; --�������� ����...?
SELECT TRUNC(SYSDATE, 'YEAR') FROM DUAL;

--<null�� ��ü>
--nvl(�÷���, ��) �÷����� null�̸� ������ ��ü��
--nvl2(�÷���, ��1, ��2) �÷����� null�� �ƴϸ� ��1, �÷����� null�̸� ��2
select last_name, salary, commission_pct, nvl2(commission_pct, 'sal+comm', 'sal') income
from employees where department_id in (50, 80);

--<null if>
--nullif(��1, ��2)
--��1�� ��2�� ���ٸ� null�� ����ϰ�, ���� �ʴٸ� ��1�� ����Ұ�

--<coalesce �Լ�>
--coalesce(��1, ��2)....��n
--��1�� ����� null�̸� ��2�� ����
--��2�� null�̸� ��3 ����....���� �������� ����
select last_name, coalesce(salary, 1000)
from employees
where department_id = 10;

--<case when then, decode>�Լ�
select last_name, decode(job_id, 'IT_PROG', 100, 'SALES', 200)
FROM EMPLOYEES;


-- <3 WAY JOIN> 3�� �̻� ���� ���̺� �����ϱ�
SELECT employee_id, city, department_name
FROM employees e
JOIN departments d
ON d.department_id = e.department_id
JOIN locations l
ON d.location_id = l.location_id;
--�ؿ��� ������.
SELECT employee_id, city, department_name
FROM employees e, departments d, locations l
where d.department_id = e.department_id
and d.location_id = l.location_id;

--self join�� alias ����� �ʼ� ������

-- non equal join�� ���...

--union
--�ٸ����̺��� ������ ������ �Ѳ����� ��� ����
SELECT job_id
FROM employees
UNION
SELECT job_id
FROM retired_employees;
--union�� ������� �ߺ����� �ǰ�, union all�� �ߺ����� �ȵ�ä�� ����

--###################################################################
--####                   SQL�ǽ�05                     ####
--###################################################################

--1-1. �޿��� 1000�̻��� �������?�μ���?���?�޿���?����غ�����?��,?�μ���?���?�޿���?2000?�̻���?�μ���?����ϼ���.
select department_id, avg(salary)
from employees
where salary >= 1000
group by department_id
having avg(salary) >= 2000;

--1-2. ��?�μ���?����?����(job)��?�ϴ�?�����?�ο�����?���ؼ�?�μ���ȣ,?����(job),?�ο�����?�μ���ȣ��?���ؼ�?��������?�����ؼ�?�����?������.
select * from employees;

select department_id, job_id, count(job_id)
from employees
group by department_id, job_id
order by department_id;

--1-3. �����ȣ,�μ���ȣ,�μ�����?����ϼ���?��,?�����?�ٹ�����?�ʴ�?�μ���?����?����غ�����.
select * from departments;
select e.employee_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;


--1-4. 'DALLAS'?����?�ٹ��ϴ�?�����?�̸�,?�μ���ȣ��?����غ�����.
select * from tab;
select * from locations;

select e.last_name, e.department_id
from employees e, locations l
where l.city = 'Dallas';

--1-5.�޿���?3000?�̻�޴�?�����?�Ҽӵ�?�μ���?������?�μ�����?�ٹ��ϴ�?�������?�̸���?�޿�,?�μ���ȣ��?�����?������
select e.last_name, e.department_id
from employees e
where e.department_id = ANY(select department_id from employees where salary >=3000);

--1-6. IN?�����ڸ�?�̿��Ͽ�?�μ�����?����?�޿���?����?�޴�?�����?�����ȣ,?��?��,?�μ���ȣ��?����غ�����.
select last_name, employee_id, salary, department_id
from employees
where (department_id,salary) in (select department_id, max(salary) from employees group by department_id);

--1-7. 30��?�μ���?����߿���?�޿���?����?����?�޴�?�������?��?����?�޿���?�޴�?�����?�̸���?�޿���?����غ�����.
select last_name, salary
from employees
where salary > (select max(salary) from employees where department_id = 30);

--1-8.�μ���ȣ��?30����?�������?�޿���?����?�޿�����?����?�޿���?�޴�?�����?�̸�,?�޿���?����غ�����.
select last_name, salary
from employees
where salary > (select min(salary) from employees where department_id = 30);

--<part 2>
--1. ��å(Job Title)�� Sales Manager�� ������� �Ի�⵵�� �Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�.
-- ��� �� �⵵�� �������� �������� �����Ͻÿ�.
select hire_date, avg(salary) from employees group by hire_date order by hire_date;
select * from jobs;

select e.hire_date, avg(e.salary)
from employees e, jobs j
where e.job_id = j.job_id
and j.job_title = 'Sales Manager'
group by e.hire_date
order by e.hire_date;

--2. �� ����(city)�� �ִ� ��� �μ� �������� ��ձ޿��� ��ȸ�ϰ��� �Ѵ�.
-- ��ձ޿��� ���� ���� ���ú��� ���ø�(city)�� ��տ���, �ش� ������ �������� ����Ͻÿ�.
-- ��, ���ÿ� �� ���ϴ� ������ 10�� �̻��� ���� �����ϰ� ��ȸ�Ͻÿ�.
select * from employees;

select l.location_id, l.city, avg(e.salary)
from employees e, locations l, departments d
where e.department_id = d.department_id
and d.location_id = l.location_id
group by l.location_id, l.city
having count(e.employee_id) < 10
order by avg(e.salary);

--3. ��Public Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�.
-- (���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ��� ���� �ʴ´�.)
-- �̸��� first_name, last_name�� �Ʒ��� �������� ���� ����Ѵ�.
select * from jobs;
select * from employees;
select * from job_history;
--hire_date between start_date and end_date
select e.employee_id, e.first_name, e.last_name, e.hire_date
from employees e, jobs j, job_history h
where e.job_id = j.job_id
and j.job_id = h.job_id
and j.job_title = 'Public Accountant';

--4. �ڽ��� �Ŵ������� ����(salary)�� ���� �޴� �������� ��(last_name)�� ����(salary)�� �� ���Ͻÿ�.

select e.last_name, e.salary
from employees e
where e.salary > (select salary from employees where employee_id = e.manager_id);


--5. 2007�⿡ �Ի�(hire_date)�� �������� ���(employee_id), �̸�(first_name), ��(last_name),
-- �μ���(department_name)�� ��ȸ�մϴ�.
-- �̶�, �μ��� ��ġ���� ���� ������ ���, ������ ����Ͻÿ�.
select e.employee_id, e.first_name, e.last_name, nvl2(d.department_name, department_name, '''')
from employees e, departments d
where e.department_id = d.department_id(+)
and e.hire_date like '2007%';

--6. ������(job_title)�� ��Sales Representative���� ���� �߿��� ����(salary)�� 9,000�̻�, 10,000 ������
-- �������� �̸�(first_name), ��(last_name)�� ����(salary)�� ����Ͻÿ�
select e.first_name, e.last_name, e.salary
from employees e, jobs j
where e.job_id = j.job_id
and j.job_title = 'Sales Representative'
and e.salary between 9000 and 10000;

--7. �μ����� ���� ���� �޿��� �ް� �ִ� ������ �̸�, �μ��̸�, �޿��� ����Ͻÿ�.
-- �̸��� last_name�� ����ϸ�, �μ��̸����� �������� �����ϰ�,
-- �μ��� ���� ��� �̸��� ���� ���� �������� �����Ͽ� ����մϴ�.
select e.last_name, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
and (e.department_id, e.salary) in (select department_id, min(salary) from employees group by department_id)
order by d.department_name, e.last_name;


--8. EMPLOYEES ���̺��� �޿��� ���� �޴� ������� ��ȸ���� �� ���ó�� 6��°���� 10 ��°����
-- 5���� last_name, first_name, salary�� ��ȸ�ϴ� sql������ �ۼ��Ͻÿ�.
select e.last_name, e.first_name, e.salary
from employees e
offset 6 rows fetch next 5 rows only;

--9. ����� �μ��� ���� ����(city)�� ��Seattle���� ����� �̸�, �ش� ����� �Ŵ��� �̸�, ��� �� �μ��̸��� ����Ͻÿ�.
-- �̶� ����� �Ŵ����� ���� ��� ��<����>���̶�� ����Ͻÿ�. �̸��� last_name�� ����ϸ�,
-- ����� �̸��� ������������ �����Ͻÿ�.
select e.last_name, nvl2(m.last_name, m.last_name, '<����>'), d.department_name
from employees e, employees m, departments d, locations l
where e.manager_id = m.employee_id(+)
and e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle'
order by e.last_name;

--10. �� ����(job) ���� ����(salary)�� ������ ���ϰ��� �Ѵ�. ���� ������ ���� ���� ��������
-- ������(job_title)�� ���� ������ ��ȸ�Ͻÿ�.?�� ���������� 30,000���� ū ������ ����Ͻÿ�.
select e.job_id, j.job_title, sum(e.salary)
from employees e, jobs j
where e.job_id = j.job_id
group by e.job_id, j.job_title
having sum(e.salary) > 30000
order by sum(e.salary) desc;