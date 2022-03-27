
  create view "dbt"."dbt_meaghan_p"."fct_product_conversions_macro__dbt_tmp" as (
    

with fct_events as(
    select * from "dbt"."dbt_meaghan_p"."fct_events"
)

SELECT
     session_id,
     created_at_utc,
     user_id,
     product_id,
     order_id
    ,
    SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
    ,
    SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
    ,
    SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
    ,
    SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped
    
    FROM fct_events

group by 1,2,3,4,5
  );