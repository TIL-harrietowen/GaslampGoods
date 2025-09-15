{% macro column_two_group_categorization(column, category_one, category_two) %}
    {%- set category_one_adjusted = category_one 
        | trim | lower | replace(' ', '_') | replace('&', 'and') 
    -%}
    {%- set category_two_adjusted = category_two 
        | trim | lower | replace(' ', '_') | replace('&', 'and') 
    %}

    case
        when {{ column }} != '{{ category_one }}' then 1
        else 0
    end as is_{{ category_two_adjusted }},

    case
        when {{ column }} = '{{ category_one }}' then 1
        else 0
    end as is_{{ category_one_adjusted }}

{% endmacro %}
