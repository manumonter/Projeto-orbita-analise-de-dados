-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Calcular percentual de atraso por região do Brasil
-- Hipótese: ✅ Entregas em regiões mais afastadas do eixo têm maior
--           percentual de atraso — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    CASE
        WHEN customer_state IN ('SP', 'RJ', 'MG', 'ES') THEN 'Sudeste'
        WHEN customer_state IN ('PR', 'SC', 'RS') THEN 'Sul'
        WHEN customer_state IN ('DF', 'GO', 'MT', 'MS') THEN 'Centro-Oeste'
        WHEN customer_state IN ('BA', 'SE', 'PE', 'AL', 'PB', 'RN', 'CE', 'PI', 'MA') THEN 'Nordeste'
        WHEN customer_state IN ('AM', 'PA', 'RO', 'RR', 'AC', 'AP', 'TO') THEN 'Norte'
        ELSE 'Desconhecido'
    END AS regiao,
    COUNT(DISTINCT ood.order_id) AS pedidos_totais,
    SUM(CASE
        WHEN DATE(order_delivered_customer_date) >
        DATE(order_estimated_delivery_date) THEN 1
        ELSE 0
    END) AS pedidos_atrasados,
    ROUND(100.0 * SUM(CASE
        WHEN DATE(order_delivered_customer_date) >
        DATE(order_estimated_delivery_date) THEN 1
        ELSE 0
    END) / COUNT(DISTINCT ood.order_id), 2) AS percentual_atraso
FROM
    main.olist_orders_dataset ood
JOIN
    main.olist_customers_dataset ocd ON ood.customer_id = ocd.customer_id
GROUP BY
    regiao
ORDER BY
    percentual_atraso DESC;
