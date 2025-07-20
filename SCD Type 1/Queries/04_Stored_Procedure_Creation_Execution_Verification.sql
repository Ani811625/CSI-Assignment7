CREATE PROCEDURE sp_scd_type1_update
AS
BEGIN
    -- Update existing records if data is different
    UPDATE D
    SET 
        D.CustomerName = S.CustomerName,
        D.Email = S.Email,
        D.City = S.City
    FROM Customer_Dimension D
    INNER JOIN Staging_Customer S
        ON D.CustomerID = S.CustomerID
    WHERE 
        ISNULL(D.CustomerName, '') <> ISNULL(S.CustomerName, '')
        OR ISNULL(D.Email, '') <> ISNULL(S.Email, '')
        OR ISNULL(D.City, '') <> ISNULL(S.City, '');

    -- Insert new records
    INSERT INTO Customer_Dimension (CustomerID, CustomerName, Email, City)
    SELECT S.CustomerID, S.CustomerName, S.Email, S.City
    FROM Staging_Customer S
    LEFT JOIN Customer_Dimension D ON D.CustomerID = S.CustomerID
    WHERE D.CustomerID IS NULL;
END;

EXEC sp_scd_type1_update;

SELECT * FROM Customer_Dimension;

