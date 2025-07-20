CREATE PROCEDURE Update_SCD_Type6
    @emp_id INT,
    @emp_name VARCHAR(100),
    @new_city VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Get the current active record
    IF EXISTS (SELECT 1 FROM Employee_SCD6 WHERE emp_id = @emp_id AND is_current = 1)
    BEGIN
        DECLARE @current_city VARCHAR(100), @surrogate_id INT;

        SELECT @current_city = emp_city,
               @surrogate_id = surrogate_id
        FROM Employee_SCD6
        WHERE emp_id = @emp_id AND is_current = 1;

        -- If city has changed
        IF @current_city <> @new_city
        BEGIN
            -- Step 1: Expire the old record
            UPDATE Employee_SCD6
            SET is_current = 0,
                end_date = GETDATE()
            WHERE surrogate_id = @surrogate_id;

            -- Step 2: Insert new version with new city and store previous city
            INSERT INTO Employee_SCD6 (
                emp_id, emp_name, emp_city, previous_city,
                start_date, end_date, is_current
            )
            VALUES (
                @emp_id, @emp_name, @new_city, @current_city,
                GETDATE(), NULL, 1
            );
        END
        ELSE
        BEGIN
            -- Type 1 behavior (update name if changed, but no city change)
            UPDATE Employee_SCD6
            SET emp_name = @emp_name
            WHERE surrogate_id = @surrogate_id;
        END
    END
    ELSE
    BEGIN
        -- New employee, insert fresh record
        INSERT INTO Employee_SCD6 (
            emp_id, emp_name, emp_city, previous_city,
            start_date, end_date, is_current
        )
        VALUES (
            @emp_id, @emp_name, @new_city, NULL,
            GETDATE(), NULL, 1
        );
    END
END;

EXEC Update_SCD_Type6 @emp_id = 301, @emp_name = 'Aniruddha Sarkar', @new_city = 'Kolkata';

EXEC Update_SCD_Type6 @emp_id = 301, @emp_name = 'Aniruddha Sarkar', @new_city = 'Delhi';

EXEC Update_SCD_Type6 @emp_id = 301, @emp_name = 'A. Sarkar', @new_city = 'Delhi';

SELECT * FROM Employee_SCD6;
