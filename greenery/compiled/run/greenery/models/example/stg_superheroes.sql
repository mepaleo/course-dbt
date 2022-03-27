

  create  table "dbt"."dbt_meaghan_p"."stg_superheroes__dbt_tmp"
  as (
    

SELECT 
    id AS superhero_id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    NULLIF(height, -99) AS height,
    publisher,
    skin_color,
    alignment,
    NULLIF(weight, -99) AS weight
FROM dbt.public.superheroes
  );