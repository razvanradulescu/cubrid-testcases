--+ holdcas on;
set names utf8;
CREATE TABLE test_cn ( 
  id     int    NOT NULL, 
  name      VARCHAR(20) collate utf8_gen);
insert into test_cn values (1,'测试');
insert into test_cn values (2,'我们'); 
insert into test_cn values (3,'我们');
insert into test_cn values (103,'我们');
insert into test_cn values (203,'我们');
insert into test_cn values (303,'我们.国家');
insert into test_cn values (403,'我们 生活');
insert into test_cn values (4,'生活');
insert into test_cn values (104,'高兴');
insert into test_cn values (5,'国家'); 
insert into test_cn values (105,'你们好');
insert into test_cn values (205,'绿色'); 
insert into test_cn values (6,'今天');
insert into test_cn values (106,'%今天'); 
insert into test_cn values (7,'汽车');
insert into test_cn values (107,'_汽车');
insert into test_cn values (8,'高兴');
insert into test_cn values (9,'发明');
insert into test_cn values (109,'?发明');
insert into test_cn values (10,'程序员');
insert into test_cn values (110,'*程序员');

select id, name, translate (name,'我们','咱们') from test_cn order by 1;

select id, name, translate (name,'今天','水仙花') from test_cn order by 1;

drop table test_cn;

set names iso88591;
commit;
--+ holdcas off;
