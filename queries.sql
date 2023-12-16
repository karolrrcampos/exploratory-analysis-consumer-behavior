CREATE DATABASE shopping_behavior;
USE shopping_behavior;

-- Verificando quantos valores distintos de ID de consumidor temos no dataset.
-- O objetivo é verificar se algum consumidor fez duas compras ou mais.
SELECT COUNT(DISTINCT customer_ID) AS total_unique_customers  
FROM consumer_behavior;

-- Volume de vendas por gênero e idade 
SELECT gender, age, 
count(*) AS AmountSold
FROM consumer_behavior
group by gender, age
order by AmountSold desc;

-- Volume de vendas por gênero
SELECT gender,
count(*) AS CountGender
FROM consumer_behavior
group by gender
order by CountGender desc;

-- Volume de vendas por item
SELECT item,
count(*) AS CountItem
FROM consumer_behavior
group by item
order by CountItem desc;

-- Volume de vendas por categoria
SELECT category,
count(*) AS CountCategory
FROM consumer_behavior
group by category
order by CountCategory desc;

-- Volume de vendas por localização geográfica onde a compra foi feita
SELECT location,
count(*) AS CountLocation
FROM consumer_behavior
group by location
order by CountLocation desc;

-- Volume de vendas por tamanho do item comprado
SELECT size,
count(*) AS CountSize
FROM consumer_behavior
group by size
order by CountSize desc;

-- Volume de vendas por cor do item comprado
SELECT color,
count(*) AS CountColor
FROM consumer_behavior
group by color
order by CountColor desc;

-- Contagem de reviews por classificação
SELECT review,
count(*) AS CountReview
FROM consumer_behavior
group by review
order by CountReview desc;

-- Volume de compras por estação do ano
SELECT season,
count(*) AS CountSeason
FROM consumer_behavior
group by season
order by CountSeason desc;

-- Volume de status de assinatura
SELECT subscription_service,
count(*) AS CountSubscription
FROM consumer_behavior
group by subscription_service
order by CountSubscription desc;

-- Tipo de entrega
SELECT shipping_type,
count(*) AS CountShipping
FROM consumer_behavior
group by shipping_type
order by CountShipping desc;

-- Descontos aplicados
SELECT discount_applied,
count(*) AS CountDiscount
FROM consumer_behavior
group by discount_applied
order by CountDiscount desc;

-- Uso código de desconto
SELECT promo_code_used,
count(*) AS CountPromoCode
FROM consumer_behavior
group by promo_code_used
order by CountPromoCode desc;

-- Contagem dos métodos de pagamento
SELECT payment_method,
count(*) AS CountPaymentMethod
FROM consumer_behavior
group by payment_method
order by CountPaymentMethod desc;

-- Contagem da frequência com que o cliente se envolve em atividades de compra
SELECT freq_purchases,
count(*) AS CountFreqPurchases
FROM consumer_behavior
group by freq_purchases
order by CountFreqPurchases desc;

-- Média das classificações dos reviews por idade
SELECT age, 
ROUND(avg(review), 1) as MeanReview
FROM consumer_behavior
group by age
order by MeanReview desc;

-- Média das classificações dos reviews por gênero
SELECT gender, 
ROUND(avg(review), 1) as MeanReview
FROM consumer_behavior
group by gender
order by MeanReview desc;

-- Média das classificações dos reviews por item
SELECT item, 
ROUND(avg(review), 1) as MeanReview
FROM consumer_behavior
group by item
order by MeanReview desc;

-- Média das classificações dos reviews por categoria
SELECT category, 
ROUND(avg(review), 1) as MeanReview
FROM consumer_behavior
group by category
order by MeanReview desc;

-- Média de preço por item
SELECT item, 
ROUND(avg(Price_usd), 2) as MeanPrice
FROM consumer_behavior
group by item
order by MeanPrice desc;

-- Média de preço por categoria
SELECT category, 
ROUND(avg(Price_usd), 2) as MeanPrice
FROM consumer_behavior
group by category
order by MeanPrice desc;

-- Média e gasto total por gênero
Select gender,
ROUND(sum(CAST(Price_usd AS DECIMAL(10,2))), 2) as TotalSpend,
ROUND(avg(CAST(Price_usd AS DECIMAL(10,2))), 2) as MeanSpend
FROM consumer_behavior
group by gender
order by gender;

-- Média e gasto total por idade
Select age,
ROUND(sum(CAST(Price_usd AS DECIMAL(10,2))), 2) as TotalSpend,
ROUND(avg(CAST(Price_usd AS DECIMAL(10,2))), 2) as MeanSpend
FROM consumer_behavior
group by age
order by age;

-- Média e gasto total por estação do ano
Select season,
ROUND(sum(CAST(Price_usd AS DECIMAL(10,2))), 2) as TotalSpend,
ROUND(avg(CAST(Price_usd AS DECIMAL(10,2))), 2) as MeanSpend
FROM consumer_behavior
group by season
order by season;

-- Contagem de categorias por localização geografica
select location, category,
count(*) AS CountCategory
FROM consumer_behavior
group by location, category
order by CountCategory desc;

-- Contagem de categorias por método de entrega
select location, shipping_type,
count(*) AS CountCategory
FROM consumer_behavior
group by location, shipping_type
order by CountCategory desc;

-- análises de tendências regionais 
SELECT location,
ROUND(avg(CAST(Price_usd AS DECIMAL(10,2))), 2) AS MeanPrice,
(
SELECT category
FROM 
(
SELECT category, 
COUNT(*) AS CountCategory
FROM consumer_behavior AS inner_cb
WHERE inner_cb.location = outer_cb.location
GROUP BY category
ORDER BY CountCategory DESC
LIMIT 1) AS subquery) AS PopularCategory,
(
SELECT shipping_type
FROM 
(
SELECT shipping_type, 
COUNT(*) AS ShippingTypeCount
FROM consumer_behavior AS inner_cb
WHERE inner_cb.location = outer_cb.location
GROUP BY shipping_type
ORDER BY ShippingTypeCount DESC
LIMIT 1
) AS subquery_shipping) AS MostFrequentShippingType
FROM consumer_behavior AS outer_cb
GROUP BY location
ORDER BY location;