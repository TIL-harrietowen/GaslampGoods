with 

order_items as (

    select * from {{ ref('stg_order_items') }}
),

orders as (
    
    select * from {{ ref('stg_orders')}}
),

products as (

    select * from {{ ref('stg_products') }}
),

supplies as (

    select * from {{ ref('fct_supplies') }}
),

joined as (

    select
        order_items.order_item_id,
        order_items.order_id,
        order_items.product_id,
        products.product_name,
        products.product_type,
        products.product_description,
        products.product_price,
        products.is_lifestyle_and_goods,
        products.is_food_and_drink,
        supplies.supply_cost,
        orders.ordered_at

    from order_items

    left join orders on order_items.order_id  = orders.order_id

    left join products on order_items.product_id = products.product_id
    
    left join supplies on order_items.product_id = supplies.product_id

)

select * from joined