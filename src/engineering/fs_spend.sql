SELECT
    '{date}' AS DtRef,
    Customer_ID,
    SUM(CASE WHEN Order_Date >= DATE('{date}', '-7 day') THEN Order_Value ELSE 0 END) AS ValueSpend7d,
    SUM(CASE WHEN Order_Date >= DATE('{date}', '-14 day') THEN Order_Value ELSE 0 END) AS ValueSpend14d,
    SUM(CASE WHEN Order_Date >= DATE('{date}', '-21 day') THEN Order_Value ELSE 0 END) AS ValueSpend21d,
    SUM(CASE WHEN Order_Date >= DATE('{date}', '-28 day') THEN Order_Value ELSE 0 END) AS ValueSpend28d

FROM sales

WHERE Order_Date < '{date}'

GROUP BY Customer_ID