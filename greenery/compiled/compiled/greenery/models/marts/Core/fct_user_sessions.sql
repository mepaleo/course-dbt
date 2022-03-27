

with session_length as (
    select
        session_id,
        min(created_at_utc) as first_event_time,
        max(created_at_utc) as last_event_time
    from "dbt"."dbt_meaghan_p"."fct_events"
    group by 
    session_id
)



select 
    se.session_id,
    se.user_id,
    du.full_name,
    se.page_view,
    se.package_shipped,
    se.session_product_id,
    se.order_id,
    (sl.last_event_time::timestamp-sl.first_event_time::timestamp) AS session_length
from "dbt"."dbt_meaghan_p"."int_session_events" se
left join "dbt"."dbt_meaghan_p"."dim_users" du
    on se.user_id = du.user_id
left join session_length sl
    on se.session_id = sl.session_id