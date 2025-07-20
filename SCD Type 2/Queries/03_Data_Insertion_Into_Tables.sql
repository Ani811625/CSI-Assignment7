INSERT INTO Customer_Dimension_SCD2 VALUES 
(1, 'Ravi Kumar', 'ravi@example.com', 'Kolkata', '2023-01-01', NULL, 1),
(2, 'Anjali Sharma', 'anjali@example.com', 'Delhi', '2023-01-01', NULL, 1);

-- Change for CustomerID = 2 and new CustomerID = 3
INSERT INTO Staging_Customer_SCD2 VALUES
(2, 'Anjali Sharma', 'anjali@example.com', 'Mumbai'),
(3, 'Suresh Raina', 'suresh@example.com', 'Pune');

SELECT * FROM Customer_Dimension_SCD2;
SELECT * FROM Staging_Customer_SCD2;
