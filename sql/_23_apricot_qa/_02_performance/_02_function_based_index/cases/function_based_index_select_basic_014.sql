--+ holdcas on;
set  system parameters 'dont_reuse_heap_file=yes';
create table t1 (i1 int, i2 int, d1 double, d2 double, s varchar(255));

create index idx on t1 (ltrim(s));

insert into t1 values (1,1,1,1,'   aaa');
insert into t1 values (2,2,2,2,'   bbb');
insert into t1 values (3,3,3,3,'   ccc');
insert into t1 values (4,4,4,4,'   ddd');
insert into t1 values (5,5,4,5,'   eee');
insert into t1 values (6,6,6,6,'   fff');
insert into t1 values (7,7,7,7,'   ggg');
insert into t1 values (8,8,8,8,'   hhh');
insert into t1 values (9,9,9,9,'   iii');

--Test
select /*+ recompile */ * from t1 where ltrim(s) > 'ccc';

--Test
select /*+ recompile */ * from t1 where ltrim(s) = 'ccc';

--Test
select /*+ recompile */ * from t1 where ltrim(s) < 'ddd' and ltrim(s) > 'bbb';

--Test
select /*+ recompile */ * from t1 where s > 'ccc';

drop index idx on t1;

create index idx on t1 (ltrim(s));

--Test
select /*+ recompile */ * from t1 where ltrim(s) > 'ccc';

--Test
select /*+ recompile */ * from t1 where ltrim(s) = 'ccc';

--Test
select /*+ recompile */ * from t1 where ltrim(s) < 'ddd' and ltrim(s) > 'bbb';

--Test
select /*+ recompile */ * from t1 where s > 'ccc';

drop index idx on t1;

drop table t1;


create table t1 (i1 int, i2 int, d1 double, d2 double, s varchar(255));

create index idx on t1 (i2, ltrim(s));

insert into t1 values (1,1,1,1,'   aaa');
insert into t1 values (2,2,2,2,'   bbb');
insert into t1 values (3,3,3,3,'   ccc');
insert into t1 values (4,3,4,4,'   ddd');
insert into t1 values (5,3,4,5,'   eee');
insert into t1 values (6,3,6,6,'   fff');
insert into t1 values (7,3,7,7,'   ggg');
insert into t1 values (8,3,8,8,'   hhh');
insert into t1 values (9,3,9,9,'   iii');

--Test
select /*+ recompile */ * from t1 where i2 = 3 and ltrim(s) > 'eee';

--Test
select /*+ recompile */ * from t1 where i2 = 3 and ltrim(s) > 'eee' and ltrim(s) < 'hhh';

--Test
select /*+ recompile */ * from t1 where i2 > 2 and s > 'ccc';

--Test
select /*+ recompile */ * from t1 where s > 'ccc';

drop index idx on t1;

create index idx on t1 (i2, ltrim(s));

--Test
select /*+ recompile */ * from t1 where i2 = 3 and ltrim(s) > 'eee';

--Test
select /*+ recompile */ * from t1 where i2 = 3 and ltrim(s) > 'eee' and ltrim(s) < 'hhh';

--Test
select /*+ recompile */ * from t1 where i2 > 2 and s > 'ccc';

--Test
select /*+ recompile */ * from t1 where s > 'ccc';


drop index idx on t1;

drop table t1;


set  system parameters 'dont_reuse_heap_file=no';
commit;
--+ holdcas off;
