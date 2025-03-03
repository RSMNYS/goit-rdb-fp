USE pandemic;

DROP TABLE IF EXISTS disease_cases;
DROP TABLE IF EXISTS entities;

-- 2. Normalize the table to 3rd normal form
-- Create entities table (1st normalized table)
CREATE TABLE entities (
    entity_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    entity_name VARCHAR(255) NOT NULL,
    code VARCHAR(10) NOT NULL,
    UNIQUE(entity_name, code)
);


CREATE TABLE disease_cases (
    case_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_id INT NOT NULL,
    year INT NOT NULL,
    number_yaws DECIMAL(20,10),
    polio_cases DECIMAL(20,10),
    cases_guinea_worm DECIMAL(20,10),
    number_rabies DECIMAL(20,10),
    number_malaria DECIMAL(20,10),
    number_hiv DECIMAL(20,10),
    number_tuberculosis DECIMAL(20,10),
    number_smallpox DECIMAL(20,10),
    number_cholera_cases DECIMAL(20,10),
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);

-- Populate the entities table with unique entity-code pairs
INSERT INTO entities (entity_name, code)
SELECT DISTINCT Entity, Code
FROM infectious_cases;


-- Populate the table with NULL handling
INSERT INTO disease_cases (
    entity_id, year, number_yaws, polio_cases, cases_guinea_worm,
    number_rabies, number_malaria, number_hiv, number_tuberculosis,
    number_smallpox, number_cholera_cases
)
SELECT 
    e.entity_id,
    ic.Year,
    NULLIF(ic.Number_yaws, ''),
    NULLIF(ic.polio_cases, ''),
    NULLIF(ic.cases_guinea_worm, ''),
    NULLIF(ic.Number_rabies, ''),
    NULLIF(ic.Number_malaria, ''),
    NULLIF(ic.Number_hiv, ''),
    NULLIF(ic.Number_tuberculosis, ''),
    NULLIF(ic.Number_smallpox, ''),
    NULLIF(ic.Number_cholera_cases, '')
FROM infectious_cases ic
JOIN entities e ON ic.Entity = e.entity_name AND ic.Code = e.code;

SELECT * FROM disease_cases
LIMIT 10;