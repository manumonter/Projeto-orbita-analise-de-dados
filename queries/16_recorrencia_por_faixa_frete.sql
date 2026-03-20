-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Verificar se clientes com frete mais barato têm maior recorrência
-- Hipótese: ✅ Clientes com frete grátis/barato compram mais vezes — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH pedidos_por_cliente AS (
    SELECT
        ocd.customer_unique_id,
        COUNT(DISTINCT ood.order_id) AS qtd_pedidos
    FROM
        main.olist_orders_dataset ood
    JOIN
        main.olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
    GROUP BY ocd.customer_unique_id
),
frete_medio_cliente AS (
    SELECT
        ocd.customer_unique_id,
        AVG(oid.freight_value) AS frete_medio
    FROM
        main.olist_orders_dataset ood
    JOIN
        main.olist_order_items_dataset oid ON ood.order_id = oid.order_id
    JOIN
        main.olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
    GROUP BY ocd.customer_unique_id
),
clientes_recorrentes AS (
    SELECT
        pc.customer_unique_id,
        fmc.frete_medio
    FROM
        pedidos_por_cliente pc
    JOIN
        frete_medio_cliente fmc ON pc.customer_unique_id = fmc.customer_unique_id
    WHERE
        pc.qtd_pedidos > 1
)
SELECT
    CASE
        WHEN frete_medio BETWEEN 0.00 AND 20.00 THEN 'R$0 - 20'
        WHEN frete_medio BETWEEN 20.01 AND 40.00 THEN 'R$20,01 - 40'
        ELSE 'R$40+'
    END AS faixa_frete,
    COUNT(*) AS clientes_recorrentes
FROM
    clientes_recorrentes
GROUP BY faixa_frete
ORDER BY clientes_recorrentes DESC;
