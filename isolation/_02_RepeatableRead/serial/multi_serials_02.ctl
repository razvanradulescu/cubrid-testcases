/*
Test Case: multi-serial
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/serial/multi_serials_01.ctl
Author: Lily

Test Point:
use several serials in transactions.

NUM_CLIENTS = 2
C1: insert into tt1 values(s1.next_value,s2.next_value); 
C2: insert into tt1 values(s1.next_value,s2.next_value);
C1: rollback;
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS tt1;
C1: CREATE TABLE tt1( id INT, col INT);
C1: CREATE SERIAL s1 START WITH 1 INCREMENT BY 1 MINVALUE 1 MAXVALUE 100 CYCLE;
C1: CREATE SERIAL s2 START WITH 10 INCREMENT BY -1;
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: INSERT INTO tt1 VALUES(s1.NEXT_VALUE,s2.NEXT_VALUE);
C1: INSERT INTO tt1 VALUES(s1.NEXT_VALUE,s2.NEXT_VALUE);
MC: wait until C1 ready;
C2: INSERT INTO tt1 VALUES(s1.NEXT_VALUE,s2.NEXT_VALUE);
MC: wait until C2 ready;

C1: rollback;
MC: wait until C1 ready;
C2: INSERT INTO tt1 VALUES(s1.NEXT_VALUE,s2.NEXT_VALUE);
C2: SELECT * FROM tt1 ORDER BY id;
C2: commit work;
C2: SELECT * FROM tt1 ORDER BY id;
MC: wait until C2 ready;
C1: SELECT * FROM tt1 ORDER BY id;
C1: DROP SERIAL s1;
C1: DROP SERIAL s2;
C2: commit;
C1: commit;
C2: quit;
C1: quit;
