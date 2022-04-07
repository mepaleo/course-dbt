{{
  config(
    materialized='table'
  )
}}

SELECT 
  (cast(count(distinct case when order_id is not null then session_id else null end) as decimal)/
  cast(COUNT(distinct session_id) as decimal))*100 as conversion_rate
  FROM {{ ref('fct_events')}}
