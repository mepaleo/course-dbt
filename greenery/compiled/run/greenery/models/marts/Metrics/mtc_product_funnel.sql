

  create  table "dbt"."dbt_meaghan_p"."mtc_product_funnel__dbt_tmp"
  as (
    

with funnel_level as(
SELECT
 session_id,
 count(DISTINCT case when page_view > 0 THEN page_view else null end) as funnel_level_one,
 count(DISTINCT case when add_to_cart > 0 THEN add_to_cart  else null end) as funnel_level_two,
 count(DISTINCT case when checkout > 0 THEN checkout else null end) as funnel_level_three
FROM "dbt"."dbt_meaghan_p"."fct_user_sessions"
group by 1)


SELECT  
 COUNT(DISTINCT session_id) as funnel_total_sessions,
 SUM(funnel_level_one) as funnel_level_one_page_view,
 SUM(funnel_level_two) as funnel_level_two_add_to_cart,
 SUM(funnel_level_three) as funnel_level_three_checkout
FROM funnel_level
  );