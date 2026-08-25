SELECT 
    '2026-05-30' as DtRef,
    *,
    Registration_Date,
    ROUND((julianday('2026-05-30') - julianday(Registration_Date)), 2) as Registration_Days,
    ROUND(((julianday('2026-05-30') - julianday(Registration_Date)) / 365), 2) as Registration_Age,
    COALESCE(ROUND((Total_Spent / Total_Orders), 2), 0) as Spent_Orders
FROM customers
