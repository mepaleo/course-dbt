
  create view "dbt"."dbt_meaghan_p"."stg_events__dbt_tmp" as (
    
    select 
        event_id,
        session_id,
        user_id,
        page_url,
        created_at as created_at_utc,
        event_type,
        order_id,
        product_id  
FROM dbt.public.events
  );