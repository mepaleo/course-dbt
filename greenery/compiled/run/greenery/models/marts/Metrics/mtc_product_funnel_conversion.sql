

  create  table "dbt"."dbt_meaghan_p"."mtc_product_funnel_conversion__dbt_tmp"
  as (
    

SELECT
ROUND(((CAST(funnel_level_two_add_to_cart AS DECIMAL)/CAST(funnel_level_one_page_view AS DECIMAL))*100),2) AS view_to_cart_conversion,
ROUND(((CAST(funnel_level_three_checkout AS DECIMAL)/CAST(funnel_level_two_add_to_cart AS DECIMAL))*100),2) AS cart_to_checkout_conversion,
ROUND(((CAST(funnel_level_three_checkout AS DECIMAL)/CAST(funnel_level_one_page_view AS DECIMAL))*100),2) AS view_to_checkout_conversion
FROM "dbt"."dbt_meaghan_p"."mtc_product_funnel"
  );