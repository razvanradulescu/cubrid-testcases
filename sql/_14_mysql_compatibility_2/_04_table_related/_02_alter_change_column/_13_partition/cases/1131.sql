---- ALTER TABLE ...  CHANGE COLUMN  
-- constraints :
-- ordering : no order defined
-- name : same of different
-- other : the column is partitioned


-- existing partition on other column
create table t1 (i1 integer, b bigint ) partition by RANGE ( b )
	( PARTITION p0 VALUES LESS THAN (1000) ,
	  PARTITION p1 VALUES LESS THAN (10000000) );

insert into t1 values (1,11),(2,3112),(3,1000012),(4,1002000),(5,1090000),(6,21);
select * from t1  order by 1,2;

alter table t1 change i1 i_1 integer default 3;

select * from t1 order by 1,2;

drop table t1;



-- type change : char to int
create table t1 (b bigint ) partition by RANGE ( b )
	( PARTITION p0 VALUES LESS THAN (1000) ,
	  PARTITION p1 VALUES LESS THAN (10000000) );

insert into t1 values (11),(3112),(1000012),(1002000),(1090000),(21);
select * from t1  order by 1;

alter table t1 change b b bigint default 3;

select * from t1 order by 1;

drop table t1;



-- type change : int to char
create table t1 (i1 integer ) partition by RANGE ( i1*10)
	( PARTITION p0 VALUES LESS THAN  (100),
	  PARTITION p1 VALUES LESS THAN (1000) );
	  
	  
insert into t1 values (1),(3),(30),(32),(54),(21);

select * from t1 order by 1;
-- MYSQL fails : ERROR 1054 (42S22): Unknown column 'i1' in 'partition function'
alter table t1 change i1 s char varying (10);

select * from t1 order by 1;

drop table t1;

