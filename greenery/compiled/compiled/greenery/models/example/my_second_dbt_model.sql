-- Use the `ref` function to select from other models

select *
from "dbt"."dbt_meaghan_p"."my_first_dbt_model"
where id = 1