-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Validar o indicador de nota média de avaliação apresentado no case
-- Hipótese: Verificar nota média geral de avaliação dos pedidos
-- Autor: Emanuelly Monteiro
-- ============================================================

SELECT
    ROUND(AVG(review_score), 1) AS "Nota média de avaliação"
FROM
    main.order_reviews or2;
