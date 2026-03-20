-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Verificar se o tempo de separação/processamento influencia no atraso
-- Hipótese: ✅ Pedidos com mais tempo de separação tendem a atrasar — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    CASE
        WHEN order_delivered_carrier_date - order_approved_at <= INTERVAL '1 day' THEN '≤ 1 dia'
        WHEN order_delivered_carrier_date - order_approved_at <= INTERVAL '2 days' THEN '2 dias'
        ELSE '> 2 dias'
    END AS tempo_separacao_envio,
    COUNT(order_id) AS total_pedidos,
    COUNT(CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
    END) AS pedidos_com_atraso_na_entrega,
    ROUND(
        100.00 * COUNT(CASE
            WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1
        END) / COUNT(order_id), 2
    ) AS percentual_atrasos
FROM
    main.olist_orders_dataset
WHERE
    order_approved_at IS NOT NULL
    AND order_delivered_carrier_date IS NOT NULL
    AND order_delivered_customer_date IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL
GROUP BY tempo_separacao_envio
ORDER BY percentual_atrasos DESC;
