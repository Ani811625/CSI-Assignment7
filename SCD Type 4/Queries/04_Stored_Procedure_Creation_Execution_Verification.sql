CREATE PROCEDURE Update_SCD_Type4
    @emp_id INT,
    @emp_name VARCHAR(100),
    @new_city VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if employee exists
    IF EXISTS (SELECT 1 FROM Employee_SCD4_Current WHERE emp_id = @emp_id)
    BEGIN
        DECLARE @old_city VARCHAR(100);
        SELECT @old_city = emp_city FROM Employee_SCD4_Current WHERE emp_id = @emp_id;

        -- If city has changed, store old record into history and update main table
        IF @old_city <> @new_city
        BEGIN
            -- Insert current record into history
            INSERT INTO Employee_SCD4_History (emp_id, emp_name, emp_city, change_date)
            SELECT emp_id, emp_name, emp_city, GETDATE()
            FROM Employee_SCD4_Current
            WHERE emp_id = @emp_id;

            -- Update main table with new data
            UPDATE Employee_SCD4_Current
            SET emp_name = @emp_name,
                emp_city = @new_city,
                last_updated = GETDATE()
            WHERE emp_id = @emp_id;
        END
        ELSE
        BEGIN
            PRINT 'No changes in city. No update needed.';
        END
    END
    ELSE
    BEGIN
        -- If employee doesn’t exist, insert into main table
        INSERT INTO Employee_SCD4_Current (emp_id, emp_name, emp_city, last_updated)
        VALUES (@emp_id, @emp_name, @new_city, GETDATE());
    END
END;

EXEC Update_SCD_Type4 @emp_id = 201, @emp_name = 'Aniruddha Sarkar', @new_city = 'Bangalore';


SELECT * FROM Employee_SCD4_Current;

SELECT * FROM Employee_SCD4_History;
