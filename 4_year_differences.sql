USE pandemic;

-- 4. Creating date attributes and year difference
SELECT 
    dc.year,
    STR_TO_DATE(CONCAT(dc.year, '-01-01'), '%Y-%m-%d') AS year_date,
    CURDATE() AS today_date,
    TIMESTAMPDIFF(YEAR, 
                 STR_TO_DATE(CONCAT(dc.year, '-01-01'), '%Y-%m-%d'), 
                 CURDATE()) AS years_difference
FROM 
    disease_cases dc
LIMIT 20;