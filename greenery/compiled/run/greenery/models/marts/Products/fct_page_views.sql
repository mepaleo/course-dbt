

  create  table "dbt"."dbt_meaghan_p"."fct_page_views__dbt_tmp"
  as (
    
    select 
        event_id as page_view_id,
        session_id,
        user_id,
        page_url,
        created_at_utc,
        order_id,
        session_product_id
FROM "dbt"."dbt_meaghan_p"."fct_events"
WHERE event_type = 'page_view'
  );