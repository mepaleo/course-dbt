
    
    

with all_values as (

    select
        repeat_customer as value_field,
        count(*) as n_records

    from "dbt"."dbt_meaghan_p"."dim_users"
    group by repeat_customer

)

select *
from all_values
where value_field not in (
    'Repeat','One-time','Never'
)


