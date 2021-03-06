CREATE table alltypes(
int_col INTEGER,
float_col FLOAT,
double_col DOUBLE,
smallint_col SMALLINT,
date_col DATE,
time_col TIME,
timestamp_col TIMESTAMP,
datetime_col DATETIME,
monetary_col MONETARY,
numeric_col NUMERIC(12,4),
char_col char(255),
varchar_col varchar(255),
nchar_col nchar(255),
varnchar_col nchar varying(255),
bit_col bit(8),
varbit_col bit varying (255),
set_col set(integer),
sequence_col sequence(integer),
multiset_col multiset(integer, varchar(255)),
blob_col blob,
clob_col clob
);

insert into alltypes values(12345, 123.45, 1003.367, 1230, date'2010-01-01', time'12:34:56', timestamp'2010-01-01 12:34:56 am', datetime'2010-01-01 12:34:56.123 am',1000, 123456.7890, '1230', '1230.45' ,N'1230.45', N'1230', b'01010101', b'111111111', {1,2,3,4,5} , {6,7,8,9}, {0,'a','b','c',13,14,15}, '1230', '1230');


select last_day(monetary_col) from alltypes;

select last_day(numeric_col) from alltypes;

--select last_day(char_col) from alltypes;
select if(last_day(char_col)=concat(year(sysdate),'-12-31'),'ok','nok') from alltypes;

select last_day(varchar_col) from alltypes;

select last_day(nchar_col) from alltypes;

--select last_day(varnchar_col) from alltypes;
select if(last_day(varnchar_col)=concat(year(sysdate),'-12-31'),'ok','nok') from alltypes;

select if(last_day('1230') = last_day(1230), 'ok','nok');

select if(last_day('1230.45') = last_day(1230.45), 'ok','nok');

select if(last_day(N'1230') = last_day(1230),'ok','nok');

select if(last_day(N'1230.45') = last_day(1230.45),'ok','nok');

select last_day(date'2010-01-01');

select last_day('2010-01-01');

$varchar, $1230
select if (last_day(?) = last_day('1230'),'ok','nok') from db_root;

$varchar, $1230
select if (last_day(?) = '1231', 'ok', 'nok') from db_root;

drop table alltypes;
