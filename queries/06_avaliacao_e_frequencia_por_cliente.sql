-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Cruzar frequência de compra com nota média de avaliação por cliente
-- Hipótese: Clientes mais recorrentes tendem a avaliar melhor
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    ocd.customer_unique_id,
    COUNT(DISTINCT ood.order_id) AS pedidos_por_cliente,
    AVG(or2.review_score) AS media_nota_avaliacao
FROM
    main.order_reviews or2
JOIN
    main.olist_orders_dataset ood ON or2.order_id = ood.order_id
JOIN
    main.olist_customers_dataset ocd ON ocd.customer_id = ood.customer_id
GROUP BY
    ocd.customer_unique_id
ORDER BY
    pedidos_por_cliente DESC;
