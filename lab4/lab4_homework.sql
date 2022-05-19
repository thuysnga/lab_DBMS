-- câu 1
CREATE
OR REPLACE PROCEDURE num_stu(
    in_section_id IN SECTION.SECTION_ID % TYPE,
    out_course_no OUT COURSE.course_no % TYPE,
    out_description OUT COURSE.DESCRIPTION % TYPE,
    out_cost OUT COURSE.COST % TYPE
) 
AS 
BEGIN
SELECT
    COURSE.COURSE_NO,
    COURSE.DESCRIPTION,
    COURSE.COST INTO out_course_no,
    out_description,
    out_cost
FROM
    SECTION
    INNER JOIN COURSE ON SECTION.COURSE_NO = COURSE.COURSE_NO
WHERE
    SECTION.SECTION_ID = in_section_id;

END;

-- gọi hàm
DECLARE in_sec_id SECTION.SECTION_ID % TYPE := 106;

out_course_no COURSE.course_no % TYPE;

out_description COURSE.DESCRIPTION % TYPE;

out_cost COURSE.COST % TYPE;

BEGIN num_stu(
    in_sec_id,
    out_course_no,
    out_description,
    out_cost
);

DBMS_OUTPUT.PUT_LINE(
    'course_no = ' || out_course_no || 'description = ' || out_description || 'cost = ' || out_cost
);

END;

-- câu 2
CREATE
OR REPLACE PROCEDURE up_salary AS res_title EMPLOYEE.TITLE % TYPE;

CURSOR cur_emp IS
SELECT
    EMPLOYEE.EMPLOYEE_ID,
    EMPLOYEE.TITLE,
    EMPLOYEE.SALARY
FROM
    EMPLOYEE;

BEGIN FOR row_emp IN cur_emp LOOP IF row_emp.TITLE = 'Analyst' THEN
UPDATE
    EMPLOYEE
SET
    SALARY = SALARY + SALARY * 0.1
WHERE
    EMPLOYEE.EMPLOYEE_ID = row_emp.EMPLOYEE_ID;

ELSIF row_emp.TITLE = 'Janitor' THEN
UPDATE
    EMPLOYEE
SET
    SALARY = SALARY + SALARY * 0.5
WHERE
    EMPLOYEE.EMPLOYEE_ID = row_emp.EMPLOYEE_ID;

ELSE
UPDATE
    EMPLOYEE
SET
    SALARY = SALARY + SALARY * 0.2
WHERE
    EMPLOYEE.EMPLOYEE_ID = row_emp.EMPLOYEE_ID;

END IF;

END LOOP;

END;

-- câu 3
DECLARE CURSOR cur_one IS
SELECT
    EMPLOYEE_ID,
    NAME,
    SALARY
FROM
    EMPLOYEE;

CURSOR cur_two IS
SELECT
    EMPLOYEE_CHANGE.SALARY,
    EMPLOYEE_CHANGE.TITLE
FROM
    EMPLOYEE_CHANGE
    INNER JOIN EMPLOYEE ON EMPLOYEE_CHANGE.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID;

BEGIN FOR row_emp IN cur_one LOOP DBMS_OUTPUT.PUT_LINE(
    'employee_id = ' || row_emp.EMPLOYEE_ID || 'name: ' || row_emp.NAME || 'salary: ' || row_emp.SALARY
);

END LOOP;

FOR row_emp_change IN cur_two LOOP DBMS_OUTPUT.PUT_LINE(
    'employee_change salary = ' || row_emp_change.SALARY || 'title: ' || row_emp_change.TITLE
);

END LOOP;

END;

-- câu 4
CREATE
OR REPLACE TRIGGER trg_employee_change BEFORE
INSERT
    OR
UPDATE
    ON EMPLOYEE_CHANGE FOR EACH ROW BEGIN :NEW.TITLE := LOWER(:NEW.TITLE);

END;

INSERT INTO
    EMPLOYEE_CHANGE (EMPLOYEE_ID, NAME, SALARY, TITLE)
VALUES
    (7, 'Triss', 1500, 'programmer');

UPDATE
    EMPLOYEE_CHANGE
SET
    NAME = 'Triss'
WHERE
    EMPLOYEE_ID = 1;