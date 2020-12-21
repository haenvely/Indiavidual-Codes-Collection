select * from tab;
CREATE TABLE EMP(
	EMPNO NUMBER(4) NOT NULL, 
        ENAME VARCHAR2(10), 
        JOB VARCHAR2(9), 
        MGR NUMBER(4), 
        HIREDATE DATE, 
        SAL NUMBER(7, 2), 
        COMM NUMBER(7, 2), 
        DEPTNO NUMBER(2));
CREATE TABLE DEPT 
       (DEPTNO NUMBER(2), 
        DNAME VARCHAR2(14), 
        LOC VARCHAR2(13) );
CREATE TABLE SALGRADE 
        (GRADE NUMBER,
          LOSAL NUMBER, 
         HISAL NUMBER);
INSERT INTO EMP VALUES 
        (7369, 'SMITH',  'CLERK',     7902, 
        TO_DATE('17-12-1980', 'DD-MM-YYYY'),  800, NULL, 20);
INSERT INTO EMP VALUES 
        (7499, 'ALLEN',  'SALESMAN',  7698, 
        TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600,  300, 30);
INSERT INTO EMP VALUES 
        (7521, 'WARD',   'SALESMAN',  7698, 
        TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250,  500, 30);
INSERT INTO EMP VALUES 
        (7566, 'JONES',  'MANAGER',   7839, 
        TO_DATE('02-04-1981', 'DD-MM-YYYY'),  2975, NULL, 20);
INSERT INTO EMP VALUES 
        (7654, 'MARTIN', 'SALESMAN',  7698, 
        TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES 
        (7698, 'BLAKE',  'MANAGER',   7839, 
        TO_DATE('01-05-1981', 'DD-MM-YYYY'),  2850, NULL, 30);
INSERT INTO EMP VALUES 
        (7782, 'CLARK',  'MANAGER',   7839, 
        TO_DATE('09-06-1981', 'DD-MM-YYYY'),  2450, NULL, 10);
INSERT INTO EMP VALUES 
        (7788, 'SCOTT',  'ANALYST',   7566, 
        TO_DATE('09-12-1982', 'DD-MM-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES 
        (7839, 'KING',   'PRESIDENT', NULL, 
        TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES 
        (7844, 'TURNER', 'SALESMAN',  7698, 
        TO_DATE('08-09-1981', 'DD-MM-YYYY'),  1500, NULL, 30);
INSERT INTO EMP VALUES 
        (7876, 'ADAMS',  'CLERK',     7788, 
        TO_DATE('12-01-1983', 'DD-MM-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES
         (7900, 'JAMES',  'CLERK',     7698, 
        TO_DATE('03-12-1981', 'DD-MM-YYYY'),   950, NULL, 30);
INSERT INTO EMP VALUES 
        (7902, 'FORD',   'ANALYST',   7566, 
        TO_DATE('03-12-1981', 'DD-MM-YYYY'),  3000, NULL, 20);
INSERT INTO EMP VALUES 
        (7934, 'MILLER', 'CLERK',     7782, 
        TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999); 

select * from tab;
select * from emp;
select * from dept;
select * from salgrade;

select * from emp;
select ename �̸� from emp; --as ��� ����� as ��ü ����
select ename as "�̸�" from emp; -- oracle sql���� allias(as) ����� ���� "" ���
select ename, job from emp;

select ename, (sal+200)*12 from emp;
select ename, -sal*10 from emp;
select ename, sal from emp;
select * from emp;

desc emp;
--null���� �ִ� �÷��� �����ϱ�
select ename, sal, comm from emp;
select ename, (sal+comm)*12 from emp; --null�� ���� ������ ���� �ʾƼ� ������ null�� ����
--nvl �Լ� ����ϱ�: NVL(�÷���, ��ü��) null ��� 0 return�Ѵ�
select sal, comm, (sal+NVL(comm, 0))*12 from emp;

--�׳� ���� �ִ� �÷� �ϳ� �߰��ؼ� �̱�
select ename, 1000, SYSDATE from emp;
--��¾���� �� ä�� �÷� �̱�
select 'Name is ' || ename || ' and no is ' || empno FROM emp;


--<where> ������ �����ϴ� ���� ��������
-- in ���տ� ���ԵǴ���
-- between a and b �� �� a�� ������
-- like ù���ڳ� �߰��� ���Ե� ���� ã�� �� ����
-- is null, is not null
-- and, or
-- any, all ���� �� ��� �� ��, ���� �� ��� ��(�ٸ� �񱳿����ڿ� �Բ� ���)
-- exist ��� row�� �ϳ��� �ִ���

-- like���꿡��
-- wildcard �̿��� ���ڿ� �κи�Ī
-- %�� _ ��밡��
--% ������ ������ ���ڿ�(���� ���� ����)
-- _ �ѱ���
-- escape ���� ���ڿ��� �����ϴ� ���ڴ� wildcard�� �ƴ� ������ �ؼ�

-- �̸� �ι�° ���ڰ� M�� ����� �̸�
select ename from emp where ename like '_M%';
--83�⿡ �Ի��� ���
select * from emp;
select * from emp where hiredate like '83%';

-- ����. �⺻�� asc��. null�� �ڷΰ�. 
select * from emp order by comm;
select * from emp order by comm desc; --null�� �տ� ���� desc

--order by ���� ���� ����
select empno, ename, sal, comm from emp order by sal desc, comm desc;
select empno, ename, sal, comm from emp order by 3 desc, 4 desc; --3��° �÷�, 4��° �÷� �ǹ�

select lower(ename) from emp; --�̱۷ο� �Լ�. �Լ��� ����� ���� �ϳ� �����°�
select sum(sal) from emp; --��Ƽ�ο� ���. ��ü ��� �� ����� �ϳ� ����

select concat(ename, sal) from emp;
select concat('hhhh', 'gggg') from dual; --�ӽ����̺��� �׽�Ʈ�غ��� ���� �� dual ���

-- ��ҹ��� ��ȯ
select lower('DaewerHweyr') from dual;
select upper('DasesweHweyr') from dual;
select initcap(ename) from emp; --ù���ڸ� �빮��ȭ��

--����Ŭ�� index�� 1���� ����
--���ڿ�����
select substr('database', 2, 4) from dual;
select length('database') from dual;
select instr('database', 'b') from dual; --index���
select lpad(24000, 10, '*') from dual;
select rpad(salary, 10, '*') from dual;
select trim('#' from '##database###') from dual;
--��������
select ceil(-2.4) from dual;
select floor(-2.4) from dual;
select abs(-2.4) from dual;
select mod(13, 2) from dual; --������
select power(2,3) from dual; --m�� n��
select round(4.567, 2) from dual; --m�� n�ڸ����� �ݿø�
select trunc(4.567, 2) from dual; --m�� n�ڸ� ���Ŀ� ����
select sign(-10) from dual; --��ȣ ���(-1, 1, 0)

select sysdate from dual;
select value from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
--�ϳ��ϳ��ϳ��� ���� �ٸ� ������ ���´�.

--��¥ �Լ� Date�Լ�
select hiredate, add_months(hiredate, 3) from emp; --�÷����� ��¥�� 3�� ���ϱ�
select last_day(sysdate) from dual; --�̹����� ������ ��
select months_between('20/12/14', '19/11/20') from dual;
select round(sysdate, 'month') from dual;
select next_day(hiredate, 3) from emp; --���̳� �÷����� n�� ��
select next_day('20/12/12', 'SUNDAY') from dual;
select round(sysdate, 'year') from dual;
select trunc(sysdate, 'month') from dual;
select trunc(sysdate, 'year') from dual;

select ename, comm, NVL2(comm, comm+30, 30) from emp;
select ename, NVL(TO_CHAR(mgr), 'No Manager') from emp; --mgr�� int�̴ϱ� char�� �ٲ�� ��ü ����

-- <case when then ����>
--case job�÷��� when �ȿ����� ���ٸ� then���� ���ž�
--case end�� ����
-- end �ڿ� allias ���� �� ����
-- <decode ����>
-- decode(�÷���, ����, ��) allias

select * from emp where deptno = 10 or deptno = 20;
select * from emp where deptno in (10, 20); --���� ��� �Ȱ���. 10, 20 �����߿� �ִ�.
select * from emp where deptno = 10 and sal>=3000;