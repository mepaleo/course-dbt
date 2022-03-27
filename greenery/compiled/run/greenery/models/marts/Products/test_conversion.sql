

  create  table "dbt"."dbt_meaghan_p"."test_conversion__dbt_tmp"
  as (
    

with product_views_purchase as(
SELECT 
  product_name,
  sum(page_view) as product_views,
  (cast(count(distinct case when order_id is not null then session_id else null end) as decimal)) as product_purchases
  FROM "dbt"."dbt_meaghan_p"."fct_product_conversions"
  GROUP BY
product_name)

SELECT
  product_name,
  product_purchases,
  product_views,
  ROUND((product_purchases/product_views)*100,2) as product_conversion
  from product_views_purchase
  );