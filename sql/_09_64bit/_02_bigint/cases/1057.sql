create class test_class (bigint_col bigint)
partition by range ( bigint_col) (
partition p0 values less than (-100),
partition p1 values less than (100),
partition p2 values less than MAXVALUE );


insert into test_class(bigint_col) values (-9223372036854775808);
insert into test_class(bigint_col) values (-1000);
insert into test_class(bigint_col) values (-100);
insert into test_class(bigint_col) values (0);
insert into test_class(bigint_col) values (100);
insert into test_class(bigint_col) values (1000);
insert into test_class(bigint_col) values (9223372036854775807);
insert into test_class(bigint_col) values (NULL);
insert into test_class(bigint_col) values (NULL);

select * from test_class order by 1;
select * from test_class__p__p0 order by 1;
select * from test_class__p__p1 order by 1;
select * from test_class__p__p2 order by 1;

select * from test_class__p__p1 where bigint_col = 1000 order by 1;

drop class test_class;