/*
Test Case: select & delete 
Priority: 1
Reference case:
Author: Ray
Function: INCR/DECR

Test Plan: 
Test MVCC SELECT/DELETE scenarios if using click counter function (INCR/DECR) in select query, 
and the affected rows are overlapped

Test Scenario:
C1 select, C2 delete, the affected rows are overlapped (based on where clause)
C1 uses INCR
C1 select doesn't affect C2 delete
C1,C2 where clauses are on index (index scan)
C1 commit, C2 commit
Metrics: data size = small, index = single index, where clause = simple, schema = single table

Test Point:
1) C2 needs to wait until C1 completed
2) C1 instances will be updated(increment) by using INCR function 
   C2 instances will be deleted 

NUM_CLIENTS = 3
C1: select from table t1;   
C2: delete from table t1;  
C3: select on table t1; C3 is used to check the final results
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: CREATE TABLE t1(id INT, title VARCHAR(10), read_count INT);
C1: CREATE INDEX idx_id on t1(id);
C1: INSERT INTO t1 VALUES(1,'book1',3),(2,'book2',5),(3,'book3',1),(4,'book4',0),(5,'book5',3),(6,'book6',2),(7,'book7',0);
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: SELECT INCR(read_count) FROM t1 WHERE id = 1; 
MC: wait until C1 ready;
C2: DELETE FROM t1 WHERE id IN (1,2);
/* expect: C2 needs to wait once C1 completed */
MC: wait until C2 ready;
/* expect: C1 select - id = 3,6,7 are updated */
C1: SELECT * FROM t1 order by 1,2,3;
C1: commit;
/* expect: 2 rows (id=1,2)deleted message should be generated once C2 ready, C2 select - id = 1,2 are deleted*/
MC: wait until C1 ready;
C2: SELECT * FROM t1 order by 1,2,3;
C2: commit;
MC: wait until C2 ready;
/* expect: the instances of id = 3,6,7 are updated, id = 1,2 are deleted */
C3: select * from t1 order by 1,2,3;
C3: commit;
MC: wait until C3 ready;

C1: quit;
C2: quit;
C3: quit;
