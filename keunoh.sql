set autotrace off;

select /*+ ordered use_hash(e) */
    d.dept_no, d.dept_name, e.emp_no, e.emp_name
from dept d, emp e
where d.dept_no = e.dept_no;

SELECT * FROM TABLE(dbms_xplan.display);

explain plan for
select emp_no, emp_name, sal
    , (select /*+ unnest */ d.dept_name from dept d where d.dept_no = e.dept_no) dname
from emp e
where sal >= 2000;

explain plan for
select dept_no, dept_name
    , to_number(substr(sal, 1, 7)) avg_sal
    , to_number(substr(sal, 8, 7)) min_sal
    , to_number(substr(sal, 15)) max_sal
from (
    select /*+ unnest */ 
          d.dept_no, d.dept_name
        , (select lpad(avg(sal), 7) || lpad(min(sal), 7) || max(sal) from emp where dept_no = d.dept_no) sal
    from dept d
    where d.dept_loc = 'CHICAGO'
);
SELECT * FROM TABLE(dbms_xplan.display);

select    
      to_number(substr(sal, 1, 7)) avg_sal
    , to_number(substr(sal, 8, 7)) min_sal
    , to_number(substr(sal, 15)) max_sal
from (
    select lpad(avg(100), 7) || lpad(min(200), 7) || max(300) as sal from dual
);

select dept_name, rowid from dept where rownum <= 1;

alter system set optimizer_mode = all_rows;
alter session set optimizer_mode = all_rows;

explain plan for
select /*+ first_rows(1) */ * from dept;
SELECT * FROM TABLE(dbms_xplan.display);

select /*+ FULL(a) */ *
from ����Ʈ�Ź� a
where :CITY in ('�����', '��⵵')
and ���� = :CITY
union all
select /*+ INDEX(a IDX01) */ *
from ����Ʈ�Ź� a
where :CITY not in ('�����', '��⵵')
and ���� = :CITY;

select * from table(dbms_xplan.display);
explain plan for
select dept_no, avg_sal
from (
    select dept_no, avg(sal) avg_sal
    from emp
    group by dept_no
)a
where dept_no = '30';

select * from table(dbms_xplan.display);
explain plan FOR
select b.dept_no, b.dept_name, a.avg_sal
from (
    select dept_no, avg(sal) avg_sal
    from emp
    group by dept_no
    ) a
    , dept b
where a.dept_no = b.dept_no
and b.dept_no = '30';


select * from table(dbms_xplan.display);
explain plan for
select *
from (
        select dept_no, avg(sal)
        from emp
        where dept_no = '10'
        group by dept_no
    ) e1,
    (
        select dept_no, min(sal), max(sal)
        from emp
        group by dept_no 
    ) e2
where e1.dept_no = e2.dept_no;

select * from table(dbms_xplan.display);
explain plan for
select d.dept_no, d.dept_name, e.avg_sal
from dept d
    , (select /*+ no_merge push_pred */
            dept_no, avg(sal) avg_sal
        from emp
        group by dept_no) e
where d.dept_no = e.dept_no(+);

select * from table(dbms_xplan.display);
explain plan for
select d.dept_no, d.dept_name
    , (select avg(sal) from emp where dept_no = d.dept_no) avg_sal
    , (select min(sal) from emp where dept_no = d.dept_no) min_sal
    , (select max(sal) from emp where dept_no = d.dept_no) max_sal
from dept d;


select * from table(dbms_xplan.display);
explain plan for
select dept_no, dept_name
    , to_number(substr(sal, 1, 7)) avg_sal
    , to_number(substr(sal, 8, 7)) min_sal
    , to_number(substr(sal, 15)) max_sal
from (
    select /*+ no_merge */ d.dept_no, d.dept_name
        , (select lpad(avg(sal), 7) || lpad(min(sal), 7) || max(sal)
            from emp
            where dept_no = d.dept_no) sal
    from dept d
);

select * from table(dbms_xplan.display);
explain plan for
select *
from dept d, emp e
where d.dept_no = e.dept_no
and e.dept_no = '10'
and e.emp_name = 'kal';

alter table emp add
constraint fk_deptno foreign key(dept_no)
references dept(dept_no);

select * from table(dbms_xplan.display);
explain plan for
select e.emp_no, e.dept_no
from emp e, dept d
where e.dept_no = d.dept_no(+);

select * from table(dbms_xplan.display);
explain plan for
select /*+ use_concat */ *
from emp
where sal = 1000 
or emp_no = '10';

select * from table(dbms_xplan.display);
explain plan for
select sal from emp
minus
select sal from emp
where dept_no = '10';

select * from table(dbms_xplan.display);
explain plan for
select sum(sal), max(sal), min(sal) from emp;

select * from table(dbms_xplan.display);
explain plan for
select * from emp order by sal desc;

select * from table(dbms_xplan.display);
explain plan for
select dept_no, emp_name, sum(sal), min(sal), max(sal)
from emp
group by dept_no, emp_name;

select * from table(dbms_xplan.display);
explain plan for
select distinct dept_no from emp order by dept_no;

select * from table(dbms_xplan.display);
explain plan for
select /*+ ordered use_merge(d) */ *
from emp e, dept d
where e.dept_no = d.dept_no;

select * from table(dbms_xplan.display);
explain plan for
select emp_no, emp_name, dept_no, row_number() over(order by sal)
from emp;

select * from table(dbms_xplan.display);
explain plan for
select emp_no, emp_name from emp where dept_no = '10'
union
select emp_no, emp_name from emp where dept_no = '20';

select * from table(dbms_xplan.display);
explain plan for
select emp_no, emp_name
from emp
where dept_no = '10'
order by emp_name desc;

select * from table(dbms_xplan.display);
explain plan for
select emp_no, sum(sal)
from emp
group by emp_no;

-- INDEX [�ֹ����� + �ֹ���ȣ]
select nvl(max(�ֹ���ȣ), 0) + 1
from �ֹ�
where �ֹ����� = :�ֹ�����;

-- 1�� ����
select lpad(��ǰ��ȣ, 30) || lpad(��ǰ��, 30) || lpad(��ID, 10)
    || lpad(����, 20) || to_char(�ֹ��Ͻ�, 'yyyymmdd hh24:mi:ss')
from �ֹ���ǰ
where �ֹ��Ͻ� between :start and :end
order by ��ǰ��ȣ;

-- 2�� ����
select lpad(��ǰ��ȣ, 30) || lpad(��ǰ��, 30) || lpad(��ID, 10)
    || lpad(����, 20) || to_char(�ֹ��Ͻ�, 'yyyymmdd hh24:mi:ss')
from (
    select ��ǰ��ȣ, ��ǰ��, ��ID, ����, �ֹ��Ͻ�
    from �ֹ���ǰ
    where �ֹ��Ͻ� between :start and :end
    order by ��ǰ��ȣ
);

create index dept_no_loc on dept(dept_no, dept_loc);

select * from table(dbms_xplan.display);
explain plan for
select * 
from (
    select /*+ INDEX(dept dept_no_loc) */ *
    from dept
    where dept_no = '10'
    and dept_loc = 'SEOUL'
    order by dept_loc
)
where rownum <= 10;

-- TOP N Sort �˰����� �۵����� �� �ϴ� ���
select *
from (
        select rownum no, �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
        from (select �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
                from �ð�������ŷ�
                where �����ڵ� = 'KR123456'
                and �ŷ��Ͻ� >= '20080304'
                order by �ŷ��Ͻ�
                )
        where rownum <= 100        
    )
where no between 91 and 100;

select ��ID, �������, ��ȭ��ȣ, �ּ�, �ڳ��
from (select ��ID, �������
            , max(�������) over (partition by ��ID) �������������
        from �������̷�)
where ������� = �������������;
-- �����ٴ� �Ʒ�
select ��ID, �������, ��ȭ��ȣ, �ּ�, �ڳ��
from (select ��ID, �������
            , rank() over (partition by ��ID order by �������) rnum
        from �������̷�)
where rnum = 1;

-- COUNT STOP KEY �ÿ���å �̿�
SELECT ����ȣ, ����
    , SUBSTR(�����̷�, 1, 8) ������������
    , TO_NUMBER(SUBSTR(�����̷�, 9, 4)) �����������
    , SUBSTR(�����̷�, 13) ���������ڵ�
FROM (
    SELECT ����ȣ, ����
    , (SELECT /*+ INDEX_DESC(X ���º����̷�_PK) */
            �������� || LPAD(�������, 4) || �����ڵ�
        FROM ���º����̷� X
        WHERE ����ȣ = P.����ȣ
          AND ROWNUM <=1) �����̷�
    FROM ��� P
    WHERE ��񱸺��ڵ� = 'A001'
);

-- ������ PUSHING, 12C�������� ���밡��
SELECT ����ȣ, ����
    , SUBSTR(�����̷�, 1, 8) ������������
    , TO_NUMBER(SUBSTR(�����̷�, 9, 4)) �����������
    , SUBSTR(�����̷�, 13) ���������ڵ�
FROM (
    SELECT ����ȣ, ����
        , (SELECT �������� || LPAD(�������, 4) || �����ڵ�
            FROM (SELECT ��������, �������, �����ڵ�
                    FROM ���º����̷�
                    WHERE ����ȣ = P.����ȣ
                    ORDER BY �������� DESC, ������� DESC)
            WHERE ROWNUM <= 1) �����̷�
    FROM ��� P
    WHERE ��񱸺��ڵ� = 'A001'
);

alter session set workarea_size_policy = manual;
alter session set sort_area_size = 10485760;

alter table dept NOLOGGING;

update �ֹ� set �����ڵ� = '9999'
where �ֹ��Ͻ� < to_date('20000101', 'yyyymmdd');

-- Oracle
create table �ֹ�_�ӽ� as select * from �ֹ�;
alter table �ֹ� drop constraint �ֹ�_pk;
truncate table �ֹ�;

insert into �ֹ�(����ȣ, �ֹ��Ͻ�, �����ڵ�)
select ����ȣ, �ֹ��Ͻ�
    , (case when �ֹ��Ͻ� >= to_date('20000101', 'yyyymmdd') then '9999' else status end) �����ڵ�
from �ֹ�_�ӽ�;

alter table �ֹ� add constraint �ֹ�_pk primary key(����ȣ, �ֹ��Ͻ�);
create index �ֹ�_idx1 on �ֹ�(�ֹ��Ͻ�, �����ڵ�);

-- �뷮 ������ delete
create table �ֹ�_�ӽ�
as
select * from �ֹ�
where �ֹ��Ͻ� >= to_date('20000101', 'yyyymmdd');

alter table emp drop constraint �ֹ�_pk;
drop index �ֹ�_idx1;
truncate table �ֹ�;

insert into �ֹ�
select * from �ֹ�_�ӽ�;

alter table �ֹ�_add constraint �ֹ�_pk primary key(����ȣ, �ֹ��Ͻ�);
create index �ֹ�_idx1 on �ֹ�(�ֹ��Ͻ�, �����ڵ�);

-- ���� ���� UPDATE Ʃ��
update ��
set (�����ŷ��Ͻ�, �ֱٰŷ��ݾ�) = (select max(�ŷ��Ͻ�), sum(�ŷ��ݾ�)
                                from �ŷ�
                                where ����ȣ = ��.����ȣ
                                and �ŷ��Ͻ� >= trunc(add_months(sysdate, -1)))
where exists (select 'x'
                from �ŷ�
                where ����ȣ = ��.����ȣ
                and �ŷ��Ͻ� >= trunc(add_months(sysdate, -1)));

-- ORACLE ���� ���� ���� �� Ȱ��
UPDATE
    (SELECT C.�����ŷ��Ͻ�, C.�ֱٰŷ��ݾ�, T.�ŷ��Ͻ�, T.�ŷ��ݾ�
        FROM (SELECT ����ȣ, MAX(�ŷ��Ͻ�) �ŷ��Ͻ�, SUM(�ŷ��ݾ�) �ŷ��ݾ�
                FROM �ŷ�
                WHERE �ŷ��Ͻ� >= TRUNC(ADD_MONTHS(SYSDATE, -1))
                GROUP BY ����ȣ) T
            , �� C
        WHERE T.����ȣ = C.����ȣ)
SET �����ŷ��Ͻ� = �ŷ��Ͻ�
    , �ֱٰŷ��ݾ� = �ŷ��ݾ�;
    
SELECT * FROM DEPT;
-- �⺻ UPDATE -> ���̺� �ڸ��� ���� �並 ���� �� �ִ�.
UPDATE DEPT SET DEPT_LOC = 'HANAM2';

-- ���� �� 2
UPDATE
    (SELECT T.�ֹ�����ó, T.������ּ�, C.������ó, T.���ּ�
        FROM �ŷ� T, �� C
        WHERE T.����ȣ = C.����ȣ
        AND T.�ŷ��Ͻ� >= TRUNC(SYSDATE)
        AND T.�ŷ������ڵ� = 'INVLD')
SET �ֹ�����ó = ������ó
    , ������ּ� = ���ּ�;

-- ORACLE MERGE �� Ȱ��
MERGE INTO �� T USING ������� S ON (T.����ȣ = S.����ȣ)
WHEN MATCHED THEN UPDATE
    SET T.����ȣ = S.����ȣ, T.���� = S.����, T.�̸��� = S.�̸���
WHEN NOT MATCHED THEN INSERT 
    (����ȣ, ����, �̸���, ...) VALUES
    (S.����ȣ, S.����, S.�̸���, ...);

MERGE INTO �� C
USING (SELECT ����ȣ, MAX(�ŷ��Ͻ�) �ŷ��Ͻ�, SUM(�ŷ��ݾ�) �ŷ��ݾ�
        FROM �ŷ�
        WHERE �ŷ��Ͻ� >= TRUNC(ADD_MONTHS(SYSDATE, -1))
        GROUP BY ����ȣ) T
ON (C.����ȣ = T.����ȣ)
WHEN MATCHED THEN UPDATE SET C.�����ŷ��Ͻ� = T.�ŷ��Ͻ�
                            , C.�ֱٰŷ��ݾ� = T.�ŷ��ݾ�; 
                            
select /*+ driving_stie(b) */ channel_id, sum(quantity_sold) authentity_cold
from order a, sales@lk_sales b
where a.order_date between :1 and :2
and b.order_no = a.order_no
group by channel_id;

create or replace function date_to_char(p_dt date) return varchar2
as 
begin
    return to_char(p_dt, 'yyyy/mm/dd hh24:mi:ss');
end;
/

select date_to_char(sysdate) from dual;

create or replace function day_test(p_date varchar2) return varchar2
as
    l_date varchar2(8);
begin
    l_date := to_char(to_date(p_date, 'yyyymmdd'), 'yyyymmdd'); -- ���� ���� ��, exception
    if l_date > to_char(trunc(sysdate), 'yyyymmdd') then
        return 'xxxxxxxx'; -- �̷����ڷ� �Էµ� �ֹ� ������
    end if;
    for i in (select sal from emp where sal = l_date)
    loop
        return 'xxxxxxxx'; -- �޹��Ͽ� �Էµ� �ֹ�������
    end loop;
    return l_date; -- �������� �ֹ�������
exception
    when others then return '00000000'; -- ����������
end;

select day_test('20230606') from dual;
--
select 'hello' from dual;

create table daily
as
select trunc(sysdate - rownum + 1) d_date, to_char(trunc(sysdate - rownum + 1), 'yyyymmdd') c_date
from dual
where rownum <= (trunc(sysdate) - trunc(add_months(sysdate, - (12 * 50)), 'yy') + 1);

select * from daily;

select * from �ֹ� o
where not exists (select 'x' from ���� where c_date = o.�ֹ�����)
or exists (select 'x' from �޹��� where �޹����� = o.�ֹ�����);

create table order_detail(order_no number, order_date varchar2(8), customer_id varchar2(5))
partition by range(order_date) (
      partition p2009_q1 values less than ('20200101')
    , partition p2009_q2 values less than ('20200301')
    , partition p2009_q3 values less than ('20200501')
    , partition p2009_q4 values less than ('20200701')
    , partition p2009_q5 values less than ('20200901')
    , partition p9999_max values less than (MAXVALUE)
);

create table order_detail2(order_no number, order_date varchar2(8), customer_id varchar2(5))
partition by range(order_date)
subpartition by hash(customer_id) subpartitions 8
( partition p2009_p1 values less than('20090401')
, partition p2009_p2 values less than('20090601')
, partition p2009_p3 values less than('20090801')
, partition p2009_p4 values less than('20091001')
, partition p2009_p5 values less than('20091201')
, partition p2009_mx values less than(MAXVALUE));

select /*+ full(o) parallel(o, 4) */
    count(*) �ֹ��Ǽ�, sum(�ֹ�����) �ֹ�����, sum(�ֹ��ݾ�) �ֹ��ݾ�
from �ֹ� o
where �ֹ��Ͻ� between '20100101' and '20101231';

select /*+ index_ffs(o, �ֹ�_idx) parallel_index(o, �ֹ�_idx, 4) */
    count(*) �ֹ��Ǽ�
from �ֹ� o
where �ֹ��Ͻ� between '20100101' and '20101231';

select * from table(dbms_xplan.display);
explain plan for
select /*+ ordered use_hash(e) full(e) parallel(e 4) */
    count(*), min(sal), max(sal), avg(sal), sum(sal)
from dept d, emp e
where d.dept_no = e.dept_no
and d.dept_loc = 'SEOUL';

INSERT INTO ������ݳ��ν���
 (����ȣ, ���Կ�, ����, �ڵ���ü, �ſ�ī��, �ڵ���, ���ͳ�)
SELECT ����ȣ, ���Կ�
    , NVL(SUM(CASE WHEN ���Թ���ڵ� = 'A' THEN ���Աݾ� END), 0) ����
    , NVL(SUM(CASE WHEN ���Թ���ڵ� = 'B' THEN ���Աݾ� END), 0) �ڵ���ü
    , NVL(SUM(CASE WHEN ���Թ���ڵ� = 'C' THEN ���Աݾ� END), 0) �ſ�ī��
    , NVL(SUM(CASE WHEN ���Թ���ڵ� = 'D' THEN ���Աݾ� END), 0) �ڵ���
    , NVL(SUM(CASE WHEN ���Թ���ڵ� = 'E' THEN ���Աݾ� END), 0) ���ͳ�
FROM �������Թ��������
WHERE ���Կ� = '200903'
GROUP BY ����ȣ, ���Կ�;

select rownum no from dual connect by level <=100;

select * 
from dept a
    , (select rownum no
        from dual
        connect by level <= 3)b;

insert into dept values(2, 'program', 'seoul');

select a.ī���ǰ�з�
    , (case when b.no = 1 then a.����� else '�Ұ�' end) as �����
    , sum(a.�ŷ��ݾ�) as �ŷ��ݾ�
from (select ī��.ī���ǰ�з� as ī���ǰ�з�
            , ��.����� as �����
            , sum(�ŷ��ݾ�) as �ŷ��ݾ�
        from ī�������, ī��, ��
        where ������� = '201008'
        and ī��.ī���ȣ = ī�������.ī���ȣ
        and ��.����ȣ = ī��.����ȣ
        group by ī��.ī���ǰ�з�, ��.�����) a
    , copy_t b
where b.no <= 2
group by a.ī���ǰ�з�, b.no, (case when b.no = 1 then a.����� else '�Ұ�' end);

select ��ǰ, ����, nvl(sum(��ȹ����), 0) as ��ȹ����, nvl(sum(��������), 0) as ��������
from (
    select ��ǰ, ��ȹ���� as ����, ��ȹ����, to_number(null) as ��������
    from �μ����ǸŰ�ȹ
    where ��ȹ���� between '200901' and '200903'
    union all
    select ��ǰ, �Ǹſ���, to_number(null), �Ǹż���
    from ä�κ��ǸŽ���
    where �Ǹſ��� between '200901' and '200903'
) a
group by ��ǰ, ����;

select to_number('1') from dual;

SELECT *
FROM (
    SELECT ROWNUM NO, �ŷ��Ͻ�, ü��Ǽ�
        , ü�����, �ŷ����, COUNT(*) OVER() CNT
      FROM (
        SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
        FROM �ð�������ŷ�
        WHERE �����ڵ� = :isu_cd -- ����ڰ� �Է��� �����ڵ�
        AND �ŷ��Ͻ� >= :trd_time
        ORDER BY �ŷ��Ͻ�
    )
    WHERE ROWNUM <= :page * pgsize + 1
)
WHERE NO BETWEEN (:page - 1) * :pgsize + 1 AND :pgsize * :page;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
EXPLAIN PLAN FOR
SELECT *
FROM (
    SELECT ROWNUM NO, DEPT_NO, DEPT_NAME, DEPT_LOC, COUNT(*) OVER() CNT
    FROM (
        SELECT DEPT_NO, DEPT_NAME, DEPT_LOC
        FROM DEPT
        ORDER BY DEPT_NO
    )
    WHERE ROWNUM <= 2
)
WHERE NO BETWEEN 1 AND 1;

-- NEXT ��ư Ŭ�� ��
SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
FROM (
    SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
    FROM �ð�������ŷ� A
    WHERE :�������̵� = 'NEXT'
    AND �����ڵ� = :ISU_CD
    AND �ŷ��Ͻ� >= :TRD_TIME
    ORDER BY �ŷ��Ͻ�
)
WHERE ROWNUM <= 11;

-- PREV ��ư Ŭ�� ��
SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
FROM (
    SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
    FROM �ð�������ŷ� A
    WHERE :�������̵� = 'PREV'
    AND �����ڵ� = :ISU_CD
    AND �ŷ��Ͻ� <= :TRD_TIME
    ORDER BY �ŷ��Ͻ� DESC
)
WHERE ROWNUM <= 11
ORDER BY �ŷ��Ͻ�;

-- UNION ALL Ȱ�� ����¡ó��
SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
FROM (
    SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
    FROM �ð�������ŷ�
    WHERE :�������̵� = 'NEXT'
    AND �����ڵ� = :isu_cd
    AND �ŷ��Ͻ� >= :trd_time
    ORDER BY �ŷ��Ͻ�
)
WHERE ROWNUM <= 11
UNION ALL
SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
FROM (
    SELECT �ŷ��Ͻ�, ü��Ǽ�, ü�����, �ŷ����
    FROM �ð�������ŷ�
    WHERE :�������̵� = 'PREV'
    AND �����ڵ� = :isu_cd
    AND �ŷ��Ͻ� <= :trd_time
    ORDER BY �ŷ��Ͻ�
)
WHERE ROWNUM <= 11
ORDER BY �ŷ��Ͻ�;

-- INDEX [�Ϸù�ȣ + �����ڵ�]
select �Ϸù�ȣ, ������
    , (select /*+ index_desc(������� �������_idx) */ �����ڵ�
         from �������
        where �Ϸù�ȣ <= o.�Ϸù�ȣ
          and �����ڵ� is not null
          and rownum <= 1) �����ڵ�
from ������� o
order by �Ϸù�ȣ;

select �Ϸù�ȣ, ������
    , last_value(�����ڵ� ignore nulls) over(order by �Ϸù�ȣ rows between unbounded preceding and current row) �����ڵ�
from �������
order by �Ϸù�ȣ;

-- With ���� Ȱ��
with �����ī�� as (select ī��.ī���ȣ, ��.����ȣ
                      from ��, ī��
                      where ��.��������� = 'Y'
                      and ��.����ȣ = ī��߱�.����ȣ)
select v.*
from (
    select  a.ī���ȣ as ī���ȣ
          , sum(a.�ŷ��ݾ�) as �ŷ��ݾ�
          , null as ���ݼ����ܾ�
          , null as �ؿܰŷ��ݾ�
    from ī��ŷ����� a
        , �����ī�� b
    where ����
    group by a.ī���ȣ
    union all
    select a.ī���ȣ
        , null 
        , sum(amt)
        , null
    from (
        select a.ī���ȣ as ī���ȣ
            , sum(a.�ŷ��ݾ�) as amt
        from ���ݰŷ����� a
            , �����ī�� b
        where ����
        group by a.ī���ȣ
        union all
        select a.ī���ȣ
            , sum(a.�����ݾ�) * -1
        from ���ݰ������� a
            , �����ī�� b
        where ����
        group by a.ī���ȣ
        ) a
    group by a.ī���ȣ
    union all
    select a.ī���ȣ
        , null 
        , null
        , sum(a.�ŷ��ݾ�)
    from �ؿܰŷ����� a
        , �����ī�� b
    where ����
    group by a.ī���ȣ
) v;

set lock_timeout 2000;

select * from t for update wait 3;
commit;

set transaction isolation level read committed;
commit;
set transaction isolation leven snapshot;

-- INDEX : [������ڵ� + ����ID + �������]�� SORT ���� ���� ����
SELECT ����ID, COUNT(*) ���Ǽ�
FROM ���
WHERE ������ڵ� = 'RS01'
AND ������� < TRUNC(SYSDATE, 'MM')
GROUP BY ����ID;

/* �ε��� ���� -> ���_X2 : [��ǰ��ȣ + �������]
FILTER
    NESTED LOOPS (SEMI)
        TABLE ACCESS (BY INDEX ROWID) OF '��ǰ' (TABLE)
            INDEX (RANGE SCAN) OF '��ǰ_X1'
        INDEX (RANGE SCAN) OF '���_X2'
*/
SELECT /*+ LEADING(P) */ P.��ǰ��ȣ, P.��ǰ��, P.��ǰ����, P.��ǰ�з��ڵ�
FROM ��ǰ P
WHERE P.��ǰ�����ڵ� = :PCLSCD
AND EXISTS (SELECT /*+ UNNEST NL_SJ */ 'X'
            FROM ��� C
            WHERE C.��ǰ��ȣ = P.��ǰ��ȣ
            AND C.������� >= TRUNC(ADD_MONTHS(SYSDATE, -12)));
/*
FILTER
    TABLE ACCESS (BY INDEX ROWID) OF '��ǰ'
        INDEX (RANGE SCAN) OF '��ǰ_X1'
    FILTER
        INDEX (RANGE SCAN) OF '���_X2'
*/
SELECT P.��ǰ��ȣ, P.��ǰ��, P.��ǰ����, P.��ǰ�з��ڵ�
FROM ��ǰ P
WHERE P.��ǰ�����ڵ� = :PCLSCD
AND EXISTS (SELECT /*+ NO_UNNEST */ 'X'
            FROM ��� C
            WHERE C.��ǰ��ȣ = P.��ǰ��ȣ
            AND C.������� >= TRUNC(ADD_MONTHS(SYSDATE, -12)));

/*
�ֹ����� ���� 1,000�� �Ǻ��� ������ �Ǽ��� ����, ���� Ű�� �ߺ� ���� �����Ƿ�
�ؽ� �� Build Input���δ� ������ ����
<1��> 
1) �ε��� �߰�
�ֹ���ǰ_X1 : [��ǰ�ڵ� + �ֹ���ȣ]
2) ��Ʈ �߰�
/+ LEADING(P) USE_HASH(O) FULL(O) INDEX(P �ֹ���ǰ_X1) /
<2��>
/+ LEADING(P) USE_HASH(O) FULL(O) INDEX_FFS(P �ֹ���ǰ_PK) /
*/

-- ����¡ ó�� ����
SELECT ����ȣ, ��ǰ�ڵ�, ����Ͻ�, ���ݾ�
FROM (
    SELECT ROWNUM AS RNUM, C.*
    FROM (
        SELECT ����ȣ, ��ǰ�ڵ�, ����Ͻ�, ���ݾ�
        FROM ���
        WHERE ����ID = :BRCH_ID
        AND ����Ͻ� >= TRUNC(SYSDATE - 7)
        ORDER BY ����Ͻ� DESC
    ) C
    WHERE ROWNUM <= (:PAGE * 10)
)
WHERE RNUM >= (:PAGE - 1) * 10 + 1;

SELECT MAX(�����Ͻ�)
FROM ��ǰ�����̷�
WHERE ��ǰ��ȣ = 'Z1123'
AND �����Ͻ� >= TRUNC(ADD_MONTHS(SYSDATE, -12))
AND ���汸���ڵ� = 'C2');

-- FIRST ROW (MIN/MAX) �ȵǴϱ�
-- INDEX : [��ǰ��ȣ + ���汸���ڵ� + �����Ͻ�]
SELECT �����Ͻ�
FROM (
    SELECT �����Ͻ�
     FROM ��ǰ�����̷�
    WHERE ��ǰ��ȣ = 'ZE367'
      AND ���汸���ڵ� = 'C2'
    ORDER BY �����Ͻ� DESC
)
WHERE ROWNUM <= 1;

-- 2021�� 3���� ���� ��ǰ�����̷� �� ����������
SELECT ��ǰ��ȣ, �����Ͻ�
FROM (
    SELECT ��ǰ��ȣ, �����Ͻ�, ���汸���ڵ�
        , ROW_NUMBER() OVER (PARTITION BY ��ǰ��ȣ ORDER BY �����Ͻ� DESC) NO
     FROM ��ǰ�����̷�
    WHERE �����Ͻ� >= TO_DATE('20210301' , 'YYYYMMDD')
      AND �����Ͻ� < TO_DATE('20210401', 'YYYYMMDD')
)
WHERE NO = 1
  AND ���汸���ڵ� = 'C2';

-- [2��]
SELECT ��ǰ��ȣ, MAX(�����Ͻ�) �����Ͻ�
FROM ��ǰ�����̷�
WHERE �����Ͻ� BETWEEN '20210301' AND '20210331'
GROUP BY ��ǰ��ȣ
HAVING MAX(���汸���ڵ�) KEEP (DENSE_RANK LAST ORDER BY �����Ͻ�) = 'C2';

-- ��ǰ������ [����ȭ X], �ε��� : [��ǰ��ȣ + �������� + �������]
SELECT B.��������, B.������
  FROM (
    SELECT ��������, MAX(�������) �������
      FROM ��ǰ������
     WHERE ��ǰ��ȣ = 'R0014'
       AND �������� BETWEEN '20210301' AND '20210331'
     GROUP BY ��������) A, ��ǰ������ B
WHERE A.�������� = B.��������
  AND A.������� = B.�������
  AND B.��ǰ��ȣ = 'R0014'
ORDER BY B.��������;

-- ��� 1��, �ε��� : [��ǰ��ȣ + �������� + �������]
SELECT ��������, ������
  FROM (
    SELECT ��������, ������
        ,  ROW_NUMBER() OVER(PARTITION BY �������� ORDER BY ������� DESC) NO
      FROM ��ǰ������
     WHERE ��ǰ��ȣ = 'R0014'
       AND �������� BETWEEN '20210301' AND '20210331'
    )
WHERE NO = 1
ORDER BY ��������;

-- 2��, �ε��� : [��ǰ��ȣ + �������� + �������]
SELECT ��������
    ,  MAX(������) KEEP (DENSE_RANK LAST ORDER BY �������) ������
  FROM ��ǰ������
 WHERE ��ǰ��ȣ = 'R0014'
   AND �������� BETWEEN '20210301' AND '20210331'
 GROUP BY ��������
 ORDER BY ��������;
 
-- 20��. �ε��� : [��ǰ��ȣ + �������� + �������]
SELECT X.������
FROM (
    SELECT ������
      FROM ��ǰ������
     WHERE ��ǰ��ȣ = 'R0014'
     ORDER BY �������� DESC, ������� DESC
) X
WHERE X.ROWNUM <= 1;
-- 21��. �ε��� : [��ǰ��ȣ + �������� + �����Ϸù�ȣ + ���汸���ڵ�]
-- IN-LIST�� ���ͷ� Ǯ�������

-- 22��. �ε��� ��� : [����ȣ], ���º����̷� : [����ȣ + �������� + �������] 
-- ���1��
SELECT ����ȣ, ����
    , SUBSTR(�����̷�, 13) ���������ڵ�
    , SUBSTR(�����̷�, 1, 8) ������������
    , SUBSTR(�����̷�, 9 ,4) �����������
FROM (
    SELECT ����ȣ, ����
        ,  (SELECT �������� || LPAD(�������, 4) || �����ڵ�
            FROM (
                SELECT ��������, �������, �����ڵ�
                FROM ���º����̷�
                WHERE ����ȣ = P.����ȣ
                ORDER BY �������� DESC, ������� DESC)
            WHERE ROWNUM <= 1) �����̷�
    FROM ��� P
    WHERE ��񱸺��ڵ� = 'A001'
)

-- ��� 2��
SELECT P.����ȣ, P.����
    ,  H.�����ڵ�, H.��������, H.�������
FROM ��� P, ���º����̷� H
WHERE P.����ȣ = H.����ȣ
AND P.��񱸺��ڵ� = 'A001'
AND (H.��������, H.�������) = (SELECT ��������, �������
                                FROM ( 
                                    SELECT ��������, �������
                                    FROM ���º����̷�
                                    WHERE ����ȣ = P.����ȣ
                                    ORDER BY �������� DESC, ������� DESC)
                                WHERE ROWNUM <= 1);
                                
/* ���ɰ����ϱ�
DELETE FROM TARGET_T;
COMMIT;
ALTER SESSION ENABLE PARALLEL DML;

INSERT /+ APPEND / INTO TARGET_T T1
SELECT /+ FULL(T2) PARALLEL(T2 4) / *
FROM SOURCE_T T2;
COMMIT;
ALTER SESSION DISABLE PARALLEL DML;
*/
TRUNCATE TABLE TARGET_T;
ALTER TABLE TARGET_T MODIFY CONSTRAINT TARGET_T_PK DISABLE DROP INDEX;
ALTER SESSION TARGET_T NOLOGGING;

INSERT /*+ PARALLEL(T1 4) */ INTO TARGET_T T1
SELECT /*+ FULL(T2) PARALLEL(T2 4) */ *
FROM SOURCE_T T2;
COMMIT;

ALTER TABLE TARGET_T MODIFY CONSTRAINT TARGET_T_PK ENABLE NOVALIDATE;
ALTER TABLE TARGET_T LOGGING;
ALTER SESSION DISABLE PARALLEL DML;

/* ���� ���� */
CREATE TABLE MYTAB_TEMP
NOLOGGING -- �߰�
AS
SELECT C0 AS ID, C1, C2, C3
    , (CASE WHEN C1 < TRUNC(SYSDATE) THEN C4 + 1 ELSE C4 END) AS C4
FROM YUOURTAB@RDS
WHERE C0 IS NOT NULL
AND C5 > 0;

DECLARE
    V_CNT NUMBER;
BEGIN
    -- ID�� �ߺ����� �ִ��� Ȯ��
    SELECT COUNT(*) INTO V_CNT
    FROM (SELECT ID
            FROM MYTAB_TEMP
            GROUP BY ID
            HAVING COUNT(*) > 1);
    
    IF V_CNT > 0 THEN
        INSERT_LOG (SYSDATE, 'INSERT MYTAB_TEMP', 'FAIL', '�ߺ� ������');
    ELSE
        -- ��ġ ���α׷��� ������� ��츦 ����ϱ� ���� DELETE (���� 0�� ����)
        DELETE FROM MYTAB WHERE DT = TO_CHAR(SYSDATE, 'YYYYMMDD');
        
        INSERT INTO MYTAB(DT, ID, C1, C2, C3, C4)
        SELECT TO_CHAR(SYSDATE, 'YYYYMMDD'), A.* FROM MYTAB_TEMP A;
    
        V_CNT := SQL%ROWCOUNT;
        INSERT_LOG (SYSDATE, 'INSERT MYTAB_TEMP', 'SUCCESS', V_CNT || ' ROWS');
    END IF;
    
    COMMIT;
END;
/
DROP TABLE MYTAB_TEMP;

/*
UPDATE OF '��'
    TABLE ACCESS (FULL) OF '��'  (TABLE)
    TABLE ACCESS (BY INDEX ROWID) OF '��'  (TABLE)
        INDEX (UNIQUE SCAN) OF '����ȣ_PK' (INDEX(UNIQUE))
*/
-- 1.
UPDATE �� C
    SET �����븮��_����ó = NVL((SELECT ����ó FROM �� WHERE ����ȣ = C.�����븮��_����ȣ), C.�����븮��_����ó)
WHERE ���ο��� = 'N';
-- 2.
UPDATE �� C
    SET �����븮��_����ó = (SELECT ����ó FROM �� WHERE ����ȣ = C.�����븮��_����ȣ)
WHERE C.���ο��� = 'N'
AND EXISTS (SELECT /*_ UNNEST NL_SJ */ 'X' FROM �� WHERE ����ȣ =  C.�����븮��_����ȣ);

-- 3. ��� 1��
UPDATE (
    SELECT /*+ LEADING(C) USE_NL(P) INDEX(C ��_X3) INDEX(P ��_PK) */
        C.�����븮��_����ó, P.����ó
    FROM �� C, �� P
    WHERE C.���ο��� = 'N'
    AND C.�����븮��_����ȣ IS NOT NULL
    AND P.����ȣ = C.�����븮��_����ȣ
    AND P.����ó <> C.�����븮��_����ó
)
SET �����븮��_����ó = ����ó;

-- 4. ��� 2��
MERGE /*+ LEADING(C) USE_NL(P) INDEX(C ��_X3) INDEX(P ��_PK) */ INTO �� C
USING �� P
    ON ( C.���ο��� = 'N'
        AND C.�����븮��_����ȣ IS NOT NULL
        AND P.����ȣ = C.�����븮��_����ȣ)
WHEN MATCHED THEN UPDATE
SET C.�����븮��_����ó = P.����ó
WHERE C.�����븮��_����ó <> P.����ó;

-- Q.
UPDATE ��ǰ��� T
    SET T.ǰ�������� =
        NVL((SELECT TRUNC(SYSDATE) - TO_DATE(MAX(A.��������), 'YYYYMMDD')
               FROM ��ǰ����̷� A, ��ǰ��� B
               WHERE A.��ǰ��ȣ = B.��ǰ��ȣ
               AND B.��ü�ڵ� = 'Z'
               AND B.������� = 0
               AND NVL(B.����������, 0) <= 0
               AND A.��ǰ��ȣ = T.��ǰ��ȣ)
            , T.ǰ��������)
    WHERE T.��ü�ڵ� = 'Z'
    AND T.������� = 0
    AND NVL(T.����������, 0) <= 0;

MERGE INTO ��ǰ��� T
USING ��ǰ����̷� A, ��ǰ��� B
    ON (A.��ǰ��ȣ = B.��ǰ��ȣ
        AND B.��ü�ڵ� = 'Z'
        AND B.������� = 0
        AND NVL(B.����������, 0) <= 0
        AND A.��ǰ��ȣ = T.��ǰ��ȣ)
WHEN MATCHED THEN UPDATE
SET T.ǰ�������� = TRUNC(SYSDATE) - TO_DATE(MAX(A.��������), 'YYYYMMDD');

-- ��� 1��
UPDATE /*+ LEADING(T) */ ��ǰ��� T
    SET T.ǰ�������� = (SELECT TRUNC(SYSDATE) - TO_DATE(MAX(��������), 'YYYYMMDD') FROM ��ǰ����̷� WHERE ��ǰ��ȣ = T.��ǰ��ȣ)
WHERE T.��ü�ڵ� = 'Z'
AND T.������� = 0
AND NVL(T.����������, 0) <= 0
AND EXISTS (SELECT /*+ NL_SJ UNNEST */ 'X' FROM ��ǰ����̷� WHERE ��ǰ��ȣ = T.��ǰ��ȣ);
-- ��� 2��
UPDATE /*+ LEADING(T) */ ��ǰ��� T
    SET T.ǰ�������� = (SELECT TRUNC(SYSDATE) - TO_DATE(MAX(A.��������), 'YYYYMMDD') FROM ( SELECT �������� FROM ��ǰ����̷� WHERE ��ǰ��ȣ = T.��ǰ��ȣ ORDER BY �������� DESC) A WHERE ROWNUM <= 1)
WHERE T.��ü�ڵ� = 'Z'
AND T.������� = 0
AND NVL(T.����������, 0) <= 0
AND EXISTS (SELECT /*+ NL_SJ UNNEST */ 'X' FROM ��ǰ����̷� WHERE ��ǰ��ȣ = T.��ǰ��ȣ); 
-- ��� 3��
MERGE INTO ��ǰ��� X
USING (
    SELECT /*+ LEADING(A) NO_MERGE(B) USE_NL(B) PUSH_PRED(B) */ A.��ǰ��ȣ, B.�ű�_ǰ��������
    FROM ��ǰ��� A
        , (SELECT ��ǰ��ȣ, (TRUNC(SYSDATE) - TO_DATE(MAX(��������), 'YYYYMMDD')) �ű�_ǰ�������� FROM ��ǰ����̷� GROUP BY ��ǰ��ȣ) B
    WHERE A.��ü�ڵ� = 'Z'
    AND A.������� = 0
    AND NVL(A.����������, 0) <= 0
    AND A.��ǰ��ȣ = B.��ǰ��ȣ
    AND A.ǰ�������� <> B.�ű�_ǰ��������
) Y 
ON (X.��ǰ��ȣ = Y.��ǰ��ȣ)
WHEN MATCHED THEN UPDATE SET X.ǰ�������� = Y.�ű�_ǰ��������;