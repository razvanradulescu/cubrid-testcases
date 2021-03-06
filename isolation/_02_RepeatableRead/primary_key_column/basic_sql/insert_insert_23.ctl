/*
Test Case: insert & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
ON DUPLICATE KEY UPDATE ...
insert into t values(1,'b'),(2,'c') on duplicate key update ...
A insert on duplicate ...
B insert rows including A inserted row -- expected waiting

NUM_CLIENTS = 2
C1: insert into t values(1,'a');
C2: insert into t values(1,'b'),(2,'c') on duplicate key update id=2; --expected blocked
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int primary key,col varchar(10));
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: insert into t values(1,'a');
MC: wait until C1 ready;
C2: insert into t values(1,'b'),(2,'c') on duplicate key update id=2;
MC: wait until C2 blocked;
C1: commit;
MC: wait until C2 ready;
/* expected (1,a) */
C2: select * from t order by 1,2;
C2: commit;

/* expected (1,a) */
C2: select * from t order by 1,2;
C2: commit;

C2: quit;
C1: quit;

