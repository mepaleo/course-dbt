

  create  table "dbt"."dbt_meaghan_p"."fct_product_conversions__dbt_tmp"
  as (
    

with products_purchased as(
  SELECT
  pr.name as product_name,
  se.session_product_id,
  sum(se.checkout) as prod_checkout,
  sum(se.page_view) as prod_page_views,
  sum(se.add_to_cart) as prod_added_to_cart,
  sum(se.package_shipped)as prod_package_shipped,
  (cast(count(distinct case when order_id is not null then session_id else null end) as decimal)) as prod_purchased
FROM "dbt"."dbt_meaghan_p"."int_session_events" se
LEFT JOIN "dbt"."dbt_meaghan_p"."dim_products" pr
on pr.product_id = se.session_product_id
GROUP BY
  pr.name,
  se.session_product_id)

SELECT
  product_name,
  session_product_id,
  prod_checkout,
  prod_page_views,
  prod_added_to_cart,
  prod_package_shipped,
  prod_purchased,
  ROUND((prod_purchased/prod_page_views)*100,2) as product_conversion
FROM products_purchased
  );