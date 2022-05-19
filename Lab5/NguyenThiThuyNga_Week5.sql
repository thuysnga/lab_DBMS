CREATE TABLE Project (
    id number PRIMARY KEY,
    pname varchar2(50),
    cost number
);

INSERT INTO project VALUES (1, 'jupiter', 2000);

INSERT INTO project VALUES (2, 'saturn', 1000);

INSERT INTO project VALUES (3, 'mercury', 15000);

COMMIT;

-- 1.1
COMMIT;

SET TRANSACTION NAME 'cost_update';

SELECT XID, name, STATUS FROM V$TRANSACTION;
UPDATE project
    SET cost = 8000 
    WHERE id = 1;
SELECT XID, name, STATUS FROM V$TRANSACTION;
SELECT * FROM project;
ROLLBACK;
SELECT * FROM project;
SELECT XID, name, STATUS FROM V$TRANSACTION;

1.2
CREATE TABLE accounts (account_id NUMBER(6), balance NUMBER (10,2),
			check (balance>=0));
INSERT INTO accounts VALUES (7715, 6350.00); 
INSERT INTO accounts VALUES (7720, 5100.50); 
COMMIT;
