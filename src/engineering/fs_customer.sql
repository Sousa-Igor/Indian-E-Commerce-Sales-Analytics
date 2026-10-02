SELECT 
    '2025-01-01' AS DtRef,
    Customer_ID,
    ROUND((julianday('2025-01-01') - julianday(Registration_Date)), 2) as Registration_Days,
    ROUND(((julianday('2025-01-01') - julianday(Registration_Date)) / 365), 2) as Registration_Age,
    COALESCE(ROUND((Total_Spent / Total_Orders), 2), 0) as Spent_Orders
FROM customers
