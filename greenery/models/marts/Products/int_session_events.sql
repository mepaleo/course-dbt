{{
  config(
    materialized='table'
  )
}}

with fct_events as (
    select * from {{ ref('fct_events') }}

{% 
set event_types = dbt_utils.get_query_results_as_dict(
  "select DISTINCT event_type from" ~ ref('fct_events')
  )
%}
)

SELECT
    session_id,
    created_at_utc,
    user_id,
    session_product_id,
    order_id
    {% for event_type in event_types['event_type'] %},
    SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{event_type}}
    {% endfor %}
FROM fct_events

{{dbt_utils.group_by(5)}}
