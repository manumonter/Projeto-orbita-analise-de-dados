-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Ajudar a estipular a nova meta de atraso médio,
--           apresentando o atraso médio por ano
-- Hipótese: Verificar evolução histórica do atraso para projeção de meta
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    EXTRACT(YEAR FROM order_delivered_customer_date) AS ano,
    ROUND(AVG(DATE(order_delivered_customer_date) -
    DATE(order_estimated_delivery_date)), 2) AS atraso_medio_dias
FROM
    main.olist_orders_dataset
WHERE
    order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL
    AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY
    EXTRACT(YEAR FROM order_delivered_customer_date)
ORDER BY
    ano;
