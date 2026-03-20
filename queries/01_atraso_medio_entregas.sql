-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Validar o indicador de atraso médio apresentado no case
-- Hipótese: Verificar o atraso médio geral nas entregas
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    ROUND(AVG(DATE(order_delivered_customer_date) -
    DATE(order_estimated_delivery_date)), 2) AS atraso_medio_dias
FROM
    main.olist_orders_dataset ood
WHERE
    DATE(order_delivered_customer_date) IS NOT NULL
    AND DATE(order_estimated_delivery_date) IS NOT NULL
    AND DATE(order_delivered_customer_date) >
    DATE(order_estimated_delivery_date);
