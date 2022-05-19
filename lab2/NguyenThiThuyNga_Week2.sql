-- 1. Create a pluggable database (PDB) and open this PDB.
CREATE PLUGGABLE DATABASE pdb1 ADMIN USER pdb1user IDENTIFIED BY PASSWORD ROLES =(DBA) file_name_convert =('pdbseed', 'pdb1');

ALTER PLUGGABLE DATABASE PDB1 OPEN;

-- RESULT
-- 2. Use SYS user to CONNECT to this PDB. Show CONNECTion name of the CONNECTion.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

-- RESULT
-- 3. Create a tablespace in this PDB.
CREATE TABLESPACE tbs_pdb1 DATAFILE 'D:\app\oradata\ORCL\PDB1\file_01.dbf' size 20M;

-- RESULT
-- 4. Add a datafile to the tablespace above.
ALTER TABLESPACE tbs_pdb1 ADD DATAFILE 'demo.dat' SIZE 1M;

-- RESULT
-- 5. CREATE 5 USERs: user1, user2, user3, user4, user5, default tablespace and quota 1M for each user on the tablespace above.
CREATE USER user1 IDENTIFIED BY userpass DEFAULT TABLESPACE tbs_pdb1 QUOTA 1M ON tbs_pdb1;

CREATE USER user2 IDENTIFIED by userpass DEFAULT tablespace tbs_pdb1 quota 1M ON tbs_pdb1;

CREATE user user3 IDENTIFIED by userpass DEFAULT tablespace tbs_pdb1 quota 1M ON tbs_pdb1;

CREATE user user4 IDENTIFIED by userpass DEFAULT tablespace tbs_pdb1 quota 1M ON tbs_pdb1;

CREATE user user5 IDENTIFIED by userpass DEFAULT tablespace tbs_pdb1 quota 1M ON tbs_pdb1;

-- RESULT
-- 6. Create a developer role: CREATE SESSION, CREATE TABLE.
CREATE ROLE developer;
GRANT CREATE SESSION, CREATE TABLE TO developer;

-- RESULT
-- 7. From SYS user, GRANT developer role to user1 and user5 with admin option.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

GRANT developer TO user1 WITH admin OPTION;

GRANT developer TO user5 WITH admin OPTION;

-- RESULT
-- 8. From SYS user, revoke the developer role from user5.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

REVOKE developer FROM user5;
-- RESULT
-- 9. From user1, grant developer role to user2 so that user2 can grant this role to other users.
CONNECT user1/user1 @localhost:1521/pdb1;

GRANT developer TO user2 WITH admin OPTION;
-- RESULT
-- 10.From user1, create ORDERS table (orderid, orderdate, total). Create a sequence. Insert 4 rows into Orders table, orderid is generated from the sequence above. 
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

GRANT CREATE SEQUENCE TO user1;

CONNECT user1/user1 @localhost:1521/pdb1;

CREATE SEQUENCE ORDERS_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE ORDERS(orderid number, orderdate date, total number);

INSERT INTO ORDERS
VALUES
    (
        ORDERS_seq.nextval,
        TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        100
    );

INSERT INTO ORDERS
VALUES
    (
        ORDERS_seq.nextval,
        TO_DATE('2000-12-17 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        200
    );

INSERT INTO ORDERS
VALUES
    (
        ORDERS_seq.nextval,
        TO_DATE('2001-6-14 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        300
    );

INSERT INTO ORDERS
VALUES
    (
        ORDERS_seq.nextval,
        TO_DATE('2001-6-14 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        100
    );

COMMIT;

SELECT * FROM ORDERS;

-- RESULT
-- 11.From user2, grant developer role to user3, so that user3 can’t grant this role to other user.
CONNECT user2/user2 @localhost:1521/pdb1;

GRANT developer TO user3;

-- RESULT
-- 12.From SYS user, grant select, insert, update (orderdate, total) privilege on ORDERS table to user2.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

GRANT SELECT, INSERT , UPDATE (orderdate, total) ON user1.ORDERS to user2 with grant option;


-- RESULT
-- 13.From SYS user, show system, object privileges and roles of user2.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

SELECT * 
FROM DBA_ROLE_PRIVS 
WHERE GRANTEE = 'user2';

SELECT * 
FROM DBA_TAB_PRIVS 
WHERE GRANTEE = 'user2';

SELECT * 
FROM DBA_SYS_PRIVS 
WHERE GRANTEE = 'user2';

-- RESULT
-- 14.From SYS user, grant select, insert, and update privileges on ORDERS table to user3.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

GRANT SELECT , INSERT , UPDATE ON user1.ORDERS to user3 with grant option;

-- RESULT
-- 15.From SYS user, grant a previlege to user 3 so that user 3 can select the SEQUENCE of user1.
CONNECT sys/Oracle123 @localhost:1521/pdb1 AS sysdba;

GRANT SELECT ON user1.ORDERS_seq to user3 with grant option;



-- RESULT
-- 16.From user3, show system, object privileges and roles of user3.
CONNECT user3/user3 @localhost:1521/pdb1;

SELECT * FROM USER_SYS_PRIVS; 

SELECT * FROM USER_TAB_PRIVS;

SELECT * FROM USER_ROLE_PRIVS;

-- RESULT
-- 17.From user3, write two statements to insert data into user1’orders table.
CONNECT user3/user3 @localhost:1521/pdb1;

INSERT INTO user1.ORDERS
VALUES
    (
        user1.ORDERS_seq.nextval,
        TO_DATE('1994-12-16 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        100
    );

INSERT INTO user1.ORDERS
VALUES
    (
        user1.ORDERS_seq.nextval,
        TO_DATE('2000-12-17 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        200
    );

INSERT INTO user1.ORDERS
VALUES
    (
        user1.ORDERS_seq.nextval,
        TO_DATE('2001-6-14 12:00:00', 'yyyy-MM-dd hh:mi:ss'),
        300
    );


-- RESULT

-- 18.From user3, write a statement to select data from user1’orders table.
CONNECT user3/user3 @localhost:1521/pdb1;

SELECT * FROM user1.ORDERS;
-- RESULT
