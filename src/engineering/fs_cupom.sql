SELECT
    '{date}' AS DtRef,
    Customer_ID,
    SUM(CASE WHEN Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS QtdComCupomVida,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-7 day') AND Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS QtdComCupom7D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-14 day') AND Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS QtdComCupom14D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-28 day') AND Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS QtdComCupom28D,

    SUM(CASE WHEN Coupon_Discount = 0.0 THEN 1 ELSE 0 END) AS QtdSemCupomVida,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-7 day') AND Coupon_Discount = 0.0 THEN 1 ELSE 0 END) AS QtdSemCupom7D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-14 day') AND Coupon_Discount = 0.0 THEN 1 ELSE 0 END) AS QtdSemCupom14D,
    SUM(CASE WHEN Order_Date > DATE('{date}', '-28 day') AND Coupon_Discount = 0.0 THEN 1 ELSE 0 END) AS QtdSemCupom28D,

    CAST(SUM(CASE WHEN Coupon_Discount <> 0.0 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS AvgComCupom,
    CAST(SUM(CASE WHEN Coupon_Discount = 0.0 THEN 1 ELSE 0 END) AS REAL) / COUNT(*) AS AvgSemCupom
FROM sales

WHERE Order_Date < '{date}'

GROUP BY Customer_ID

