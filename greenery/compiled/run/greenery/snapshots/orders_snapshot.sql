
      update "dbt"."snapshots"."orders_snapshot"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "orders_snapshot__dbt_tmp225548822651" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "dbt"."snapshots"."orders_snapshot".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "dbt"."snapshots"."orders_snapshot".dbt_valid_to is null;

    insert into "dbt"."snapshots"."orders_snapshot" ("order_id", "user_id", "promo_id", "address_id", "created_at", "order_cost", "shipping_cost", "order_total", "tracking_id", "shipping_service", "estimated_delivery_at", "delivered_at", "status", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."order_id",DBT_INTERNAL_SOURCE."user_id",DBT_INTERNAL_SOURCE."promo_id",DBT_INTERNAL_SOURCE."address_id",DBT_INTERNAL_SOURCE."created_at",DBT_INTERNAL_SOURCE."order_cost",DBT_INTERNAL_SOURCE."shipping_cost",DBT_INTERNAL_SOURCE."order_total",DBT_INTERNAL_SOURCE."tracking_id",DBT_INTERNAL_SOURCE."shipping_service",DBT_INTERNAL_SOURCE."estimated_delivery_at",DBT_INTERNAL_SOURCE."delivered_at",DBT_INTERNAL_SOURCE."status",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "orders_snapshot__dbt_tmp225548822651" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  