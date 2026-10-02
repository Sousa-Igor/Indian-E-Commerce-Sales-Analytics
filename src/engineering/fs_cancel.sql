SELECT 
    '{date}' AS DtRef,
    Customer_ID,
    SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS QtdCancelledVida,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-7 day') THEN 1 ELSE 0 END) AS QtdCancelled7D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-14 day') THEN 1 ELSE 0 END) AS QtdCancelled14D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-28 day') THEN 1 ELSE 0 END) AS QtdCancelled28D,
    CAST(SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS AvgCancelled
FROM sales

WHERE Order_Date < '{date}'

GROUP BY Customer_ID
