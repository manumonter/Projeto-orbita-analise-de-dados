-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Calcular percentual de atraso por mês do ano
-- Hipótese: Verificar se períodos sazonais/feriados geram pico de atrasos
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    EXTRACT(MONTH FROM order_delivered_customer_date) AS "Mês",
    COUNT(DISTINCT order_id) AS "Pedidos totais",
    SUM(CASE
        WHEN DATE(order_delivered_customer_date) >
        DATE(order_estimated_delivery_date) THEN 1
        ELSE 0
    END) AS "Pedidos com atraso",
    ROUND(
        100.0 * SUM(
            CASE
                WHEN DATE(order_delivered_customer_date) >
                DATE(order_estimated_delivery_date)
                THEN 1
                ELSE 0
            END
        ) / COUNT(DISTINCT order_id), 2
    ) AS "Percentual atraso"
FROM
    main.olist_orders_dataset
WHERE
    order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL
GROUP BY
    EXTRACT(MONTH FROM order_delivered_customer_date)
ORDER BY
    "Percentual atraso" DESC;
