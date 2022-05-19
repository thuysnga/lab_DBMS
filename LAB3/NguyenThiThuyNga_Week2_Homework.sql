-- cau 1
CREATE OR REPLACE PROCEDURE count_student(give_section IN SECTION.SECTION_ID%TYPE) 
AS
    num_stu NUMBER;
BEGIN
    SELECT COUNT(*) INTO num_stu
    FROM SECTION
    INNER JOIN ENROLLMENT ON SECTION.SECTION_ID = ENROLLMENT.SECTION_ID
    WHERE SECTION.SECTION_ID = give_section 
    AND EXTRACT(MONTH FROM ENROLL_DATE) = '2'
    AND EXTRACT(YEAR FROM ENROLL_DATE) = '2007';
    
    IF num_stu > 10 THEN
        RAISE_APPLICATION_ERROR(-20201, 'too many students');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Num student: ' || num_stu);
    END IF;
END;

set serveroutput on;

BEGIN
    count_student(101);
END;

BEGIN
    count_student(112);
END;

-- cau 2
CREATE OR REPLACE FUNCTION count_course(stu_id IN STUDENT.STUDENT_ID%TYPE) RETURN NUMBER
AS
    num_courses NUMBER;
BEGIN
    SELECT COUNT(COURSE_NO) INTO num_courses
    FROM ENROLLMENT
    INNER JOIN SECTION ON ENROLLMENT.SECTION_ID = SECTION.SECTION_ID
    WHERE ENROLLMENT.STUDENT_ID = stu_id;
    
    RETURN num_courses;
END;

CREATE OR REPLACE PROCEDURE print_stuname(stu_id IN STUDENT.STUDENT_ID%TYPE)
AS
    name_stu VARCHAR2(50);
BEGIN
    SELECT STUDENT.FIRST_NAME || STUDENT.LAST_NAME INTO name_stu
    FROM STUDENT
    WHERE STUDENT.STUDENT_ID = stu_id;
    
    DBMS_OUTPUT.PUT_LINE('Student name: ' || name_stu);
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Student is not exist');
END;

BEGIN
    print_stuname(106);
END;

BEGIN
    print_stuname(25);
END;


-- cau 4
CREATE OR REPLACE FUNCTION get_info(give_course IN COURSE.COURSE_NO%TYPE) RETURN SYS_REFCURSOR
AS
    c_info_course SYS_REFCURSOR; 
BEGIN
    OPEN c_info_course FOR 
    SELECT * 
    FROM COURSE 
    WHERE COURSE.COURSE_NO = give_course;
    
    RETURN c_info_course;
END;

-- CALL FUNCTION
DECLARE
    c_info_course SYS_REFCURSOR;
    course_row COURSE%ROWTYPE;
BEGIN
    c_info_course := get_info(10);
    LOOP
        FETCH c_info_course INTO course_row;
        EXIT WHEN c_info_course%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('description: ' || course_row.DESCRIPTION || 'cost: ' || course_row.COST || 'created by: ' || course_row.CREATED_BY);
    END LOOP;
    CLOSE c_info_course;
END;

-- cau 5
CREATE OR REPLACE PROCEDURE insert_cour(cour_no IN COURSE.COURSE_NO%TYPE, descript IN COURSE.DESCRIPTION%TYPE, course_cost IN COURSE.COST%TYPE, pre IN COURSE.PREREQUISITE%TYPE, createby IN COURSE.CREATED_BY%TYPE, createddate IN COURSE.CREATED_DATE%TYPE, modifiedby IN COURSE.MODIFIED_BY%TYPE, modifiedbdate IN COURSE.MODIFIED_DATE%TYPE)
AS
    courseno COURSE.COURSE_NO%TYPE;
BEGIN
    SELECT COURSE_NO INTO courseno
    FROM COURSE
    WHERE COURSE_NO = cour_no;
    DBMS_OUTPUT.PUT_LINE('COURSE NO IS EXSIST!');

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        BEGIN
            INSERT INTO course VALUES (cour_no, descript, course_cost, pre, createby, createddate, modifiedby, modifiedbdate);
            DBMS_OUTPUT.PUT_LINE('INSERT SUCCESSFULLY!');
        END;
END;

BEGIN
    insert_cour(99,'Technology Concepts',1195 , NULL,'DSCHERER','29-MAR-2007','ARISCHER','05-APR-2007');
END;
/
BEGIN
    insert_cour(78,'Technology Concepts',1195 , NULL,'DSCHERER','29-MAR-2007','ARISCHER','05-APR-2007');
END;