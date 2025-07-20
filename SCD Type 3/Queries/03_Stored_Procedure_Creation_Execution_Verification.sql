CREATE PROCEDURE Update_SCD_Type3
    @emp_id INT,
    @emp_name VARCHAR(100),
    @new_city VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Employee_SCD3
        WHERE emp_id = @emp_id
    )
    BEGIN
        DECLARE @old_city VARCHAR(100);

        -- Getting current city before update
        SELECT @old_city = current_city
        FROM Employee_SCD3
        WHERE emp_id = @emp_id;

        -- Only update if new value is different
        IF @old_city <> @new_city
        BEGIN
            UPDATE Employee_SCD3
            SET previous_city = current_city,
                current_city = @new_city,
                emp_name = @emp_name,
                last_updated = GETDATE()
            WHERE emp_id = @emp_id;
        END
    END
    ELSE
    BEGIN
        INSERT INTO Employee_SCD3 (
            emp_id, emp_name, current_city, previous_city, last_updated
        ) VALUES (
            @emp_id, @emp_name, @new_city, NULL, GETDATE()
        );
    END
END;

EXEC Update_SCD_Type3 @emp_id = 101, @emp_name = 'Aniruddha Sarkar', @new_city = 'Delhi';

SELECT * FROM Employee_SCD3 WHERE emp_id = 101;

