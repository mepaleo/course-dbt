
{% macro event_types() %}

{% set event_types = dbt_utils.get_query_results_as_dict("select DISTINCT event_type from" ~ ref('stg_events'))%}

{% endmacro %}