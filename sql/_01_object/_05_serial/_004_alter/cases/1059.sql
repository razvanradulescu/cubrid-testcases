-- create serial using INCREMENT BY which value is 2 and alter it using MAXVALUE which value is 999999999999999999999999999999999998


create serial ser1
INCREMENT BY 2;
alter serial ser1
MAXVALUE 9999999999999999999999999999999999998
;

select * from db_serial WHERE name='ser1';

drop serial ser1;
