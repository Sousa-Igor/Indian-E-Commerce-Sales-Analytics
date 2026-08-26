SELECT
    Customer_ID,
    SUM(
        CASE
                WHEN Coupon_Discount <> 0.0 THEN 1 ELSE 0
        END) AS QtdComCupom,
    SUM(
        CASE
            WHEN Coupon_Discount = 0.0 THEN 1 ELSE 0 
        END) AS QtdSemCupom,
    CAST(SUM(CASE WHEN Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS AvgComCupom
FROM sales

WHERE Order_Date < '2026-05-30'
    AND Order_Date >= DATE('2026-05-30', '-30 day') 

GROUP BY Customer_ID

