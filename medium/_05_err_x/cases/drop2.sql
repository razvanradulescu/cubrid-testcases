autocommit off;
call login ('dba', '') on class db_user;
call find_user ('gruppe') on class db_user to gruppe;
call drop_member ('user2') on gruppe;
call login ('dba', '') on class db_user;
rollback;
