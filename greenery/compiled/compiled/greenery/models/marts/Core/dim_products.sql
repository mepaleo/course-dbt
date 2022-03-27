

with products_ordered as(
    SELECT 
        product_id,
        sum(quantity) as count_products_ordered
FROM dbt.public.order_items
GROUP BY product_id)

select 
    pr.product_id,
    pr.name,
    pr.price,
    pr.inventory,
    pc.count_products_ordered
FROM "dbt"."dbt_meaghan_p"."stg_products" pr
LEFT JOIN products_ordered pc
ON pr.product_id=pc.product_id