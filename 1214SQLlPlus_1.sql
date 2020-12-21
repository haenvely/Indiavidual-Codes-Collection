select * from tab;
DESCRIBE dept;
select empno, ename, sal from emp;
--## ���� ������ ������ ���ÿ�.? Column�� Null�� ��� ��� ǥ���Ǵ°�?? 
--Comm ���� �ִ� ����� � ������ΰ�??? 
--��� 7844�� ����� Ŀ�̼��� ���ΰ�?
select empno, job, comm from emp;
select empno, comm from emp where empno=7844;
--## ������ ������� ������ ����ϴ� �����̴�.? 
--Comm ���� Null�� ��� ������ ���ΰ�?? 
--���� ����� ������ column heading�� ��� ��Ÿ���°�? 
select sal, comm, (sal+comm)*12 from emp;
--## ������ ����� Ŀ�̼��� ����ϸ鼭 Ŀ�̼��� ���� ����� ��� Null�� �ƴ϶� 0���� ����ϵ��� �ϴ� �����̴�.? ������ ���ÿ�.
select empno, ename, NVL(comm, 0) comm from emp;
--## ������ �Ŵ����� ���� , �� �ְ� ������ ����� ��� ��No Manager����� ��µǵ��� �ϴ� �����̴�.? �����Ͽ� Error �޽����� ����� Error�� ���� ������ �����Ͻÿ�.
select NVL(mgr, 'No Manager') from emp;
--Error: ORA-01722: invalid number 01722. 00000 -  "invalid number" *Cause:    The specified number was invalid. *Action:   Specify a valid number.
select NVL(TO_CHAR(mgr), 'No Manager') from emp;
--* Error �߻�.? ������ :?????mgr�� 'No Manager'�� ���ϱ⿡ ���� ������ ������ �ƴϱ� ������ ��ȯ �ʿ�
--## column alias�� ����� ������̴�.? column heading�� ��� ��Ÿ�������� ����ϰ�,? Error�� ���� ���忡 ���ؼ��� ������ �����Ͻÿ�.
select sal*12 annual_salary from emp; --�÷����: ANNUAL_SALARY
select sal*12 Annual_salary from emp;--�÷����: ANNUAL_SALARY
select sal*12  "Annual Salary" from emp; --alias ���� ���� �Ұ�. �ֵ���ǥ �ʿ�

select empno||ename from emp;
select empno||ename||hiredate FROM emp;

select ename||' '||sal from emp;
select ename|| ' is working as a '|| job from emp;

select 'Korea Fighting' from emp;
--(* Korea Fighting �̶�� literal�� 14 �� ��µȴ�. ������ :?emp�� �����Ͱ� 14���̱� ������

select 'Korea Fighting' from dept;
--(* Korea Fighting �̶�� literal�� 4 �� ��µȴ�. ���� :?dept�� �����Ͱ� 4����)

--## literal�̳� literal���� �������� ����� �� ���� sys����� ������ dual�̶�� dummy table�� Ȱ���Ѵ�.
select 'Korea Fighting' from dual;
select 10+20 from dual;
select 'Red' || ' ' || 'Devil' from dual;

--##? dual table�� �̿��Ͽ� server�� ���� �ð��̳� ���� �������� DB ����ڸ� ��ȸ�� �� �� �ִ�. 
select sysdate, user from dual;

--## DISTINCT: ���� ������� �����ϰ� ����� ���Ͻÿ�.## �� ���� Ʃ���� ��µǴ°�??
select job from emp;--14��
select distinct job from emp; --5��
select deptno from emp; --14��
select distinct deptno from emp; --3��

--## ������ ���� column�� ���� �ߺ� ���� �����ϴ� �����̴�. ����� ���Ͻÿ�.
select deptno, job from emp; -- 14��
select distinct deptno, job from emp; --9��
select distinct job, deptno from emp; --9��

--## Date ���� ���� ������ �� ���� ���� session�� NLS_DATE_FORMAT�� ���� �ֵ��� �Ѵ�.
--## ���� Date������?
select value from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
-- RR/MM/DD
--## �׿ܿ��� ���� SESSION �Ķ���͸� Ȯ���غ���.
select * from nls_session_parameters;
--## ��¥ ��� ���� ����, RR�� Y2K����� 2�ڸ� �⵵
alter session set nls_date_format = 'DD-MON-RR';
SELECT empno, ename FROM emp WHERE hiredate>='01-1��-82'; --�̰� ������ nov a valid month ����
alter session set nls_date_format = 'RR/MM/DD';
select empno, ename from emp where hiredate >= '82/01/01';

--## ANY / IN ������
--## BOSTON�̳� DALLAS �� ��ġ�� �μ��� ����Ͻÿ�.
select * from dept;
select dname, loc from dept where loc IN('BOSTON', 'DALLAS');
select dname, loc from dept where loc = ANY('BOSTON', 'DALLAS');

--## 30, 40�� �μ��� ������ �ʴ� ������� ����Ͻÿ�.
select ename, deptno from emp where deptno NOT in (30,40);
select ename, deptno from emp where deptno <> all(30,40);

--## DALLAS�� 20�� �μ�, �Ǵ� CHICAGO�� 30�� �μ��� ����Ͻÿ�.
select * from dept where (deptno,loc) in ((30, 'DALLAS'),(30,'CHICAGO'));

--# �޿��� 2000���� 3000 ������ ����� ����Ͻÿ�.
select ename, job, sal from emp where sal between 2000 and 3000;
--## �̸��� A �� ���۵Ǵ� ����� ����Ͻÿ�.
select * from emp where ename like 'A%';
--## ����� 8������ ������ ����� ����Ͻÿ�.
select * from emp where empno like '%8';
--## 82�⵵�� �Ի��� ����� ����Ͻÿ�.
select * from emp where hiredate like '82%';
--## �μ��� X_Y �� ���ԵǾ� �ִ� �μ��� ����Ͻÿ�.
select *  FROM dept WHERE dname LIKE '%X/_Y%' ESCAPE '/';

--## Ŀ�̼� ���� ����� ����� ����Ͻÿ�.
select ename, comm from emp where comm is not null;
--##�Ʒ� �� ������ ����� ���� ���� �������� �����Ͻÿ�.
select ename, comm from emp where comm is null; --11��
select ename, comm from emp where comm = null; --��� ����

--## ����� 7788�� ����� �̸��� �޿��� ����Ͻÿ�.
select ename, sal from emp where empno = 7788;
--## �޿��� 3000 �� �Ѵ� ������ ����Ͻÿ�.
select job from emp where sal>3000;
--## PRESIDENT �� ������ ������� �̸��� ������ ����Ͻÿ�.
select ename, job from emp where job <>'PRESIDENT';
--## BOSTON ������ �ִ� �μ��� ��ȣ�� �̸��� ����Ͻÿ�. 
select deptno, dname from dept where loc = 'BOSTON';
--## ������ CLERK �� ��� �߿��� �޿��� 1000 �̻��� ����� ����Ͻÿ�.
SELECT ename, job, sal FROM emp WHERE job = 'CLERK' AND sal >= 1000;
--## commission�� �޴� ����� ����Ͻÿ�.
SELECT ename FROM emp WHERE comm IS NOT NULL;
SELECT ename FROM emp WHERE NOT comm IS NULL; --not ���
--## 10�� �μ��� 20�� �μ��� ���� ����� ����Ͻÿ�.
select * from emp where deptno = 10 or deptno = 20;
select * from emp where deptno in (10,20);

--## 10���� 20�� �μ��� ������ �ʴ� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
select * from emp where deptno not in (10,20);
select * from emp where deptno <> 10 and deptno <> 20;

--## �޿��� 2000���� 3000 ������ ����� ����Ͻÿ�.
select ename from emp where sal>=2000 and sal <=3000;
select ename from emp where sal between 2000 and 3000;

--## ORDER BY## Null ���� ���������� ��� �� ��������, �����ڼ��� ��� �� ó���� display�ȴ�.
select ename, comm from emp order by comm desc;

--## �޿��� ���� ������� ����Ͻÿ�.
select ename from emp order by sal;
--## �޿��� ���� ������� ����Ͻÿ�.
select ename from emp order by sal desc;
--## �޿��� ���� ������� ����ϵ� �޿��� ���� ��� �̸� ������� ����Ͻÿ�.
select ename, sal from emp order by sal desc, ename;
--## �޿��� ���� ������� ����ϵ� �޿��� ���� ��� �̸� ������� ����Ͻÿ�. (ORDER BY ���� ���� ���: ���° �÷�?)
select ename, sal from emp order by 2 desc, 1;

--## SELECT ���� ��Ÿ���� ���� column�� ���ؼ��� ������ �����ϴ�.
select ename from emp order by sal desc;

--#ROUND, TRUNC �� ù ��° argument�� �Ҽ��� �Ʒ� �� ��° argument�ڸ����� ǥ���Ѵ�.
SELECT sal, ROUND(sal, -3), TRUNC(sal, -3) FROM emp;

--#TRUNC�� ROUND�� �ڸ��� ǥ��, �ڸ��� ���� ������ �����κ�
select floor(45.925), ceil(45.925) from dual;
select trunc(45.925), round(45.925) from dual;

--# ���� ���� �Լ� ������ �ǽ��� ���ÿ�.
SELECT MOD(10, 3), MOD(10, -3), MOD(-10, 3), MOD(45.925, 10) FROM dual;
SELECT ABS(-15), ABS(15) FROM dual;
SELECT SIGN(-15),SIGN(15) FROM dual;
SELECT SIN(3.141592/2) FROM dual;
SELECT EXP(4) FROM dual;

--# TRIM: �־��� ���ڰ� �ƴ� ���ڰ� ���ö����� �����. 
select ename, LTRIM(ename, 'AB'), RTRIM(ename, 'SR') from emp;
