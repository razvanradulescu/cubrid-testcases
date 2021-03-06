--create range partition table with timestamp data type and partition values less than MAXVALUE

create table range_test(id int,	
			   test_time time,
			   test_date date,
			   test_timestamp timestamp, primary key(id,test_timestamp))
   	PARTITION BY RANGE (test_timestamp) (
	PARTITION p0 VALUES LESS THAN MAXVALUE
);

select * from db_class where class_name like 'range_test%' order by 1;


drop table range_test;
