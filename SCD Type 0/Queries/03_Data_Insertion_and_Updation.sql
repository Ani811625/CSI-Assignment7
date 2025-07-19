-- Insertion into staging
INSERT INTO stg_customer VALUES (1, 'John Doe', 'Delhi'), (2, 'Jane Smith', 'Mumbai');

-- Initial load into dimension
INSERT INTO dim_customer SELECT * FROM stg_customer;

-- Now staging has updated city
TRUNCATE TABLE stg_customer;
INSERT INTO stg_customer VALUES (1, 'John Doe', 'Kolkata'); -- updated city

SELECT * FROM stg_customer;
SELECT * FROM dim_customer;
