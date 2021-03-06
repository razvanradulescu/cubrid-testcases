/*
Test Case: rollback 
Priority: 1
Reference case:
Author: Lily

Test Point:
Event Type:rollback,   Event time:after

NUM_CLIENTS = 2
C1: insert, update, then commit; 
C2: update the table; 
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS tt1;
C1: DROP TABLE IF EXISTS hi;
C1: CREATE TABLE hi( id INT, col VARCHAR(10));
C1: INSERT INTO hi VALUES(1,'111'),(2,'222'),(3,'333');
C1: CREATE TABLE tt1( id INT, col VARCHAR(10));
C1: CREATE TRIGGER trg1 AFTER rollback EXECUTE PRINT 'Success to rollback the transaction';
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: INSERT INTO tt1 VALUES(1,'test');
C1: UPDATE hi SET col=NULL WHERE id=3;
MC: wait until C1 ready;
C2: INSERT INTO hi VALUES(2,'test');
MC: wait until C2 ready;
C1: SELECT * FROM hi order by 1,2;
MC: wait until C1 ready;
C2: SELECT * FROM hi order by 1,2;
MC: wait until C2 ready;
C1: rollback;
MC: wait until C1 ready;
C2: SELECT * FROM hi order by 1,2;
C2: rollback;
C2: drop trigger trg1;
C2: commit;
C2: quit;
C1: quit;
