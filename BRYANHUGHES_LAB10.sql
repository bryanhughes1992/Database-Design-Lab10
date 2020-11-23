/*
 * QUESTION #1
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

/*
 * QUESTION #2
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

SELECT combineStrings(Bryan, Hughes)
FROM dual;


