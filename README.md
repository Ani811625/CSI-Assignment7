# CSI - Assignment 7: Slowly Changing Dimensions (SCD) Stored Procedures

This repository contains solutions to **Week 7** of the **Celebal Technologies Summer Internship - SQL Track**. In this task, I implemented stored procedures for various **Slowly Changing Dimensions (SCD)** types in SQL Server.

Each SCD type has its own folder structured with:
- `Queries/`: Contains SQL files used to create and execute the stored procedure.
- `Outputs/`: Contains execution results demonstrating each SCD implementation.

---

## 📁 Repository Structure

| SCD Type | Folder Name    | Description |
|----------|----------------|-------------|
| SCD Type 0 | `SCD Type 0` | Retains original data, no changes allowed. |
| SCD Type 1 | `SCD Type 1` | Overwrites old data with new data (no history). |
| SCD Type 2 | `SCD Type 2` | Maintains full history with additional records. |
| SCD Type 3 | `SCD Type 3` | Tracks limited history using additional columns. |
| SCD Type 4 | `SCD Type 4` | Uses a separate history table to store changes. |
| SCD Type 6 | `SCD Type 6` | Hybrid: Combines Type 1, 2, and 3 characteristics. |

---

## 🧠 Key Learnings

- Understanding how data changes over time can be tracked and managed in data warehouses.
- Writing and executing complex stored procedures in SQL Server.
- Using different strategies (SCD types) for historical tracking of dimensional data.

---

## 📂 Folder Description

Each folder contains:
- ✅ `Queries/`: The `.sql` files used to define and run the stored procedures.
- 📷 `Outputs/`: Contains executed results from SQL Server Management Studio (SSMS).

---

## 📌 Technologies Used

- Microsoft SQL Server (SSMS)
- Git & GitHub for version control
- SQL (Stored Procedures, Triggers, Tables, Joins, etc.)

---

## 📬 Contact

For any queries or guidance, feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/aniruddha-sarkar-90a34334b/) or drop an email at: `aniruddhas387@gmail.com`

---

> 💡 **Note**: This project was done as part of **Week 7 assignment** under the **Celebal Technologies Summer Internship - SQL Domain (Batch 2)**.
