/*
Test Case: delete & delete db_class
Priority: 1
Reference case:
Author: Lily

Test Point:
- C1 delete db_class (by drop table) 
- C2 delete db_class 
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;
C2: commit;

/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: DROP TABLE IF EXISTS tb2;
C1: DROP TABLE IF EXISTS tb3;
C1: CREATE TABLE tb1( id INT, col VARCHAR(10));
C1: CREATE TABLE tb2( id INT, col VARCHAR(10));
C1: CREATE TABLE tb3( id INT, col VARCHAR(10));
C1: commit;

/* test case */
/* drop different table */
C1: drop table tb1; 
MC: wait until C1 ready;
C2: drop table tb2;
C2: select class_name,owner_name,is_system_class from db_class where class_name like 'tb%';
MC: wait until C2 ready;
C1: commit;
MC: wait until C1 ready;
C2: select class_name,owner_name,is_system_class from db_class where class_name like 'tb%';
C2: commit;
C2: select class_name,owner_name,is_system_class from db_class where class_name like 'tb%';
C2: commit;
MC: wait until C2 ready;

/* drop same table */
C1: drop table tb3; 
MC: wait until C1 ready;
C2: drop table tb3;
MC: wait until C2 blocked;
C1: rollback;
MC: wait until C1 ready;
C2: select class_name,owner_name,is_system_class from db_class where class_name like 'tb%';
C2: commit;
MC: wait until C2 ready;
C1: select class_name,owner_name,is_system_class from db_class where class_name like 'tb%';
C1: commit;
MC: wait until C1 ready;

C2: quit;
C1: quit;
