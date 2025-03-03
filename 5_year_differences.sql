USE pandemic;

-- 5. Creating a custom function to calculate year difference
DROP FUNCTION IF EXISTS calculate_year_difference;

DELIMITER //

CREATE FUNCTION calculate_year_difference(input_year INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE year_date DATE;
    DECLARE year_diff INT;
    
    -- Convert input year to date (January 1st of that year)
    SET year_date = STR_TO_DATE(CONCAT(input_year, '-01-01'), '%Y-%m-%d');
    
    -- Calculate difference in years between current date and the created date
    SET year_diff = TIMESTAMPDIFF(YEAR, year_date, CURDATE());
    
    RETURN year_diff;
END //

DELIMITER ;

-- Test the function with sample data
SELECT 
    dc.year,
    STR_TO_DATE(CONCAT(dc.year, '-01-01'), '%Y-%m-%d') AS year_date,
    CURDATE() AS today_date,
    calculate_year_difference(dc.year) AS years_difference
FROM 
    disease_cases dc
LIMIT 20;