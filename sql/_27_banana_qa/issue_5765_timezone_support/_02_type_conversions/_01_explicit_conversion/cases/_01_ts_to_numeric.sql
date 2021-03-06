--cast TIMESTAMP(L)TZ columns to numeric data types


drop table if exists tz_test;

create table tz_test(id int, ts timestamp, tsltz timestamp with local time zone, tstz timestamp with time zone);

set timezone 'UTC';
insert into tz_test values(1, timestamptz'2019-01-02 12:00:01', timestamptz'2019-01-02 12:00:01', timestamptz'2019-01-02 12:00:01');
insert into tz_test values(2, timestamptz'2019-01-02 12:00:01 -10:00', timestamptz'2019-01-02 12:00:01 -10:00', timestamptz'2019-01-02 12:00:01 -10:00');
insert into tz_test values(3, timestamptz'2019-01-02 12:00:01 +8:00', timestamptz'2019-01-02 12:00:01 +8:00', timestamptz'2019-01-02 12:00:01 +8:00');
insert into tz_test values(4, timestamptz'2019-01-02 12:00:01 Asia/Tokyo', timestamptz'2019-01-02 12:00:01 Asia/Tokyo', timestamptz'2019-01-02 12:00:01 Asia/Tokyo');

--test: cast ts column to numeric types
select id, cast(ts as short) from tz_test order by 1;
select id, cast(ts as int) from tz_test order by 1;
select id, cast(ts as bigint) from tz_test order by 1;
select id, cast(ts as numeric(6, 2)) from tz_test order by 1;
select id, cast(ts as float) from tz_test order by 1;
select id, cast(ts as double) from tz_test order by 1;

--test: cast tsltz column to numeric types
select id, cast(tsltz as short) from tz_test order by 1;
select id, cast(tsltz as int) from tz_test order by 1;
select id, cast(tsltz as bigint) from tz_test order by 1;
select id, cast(tsltz as numeric(6, 2)) from tz_test order by 1;
select id, cast(tsltz as float) from tz_test order by 1;
select id, cast(tsltz as double) from tz_test order by 1;

--test: cast tstz column to numeric types
select id, cast(tstz as short) from tz_test order by 1;
select id, cast(tstz as int) from tz_test order by 1;
select id, cast(tstz as bigint) from tz_test order by 1;
select id, cast(tstz as numeric(6, 2)) from tz_test order by 1;
select id, cast(tstz as float) from tz_test order by 1;
select id, cast(tstz as double) from tz_test order by 1;


drop table tz_test;

set timezone 'Asia/Seoul';
