--timestamp  + time string
--normal value
set timezone 'Asia/Seoul';
select addtime(timestamp'2000-1-1 14:00:30','13:00:00');
select to_datetime_tz(addtime(timestamp'2000-1-1 14:00:30' ,'13:00:00'));
--select to_timestamp_tz(addtime(timestamp'2000-1-1' ,'13:00:00'));

--non-exist value
set timezone 'America/New_York';
select addtime(timestamp'2015-3-8 00:20:00' ,'2:30:00');
select to_datetime_tz(addtime(timestamp'2015-3-8 00:20:00' ,'2:30:00'));
--select to_timestamp_tz(addtime(timestamp'2015-3-8' ,'2:30:00'));

--exist value
select to_datetime_tz(addtime(timestamp'2015-3-8 00:20:00' ,'1:30:00')); 
select to_datetime_tz(addtime(timestamp'2015-3-8 00:20:00' ,'3:30:00')); 
