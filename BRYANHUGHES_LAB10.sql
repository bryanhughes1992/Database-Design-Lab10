/* QUESTION #1
 * Take an integer as an input parameter, 
 * multiply it by itself, and then multiply 
 * that by the value of ? (note: you can easily 
 * get the value of ? with the built-in function 
 * PI()). This function can calculate the area 
 * of a circle based on the radius!
 */

DELIMITER $$

CREATE FUNCTION circleArea (
	radius INT
)
RETURNS DECIMAL
BEGIN
	RETURN (radius * 2) * PI();
END; $$

DELIMITER ;

/* QUESTION #2
 * Take two strings as your input parameters. 
 * Concatenate them, starting with the longer 
 * of the two strings. (Remember - there is 
 * a built-in function for checking the length 
 * of strings.)
 */
DELIMITER $$

CREATE FUNCTION combineStrings( 
	stringOne	VARCHAR(255),
	stringTwo	VARCHAR(255)
)
RETURNS VARCHAR(255)
BEGIN
	IF (LENGTH(stringOne) > LENGTH(stringTwo))
		THEN
			RETURN CONCAT(stringOne, ' ', stringTwo);
	ELSE
		return CONCAT(stringTwo, ' ', stringOne);
	END IF;	
END $$
DELIMITER ;

/* QUESTION #3
 * Set a due date - books are due three weeks from the withdrawal date, 
 * unless that date is a Tuesday. The library has shortened hours on 
 * Tuesdays, so books withdrawn on a Tuesday are due in three weeks plus 
 * one day. Have your function return the due date based on the withdrawal 
 * date.
 */

DELIMITER $$
CREATE FUNCTION dueDate ( 
	withdrawalDate	DATE
)
RETURNS DATE
BEGIN
	DECLARE dueDate DATE DEFAULT NOW();
	IF (DAYNAME(withdrawalDate) = 'tuesday')
		THEN
			SET dueDate = DATE_ADD(dueDate, INTERVAL 22 DAY);
	ELSE
		SET dueDate = DATE_ADD(dueDate, INTERVAL 3 WEEK);
	END IF;
	RETURN dueDate;
END; $$
DELIMITER ;
	
	
/* QUESTION #4
 * Let's cleanse some data! Take a string as an input parameter. 
 * If the string begins with 'ca' (regardless of the casing), 
 * and the string is not Cabo Verde, Cambodia, or Cameroon, 
 * return 'CAN'. Otherwise, return the value of the input 
 * parameter.
 */

DELIMITER $$

CREATE FUNCTION cleanseString (
	inputString	VARCHAR(255)
)
RETURNS VARCHAR(255)
BEGIN
	DECLARE cleansedString VARCHAR(255);
	IF (LEFT(inputString, 2) = REGEXP_LIKE('^[caCA]')
		THEN
		SET cleansedString = 'CAN';
		RETURN cleansedString;
	ELSE IF (LEFT(inputString, 3) = REGEXP_LIKE('^[camCAM]') OR LEFT(inputString, 3) = '^[cabCAB]')
		return inputString;
	END IF;
END
DELIMITER ;

/* QUESTION # 5
 * Take three integers as your input parameters. 
 * Return the sum of those numbers. If arguments 
 * passed in for the first or second parameters 
 * are null, set the value of the null argument 
 * to zero. If the value of the third argument 
 * is null, throw an error.
 */

DELIMITER $$
CREATE FUNCTION sumOfThree (
	numberOne = INT,
	numberTwo = INT,
	numberThree = INT
)
RETURNS INT
BEGIN
	DECLARE	sumOfNums = INT;
	IF (numberOne IS NULL)
		THEN
			SET numberOne = 0;
	ELSE IF (numberTwo IS NULL)
		THEN
			SET numberTWO = 0;
	ELSE IF (numberThree IS NULL)
		THEN
		SIGNAL SQLSTATE '45000'
      	SET MESSAGE_TEXT = 
        'Please Input an Integer';
    END IF;
    SET sumOfNums = numberOne + numberTwo + numberThree;
  RETURN sumOfNums;
END; $$
DELIMITER ;

/* QUESTION #6
 * One kilometre is approximately 0.621371 miles. 
 * Create a function that accepts two parameters - 
 * one for the value, and one for the type of unit. 
 * This function should convert miles to kilometres, 
 * or vice-versa, rounded to six decimal places.
 */

CREATE FUNCTION convertDistance (
	distance	DECIMAL(3,6),
	convertToType	VARCHAR(11)	DEFAULT 'kilometers'
)
RETURNS DECIMAL(3,6)
DETERMINISTIC 
BEGIN
	DECLARE convertedNumber	DECIMAL(3,6);
	IF (convertToType = 'kilometers')
		THEN
			SET convertedNumber = distance / 1.621371;
	ELSE IF (convertToType = 'miles')
		THEN
			SET convertedNumber = distance * 0.621371;
	END IF;
  RETURN convertedNumber;
END; $$
DELIMITER ;

/* QUESTION #7
 * James Hoffman recommends a ratio of 60 grams
 * of ground coffee to 1 litre of water for 
 * percolation brewing, and 75 grams of coffee 
 * to 1L of water for immersion brewing. Create 
 * a function that accepts three inputs - the 
 * volume of coffee, the volume of water, and 
 * the brew type. If one or the other volume 
 * parameters are null, calculate the required 
 * volume of the null parameter based on the 
 * volume argument provided, and the brew type. 
 * If both arguments are provided, round to the 
 * nearest gram and ml, and return a response that 
 * either confirms that this is the correct ratio, 
 * or recommends an adjustment in the volume of water.
 */

CREATE FUNCTION brewingMethod (
	coffeeVolume	DECIMAL(3,2),
	waterVolume		DECIMAL(3,2),
	brewingType		VARCHAR(30)
)
RETURNS VARCHAR(255)
DETERMINISTIC 
BEGIN
	DECLARE recommendation;
	IF (brewingType = 'percolation')
		THEN 
			SET 
	ELSE IF (brewingType = 'immersion')
		THEN
	
		
END; $$

DELIMITER ;

/* QUESTION #8
 * Create a function that prints integers, 
 * counting down from 20 to 1 by twos, 
 * using a WHILE loop.
 */

DELIMITER $$

CREATE FUNCTION countdown()
RETURNS INT
DETERMINISTIC 
BEGIN 
	DECLARE countdownVar = 20;
	WHILE countdownVar > 0 DO
		SET countdownVar = countdownVar - 2;
	END WHILE;
	RETURN countdownVar;
END; $$

DELIMITER ;

/* QUESTION #9
 * Create a non-deterministic function that checks 
 * to see if a date is Friday the 13th. If a null 
 * argument is passed, it should check if today is 
 * Friday the 13th.
 */

CREATE FUNCTION checkDate(
	datePassed	DATE
)
RETURNS INT
DETERMINISTIC
BEGIN
	IF (datePassed IS NULL)
		THEN
			SET daysPassed = NOW();
			IF (DAY(datePassed) = 'friday' AND EXTRACT(DAY FROM datePassed) = 13)
				THEN
					RETURN 1;
			ELSE
				RETURN 0;
	ELSE IF (DAY(datePassed) = 'friday' AND EXTRACT(DAY FROM datePassed) = 13)
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END; $$

DELIMITER ;

/* QUESTION #10
 * Create a function to format a date as 
 * "{day name}, the {date}{ordinal indicator} of {month name}", 
 * for example, today is "Wednesday, the 18th day of November". 
 * You can use any built-in date functions except DATE_FORMAT(). 
 * Remember to use the appropriate ordinal indicator for a given 
 * number, i.e. 1st, 22nd, 23rd. 
 */ 

DELIMITER $$

CREATE FUNCTION formatString(
	day_Name	VARCHAR(255) 	DEFAULT	'Monday',
	day_Number 	INT		DEFAULT 	1,
	month_Name 	VARCHAR(255)	DEFAULT	'January'
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE formattedString VARCHAR(255);
	IF (day_Number % 100 IN (11, 12, 13))
		THEN
			SET formattedString = CONCAT(day_Name, ", the ", day_Number, "th day of ", month_Name);
	ELSE IF (day_Number % 10 = 1)
		THEN
			SET formattedString = CONCAT(day_Name, ", the ", day_Number, "st day of ", month_Name);
	ELSE IF (day_Number % 10 = 2)
		THEN
			SET formattedString = CONCAT(day_Name, ", the ", day_Number, "nd day of ", month_Name);
	ELSE IF (day_Number % 10 = 3)
		THEN
			SET formattedString = CONCAT(day_Name, ", the ", day_Number, "rd day of ", month_Name);
	ELSE
		SET formattedString = CONCAT(day_Name, ", the ", day_Number, "th day of ", month_Name);
	END IF;
  RETURN formattedString;		
END; $$

DELIMITER ;


