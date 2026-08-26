SELECT 
    Customer_ID,
    SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS QtdCancelled,
    CAST(SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS AvgCancelled
FROM sales

WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-30 day') 

GROUP BY Customer_ID
