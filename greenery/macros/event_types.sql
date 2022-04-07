
{% macro event_types(table, column) %}

{% set event_types = dbt_utils.get_query_results_as_dict("select DISTINCT event_type from" ~ ref('stg_events'))%}

{% for event_type in event_types['event_type'] %},
SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{event_type}}
{% endfor %}

{% endmacro %}