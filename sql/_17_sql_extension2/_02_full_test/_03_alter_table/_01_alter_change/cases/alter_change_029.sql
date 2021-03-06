--primary key (on multiple columns) related change


create table coo(col1 double not null, col2 char varying(10), col3 list, col4 bit varying(20), primary key(col1, col2, col4));

insert into coo values(111.11111, 'aaa', {1, 2, 3}, B'10010');
insert into coo values(222.22222, 'aaa', {1, 2, 3}, B'01011');
insert into coo values(333.33333, 'bbb', {2, 3, 4}, b'110111');

select * from coo order by 1;

--change name only
alter table coo change col1 col11 double not null;
show columns in coo;
--change type only
alter table coo change col2 col2 char(10);
show columns in coo;
--add constraint
alter table coo change col4 col4 bit varying(20) default b'1111';
show columns in coo;
--change non-pk column
alter table coo change col3 col3 list not null default {5, 7, 9};
show columns in coo;

--[er]
alter table coo change col11 col1 int primary key;

drop table coo;



