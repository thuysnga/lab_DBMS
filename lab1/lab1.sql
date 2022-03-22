-- 1. Display the user id for employee 23.
    SELECT USERID
    FROM S_EMP
    WHERE ID=23;
/* RESULT:
    USERID  
    --------
    rpatel
*/

-- 2. Display the first name, last name, and department number of the employees in departments 10 and 50 in alphabetical order of last name. Merge the first name and last name together, and title the column Employees.(Use ‘||’ to merge columns).
    SELECT FIRST_NAME ||' '|| LAST_NAME AS EMPLOYEES, DEPT_ID
    FROM S_EMP
    WHERE DEPT_ID IN (10,50)
    ORDER BY LAST_NAME;
/* RESULT:
    EMPLOYEES                                              DEPT_ID
    --------------------------------------------------- ----------
    Mark Quick-To-See                                           10
    Audry Ropeburn                                              50
    Carmen Velasquez                                            50
*/

-- 3. Display all employees whose last names contain an “s”. 
    SELECT * 
    FROM S_EMP
    WHERE LAST_NAME LIKE '%s%';
/* RESULT:
    ID  LAST_NAME   FIRST_NAME      USERID      START_DATE   COMMENTS    MANAGER_ID  TITLE                   DEPT_ID     SALARY  COMMISSION_PCT
    --  ---------   -----------     --------    --------    -------     ---------   --------------------    -------     ------  ---------------
    1   Velasquez   Carmen          cvelasqu    03-MAR-90                           President               50          2500    
    15  Dumas       Andre           adumas      09-OCT-91               3           Sales Representative    35          1450    17.5
    24  Dancs       Bela            bdancs      17-MAR-91               10          Stock Clerk             45          860 
*/

-- 4. Display the user ids and start date of employees hired between May 5,1990 and May 26, 1991. Order the query results by start date ascending order.
    SELECT USERID
    FROM S_EMP
    WHERE START_DATE BETWEEN '5-MAY-1990' AND '26-MAY-1991'
    ORDER BY START_DATE ASC;
/* RESULT:
    USERID  
    --------
    rmenchu
    cmagee
    rpatel
    echang
    murguhar
    anozaki
    ysedeghi
    mhavel
    bdancs
    sschwart
    amarkari
*/

-- 5. Write a query to show the last name and salary of all employees who are not making between 1000 and 2500 per month.
    SELECT LAST_NAME, SALARY
    FROM S_EMP 
    WHERE SALARY < 1000 OR SALARY > 2500;
/* RESULT:
    LAST_NAME                     SALARY
    ------------------------- ----------
    Smith                            940
    Patel                            795
    Newman                           750
    Markarian                        850
    Chang                            800
    Patel                            795
    Dancs                            860
*/

-- 6. List the last name and salary of employees who earn more than 1350 who are in department 31, 42, or 50. Label the last name column Employee Name, and label the salary column Monthly Salary. 
    SELECT LAST_NAME, SALARY
    FROM S_EMP
    WHERE SALARY>1350 AND DEPT_ID IN (31, 42, 50);
/* RESULT:
    LAST_NAME                     SALARY
    ------------------------- ----------
    Velasquez                       2500
    Nagayama                        1400
    Ropeburn                        1550
    Magee                           1400
*/

-- 7. Display the last name and start date of every employee who was hired in 1991. 
    SELECT LAST_NAME, START_DATE
    FROM S_EMP
    WHERE EXTRACT(YEAR FROM START_DATE) = '1991';
/* RESULT:
    LAST_NAME                 START_DAT
    ------------------------- ---------
    Nagayama                  17-JUN-91
    Urguhart                  18-JAN-91
    Havel                     27-FEB-91
    Sedeghi                   18-FEB-91
    Dumas                     09-OCT-91
    Nozaki                    09-FEB-91
    Patel                     06-AUG-91
    Newman                    21-JUL-91
    Markarian                 26-MAY-91
    Dancs                     17-MAR-91
    Schwartz                  09-MAY-91
*/

-- 8. Display the employee number, last name, and salary increased by 15% and expressed as a whole number 
    SELECT ID, LAST_NAME, SALARY*1.15 AS "whole number"
    FROM S_EMP;
/* RESULT:
            ID LAST_NAME                 whole number
    ---------- ------------------------- ------------
             1 Velasquez                         2875
             2 Ngao                            1667.5
             3 Nagayama                          1610
             4 Quick-To-See                    1667.5
             5 Ropeburn                        1782.5
             6 Urguhart                          1380
             7 Menchu                          1437.5
             8 Biri                              1265
             9 Catchpole                         1495
            10 Havel                          1503.05
            11 Magee                             1610
            12 Giljum                          1713.5
            13 Sedeghi                        1742.25
            14 Nguyen                         1753.75
            15 Dumas                           1667.5
            16 Maduro                            1610
            17 Smith                             1081
            18 Nozaki                            1380
            19 Patel                           914.25
            20 Newman                           862.5
            21 Markarian                        977.5
            22 Chang                              920
            23 Patel                           914.25
            24 Dancs                              989
            25 Schwartz                          1265
*/

-- 9. Display the employee last name and title in parentheses for all employees. The report should look like the output below.
    SELECT LAST_NAME || '(' || TITLE || ')' AS EMPLOYEE
    FROM S_EMP;
/* RESULT:
    EMPLOYEE                                            
    ----------------------------------------------------
    Velasquez(President)
    Ngao(VP, Operations)
    Nagayama(VP, Sales)
    Quick-To-See(VP, Finance)
    Ropeburn(VP, Administration)
    Urguhart(Warehouse Manager)
    Menchu(Warehouse Manager)
    Biri(Warehouse Manager)
    Catchpole(Warehouse Manager)
    Havel(Warehouse Manager)
    Magee(Sales Representative)
    Giljum(Sales Representative)
    Sedeghi(Sales Representative)
    Nguyen(Sales Representative)
    Dumas(Sales Representative)
    Maduro(Stock Clerk)
    Smith(Stock Clerk)
    Nozaki(Stock Clerk)
    Patel(Stock Clerk)
    Newman(Stock Clerk)
    Markarian(Stock Clerk)
    Chang(Stock Clerk)
    Patel(Stock Clerk)
    Dancs(Stock Clerk)
    Schwartz(Stock Clerk)
*/

-- 10. Display the product name for products that have “ski” in the name.
    SELECT NAME
    FROM S_PRODUCT
    WHERE LOWER(NAME) LIKE '%ski%';
/* RESULT:
    NAME                                              
    --------------------------------------------------
    Ace Ski Boot
    Ace Ski Pole
    Bunny Ski Pole
    Pro Ski Boot
    Pro Ski Pole
*/

-- 11. For each employee, calculate the number of months between today and the date the employee was hired. Order your result by the number of months employed. Round the number of months up to the closest whole number. (use the MONTHS_BETWEEN and ROUND function).
    SELECT ID, LAST_NAME, FIRST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, START_DATE)) NUM_OF_MONTHS
    FROM S_EMP
    ORDER BY NUM_OF_MONTHS
/* RESULT:
            ID LAST_NAME                 FIRST_NAME                NUM_OF_MONTHS
    ---------- ------------------------- ------------------------- -------------
            16 Maduro                    Elena                               361
             9 Catchpole                 Antoinette                          361
            14 Nguyen                    Mai                                 362
            12 Giljum                    Henry                               362
            15 Dumas                     Andre                               365
            19 Patel                     Vikram                              367
            20 Newman                    Chad                                368
             3 Nagayama                  Midori                              369
            25 Schwartz                  Sylvie                              370
            21 Markarian                 Alexander                           370
            24 Dancs                     Bela                                372
            10 Havel                     Marta                               373
            13 Sedeghi                   Yasmin                              373
            18 Nozaki                    Akira                               373
             6 Urguhart                  Molly                               374
            22 Chang                     Eddie                               376
            23 Patel                     Radha                               377
             7 Menchu                    Roberta                             382
            11 Magee                     Colin                               382
             4 Quick-To-See              Mark                                383
             8 Biri                      Ben                                 383
             1 Velasquez                 Carmen                              384
            17 Smith                     George                              384
             2 Ngao                      LaDoris                             384
             5 Ropeburn                  Audry                               384
*/

-- 12. Display the highest and lowest order totals in the S_ORD. Label the columns Highest and Lowest, respectively.
    SELECT MAX(TOTAL) AS Highest, MIN(TOTAL) AS Lowest
    FROM S_ORD;
/* RESULT:
       HIGHEST     LOWEST
    ---------- ----------
       1020935        377
*/

-- 13. Display the product name, product number, and quantity ordered of all items in order number 101. Label the quantity column ORDERED.
    SELECT NAME, P.ID, QUANTITY ORDERED
    FROM S_PRODUCT P, S_ITEM I
    WHERE P.ID=I.PRODUCT_ID
    AND I.ORD_ID=101;
/* RESULT:
    NAME                                                       ID    ORDERED
    -------------------------------------------------- ---------- ----------
    Cabrera Bat                                             50530         50
    Grand Prix Bicycle Tires                                30421         15
    Griffey Glove                                           50417         27
    Major League Baseball                                   50169         40
    Pro Curling Bar                                         40422         30
    Prostar 10 Pound Weight                                 41010         20
    Prostar 100 Pound Weight                                41100         35
*/

-- 14. Display the customer number and the last name of their sales representative. Order the list by last name.
    SELECT C.ID, E.LAST_NAME
    FROM S_CUSTOMER C, S_EMP E
    WHERE C.SALES_REP_ID=E.ID;
/* RESULT:
            ID LAST_NAME                
    ---------- -------------------------
           209 Magee                    
           214 Magee                    
           204 Magee                    
           213 Magee                    
           201 Giljum                   
           210 Giljum                   
           212 Sedeghi                  
           203 Nguyen                   
           202 Nguyen                   
           211 Dumas                    
           206 Dumas  
           205 Dumas                    
           215 Dumas                    
           208 Dumas 
*/

-- 15. Display the customer number, customer name, and order number of all customers and their orders. Display the customer number and name, even if they have not placed an order.f
    SELECT C.ID "CUSTOMER NUMER ", C.NAME, O.ID "ORDER NUMBER"
    FROM S_CUSTOMER C LEFT JOIN S_ORD O ON C.ID=O.CUSTOMER_ID;
/* RESULT:
    CUSTOMER NUMER  NAME                                               ORDER NUMBER
    --------------- -------------------------------------------------- ------------
                201 Unisports                                                    97
                202 Simms Athletics                                              98
                203 Delhi Sports                                                 99
                204 Womansport                                                  100
                204 Womansport                                                  111
                205 Kam's Sporting Goods                                        101
                206 Sportique                                                   102
                207 Sweet Rock Sports                                              
                208 Muench Sports                                               103
                208 Muench Sports                                               104
                209 Beisbol Si!                                                 105
                210 Futbol Sonora                                               112
                210 Futbol Sonora                                               106
                211 Kuhn's Sports                                               107
                212 Hamada Sport                                                108
                213 Big John's Sports Emporium                                  109
                214 Ojibway Retail                                              110
                215 Sporta Russia                                                  
*/

-- 16. Display all employees by last name and employee number along with their manager’s last name and manager number. 
    SELECT NV.ID EMPID, NV.LAST_NAME EMPNAME, QLY.ID MANAGERID, QLY.LAST_NAME MANAGERNAME
    FROM S_EMP NV JOIN S_EMP QLY ON NV.MANAGER_ID=QLY.ID;
/* RESULT:
         EMPID EMPNAME                    MANAGERID MANAGERNAME              
    ---------- ------------------------- ---------- -------------------------
             5 Ropeburn                           1 Velasquez                
             4 Quick-To-See                       1 Velasquez                
             3 Nagayama                           1 Velasquez                
             2 Ngao                               1 Velasquez                
             9 Catchpole                          2 Ngao                     
             8 Biri                               2 Ngao                     
             7 Menchu                             2 Ngao                     
             6 Urguhart                           2 Ngao                     
            10 Havel                              2 Ngao                     
            13 Sedeghi                            3 Nagayama                 
            15 Dumas                              3 Nagayama 
            14 Nguyen                             3 Nagayama                 
            12 Giljum                             3 Nagayama                 
            11 Magee                              3 Nagayama                 
            16 Maduro                             6 Urguhart                 
            17 Smith                              6 Urguhart                 
            19 Patel                              7 Menchu                   
            18 Nozaki                             7 Menchu                   
            20 Newman                             8 Biri                     
            21 Markarian                          8 Biri                     
            23 Patel                              9 Catchpole                
            22 Chang                              9 Catchpole
            25 Schwartz                          10 Havel                    
            24 Dancs                             10 Havel
*/

-- 17. Display all customers and the product number and quantities they ordered for those customers whose order totaled more than 100000.
    SELECT C.ID, C.NAME, I.PRODUCT_ID
    FROM S_CUSTOMER C, S_ORD O, S_ITEM I
    WHERE   C.ID=O.CUSTOMER_ID
    AND     O.ID=I.ORD_ID
    AND     TOTAL>100000;
/* RESULT:
            ID NAME                                               PRODUCT_ID
    ---------- -------------------------------------------------- ----------
           204 Womansport                                              10011
           204 Womansport                                              10013
           204 Womansport                                              10021
           204 Womansport                                              10023
           204 Womansport                                              30326
           204 Womansport                                              30433
           204 Womansport                                              41010
           211 Kuhn's Sports                                           20106
           211 Kuhn's Sports                                           20108
           211 Kuhn's Sports                                           20201
           211 Kuhn's Sports                                           30321
           211 Kuhn's Sports                                           30421
           212 Hamada Sport                                            20510
           212 Hamada Sport                                            20512
           212 Hamada Sport                                            30321
           212 Hamada Sport                                            32779
           212 Hamada Sport                                            32861
           212 Hamada Sport                                            41080
           212 Hamada Sport                                            41100
           213 Big John's Sports Emporium                              10011
           213 Big John's Sports Emporium                              10012
           213 Big John's Sports Emporium                              10022
           213 Big John's Sports Emporium                              30326
           213 Big John's Sports Emporium                              30426
           213 Big John's Sports Emporium                              32861
           213 Big John's Sports Emporium                              50418
*/

-- 18. Display the id, full name of all employees with no manager. 
    SELECT ID, FIRST_NAME ||' '|| LAST_NAME AS "FULL NAME"
    FROM S_EMP
    WHERE MANAGER_ID IS NULL;
/* RESULT:
            ID FULL NAME                                          
    ---------- ---------------------------------------------------
             1 Carmen Velasquez                                   

*/

-- 19. Alphabetically display all products having a name beginning with Pro. 
    SELECT *
    FROM S_PRODUCT
    WHERE NAME LIKE 'Pro%';
/* RESULT:
       ID   NAME                        SHORT_DESC                  SUGGESTED_WHLSL_PRICE   WHLSL_UNITS
    -----   ------------------------    --------------------------  --------------------    --------------
    40422   Pro Curling Bar             Curling bar                 50  
    10013   Pro Ski Boot                Advanced ski boot           410 
    10023   Pro Ski Pole                Advanced ski pole           40.95   
    41010   Prostar 10 Pound Weight     Ten pound weight            8   
    41100   Prostar 100 Pound Weight    One hundred pound weight    45  
    41020   Prostar 20 Pound Weight     Twenty pound weight         12  
    41050   Prostar 50 Pound Weight     Fifty pound weight          25  
    41080   Prostar 80 Pound Weight     Eighty pound weight         35  
*/

-- 20. Display all product ids, names and short descriptions (short_desc) for all descriptions containing the word bicycle. 
    SELECT ID, NAME, SHORT_DESC
    FROM S_PRODUCT
    WHERE SHORT_DESC LIKE '%bicycle%';
/* RESULT:
            ID NAME                                               SHORT_DESC
    ---------- -------------------------------------------------- ---------------
         30321 Grand Prix Bicycle                                 Road bicycle
         30326 Himalaya Bicycle                                   Mountain bicycle
         30421 Grand Prix Bicycle Tires                           Road bicycle tires
         30426 Himalaya Tires                                     Mountain bicycle tires
*/

-- 21. Determine the number of managers without listing them. 
    SELECT COUNT(DISTINCT MANAGER_ID)
    FROM S_EMP;
/* RESULT:
    COUNT(DISTINCTMANAGER_ID)
    -------------------------
                            8
*/

-- 22. Display the customer name, phone, and the number of orders for each customer. 
    SELECT C.NAME, C.PHONE, COUNT(O.ID) AS "number of orders"
    FROM S_CUSTOMER C, S_ORD O
    WHERE C.ID=O.CUSTOMER_ID
    GROUP BY C.ID, C.NAME, C.PHONE;
/* RESULT:
    NAME                                               PHONE                     number of orders
    -------------------------------------------------- ------------------------- ----------------
    Big John's Sports Emporium                         1-415-555-6281                           1
    Unisports                                          55-2066101                               1
    Womansport                                         1-206-104-0103                           2
    Kuhn's Sports                                      42-111292                                1
    Simms Athletics                                    81-20101                                 1
    Delhi Sports                                       91-10351                                 1
    Sportique                                          33-2257201                               1
    Hamada Sport                                       20-1209211                               1
    Muench Sports                                      49-527454                                2
    Kam's Sporting Goods                               852-3692888                              1
    Beisbol Si!                                        809-352689                               1
    Futbol Sonora                                      52-404562                                2
    Ojibway Retail                                     1-716-555-7171                           1
*/

-- 23. Display the employee number, first name, last name, and user name for all employees with salaries above the average salary. 
    SELECT ID, FIRST_NAME, LAST_NAME, USERID
    FROM S_EMP
    WHERE SALARY > (
        SELECT AVG(SALARY)
        FROM S_EMP
    );
/* RESULT:
            ID FIRST_NAME                LAST_NAME                 USERID  
    ---------- ------------------------- ------------------------- --------
             1 Carmen                    Velasquez                 cvelasqu
             2 LaDoris                   Ngao                      lngao   
             3 Midori                    Nagayama                  mnagayam
             4 Mark                      Quick-To-See              mquickto
             5 Audry                     Ropeburn                  aropebur
             9 Antoinette                Catchpole                 acatchpo
            10 Marta                     Havel                     mhavel  
            11 Colin                     Magee                     cmagee  
            12 Henry                     Giljum                    hgiljum 
            13 Yasmin                    Sedeghi                   ysedeghi
            14 Mai                       Nguyen                    mnguyen
            15 Andre                     Dumas                     adumas  
            16 Elena                     Maduro                    emaduro 
*/

-- 24. Display the employee number, first name, and last name for all employees with a salary above the average salary and that work with any employee with a last name that contains a “t”. 
    SELECT ID, FIRST_NAME, LAST_NAME, USERID
    FROM S_EMP
    WHERE SALARY > (
        SELECT AVG(SALARY)
        FROM S_EMP
    )
    AND DEPT_ID IN (
        SELECT DEPT_ID 
        FROM S_EMP
        WHERE LAST_NAME LIKE'%t%'
    );
/* RESULT:
            ID FIRST_NAME                LAST_NAME                 USERID  
    ---------- ------------------------- ------------------------- --------
             2 LaDoris                   Ngao                      lngao   
            16 Elena                     Maduro                    emaduro 
             9 Antoinette                Catchpole                 acatchpo
            14 Mai                       Nguyen                    mnguyen 
            10 Marta                     Havel                     mhavel  
*/

-- 25. Write a query to display the minimum, maximum, and average salary for each job type ordered alphabetically.
    SELECT TITLE, MIN(SALARY), MAX(SALARY), AVG(SALARY)
    FROM S_EMP
    GROUP BY TITLE
    ORDER BY TITLE;
/* RESULT:
    TITLE                     MIN(SALARY) MAX(SALARY) AVG(SALARY)
    ------------------------- ----------- ----------- -----------
    President                        2500        2500        2500
    Sales Representative             1400        1525        1476
    Stock Clerk                       750        1400         949
    VP, Administration               1550        1550        1550
    VP, Finance                      1450        1450        1450
    VP, Operations                   1450        1450        1450
    VP, Sales                        1400        1400        1400
    Warehouse Manager                1100        1307      1231.4
*/