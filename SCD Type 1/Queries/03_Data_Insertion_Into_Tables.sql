INSERT INTO Customer_Dimension VALUES 
(1, 'Ravi Kumar', 'ravi@example.com', 'Kolkata'),
(2, 'Anjali Sharma', 'anjali@example.com', 'Delhi');

INSERT INTO Staging_Customer VALUES 
(2, 'Anjali Sharma', 'anjali_new@example.com', 'Delhi'),
(3, 'Suresh Raina', 'suresh@example.com', 'Mumbai');

SELECT * FROM Customer_Dimension;
SELECT * FROM Staging_Customer;
