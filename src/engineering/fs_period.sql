WITH period AS (
    SELECT
        *,
        CASE
            WHEN Order_Time BETWEEN '00:00:00' AND '07:59:59' THEN 'Madrugada' 
            WHEN Order_Time BETWEEN '08:00:00' AND '11:59:59' THEN 'Manha' 
            WHEN Order_Time BETWEEN '12:00:00' AND '17:59:59' THEN 'Tarde' 
            WHEN Order_Time BETWEEN '18:00:00' AND '23:59:59' THEN 'Noite' 
        END AS Period
    FROM sales
    WHERE Order_Date < '2026-05-30'
        AND Order_Date >= DATE('2026-05-30', '-28 day') 
),
rank AS (
    SELECT  
        Customer_ID,
        Period,
        COUNT(Period) AS QtdPeriod,
        RANK() OVER(PARTITION BY Customer_ID ORDER BY COUNT(Period) DESC ) AS RankPeriod
    FROM period

    GROUP BY Customer_ID, Period

    ORDER BY RankPeriod DESC
)

SELECT 
    Customer_ID,
    CASE
        WHEN COUNT(*) > 1 THEN 'SP' ELSE max(Period)
    END AS FavPeriod
FROM rank
WHERE RankPeriod = 1

GROUP BY Customer_ID


