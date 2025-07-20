CREATE TABLE Employee_SCD6 (
    surrogate_id INT IDENTITY(1,1) PRIMARY KEY,  -- Unique record ID
    emp_id INT,                                  -- Business key
    emp_name VARCHAR(100),
    emp_city VARCHAR(100),
    previous_city VARCHAR(100),                  -- Type 3 aspect
    start_date DATETIME,
    end_date DATETIME,
    is_current BIT                               -- Type 2 aspect
);
