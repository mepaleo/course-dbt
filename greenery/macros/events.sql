
{% macro events () %}

{% set events = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') %}

{% endmacro %}