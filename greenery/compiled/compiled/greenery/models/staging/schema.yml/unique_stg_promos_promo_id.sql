
    
    

select
    promo_id as unique_field,
    count(*) as n_records

from "dbt"."dbt_meaghan_p"."stg_promos"
where promo_id is not null
group by promo_id
having count(*) > 1


