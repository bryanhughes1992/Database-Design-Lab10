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
	RETURN radius * 2 / PI();
END; $$