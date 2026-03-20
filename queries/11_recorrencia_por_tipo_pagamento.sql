-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Identificar qual tipo de pagamento está associado a maior recorrência
-- Hipótese: ✅ Cartão de crédito tem maior frequência de compra — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH pagamentos_com_pedidos AS (
    SELECT
        ocd.customer_unique_id,
        oopd.payment_type,
        COUNT(DISTINCT ood.order_id) AS qtd_pedidos
    FROM
        main.olist_orders_dataset ood
    JOIN
        main.olist_order_payments_dataset oopd ON ood.order_id = oopd.order_id
    JOIN
        main.olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
    GROUP BY ocd.customer_unique_id, oopd.payment_type
)
SELECT
    payment_type AS "Tipo de pagamento",
    COUNT(DISTINCT customer_unique_id) AS "Clientes recorrentes"
FROM
    pagamentos_com_pedidos
WHERE
    qtd_pedidos > 1
GROUP BY payment_type
ORDER BY "Clientes recorrentes" DESC;
