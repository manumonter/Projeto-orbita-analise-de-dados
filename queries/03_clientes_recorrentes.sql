-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Calcular a quantidade de clientes únicos totais,
--           recorrentes e a taxa de recorrência
-- Hipótese: Identificar o percentual de clientes que compram mais de uma vez
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    COUNT(customer_unique_id) AS "Clientes únicos",
    SUM(CASE WHEN pedidos_por_cliente > 1 THEN 1 ELSE 0 END) AS "Clientes recorrentes",
    ROUND(
        1.0 * SUM(CASE WHEN pedidos_por_cliente > 1 THEN 1 ELSE 0 END)
        / COUNT(customer_unique_id), 4) AS "Taxa recorrência"
FROM (
    SELECT
        ocd.customer_unique_id,
        COUNT(ood.order_id) AS pedidos_por_cliente
    FROM
        main.olist_customers_dataset ocd
    JOIN
        main.olist_orders_dataset ood ON ocd.customer_id = ood.customer_id
    GROUP BY
        ocd.customer_unique_id
) AS resumo;
