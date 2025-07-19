CREATE OR ALTER PROCEDURE scd_type_0
AS
BEGIN
    SET NOCOUNT ON;

    -- Only insert new records, never update existing ones
    INSERT INTO dim_customer (customer_id, customer_name, city)
    SELECT s.customer_id, s.customer_name, s.city
    FROM stg_customer s
    LEFT JOIN dim_customer d ON s.customer_id = d.customer_id
    WHERE d.customer_id IS NULL;
END;

EXEC scd_type_0;

