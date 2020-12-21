--ddl & dcl
--�����͸� ��ȸ�ϴ� dml���� ��� ���̺��� �����ϰų� �����ϴ� ���� ���
--create table ��ü;
--alter table ��ü;--���� ����(unlock)�ÿ��� ��� ����
--drop table ��ü; --���̺� ����
--rename, truncate, comment --�̸� ����, ���̺� �� ��� �����͸� ����, 
--�ּ����� �۾�(����)����. transaction. ���� �Ͼ�ٰ� �����ϸ� ��ü�� rollback���Ѿ� ������ ������ ����.
--���� ���� ���� �������� ���� commit.

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
(select * from emp
where job = 'SALES');

--[�÷� �߰� / ����]
--add(�÷���, ����): �÷� �߰��� ���� �������� ������ �߰���
alter table book ADD(pubs varchar2(50));

--modify(�÷���, ����): �÷��� ������ �ٲ���
alter table book modify(title varchar2(100));
--�÷� ����
desc book;
alter table book DROP author;
--�÷� �̻������ �з��ϰ�, �̻�� �÷� �����ϱ�
alter table book set unused(author);
desc book; --�̹� author �ȳ���
alter table book drop unused columns;
desc book;

--column ���� �ٲٱ�...!! 12c���� �߰��� ����Ŭ ���
--�÷��� invisible�� �ٲ�ٰ� visible�� �ٲٸ�, �� �Ʒ��� �߰��� ��
alter table book modify title INVISIBLE;
desc book;
alter table book modify title visible;
desc book;
--<����> rollback�� ����� �ƴ�! �ǵ���������
--comment
comment on table book is 'this is comment';
desc book;
rename book to article;

--<Constraint> ��������
-- ����ġ ���� �������� �ս��̳� �ϰ����� ���� �����͸� ����
-- not null: null�� �ƴϾ����
-- unique: ������ ���� ���� �� ����
-- primary key: �⺻Ű
-- foriegn key: �ܷ�Ű
-- check: �� �÷� �ȿ��� �����س� �� �ܿ��� ������

--defualt ���� �����ϸ� ���� �ȵ����� ���� defualt�� �ش��ϴ� ���� ��������

--<�������� �ǽ� ����>
create table book(
bookno number primary key);
-- (default 10)

-- primary key�� �̸��� ã�¹�?
--<constraint�� �̸��� �ο�>
--**�������� �̸�: ���������� Ȱ��ȭ�ϰų� ��Ȱ��ȭ�� �� �ֱ� ���ؼ� ��밡��

drop table book;
create table book
(bookno number(5) constraint c_emp_u not null
title varchar2(50););

--[not null�� ���� �ʾѱ⿡, insert�� null���� �ְų�, bookno�� ��ŵ�ص� insert ����]
create table book(
bookno number,
title varchar2(50));

insert into book values(null, 'testbook');
insert into book(title) values ('javabook');
select * from book;
insert into book values(1, 'testbook');

--[not null�� �ƴ����� unique�� ������?]
create table book(
bookno number unique,
title varchar2(50));

insert into book values(null, 'testbook'); --�־���
insert into book(title) values ('javabook'); --�̹� null�� �Ҵ�Ǿ� �ȳ־���
select * from book;
insert into book values(1, 'testbook');
insert into book values(1, 'test');

--[not null + unique]
create table book(
bookno number unique not null,
title varchar2(50));

insert into book values(null, 'testbook'); --�ȳ־���
insert into book(title) values ('javabook'); --�ȳ־���
insert into book values(1, 'testbook');
insert into book values(1, 'test'); --�ȳ־���

drop table book;
--[Primary Key + �������� �̸�]
create table book(
bookno number constraint book_pk primary key,
title varchar2(50));
--�������� �̸� book_pk
--primary key�� ����Ͽ��� ������, not null + unique�� �ȴ�.
insert into book values(null, 'testbook'); --�ȳ־���
insert into book(title) values ('javabook'); --�ȳ־���
insert into book values(1, 'testbook');
insert into book values(1, 'test'); --�ȳ־���

--<Primary Key�� �������� �����ؼ� ��밡���ϴ�. create �� �������ٿ�
--constraint�� �� �������ٿ� ���Ƽ� �ᵵ �����ϴ�.
create table ssnbook(
ssn1 number(6),
ssn2 number(6),
constraint ssn_book_pk primary key(ssn1, ssn2));

--<check ��������>
--�پ��� ������ �����Ӱ� �� �� ����. check (�÷��� ����);
create table thesis( rate number check (rate IN (1,2,3,4,5)));
create table thesis2 ( title number check (title <20));
--rate �÷��� 6�� ������ ���� �߻�
select * from thesis;
--<Foreign Key>
--constraint�� foriegn key(�÷���) reference �ܺ����̺��(�����÷���)
--on delete set null: �ܺ����̺��� ������ �� ������ �߻��ұ�� �ִ� �ɼ�
--�ܺ����̺��� �����÷��� �����ϸ� foriegn key�� null�� �ȴ�
--on delete cascade: 10���� ����鵵 �� ���������ž�...��, foriegn key�� ���󰡴� ���� ���� �������� �ش� row�� ����

--<���� ���� �߰�>
alter table emp add constraint emp_mgr_fk
foreign key(mgr) references emp(empno); -- + on delete cascade/set null

--���������� ������ �� �̸� ���� ��
alter table book drop constraint c_emp_u;
alter table dept drop primary key cascade; --primary key�� �ܺο� fk�� ���� cascade�� �����ؾ���

--primary key�� unique�� ���������� ������ �ε����� ������ ��
--�����Ͱ� ���� �Էµǰų� �����ǰų� �� �� �ε����� ���� �ٲ��....????

--<������ ���� Data Dictionary>
--��Ű����ü�� ��������, �������� �÷� ���� Ȯ�� ����
alter table emp disable constraint c_emp_pk cascade;

desc user_objects;
--���̺� Ȯ��
select object_name
from user_objects
where object_type = 'TABLE';

--�������� Ȯ��(���̺�� �빮�ڷ�)
select constraint_name, constraint_type, search_condition
from user_constraints
where table_name = 'EMP';

--�������� �÷� Ȯ��
select constraint_name, column_name
from user_cons_columns
where table_name = 'EMP';

select * from dictionary;
select * from user_constraints; - -�������
select * from user_cons_columns; --���̺��, �������Ǹ�, �ش� �÷���

--�̹� ������ ���̺���, �����ؼ� ���������� �������� �ϸ�
--������ �����Ϳ� ���������� �浹�ϸ� ���� ���� �� ����

--����

desc book;
select * from user_cons_columns;
select * from user_constraints;
select * from book;

-- ���� ���� �߰� ���� (alter table ���̺�� add constraint ����� ����);
ALTER TABLE book
ADD CONSTRAINT title_len CHECK ( length(title) < 20); 

--emp number primary key
select empno from emp;
select * from user_constraints;
--�������� �߰�: �׳� �÷��� �����̸Ӹ�Ű�� �����ϱ�
alter table thesis add constraint rate_pk
primary key(rate);

--emp manager ��ȣ�� foriegn key�� ����
alter table emp add constraint emp_mgr_fk
foreign key (mgr) references emp(empno);


rollback; --transaction ó������ �ǵ�����
--create - create ���̰� Ʈ����� �����̶� �� �� �ְ���.

--dept number ��ȣ�� foriegn key�� ����

--<DCL>
--�������� ������ ��������� : role
select * from user_users;
desc ALL_USERS;

--dba ������ ���� �������� ���� ��� �� �� ����. �ǽ��� ��� ������ ���� ������ ���� ������. �ý��ۿ��� �� ���ۿ� ������
select * from ALL_USERS;
--select * from DBA_USERS; --SYSTEM����

--���� �ο�: grant ���� ȸ��: revoke
grant to user1;
revoke from user1;

--role�� ������ ���� ����
--role�� �����Ϸ���, role�� ������ grant�� �� role ����
--create role~~
--���� ��ųʸ�: user_role_pr, role_p;

--<DML>
--insert into ���̺�� (�÷�����Ʈ. ��������) values(������Ʈ);
--update ���̺�� set ���泻�� where����; ������ ������ ��� ���� �����..
--delete from ���̺�� where ����;
create table test(no number, name varchar(10));
insert into test values(3, 'kim');
update test set name = 'kang' where no = 3;
select * from test;
delete from test; --where �Ⱦ��� ������ ���� ������;;
rollback;
select * from test;
delete from test where no = 3;

insert into test values(5, 'oh');
insert into test values(10, 'jeon');
insert into test values(15, 'cha');

update test set name = 'kang', no = 1 where no = 3;
select * from test;

--subquery�� �̿��� dml: �ٸ� ���̺��� ���� �����ؿ���.
create table deptusa(no number, name varchar(20));
select deptno, dname from dept where loc = 'kangnam';

insert into deptusa (select deptno, dname from dept where loc = 'kangnam');
select * from deptusa;
--subquery�� �̿��� dml: �ٸ� ���̺��� �̿��Ͽ� ���� �����ϱ�.
delete from deptusa where name = (select dname from dept where loc = 'kangnam');
rollback;

--������ �Է�, ������ ���� ���Ǵ� psedu�÷�
--user, sysdate, rowid
insert into emp(empno, hiredate) values(200, sysdate);
select * from emp;

select * from book;
--�÷� �߰��ϱ�:ALTER TABLE ���̺�� ADD(�÷��� ����ŸŸ��(������))
alter table book add(pubdate date);
insert into book values(200, 'Gems', DEFAULT);


insert into book values(200, 'Gems', default);
commit;
select * from book;
delete from book where bookno = 200;
rollback;
--rollback�� ������ ��, insert - delete -rollback�� insert�� ���Ƿ�..�߰��ϰ� delete�� �� �����.
--insert ������ commit�� ����� delete�� rollback��.

--transaction�� ������ �� ���ǿܿ��� ������ �� ��� ���̴��ĸ� ������.
--���� �� ���ǿ��� �����͸� �����ϰų� �߰��ߴ���, �� transaction�� �����ϰų� commit�� �Ϸ��ϱ� ������ �ٸ� ���ǿ��� �����ص� ������Ʈ ��������

--���� �� ���ǿ��� ���� transaction���ε�, �ٸ� ���ǿ��� transaction�� �����ϸ� ������ �ȵǰ� �����·� ��
--sqlplus�� lock�� �ɷȴٰ� sql developer���� ������ ������ ��

--<Sequence>:���̺�� �������� ����. ���̺�� ������� �����ؼ� �ִ� ����� ���� ������
create sequence test_seq; --+�ɼ� ����
create sequence incre2_seq increment by 2 start with 40; --40���� �����ؼ� 2�� �����ϴ� ������
select test_seq.nextval from dual; : --1���� ����. �����Ҷ����� ���ڰ� �� �ö�
--����:
insert into test values(test_seq.nextval, default); --
select * from test;
commit;

update test set no = 0 where name = 'kang';
commit;

--sequence ����
drop sequence test_seq;


--<View>: Ư�� ���̺� ������ �ʹ� ����� �Ͼ�ų�, Ư�� ���Ǹ� ���� ����ϰų� �� �� ����ϸ� ����
create view emp_10 as select * from emp where deptno = 10;
select * from emp_10 where sal>3000;



--##sql �ǽ� 3##
--����ڿ��� ���� ���̺�
select table_name from user_tables;
select * from tab;

--����ڿ��� ���� ��ü Ÿ��
select distinct object_type from user_objects;

--������� ��Ű�� ��ü
select * from user_catalog; --���̺���̶� ���̺� Ÿ�� ��µ�(��, �������� ���� ����. �ε��� �ȳ���)

--������ �ǽ��غ��ÿ�
CREATE TABLE  cre_tab1
            (  db_user  VARCHAR2(30) DEFAULT USER,
               issue_date DATE DEFAULT  SYSDATE, 
           type_operation NUMBER(3));
insert into cre_tab1(type_operation) values(100); --default(scott), default(20/12/16), 100
select * from cre_tab1;
select * from CRE_TAB1; --��ҹ��� �������. ���� ���̺� ��ȸ��.

CREATE TABLE "Cre_tab2" ( a  NUMBER,  b  CHAR );
--SELECT * FROM cre_tab2; �����߻�: ���̺� ���� ����ǥ�� ��õǾ� ��ҹ��� ������ ��.

--# ������ CHAR�� VARCHAR2 type�� ���� �ǽ��̴�. �� ������ ���� ����� �����Ͻÿ�.
CREATE TABLE test_char
           ( id  NUMBER,
             a CHAR(2), 
             b VARCHAR2(2));
INSERT INTO test_char VALUES (1, 'x','x');
INSERT INTO test_char VALUES (2, 'x ','x ');
SELECT * FROM test_char  WHERE  a = 'x';
--# ���� ����� ��� �Ǵ°�? 2�� �� ��ȸ��
SELECT * FROM test_char  WHERE  a = 'x '; 
--# ���� ����� ��� �Ǵ°�? 2�� �� ��ȸ��
SELECT * FROM test_char  WHERE  b = 'x';
--# ���� ����� ��� �Ǵ°�? 1�ุ ��ȸ��
SELECT * FROM test_char  WHERE  b = 'x ';
--# ���� ����� ��� �Ǵ°�? 2�ุ ��ȸ��

--# ���� ���ڰ� �Է��� �Ǵ���, �Է��� �ȴٸ� ����� ��� �������� Ȯ���Ͻÿ�.
create table test_num(a number(3), b number(3,1));
insert into test_num values (100, 10);
insert into test_num values (100, 0.1);
insert into test_num values (100, 0.5);
insert into test_num values (100, 0.51);
insert into test_num values (100, 0.55);
select * from test_num; --�Է��� ������� �ݿø��ż� 0,5, 0,6���� ����
insert into test_num values (999, 99);
insert into test_num values (999, 100); --���� �߻�
insert into test_num values (99, 99.9);
insert into test_num values (99, 99.91);
insert into test_num values (99, 99.95); --���� �߻�
insert into test_num values (1000, 10); --���� �߻�
select * from test_num; --99.9���� ©��
insert into test_num values (0.1, 10);
insert into test_num values (0.6, 10);
select * from test_num; --���� �ݿø��ؼ� 0, 1�� ��

insert into test_num values ('A', 10); --���� �߻�

--# ���� �� ������ � ���̰� �ֳ�?
CREATE TABLE history1
           AS SELECT * FROM emp;
CREATE TABLE history2
AS SELECT * FROM emp WHERE 1 = 0;

desc history1;
desc history2;

select * from all_users; --#��� user ��
select * from user_users; --scott�� ������ ��
select * from dba_users; --���� ��. system���� �ؾ���

select table_name from dictionary where table_name like '%USER%';
SELECT table_name FROM dictionary
          WHERE table_name LIKE '%PRIV%';
SELECT table_name FROM dictionary
          WHERE table_name LIKE '%TABLE%' 
          OR table_name LIKE '%COLUMN%';
SELECT table_name FROM dictionary
          WHERE table_name LIKE '%CONS%';
SELECT table_name FROM dictionary
          WHERE table_name LIKE '%AUDIT%';
SELECT table_name FROM dictionary
          WHERE table_name LIKE '%IND%';
          
--# create table with constraints �ǽ�

--# ���̺� ����: ������ �ǹ��ϴ� �ٴ� �����ΰ�?
--# ���̺��� ������ ��� �Ǵ��� Ȯ������.

drop table book;
CREATE TABLE book(
    id    NUMBER(5) CONSTRAINT book_id_pk PRIMARY KEY,
    name    VARCHAR2(20) CONSTRAINT book_name_not_null NOT NULL, 
    price    NUMBER(12,2) CONSTRAINT book_price_check CHECK (price > 0), 
    isbn    VARCHAR2(14) CONSTRAINT book_isbn_unique UNIQUE,
    pub_date DATE DEFAULT SYSDATE
     );
CREATE TABLE job(
    id    NUMBER(3) CONSTRAINT job_id_pk PRIMARY KEY,
    name    VARCHAR(5) NOT NULL
     );
CREATE TABLE author (
    id    NUMBER(5) CONSTRAINT author_id_pk PRIMARY KEY, 
    name    VARCHAR2(20) CONSTRAINT author_name_not_null NOT NULL,
    gender    CHAR(1) DEFAULT 'M',
    age    NUMBER(2),
    job_id    NUMBER(3),
    CONSTRAINT author_gender_check CHECK (gender in ('M', 'F')),
    CONSTRAINT author_job_id_fk FOREIGN KEY (job_id) REFERENCES job(id) 
     );
CREATE TABLE author_book (
    author_id    NUMBER(5),
    book_id        NUMBER(5),
    author_order    NUMBER(2) DEFAULT 1,
    CONSTRAINT authorbook_author_id_fk FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE,
    CONSTRAINT authorbook_book_id_fk FOREIGN KEY (book_id) REFERENCES book(id) ON DELETE CASCADE,
    CONSTRAINT authorbook_pk PRIMARY KEY (book_id, author_id, author_order)
     );
--#������ �������� Ȯ���غ���
--�־ȳ��ñ�?
SELECT constraint_name, constraint_type,
    search_condition
    FROM user_constraints
    WHERE table_name = 'book'; --�ȳ���
--��ųʸ����� �˻��Ҷ��� ���̺� �̸��� ������ �빮�ڷ� �Ѵ�

--# ���������� �̸��� ����, �˻� ���Ǹ� ���´�.
SELECT constraint_name, constraint_type,
    search_condition
    FROM user_constraints
    WHERE table_name = 'BOOK';
--# ��� �÷��� �ɷȴ����� ���´�.
SELECT constraint_name, column_name
    FROM user_cons_columns
    WHERE table_name = 'BOOK'; 
--# ������ �ϸ� ���ϴ� ���� ���� �� �ִ�.
SELECT uc.constraint_name, uc.constraint_type, ucc.column_name, uc.search_condition
    FROM user_constraints uc, user_cons_columns ucc
    WHERE uc.constraint_name = ucc.constraint_name and uc.table_name = 'BOOK';
--# �ٸ� ���̺� Ȯ���غ���
SELECT uc.constraint_name, uc.constraint_type, ucc.column_name, ucc.position, uc.search_condition
    FROM user_constraints uc, user_cons_columns ucc
    WHERE uc.constraint_name = ucc.constraint_name and uc.table_name = '&table_name';
--(* SQL*PLUS������ &�� ����ϸ� ���� �Է¹޵��� �� �� �ִ�.) ; EMP �־��
--job�� �־��, �������� name not null�� ��µǾ���.

--#������ ���̺��� ���� �׽�Ʈ
INSERT INTO book VALUES (1, 'C++ INTRO', 20000, '15-222-22222', '07/01/02');
INSERT INTO book VALUES (2, 'JAVA PRIMER', 50000, '11-111-1111', DEFAULT);
SELECT * FROM book; --2�� ���

--# ������ ����� �� �ֳ�? �ȵȴٸ� ���� ��� �������ǿ� �ɸ����� Ȯ���غ���.
INSERT INTO book VALUES (1, 'TEST BOOK', 50000, '33-333-3333', DEFAULT); --����, ����ũ ����
INSERT INTO book VALUES (3, NULL, 50000, '33-333-3333', DEFAULT); --����, not null ����
INSERT INTO book VALUES (3, 'TEST BOOK', 50000, '11-111-1111', DEFAULT); --����, ����ũ ����
INSERT INTO book VALUES (3, 'TEST BOOK', -100, '33-333-3333', DEFAULT); --üũ ���� ����
INSERT INTO book VALUES (3, 'TEST BOOK', 30000, '33-333-3333', NULL);
SQL> INSERT INTO book VALUES (4, 'TEST BOOK', 30000, '33-333-3333', NULL);
SQL> SELECT * FROM book;