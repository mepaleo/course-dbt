{{
  config(
    materialized='table'
  )
}}

  SELECT 
        session_id,
        max(created_at_utc) AS last_session_event_time,
        min(created_at_utc) AS first_session_event_time
    FROM {{ ref('fct_events') }}
    GROUP BY 
    session_id

