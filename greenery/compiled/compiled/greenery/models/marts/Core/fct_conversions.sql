


SELECT 
  (cast(count(distinct case when order_id is not null then session_id else null end) as decimal)/
  cast(COUNT(distinct session_id) as decimal))*100 as conversion_rate
  FROM dbt."dbt_meaghan_p".fct_events