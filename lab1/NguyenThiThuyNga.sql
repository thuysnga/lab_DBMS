-- 1. Display all information from the customer table whose state is null.
	SELECT * 
	FROM S_CUSTOMER
	WHERE STATE IS NULL;
/* RESULT:
	ID		NAME				PHONE					ADDRESS							CITY				STATE		COUNTRY		ZIP_CODE 	CREDIT_RA 	SALES_REP_ID  REGION_ID 	COMMENTS
	---		---------		-----------		------------------	----------	-----		-------		--------	---------		------------	---------		-------------------------------------------------------------------------------------------------------------------------------
	201		Unisports		55-2066101		72 Via Bahia				Sao Paolo						Brazil							EXCELLENT		12						2						Customer usually orders large amounts and has a high order total.  This is okay as long as the credit rating remains excellent.
	202		Simms
				Athletics		81-20101			6741 Takashi Blvd.	Osaka								Japan								POOR				14						4						Customer should always pay by cash until his credit rating improves.
	203		Delhi 
				Sports			91-10351			11368 Chanakya			New Delhi						India								GOOD				14						4						Customer specializes in baseball equipment and is the largest retailer in India.
	205		Kam's 
				Sporting 
				Goods				852-3692888		15 Henessey Road		Hong Kong																EXCELLENT		15						4	
	206		Sportique		33-2257201		172 Rue de Rivoli		Cannes							France							EXCELLENT		15						5						Customer specializes in Soccer.  Likes to order accessories in bright colors.
	207		Sweet 
				Rock 
				Sports			234-6036201		6 Saint Antoine			Lagos								Nigeria							GOOD											3	
	208		Muench 
				Sports			49-527454			435 Gruenestrasse		Stuttgart						Germany							GOOD				15						5						Customer usually pays small orders by cash and large orders on credit.
	209		Beisbol 
				Si!					809-352689		792 Playa Del Mar		San Pedro 					Dominican
																											de Macon's					Republic						EXCELLENT		11						1	
	210		Futbol 
				Sonora			52-404562			3 Via Saguaro				Nogales							Mexico							EXCELLENT		12						2						Customer is difficult to reach by phone.  Try mail.
	211		Kuhn's 
				Sports			42-111292			7 Modrany						Prague							Czechoslovakia			EXCELLENT		15						5	
	212		Hamada 
				Sport				20-1209211		57A Corniche				Alexandria					Egypt								EXCELLENT		13						3						Customer orders sea and water equipment.
	215		Sporta 
				Russia			7-3892456			6000 Yekatamina			Saint Petersburg		Russia							POOR				15						5						This customer is very friendly, but has difficulty paying bills.  Insist upon cash.
*/
-- 2. Display the Employee Id, Lastname, Firstname, and start_date from the S_emp table who started working in Feb, 1991.
	SELECT ID, LAST_NAME, FIRST_NAME, START_DATE
	FROM S_EMP
	WHERE START_DATE > '31-JAN-1991'
	ORDER BY START_DATE;
/* RESULT:
	  ID LAST_NAME                 FIRST_NAME                START_DAT
	---- ------------------------- ------------------------- ---------
	  18 Nozaki                    Akira                     09-FEB-91
	  13 Sedeghi                   Yasmin                    18-FEB-91
	  10 Havel                     Marta                     27-FEB-91
	  24 Dancs                     Bela                      17-MAR-91
	  25 Schwartz                  Sylvie                    09-MAY-91
	  21 Markarian                 Alexander                 26-MAY-91
	   3 Nagayama                  Midori                    17-JUN-91
	  20 Newman                    Chad                      21-JUL-91
	  19 Patel                     Vikram                    06-AUG-91
	  15 Dumas                     Andre                     09-OCT-91
	  12 Giljum                    Henry                     18-JAN-92
	  14 Nguyen                    Mai                       22-JAN-92
	  16 Maduro                    Elena                     07-FEB-92
	   9 Catchpole                 Antoinette                09-FEB-92
*/
-- 3. Display Employee Firstname whose title is 'Stock Clerk'.
	SELECT FIRST_NAME
	FROM S_EMP
	WHERE TITLE = 'Stock Clerk';
/* RESULT:
	FIRST_NAME               
	-------------------------
	Elena
	George
	Akira
	Vikram
	Chad
	Alexander
	Eddie
	Radha
	Bela
	Sylvie
*/
-- 4. Display Products that name starts with the letter "B".
	SELECT NAME
	FROM S_PRODUCT
	WHERE NAME LIKE 'B%';
/* RESULT:
	NAME                                              
	--------------------------------------------------
	Black Hawk Elbow Pads
	Black Hawk Knee Pads
	Bunny Boot
	Bunny Ski Pole
*/
-- 5. Display Employees whose Firstname contains 'd' in the Fourth position.
	SELECT ID, LAST_NAME, FIRST_NAME
	FROM S_EMP
	WHERE FIRST_NAME LIKE '___d%';
/* RESULT:
	  ID LAST_NAME                 FIRST_NAME               
	---- ------------------------- -------------------------
	  20 Newman                    Chad                     
*/
-- 6. Display Employees Firstname and Lastname Concatenated.
	SELECT ID, FIRST_NAME ||' '|| LAST_NAME AS FULL NAME
	FROM S_EMP;
/* RESULT:
	  ID FULL NAME                                          
	---- ---------------------------------------------------
	   1 Carmen Velasquez                                   
	   2 LaDoris Ngao                                       
	   3 Midori Nagayama                                    
	   4 Mark Quick-To-See                                  
	   5 Audry Ropeburn                                     
	   6 Molly Urguhart                                     
	   7 Roberta Menchu                                     
	   8 Ben Biri                                           
	   9 Antoinette Catchpole                               
	  10 Marta Havel                                        
	  11 Colin Magee                                        
	  12 Henry Giljum                                       
	  13 Yasmin Sedeghi                                     
	  14 Mai Nguyen                                         
	  15 Andre Dumas                                        
	  16 Elena Maduro                                       
	  17 George Smith                                       
	  18 Akira Nozaki                                       
	  19 Vikram Patel                                       
	  20 Chad Newman                                        
	  21 Alexander Markarian                                
	  22 Eddie Chang                                        
	  23 Radha Patel                                        
	  24 Bela Dancs                                         
	  25 Sylvie Schwartz 
*/
-- 7. Display Employees Firstname, Start_date whose start_date falls in the month of Jan.
	SELECT FIRST_NAME, START_DATE
	FROM S_EMP
	WHERE EXTRACT(MONTH FROM START_DATE) = 1;
/* RESULT:
	FIRST_NAME                START_DAT
	------------------------- ---------
	Molly                     18-JAN-91
	Henry                     18-JAN-92
	Mai                       22-JAN-92
*/
-- 8. Display employee that have worked more than 31 years.
	SELECT ID, LAST_NAME, FIRST_NAME 
	FROM S_EMP
	WHERE MONTHS_BETWEEN(SYSDATE, START_DATE)/12 > 31;
/* RESULT:
	ID LAST_NAME                 FIRST_NAME               
	-- ------------------------- -------------------------
	 1 Velasquez                 Carmen                   
	 2 Ngao                      LaDoris                  
	 4 Quick-To-See              Mark                     
	 5 Ropeburn                  Audry                    
	 6 Urguhart                  Molly                    
	 7 Menchu                    Roberta                  
	 8 Biri                      Ben                      
	10 Havel                     Marta                    
	11 Magee                     Colin                    
	13 Sedeghi                   Yasmin                   
	17 Smith                     George                   
	18 Nozaki                    Akira                    
	22 Chang                     Eddie                    
	23 Patel                     Radha                    
	24 Dancs                     Bela                     

*/
-- 9. Display the product name, short_desc concatenated together and price is higher than 100.
	SELECT NAME || ' - ' ||SHORT_DESC AS "DETAIL PRODUCT"
	FROM S_PRODUCT
	WHERE SUGGESTED_WHLSL_PRICE > 100; 
/* RESULT:
	DETAIL PRODUCT
	--------------------------------------
	Bunny Boot - Beginner's ski boot
	Ace Ski Boot - Intermediate ski boot
	Pro Ski Boot - Advanced ski boot
	World Cup Net - World cup net
	Grand Prix Bicycle - Road bicycle
	Himalaya Bicycle - Mountain bicycle
*/
-- 10. Display customers whose phone contains two zeros.
	SELECT ID, NAME, PHONE, ADDRESS
	FROM S_CUSTOMER
	WHERE PHONE LIKE '%0%0%';
/* RESULT:
	  ID NAME                  PHONE                     ADDRESS
	---- --------------------- ------------------------- ---------
	 201 Unisports             55-2066101                72 Via Bahia
	 202 Simms Athletics       81-20101                  6741 Takashi Blvd.
	 204 Womansport            1-206-104-0103            281 King Street
	 207 Sweet Rock Sports     234-6036201               6 Saint Antoine
	 212 Hamada Sport          20-1209211                57A Corniche
*/
-- 11. Retrieve the region number, region name, and the number of departments within each region. Order the data by the region name.
	SELECT R.ID, R.NAME, COUNT(*) AS "NUM OF DEPARTMENT"
	FROM S_REGION R, S_DEPT D
	WHERE R.ID=D.REGION_ID
	GROUP BY R.ID, R.NAME;
/* RESULT:
	  ID NAME                                               NUM OF DEPARTMENT
	---- -------------------------------------------------- -----------------
	   4 Asia                                                               2
	   5 Europe                                                             2
	   2 South America                                                      2
	   1 North America                                                      4
	   3 Africa / Middle East                                               2
*/
-- 12. Display the product number and number of times it was ordered, labeled Times Ordered. Only show those products that have been ordered at least three times. Order the data by the number of products ordered.
	SELECT P.ID, P.NAME, COUNT(O.ID) AS "Times Ordered"
	FROM S_ITEM I, S_ORD O, S_PRODUCT P
	WHERE I.ORD_ID = O.ID
    AND I.PRODUCT_ID = P.ID
	GROUP BY P.ID, P.NAME
	HAVING COUNT(O.ID) >= 3
	ORDER BY P.ID;
/* RESULT:
	    ID	NAME                              Times Ordered
	------	--------------------------------- -------------
	 20106	Junior Soccer Ball                            3
	 20108	World Cup Soccer Ball                         3
	 20201	World Cup Net                                 3
	 20510	Black Hawk Knee Pads                          3
	 20512	Black Hawk Elbow Pads                         3
	 30321	Grand Prix Bicycle                            4
	 30421	Grand Prix Bicycle Tires                      3
	 50273	Chapman Helmet                                3
*/
-- 13. How many employees each manager has. Show manager id, name, and number employee.
	SELECT 	E1.ID, E1.LAST_NAME || ' ' || E1.FIRST_NAME AS "MANAGER NAME", 
					COUNT(*) AS "NUM EMPLOYEE"
	FROM S_EMP E1, S_EMP E2
	WHERE E1.ID = E2.MANAGER_ID
	GROUP BY E1.ID, E1.LAST_NAME, E1.FIRST_NAME;
/* RESULT:
	  ID MANAGER NAME                NUM EMPLOYEE
	---- --------------------------- ------------
	  10 Havel Marta                            2
	   2 Ngao LaDoris                           5
	   6 Urguhart Molly                         2
	   7 Menchu Roberta                         2
	   9 Catchpole Antoinette                   2
	   3 Nagayama Midori                        5
	   8 Biri Ben                               2
	   1 Velasquez Carmen                       4
*/
-- 14. Which regions have more than 3 customers.
	SELECT ID, NAME
	FROM S_REGION
	WHERE ID IN (
		SELECT REGION_ID
		FROM S_CUSTOMER
		GROUP BY REGION_ID
		HAVING COUNT(ID) > 3
	);
/* RESULT:
	  ID NAME                         
	---- -----------------------------
	   5 Europe                       
	   1 North America   
*/