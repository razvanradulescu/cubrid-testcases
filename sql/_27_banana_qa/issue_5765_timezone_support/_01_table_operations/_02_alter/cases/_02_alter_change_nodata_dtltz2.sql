--change DATETIMELTZ from with DEFAULT/constraints to without DEFAULT/constraints, no data


drop table if exists tz;

create table tz(
	c_dtltz1 datetime with local time zone not null,
	c_dtltz2 datetime with local time zone default current_datetime,
	c_dtltz3 datetime with local time zone primary key,
	c_dtltz4 datetime with local time zone unique not null,
	c_dtltz5 datetime with local time zone not null default current_datetime
);


--test: not null
alter table tz change c_dtltz1 c_dtltz11 datetime with local time zone;
desc tz;

--test: default
alter table tz change c_dtltz2 c_dtltz22 datetime with local time zone;
desc tz;

--test: pk
alter table tz change c_dtltz3 c_dtltz33 datetime with local time zone;
show columns in tz;

--test: unique + not null
alter table tz change c_dtltz4 c_dtltz44 datetime with local time zone;
desc tz;

--test: not null + default
alter table tz change c_dtltz5 c_dtltz55 datetime with local time zone;
show full columns in tz;


drop table tz;


