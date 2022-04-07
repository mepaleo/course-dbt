

  create  table "dbt"."dbt_meaghan_p"."fct_user_sessions__dbt_tmp"
  as (
    
with session_length as (
select
    session_id,
    (min(created_at_utc)::timestamp) as session_start_time,
    (max(created_at_utc)::timestamp) as session_end_time
from "dbt"."dbt_meaghan_p"."fct_events"
group by 
session_id
)

SELECT
    fe.session_id,
    fe.user_id,
    du.full_name,
    fe.page_view,
    fe.add_to_cart,
    fe.checkout,
    fe.package_shipped,
    fe.product_id,
    fe.order_id,
    sl.session_start_time,
    sl.session_end_time,
    (date_part('day', sl.session_end_time::timestamp - sl.session_start_time::timestamp) * 24 +
    date_part('hour', sl.session_end_time::timestamp - sl.session_start_time::timestamp) * 60 +
    date_part('minute', sl.session_end_time::timestamp - sl.session_start_time::timestamp))
    AS session_lengh_minutes
FROM "dbt"."dbt_meaghan_p"."fct_events" fe
LEFT JOIN "dbt"."dbt_meaghan_p"."dim_users" du
    ON fe.user_id = du.user_id
LEFT JOIN session_length sl
    ON fe.session_id = sl.session_id

        -- DATEDIFF(MINUTE, sl.session_end_time, sl.session_start_time) AS session_length
  );