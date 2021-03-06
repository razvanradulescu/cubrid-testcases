--+ holdcas on;
set names utf8;
Create table t (col1 char(10) collate utf8_ko_cs_uca,col2 varchar(10) collate utf8_ko_cs_uca,col3 nchar(10) collate utf8_ko_cs_uca,col4 NCHAR VARYING(10) collate utf8_ko_cs_uca,col5 string collate utf8_ko_cs_uca);
insert into t values('가abcd012@#','가abcd012@#',N'가abcd012@#',N'가abcd012@#','가abcd012@#');
insert into t values('각刻却各恪慤殼珏脚覺','각刻却各恪慤殼珏脚覺',N'각刻却各恪慤殼珏脚覺',N'각刻却各恪慤殼珏脚覺','각刻却各恪慤殼珏脚覺');
insert into t values('0刻0x123456','0刻0x123456',N'0刻0x123456',N'0刻0x123456','0刻0x123456');
insert into t values('각伽佳假價加可呵哥嘉','각伽佳假價加可呵哥嘉',N'각伽佳假價加可呵哥嘉',N'각伽佳假價加可呵哥嘉','각伽佳假價加可呵哥嘉');
insert into t values('각刊墾奸姦干幹懇揀杆','각刊墾奸姦干幹懇揀杆',N'각刊墾奸姦干幹懇揀杆',N'각刊墾奸姦干幹懇揀杆','각刊墾奸姦干幹懇揀杆');
insert into t values('test可%1234','test可%1234',N'test可%1234',N'test可%1234','test可%1234');
insert into t values('0x1234567嫁','0x1234567嫁',N'0x1234567嫁',N'0x1234567嫁','0x1234567嫁');
select * from t where col1 like '_刻%' order by 1;
select * from t where col2 like '_伽%' order by 1;
select * from t where col3 like N'가%' order by 1;
select * from t where col4 like N'%嫁' order by 1;
select * from t where col5 like '%可%' order by 1;
drop table t;
set names iso88591;
commit;
--+ holdcas off;