-- create serial using START WITH which value is  -2 and alter it using INCREMENT BY which value is -999999999999999999999999999999999998


create serial ser1
START WITH -2;
alter serial ser1
INCREMENT BY -999999999999999999999999999999999998;

select * from db_serial WHERE name='ser1';

drop serial ser1;
