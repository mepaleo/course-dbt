

  create  table "dbt"."dbt_meaghan_p"."mtc_product_conversion__dbt_tmp"
  as (
    

with product_event_count as(
SELECT
product_name,
product_id,
sum(checkout) as product_checkout_count,
sum(page_view) as product_page_views_count,
sum(add_to_cart) as product_added_to_cart_count,
sum(package_shipped)as product_package_shipped_count,
(cast(count(distinct case when order_id is not null then order_id else null end) as decimal)) as product_purchased
FROM "dbt"."dbt_meaghan_p"."fct_events" 
group by 1,2)

SELECT
product_name,
product_id,
product_checkout_count,
product_page_views_count,
product_added_to_cart_count,
product_package_shipped_count,
product_purchased,
ROUND((product_checkout_count/product_page_views_count)*100,2) as product_conversion
from product_event_count
  );