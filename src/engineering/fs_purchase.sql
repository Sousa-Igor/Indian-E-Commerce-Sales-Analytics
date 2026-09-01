WITH row_number AS (
    SELECT
        '2026-05-30' as DtRef,
        Customer_ID,
        Order_Date,
        Order_Value,
        ROW_NUMBER() OVER(PARTITION BY Customer_ID
                        ORDER BY Order_Date DESC, Order_Time DESC) AS rn
    FROM sales
    WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-28 day') 
),

penult_purchase AS (

    SELECT
        Customer_ID,
        julianday('2026-05-30') - julianday(Order_Date) AS Days_penult_purchase
    FROM row_number
    WHERE rn = 2
),

LastPurchase AS (
SELECT
    Customer_ID,
    Order_Value AS LastPurchaseValue
FROM row_number
WHERE rn = 1
),

purchases AS (
    SELECT
        Customer_ID,
        Order_Date,
        LAG(Order_Date) OVER (
            PARTITION BY Customer_ID
            ORDER BY Order_Date
        ) AS Previous_Order_Date
    FROM sales
),
avg_purchase AS (

SELECT
    Customer_ID,
    AVG(
        julianday(Order_Date) - julianday(Previous_Order_Date)
    ) AS AvgDaysBetweenPurchases
FROM purchases
WHERE Previous_Order_Date IS NOT NULL
GROUP BY Customer_ID)

SELECT
        '2026-05-30' AS DtRef,
        t1.Customer_ID,
        julianday('2026-05-30') - julianday(MAX(Order_Date)) as Days_last_purchase,
        SUM(
            CASE
                WHEN (Order_Date) >= DATE('2026-05-30', '-7 day') THEN 1 ELSE 0
            END) AS QtdOrder7d,
       
        SUM(
            CASE
                WHEN (Order_Date) >= DATE('2026-05-30', '-14 day') THEN 1 ELSE 0
            END) AS QtdOrder14d,
        
        SUM(
            CASE
                WHEN (Order_Date) >= DATE('2026-05-30', '-21 day') THEN 1 ELSE 0
            END) AS QtdOrder21d,

        CASE WHEN Order_Date >= DATE('2026-05-30', '-7 day') THEN MAX(Order_Value) ELSE 0 END AS MaxValue7d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-14 day') THEN MAX(Order_Value) ELSE 0 END AS MaxValue14d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-21 day') THEN MAX(Order_Value) ELSE 0 END AS MaxValue21d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-28 day') THEN MAX(Order_Value) ELSE 0 END AS MaxValue28d,

        CASE WHEN Order_Date >= DATE('2026-05-30', '-7 day') THEN MIN(Order_Value) ELSE 0 END AS MinValue7d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-14 day') THEN MIN(Order_Value) ELSE 0 END AS MinValue14d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-21 day') THEN MIN(Order_Value) ELSE 0 END AS MinValue21d,
        CASE WHEN Order_Date >= DATE('2026-05-30', '-28 day') THEN MIN(Order_Value) ELSE 0 END AS MinValue28d,

        t2.Days_penult_purchase,
        t3.LastPurchaseValue,
        t4.AvgDaysBetweenPurchases

    FROM sales as t1

    LEFT JOIN penult_purchase AS t2
    ON t1.Customer_ID = t2.Customer_ID

    LEFT JOIN LastPurchase AS t3
    ON t1.Customer_ID = t3.Customer_ID

    LEFT JOIN avg_purchase AS t4
    ON t1.Customer_ID = t4.Customer_ID


    WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-28 day')
    GROUP BY t1.Customer_ID

