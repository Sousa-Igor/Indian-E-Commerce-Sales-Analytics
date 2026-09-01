WITH pedidos as (
SELECT
    customers.Customer_ID,
    sales.Order_ID,
    sales.Order_Date
FROM customers

LEFT JOIN sales 
ON customers.Customer_ID = sales.Customer_ID
AND sales.Order_Date > '2026-05-30'

ORDER BY Order_Date)

SELECT
    Customer_ID,
    CASE
        WHEN COUNT(Order_ID) = 0 THEN 1 ELSE 0
    END AS churn
FROM pedidos
GROUP BY Customer_ID

ORDER BY Order_Date 
