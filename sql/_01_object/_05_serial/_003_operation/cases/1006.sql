--test serial using 'start with', 'increment by' clause and arithmetic operation for serial value
create class cnf_1( col1 int);


create serial cnf_col1;

insert into cnf_1 values( cnf_col1.next_value );





SELECT to_char(cnf_col1.current_value),cnf_col1.next_value +100  from cnf_1;



drop serial cnf_col1;

drop class cnf_1;

