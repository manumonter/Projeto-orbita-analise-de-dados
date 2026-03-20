-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Calcular clientes recorrentes segmentados por ano
-- Hipótese: Verificar evolução histórica da recorrência para projeção de meta
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH pedidos_por_ano AS (
    SELECT
        ocd.customer_unique_id,
        EXTRACT(YEAR FROM ood.order_purchase_timestamp) AS ano,
        COUNT(ood.order_id) AS pedidos_no_ano
    FROM
        main.olist_orders_dataset ood
    JOIN
        main.olist_customers_dataset ocd ON ocd.customer_id = ood.customer_id
    GROUP BY
        ocd.customer_unique_id,
        EXTRACT(YEAR FROM ood.order_purchase_timestamp)
)
SELECT
    ano,
    COUNT(DISTINCT customer_unique_id) AS clientes_unicos,
    COUNT(DISTINCT CASE WHEN pedidos_no_ano > 1 THEN customer_unique_id END) AS clientes_recorrentes
FROM
    pedidos_por_ano
GROUP BY
    ano
ORDER BY
    ano;
