autocommit on;
CREATE TABLE tab0(pk INTEGER PRIMARY KEY, col0 INTEGER, col1 FLOAT, col2 VARCHAR, col3 INTEGER, col4 FLOAT, col5 VARCHAR);

INSERT INTO tab0 VALUES(0,940,352.36,'bsdqx',972,108.53,'ipwkm');

INSERT INTO tab0 VALUES(1,947,452.80,'fszup',331,438.66,'moabs');

INSERT INTO tab0 VALUES(2,89,760.28,'viqwz',855,218.12,'ddtqu');

INSERT INTO tab0 VALUES(3,238,819.69,'nioox',244,501.28,'peagi');

INSERT INTO tab0 VALUES(4,829,476.2,'ueaat',575,209.90,'ycfto');

INSERT INTO tab0 VALUES(5,489,10.98,'xqhnp',929,260.76,'hmfnl');

INSERT INTO tab0 VALUES(6,657,258.58,'hmsci',13,691.28,'ttqxt');

INSERT INTO tab0 VALUES(7,214,736.81,'icvcr',784,781.15,'rpsxh');

INSERT INTO tab0 VALUES(8,102,770.21,'ucmym',79,179.95,'rxtyx');

INSERT INTO tab0 VALUES(9,956,614.56,'uwcos',234,30.80,'xczft');
SELECT col3 FROM tab0 WHERE -1 BETWEEN NULL AND col3;
SELECT col3 FROM tab0 WHERE NOT -1 NOT BETWEEN NULL AND col3;
drop table tab0;



