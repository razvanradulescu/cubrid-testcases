/*
Test Case: delete & select
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/primary_key_column/basic_sql/delete_select_01.ctl
Author: Lily

Test Point:
C1 delete rows, C2 select rows, C1 commit, C2 can not see the change made by C1.

NUM_CLIENTS = 2
C1: DELETE FROM tb1 WHERE id =3;
C2: commit work;
C2: select * from tb1 order by id; 
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: CREATE TABLE tb1( id INT, col VARCHAR(10) );
C1: CREATE INDEX idx_id on tb1(col);
C1: CREATE INDEX idx_col on tb1(id);
C1: INSERT INTO tb1 VALUES(1,'do');INSERT INTO tb1 VALUES(2,'make');INSERT INTO tb1 VALUES(3,'spell');INSERT INTO tb1 VALUES(4,'have');INSERT INTO tb1 VALUES(6,'be');INSERT INTO tb1 VALUES(8,'run');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM tb1 WHERE id = 3;
MC: wait until C1 ready;
C2: SELECT * FROM tb1 WHERE id>0 ORDER BY id;
MC: wait until C2 ready;
C1: commit work;
MC: wait until C1 ready;
C2: SELECT * FROM tb1 WHERE id>0 ORDER BY id;
MC: wait until C2 ready;
C1: DELETE FROM tb1 WHERE col='be';
C1: commit work;
MC: wait until C1 ready;
C2: SELECT * FROM tb1 WHERE id>0 ORDER BY id;
C2: commit work;
C2: SELECT * FROM tb1 WHERE id>0 ORDER BY id;
C2: commit work;

C2: quit;
C1: quit;
