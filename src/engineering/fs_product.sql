WITH rownumber AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date DESC, Order_Time DESC) AS rn
    FROM sales
    WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-28 day') 
    ),

quant AS (


SELECT
    Customer_ID,
    Quantity AS QuantityLastPurchase
FROM rownumber
WHERE rn = 1),

CatBrand AS (

SELECT
    t1.Customer_ID,
    COUNT(DISTINCT t2.Category) AS QtdCategory,
    COUNT(DISTINCT t2.Brand) AS QtdBrand
FROM sales AS t1

LEFT JOIN products as t2
ON t1.Product_ID = t2.Product_ID

WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-28 day')

GROUP BY t1.Customer_ID
),

favcat AS (

    SELECT
        t1.Customer_ID,
        t2.Category,
        COUNT(*) AS QtdCategory,

        ROW_NUMBER() OVER (
            PARTITION BY t1.Customer_ID
            ORDER BY COUNT(*) DESC
        ) AS rn

    FROM sales AS t1

    LEFT JOIN products AS t2
        ON t1.Product_ID = t2.Product_ID

    WHERE t1.Order_Date < '2026-05-30'
      AND t1.Order_Date >= DATE('2026-05-30', '-28 day')

    GROUP BY
        t1.Customer_ID,
        t2.Category
),

favbrand AS (

    SELECT
        t1.Customer_ID,
        t2.Brand,
        COUNT(*) AS QtdBrand,

        ROW_NUMBER() OVER (
            PARTITION BY t1.Customer_ID
            ORDER BY COUNT(*) DESC
        ) AS rn

    FROM sales AS t1

    LEFT JOIN products AS t2
        ON t1.Product_ID = t2.Product_ID

    WHERE t1.Order_Date < '2026-05-30'
      AND t1.Order_Date >= DATE('2026-05-30', '-28 day')

    GROUP BY
        t1.Customer_ID,
        t2.Brand
),

fav AS (

SELECT
    fc.Customer_ID,
    fc.Category AS FavoriteCategory,
    fc.QtdCategory,
    fb.Brand AS FavoriteBrand,
    fb.QtdBrand

FROM favcat AS fc

LEFT JOIN favbrand AS fb
    ON fc.Customer_ID = fb.Customer_ID

WHERE fc.rn = 1
  AND fb.rn = 1

)

SELECT 
    t1.*,
    t2.QtdCategory,
    t2.QtdBrand,
    t3.FavoriteCategory,
    t3.FavoriteBrand

FROM quant as t1
 
LEFT JOIN CatBrand AS t2
ON t1.Customer_ID = t2.Customer_ID

LEFT JOIN fav AS t3
ON t1.Customer_ID = t3.Customer_ID