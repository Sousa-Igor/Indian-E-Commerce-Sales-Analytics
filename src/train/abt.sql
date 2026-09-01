SELECT 
    t1.*,
    t2.QtdComCupom,
    t2.QtdSemCupom,
    t2.AvgComCupom,
    t3.Registration_Days,
    t3.Registration_Age,
    t3.Spent_Orders,
    t4.FavPeriod,
    t5.QuantityLastPurchase,
    t5.QtdCategory,
    t5.QtdBrand,
    t5.FavoriteCategory,
    t5.FavoriteBrand,
    t6.Days_last_purchase,
    t6.QtdOrder7d,
    t6.QtdOrder14d,
    t6.QtdOrder21d,
    t6.MaxValue7d,
    t6.MaxValue14d,
    t6.MaxValue21d,
    t6.MaxValue30d,
    t6.MinValue7d,
    t6.MinValue14d,
    t6.MinValue21d,
    t6.MinValue30d,
    t6.Days_penult_purchase,
    t6.LastPurchaseValue,
    t6.AvgDaysBetweenPurchases,
    t7.ValueSpend7d,
    t7.ValueSpend14d,
    t7.ValueSpend21d,
    t7.ValueSpend30d,
    t8.churn
FROM fs_cancel AS t1

LEFT JOIN fs_cupom as t2
ON t1.Customer_ID = t2.Customer_ID

LEFT JOIN fs_customer as t3
ON t1.Customer_ID = t3.Customer_ID

LEFT JOIN fs_period as t4
ON t1.Customer_ID = t4.Customer_ID

LEFT JOIN fs_product as t5
ON t1.Customer_ID = t5.Customer_ID

LEFT JOIN fs_purchase as t6
ON t1.Customer_ID = t6.Customer_ID

LEFT JOIN fs_spend as t7
ON t1.Customer_ID = t7.Customer_ID

LEFT JOIN fs_churn AS t8
ON t1.Customer_ID = t8.Customer_ID