--ddl & dcl
--�����͸� ��ȸ�ϴ� dml���� ��� ���̺��� �����ϰų� �����ϴ� ���� ���
--create table ��ü;
--alter table ��ü;--���� ����(unlock)�ÿ��� ��� ����
--drop table ��ü; --���̺� ����
--rename, truncate, comment --�̸� ����, ���̺� �� ��� �����͸� ����, 

create table book(bookno number(5), title varchar2(50));
--<���ֻ��Ǵ� ������Ÿ��
--number(5)-- ���ڰ���
--varchar2(50)--char�� �������� �׻� 50�� �׻� ��������, 
--varchar�� 50�� �ο��ص� ������ �޸𸮴� 50 ���� �����͸� 50���ϸ� �����Ͽ� �޸� ���� ����.
--date

--database�� ������ ��α� ������, ������ �̸��� ���� ��ġ������ db�� �����ϰ�, �������� ��� �ϵ��ũ�� ����
--������ �߿��� �����ʹ� db�� �����ϴ°� �� ����

create table book(
bookno number(5),
title varchar2(50),
author varchar2(10),
pubdate date
);



create table empSALES
AS
select * from emp
where job = 'SALES';
