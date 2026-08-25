SELECT
    '2026-05-30' AS DtRef,
    Customer_ID,
    SUM(CASE WHEN Order_Date >= DATE('2026-05-30', '-7 day') THEN Order_Value ELSE 0 END) AS ValueSpend7d,
    SUM(CASE WHEN Order_Date >= DATE('2026-05-30', '-14 day') THEN Order_Value ELSE 0 END) AS ValueSpend14d,
    SUM(CASE WHEN Order_Date >= DATE('2026-05-30', '-21 day') THEN Order_Value ELSE 0 END) AS ValueSpend21d,
    SUM(CASE WHEN Order_Date >= DATE('2026-05-30', '-30 day') THEN Order_Value ELSE 0 END) AS ValueSpend30d

FROM sales
GROUP BY Customer_ID