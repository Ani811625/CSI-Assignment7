CREATE PROCEDURE sp_scd_type2_update
AS
BEGIN
    DECLARE @currentDate DATE = GETDATE();

    -- Step 1: Handling changes (close old record and insert new one)
    INSERT INTO Customer_Dimension_SCD2 (CustomerID, CustomerName, Email, City, StartDate, EndDate, IsActive)
    SELECT
        S.CustomerID,
        S.CustomerName,
        S.Email,
        S.City,
        @currentDate AS StartDate,
        NULL AS EndDate,
        1 AS IsActive
    FROM Staging_Customer_SCD2 S
    INNER JOIN Customer_Dimension_SCD2 D
        ON S.CustomerID = D.CustomerID
        AND D.IsActive = 1
    WHERE 
        ISNULL(S.CustomerName, '') <> ISNULL(D.CustomerName, '')
        OR ISNULL(S.Email, '') <> ISNULL(D.Email, '')
        OR ISNULL(S.City, '') <> ISNULL(D.City, '');

    -- Step 2: Marking the old record as inactive
    UPDATE D
    SET D.EndDate = @currentDate,
        D.IsActive = 0
    FROM Customer_Dimension_SCD2 D
    INNER JOIN Staging_Customer_SCD2 S
        ON S.CustomerID = D.CustomerID
    WHERE D.IsActive = 1
      AND (
            ISNULL(S.CustomerName, '') <> ISNULL(D.CustomerName, '')
         OR ISNULL(S.Email, '') <> ISNULL(D.Email, '')
         OR ISNULL(S.City, '') <> ISNULL(D.City, '')
      );

    -- Step 3: Insertion of new customers
    INSERT INTO Customer_Dimension_SCD2 (CustomerID, CustomerName, Email, City, StartDate, EndDate, IsActive)
    SELECT
        S.CustomerID,
        S.CustomerName,
        S.Email,
        S.City,
        @currentDate AS StartDate,
        NULL AS EndDate,
        1 AS IsActive
    FROM Staging_Customer_SCD2 S
    LEFT JOIN Customer_Dimension_SCD2 D
        ON S.CustomerID = D.CustomerID
    WHERE D.CustomerID IS NULL;
END;

EXEC sp_scd_type2_update;

SELECT * FROM Customer_Dimension_SCD2 ORDER BY CustomerID, StartDate;
