
select
    e.session_id,
    e.user_id,
    (st.last_session_event_time-st.first_session_event_time) as session_length,
    (case when e.created_at_utc= st.first_session_event_time then e.event_type end) as first_event_type,
    (case when e.created_at_utc= st.last_session_event_time then e.event_type end) as last_event_type
FROM "dbt"."dbt_meaghan_p"."fct_events" e
LEFT JOIN "dbt"."dbt_meaghan_p"."int_sessions" st
ON e.session_id=st.session_id
WHERE e.created_at_utc=st.last_session_event_time or e.created_at_utc=st.first_session_event_time
GROUP BY
    e.session_id,
    e.user_id, 
    st.last_session_event_time,
    st.first_session_event_time,
    e.created_at_utc,
    e.event_type