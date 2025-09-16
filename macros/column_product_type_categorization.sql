{% macro product_type_categorization(column, category_one, category_two) %}

    case
        when {{ column }} != '{{ category_one }}' then '{{ category_two }}'
        else '{{ category_one }}'
    end as product_type_category

{% endmacro %}
