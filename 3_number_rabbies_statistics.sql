USE pandemic;

-- 3. Analyze the data - calculate statistics for Number_rabies
SELECT 
    e.entity_name,
    e.code,
    AVG(dc.number_rabies) AS average_rabies,
    MIN(dc.number_rabies) AS min_rabies,
    MAX(dc.number_rabies) AS max_rabies,
    SUM(dc.number_rabies) AS total_rabies
FROM 
    disease_cases dc
JOIN 
    entities e ON dc.entity_id = e.entity_id
WHERE 
    dc.number_rabies IS NOT NULL
GROUP BY 
    e.entity_name, e.code
ORDER BY 
    average_rabies DESC
LIMIT 10;