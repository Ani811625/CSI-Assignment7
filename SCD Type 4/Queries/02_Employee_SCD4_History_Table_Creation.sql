CREATE TABLE Employee_SCD4_History (
    history_id INT IDENTITY(1,1) PRIMARY KEY,
    emp_id INT,
    emp_name VARCHAR(100),
    emp_city VARCHAR(100),
    change_date DATETIME
);