--[er]test update without set keyword
create class tb1(
	col1 int primary key,
	col2 varchar
);

insert into tb1 (col1, col2) values(1, 'aaa');
update tb1 col2='bbb' ;

drop class tb1;
