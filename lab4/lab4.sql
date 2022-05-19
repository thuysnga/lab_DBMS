SET SERVEROUTPUT ON;

-- câu 1
CREATE OR REPLACE PROCEDURE factorial(val IN NUMBER, result_val OUT NUMBER)
AS
    kq NUMBER := 1;
BEGIN
    FOR i IN 1..val LOOP
        kq := kq*i;
    END LOOP;
    result_val := kq;
END;
-- execute
DECLARE
    kq NUMBER;
BEGIN
    factorial(7, kq);
    DBMS_OUTPUT.PUT_LINE('7!= ' || kq);
END;

-- câu 2
CREATE OR REPLACE PROCEDURE findStudent(stuid STUDENT.STUDENT_ID%TYPE, stu_name OUT VARCHAR2, stu_address OUT STUDENT.STREET_ADDRESS%TYPE)
AS
BEGIN
    SELECT FIRST_NAME || LAST_NAME, STREET_ADDRESS INTO stu_name, stu_address
    FROM STUDENT
    WHERE STUDENT_ID = stuid;
END;
-- execute
DECLARE
    stu_id STUDENT.STUDENT_ID%TYPE := 114;
    stu_name VARCHAR2(50);
    stu_address STUDENT.STREET_ADDRESS%TYPE;
BEGIN
    findStudent(stu_id, stu_name, stu_address);
    DBMS_OUTPUT.PUT_LINE('student name = ' || stu_name || 'student address = ' || stu_address);
END;

-- câu 3
CREATE OR REPLACE PROCEDURE print_student_info(stu_id STUDENT.STUDENT_ID%TYPE)
AS
    stu_name VARCHAR(50);
    stu_address STUDENT.STREET_ADDRESS%TYPE;
    numCourse NUMBER;
BEGIN
    findstudent(stu_id, stu_name, stu_address);
    DBMS_OUTPUT.PUT_LINE('NAME: ' || stu_name || 'Address : ' || stu_address);
    
    SELECT COUNT(COURSE_NO) INTO numcourse
    FROM ENROLLMENT e JOIN SECTION s ON e.SECTION_ID = s.SECTION_ID
    WHERE STUDENT_ID=stu_id;
    DBMS_OUTPUT.PUT_LINE('SO LUONG COURSE ENROLL: ' || numcourse);
END;
-- execute
BEGIN
    print_student_info(106);
END;

-- câu 4
-- câu 5
BEGIN
    FOR ins IN (SELECT instructor_id, salutation, first_name, last_name FROM INSTRUCTOR)
    LOOP
        DBMS_OUTPUT.PUT_LINE(ins.instructor_id || ' ' || ins.salutation || ' ' || ins.first_name || ' ' || ins.last_name);
    END LOOP;
END;

-- câu 6
CREATE OR REPLACE PROCEDURE print_employee (sal number)
AS
BEGIN
    FOR emp IN (SELECT * FROM EMPLOYEE WHERE salary > sal)
    LOOP
        DBMS_OUTPUT.PUT_LINE (emp.EMPLOYEE_ID ||emp.NAME || emp.TITLE|| emp.SALARY);
    END LOOP;
END;

-- execute
BEGIN
 print_employee (900);
END;

-- CÂU 7
DECLARE
    numstudent NUMBER;
BEGIN
    FOR itemcourse IN (SELECT * FROM COURSE) 
    LOOP
        SELECT COUNT(STUDENT_ID) INTO num_student
        FROM ENROLLMENT e JOIN  SECTION s ON e.SECTION_ID = s.SECTION_ID
        WHERE COURSE_NO=itemcourse.COURSE_NO;
        DBMS_OUTPUT.PUT_LINE('SO LUONG STUDENT: ' || numstudent);
        IF(numstudent >= 8) THEN
            UPDATE COURSE SET COST=COST*0.95 WHERE COURSE_NO=itemcourse.COURSE_NO;
            DBMS_OUTPUT.PUT_LINE('COURSE: ' || itemcourse.COURSE_NO || ' DUOC GIAM 5%');
        END IF;
    END LOOP;
END;

-- CÂU 9
DECLARE
    cursor student_cur IS SELECT * FROM STUDENT WHERE student_id<110;
    cursor student_course_cur (stuid NUMBER) IS
    SELECT c.description
    FROM COURSE c, ENROLLMENT e, SECTION s
    WHERE c.course_no=s.course_no AND e.section_id=s.section_id AND e.student_id=stuid;
BEGIN
    FOR stu IN student_cur
    LOOP
        DBMS_OUTPUT.PUT_LINE (stu.student_id || ' - ' || stu.first_name || ' - '|| stu.last_name);
        FOR cour IN student_course_cur(stu.student_id)
        LOOP
            DBMS_OUTPUT.PUT_LINE (CHR(9) || cour.description);
        END LOOP;
    END LOOP;
END;

-- câu 11
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF(INSERTING) THEN
    ELSIF(UPDATING) THEN
    END IF;
END;

-- câu 15
CREATE OR REPLACE TRIGGER employee_trg15
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    IF(:NEW.SALARY<100) THEN
        RAISE_APPLICATION_ERROR (-20000, 'SALARY CANNOT BELOW 100');
    END IF;
END;
-- call trigger
Insert into EMPLOYEE (EMPLOYEE_ID,NAME,SALARY,TITLE)
values (5,'Micheal',30,'Analyst');

-- câu 16
CREATE OR REPLACE TRIGGER TRG_EMPLOYEE
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    :NEW.NAME := INITCAP(:NEW.NAME);
END;