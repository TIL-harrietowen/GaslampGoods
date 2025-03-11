with 

supplies as (

    select * from {{ ref('stg_supplies') }}
),

final as (
    select
        product_id,
        sum(supply_cost) as supply_cost

    from supplies
    group by product_id

)

select * from final