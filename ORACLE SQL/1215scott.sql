--<������ �ʿ伺>
select ename, dname from emp, dept; --56�� ���(�ܼ���)
select count(ename) from emp; -- 14��
select count(dname) from dept;  --4��

--join �� �� ������ ������ ������ �־������
--�ٸ� ������ and�� ���� ����
select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno and sal > 2500;

--Theta Join(Non-equal �����̸鼭 ������ �ִ� ����)
---between ������ join�ϴ� ����
select e.ename, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;

--<Outer Join>
--�����Ϳ��� null�� ���� ��� �߰��غ���. �μ� ���� ����� ������.
--���̺� ���� ������ �÷� �������
--�÷����� ��������� null�� ������, ���̺��� �÷� ������ not null�� �÷��� ��� ������ ��. ������ �־����
insert into emp values(7499, 'carami', 'CLERK', null, sysdate, 5000, NULL, null);
insert into dept values(50, 'dev', 'kangnam');

--�⺻ ����(Inner Join)�� ���ο� ��� Carami�� 50�� �μ��� ����� ������ ����
select e.ename, d.dname from emp e, dept d where e.deptno = d.deptno; --14��
--(+) ���� ���(null)�� ����ʹ� �� �� ����. ���ʿ� (+) ���̸� Right ����. �����ʿ� (+)���̸� Left ����.
--null�� ���Ե� ����ʿ� +�� ���δ�.
select e.ename, d.dname from emp e, dept d where e.deptno(+) = d.deptno; --15��

--<natural join> ���Ͱ� �˾Ƽ� ���� �ϴ� ���
--���� �� ¥�� ������ ���̺��� �ƴ��̻� ���� �ʴ´�
select * from emp natural join dept;

--<From ���� join�� �ֱ�>
--������ �Ǵ� �÷����� ������ִ� ���� using
--join on�� where ��� ��� ����
--from ���̺� �� where equal ������ ������ ���� ���밡��
select * from emp join dept using(deptno);
select * from emp join dept on emp.deptno = dept.deptno;

--Join on�� ����� Outer Join �ϱ�
select * from emp Left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno = dept.deptno;
select * from emp full outer join dept on emp.deptno = dept.deptno;
--full outer join�� ����Ŭ������ �����ϴ�. mysql������ left �ѵ� right �ѵ� ���� union �ؾ���.

--<Self Join>
--�ڱ��ڽŰ� �����ϱ�
--alias�� ����Ҽ��ۿ� ����.
select e.empno ���, e.ename ����̸�, m.empno �Ŵ������, m.ename �Ŵ����̸�
from emp e, emp m
where e.mgr = m.empno; --������̺��� �Ŵ����� �Ŵ������̺��� ������̵� ���ƾ���

--������ �Ŵ����� ���� ���(����) �̾ƺ���
select e.empno ���, e.ename ����̸�, m.empno �Ŵ������, m.ename �Ŵ����̸�
from emp e, emp m
where e.mgr = m.empno(+);

--natural join���� ǥ���غ���
select e.empno ���, e.ename ����̸�, m.empno �Ŵ������, m.ename �Ŵ����̸�
from emp e join emp m on (e.mgr = m.empno);

select e.empno ���, e.ename ����̸�, m.empno �Ŵ������, m.ename �Ŵ����̸�
from emp e left outer join emp m on (e.mgr = m.empno);

--������ Ʈ�� ���� ������ ��ŷ�ϱ�
--����Ŭ�� ������ �÷� level ����
select level, ename from emp
start with mgr is null
connect by prior empno = mgr
order by level;

--<�׷��Լ�(�����Լ�)>
select avg(sal) from emp;
select count(*) from emp;
select count(empno) from emp; --15
select count(mgr) from emp; -- 13
--null���̸� count ����� �ȵǱ� ������ pk Ȥ�� *�� ���� ��ü ���� ���� ����

--�����Լ��� ����� �� row�� ���� ��.
select * from emp;
select min(sal) from emp;
select max(sal) from emp;
--min()�� ���� ��� �̸���? (subquery���)
select empno, ename, sal from emp where sal = (select min(sal) from emp);

select deptno, avg(sal) from emp; --�����߻�!
--������ �� ���� ������ �ʿ��� ���� group by�� ���
--�ֳĸ� avg()�� min()�� ���� ���� ������row�� �� �ϳ�
--deptno�� �ٸ� �÷����� ����row�̱� ����.

--<group by> ��� : ������ �� ����ϰ� ���� ��
select deptno, avg(sal) from emp
group by deptno;

select deptno, dname, avg(sal)
from emp natural join dept
group by deptno, dname
order by dname;

select e.deptno, d.dname, avg(e.sal) from emp e, dept d
where e.deptno=d.deptno
group by e.deptno, d.dname;

select deptno, avg(sal) from emp
where sal < 5000
group by deptno
having avg(sal) > 2000;
--��� �޿��� 5000�̻��� ����� ���ٴ� where
--�μ��� �޿��� ��� 2000 �̻��� �׷츸 ����ٴ� having

--�޿��� 5000�̻��� ������ ���� �μ��� ��ձ޿��� ��Ÿ���µ�, 
--�μ��� ��ձ޿��� 2000������ �μ��� ���� ���
--��ձ޿��� ���� �μ����� ����
select deptno, avg(sal)
from emp
where sal <5000
group by deptno
having avg(sal) > 2000
order by avg(sal) desc;

select d.dname, e.deptno, avg(e.sal) 
from emp e, dept d 
where e.deptno = d.deptno and e.sal < 5000 
group by e.deptno, d.dname 
having avg(e.sal) >= 2000 
order by avg(e.sal) desc;

--rollup, cube
--roll�� A(��з�) �ȿ� B(�Һз�)
--cube�� A�з� B�з� �������� ����

--<SUBQUERY> ��������. ������ �ȿ� �Ǵٸ� ������ ���
---single row �������� ���(���� ���� ���� ��)
--#���̽� �μ��� ��� �޿�
select avg(sal) from emp
where deptno = (select deptno from emp where ename = 'SMITH');

--#�޿��� 20�� �μ��� ��ձ޿����� ���� �޴� ����鸸 ���
select ename from emp
where sal > (select avg(sal) from emp where deptno = 20);

--#scott���� ������ ���� ����� �̸�
select ename from emp
where sal> (select sal from emp where ename = 'SCOTT');

select ename, sal, deptno from emp
where ename = (select min(ename) from emp);

select ename, sal from emp
where sal < (select avg(sal) from emp);

select ename, deptno
from emp
where deptno = (select deptno from dept where dname = 'SALES');

---multi row subquery
select ename, sal, deptno
from emp
where ename in (select min(ename) from emp group by deptno);
-- in (allen, adams, clark, carami)�� ���� ����
-- in�� equal or�� ���� : �� = (A or B)
-- in() = =ANY()
-- ALL�� ��� and�� �����.

--#�� �μ����� �ְ�޿��� �޴� ����� ����Ͻÿ�
select deptno, empno, ename, sal
from emp
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);

select e.deptno, e.empno, e.ename, e.sal
from emp e, (select s.deptno, max(s.sal) msal 
from emp s group by deptno) m
where e.deptno = m.deptno AND e.sal = m.msal;

--<Correlated Query> ���������� �� ����. �ٱ��� ������ �޴� subquery
--outer query�� inner query�� ���� �����Ǿ�����
--outer query�� ���̺��� alias ������ �ο��ؾ���
--�ٱ��� ������ ������ �޴°��� correlated query ����

SELECT
deptno , empno , ename , sal
FROM
emp e
WHERE e.sal = (SELECT max(
sal )
FROM
emp WHERE deptno = e.deptno;

--<Top K query>
--rownum: ������ ����� �������� �Ű����� index?
select rownum, ename, sal
from emp order by ename;
--rownum�� order by�� ���ĺ��� ���� ���ĵǾ�����
--order by�� ���߿� ����

select rownum, ename, sal
from (select * from emp
where hiredate like '81%'
order by sal desc)
where rownum < 4;
--���̺� ���캸��
select * from emp
where hiredate like '81%'
order by sal desc;

--select * from emp group by sal desc
--OFFSET 2 ROWS fetch next 3 rows only;
--������ ���� ���� ��� �� 2������ 3�� ������
--offset 2 fetch next 3
--fetch first 3 rows only --ó������ 3�� ������

--�����ڸ� ��� ó���� ���ΰ�(�ߺ��� ó��?)
--rank ���� �Լ�
--SELECT sal, ename, RANK() OVER (ORDER BY sal DESC) AS rank, DENSE_RANK() OVER (ORDER BY sal DESC) AS dense_rank, ROW_NUMBER() OVER (ORDER BY sal DESC) AS row_number, rownum AS "rownum��
--FROM emp;


--##������ 5���� ���� Ǯ�̿� �Բ� ���ε�
select * from emp;
select * from emp cross join dept;

--[sql �ǽ� 2]
--#���� ������� ���� ����� ���غ��ÿ�
select ename, dname from emp e, dept d where e.deptno(+) = d.deptno;
select ename, dname from dept left outer join emp using (deptno);
--��� �Ȱ��� 16�� ��µ�

--#�� �μ��� �ο��� ����Ͽ� ��� ��
select dname, count(empno) from emp e, dept d
where e.deptno = d.deptno
group by d.deptno, d.dname;

select dname, count(empno) from emp e, dept d
where e.deptno(+) = d.deptno
group by d.deptno, d.dname; --�̰��, ����� ���� �μ��� ��µ�

--#Ʈ������
--top to bottom
select empno, ename, job, mgr, level from emp
start with mgr is null
connect by prior empno = mgr
order by level;
--bottom to top
select empno, ename, job, mgr, level from emp
start with ename = 'SMITH'
connect by prior mgr = empno;

--aggregation

--������ �ְ� �޿��� �޿��� ���� �������� ����Ͻÿ�
select job, max(sal) from emp
group by job
order by max(sal) desc;

--������ �ְ� �޿��� �޿��� ���� �������� ����ϴµ�, ������ 2���̻��� ��츸
select job, max(sal) from emp
group by job
having count(sal)>=2
order by max(sal) desc;

--<���� ���� 1> scott���� ��տ����� 2000�̻� 3000������ �μ��� ?
select * from dept;
select d.dname from dept d, emp e
where e.deptno = d.deptno
and avg(e.sal) between 2000 and 3000;

SELECT deptno, AVG(sal)
FROM emp
having avg(sal) < 3000 and avg(sal) > 2000
GROUP BY deptno;

--<���� ���� 2> -- 1. �޿��� ���� �޴� ������� ���� 5���� ����Ͻÿ�. 
--���� �޿��� ���� ���, �̸� ������ ����Ͻÿ�.
select rownum, ename
from (select * from emp order by sal, ename)
where rownum < 6;

SELECT rownum, ename, sal 
           FROM (SELECT * FROM emp  ORDER BY sal, ename) 
           WHERE rownum < 6;

--rownum�� order by���� ���� ���� ������ ������ ���� ������ �̰� �ʹٸ� 
--������ �������� �ȿ� ��� �̰� �ٱ����� rownum

--<���� ���� 3>�� �μ��� �ο��� �μ��� ��տ����� ������������ ����
select dname, count(empno),avg(e.sal) FROM emp e, dept d where e.deptno  = d.deptno group by d.dname
order by avg(e.sal) desc;

--<���� ���� 4>scott���� �� �μ����� �޿��� 1500 �̻��� ����� �� �Ի�⵵�� ���� �ֱ��� ����� ����Ͻÿ�.
select * from emp;

select ename
from emp
where sal >= 1500 and hiredate = (select max(hiredate) from emp);

SELECT deptno, empno, ename, sal, hiredate
           FROM emp
           WHERE (deptno,hiredate) IN  (SELECT deptno, max(hiredate) 
                                          FROM emp WHERE sal >= 1500 GROUP BY deptno);

select deptno, max(hiredate)
from emp
where sal >= 1500
group by deptno;