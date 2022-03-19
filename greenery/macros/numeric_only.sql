{% test numeric_only (model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }}
    
{% endtest %}