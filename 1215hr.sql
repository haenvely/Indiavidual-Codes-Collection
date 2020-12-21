select * from tab;
-- countries, departments, employees, emp_details_view, jobs, job_history, locations, regions

--#20�� �μ��� �̸��� �� �μ��� �ٹ��ϴ� ����� �̸�
select * from departments;
select d.department_name, e.last_name from departments d, employees e
where d.department_id = e.department_id and d.department_id = 20;

--#1400, 1500�� ��ġ�� ���� �̸��� �װ��� �ִ� �μ��� �̸� ���
select * from locations;
select l.city, d.department_name from locations l, departments d
where l.location_id = d.location_id;

--<����1.>HR ���� ��� �� ���� ���� �Ի��� ��� ���
select * from employees;

select e.*
from employees e
where e.hire_date = (select min(hire_date) from employees);


--<���� 2> HR ���� �� ����(region)���� ������ ������ ����Ͻÿ�(������, ���� ���� ���)
select * from regions;
select * from countries;

select r.region_name, count(c.country_id)
from regions r, countries c
where r.region_id = c.region_id
group by r.region_id, r.region_name;

select r.region_id, r.region_name, count(c.country_id)
from regions r, countries c
where r.region_id = c.region_id
group by r.region_id, r.region_name;

--<���� 3> HR���� ����� ������ ���� ���� ����� ��� ������ ����Ͻÿ�
select * from employees
where salary = (select max(salary) from employees);

--<���� 4> HR���� ����� last_name �̸� ������� ���� 3���� last_name�� ����Ͻÿ�.
--top k ���
select * from employees;

select rownum, last_name
from (select * from employees order by last_name)
where rownum < 4;


--<���� 5> HR���� �� �μ��� �Ŵ��� ��ȭ��ȣ�� ����ϰ�, �μ� ��ȣ ������� ����(�μ���ȣ, �μ��̸�, �Ŵ��� last �̸�, �Ŵ��� ��ȭ��ȣ)
select * from departments;
select * from employees;

select d.department_id, d.department_name, e.last_name, e.phone_number
from departments d, employees e
where d.manager_id = e.employee_id
order by d.department_id;




