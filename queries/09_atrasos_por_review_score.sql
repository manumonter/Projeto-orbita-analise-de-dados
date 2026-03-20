-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Cruzar pedidos atrasados com nota de avaliação
-- Hipótese: ✅ Problemas com atraso influenciam em avaliações baixas — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    COUNT(ood.order_id) AS "Pedidos atrasados",
    review_score
FROM
    main.olist_orders_dataset ood
JOIN
    main.order_reviews or2 ON or2.order_id = ood.order_id
WHERE
    DATE(order_delivered_customer_date) > DATE(order_estimated_delivery_date)
GROUP BY
    review_score;
