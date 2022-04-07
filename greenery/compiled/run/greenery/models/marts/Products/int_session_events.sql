

  create  table "dbt"."dbt_meaghan_p"."int_session_events__dbt_tmp"
  as (
    

with fct_events as (
    select * from "dbt"."dbt_meaghan_p"."fct_events")

SELECT
    session_id,
    created_at_utc,
    user_id,
    session_product_id,
    order_id
FROM fct_events

group by 1,2,3,4,5
  );