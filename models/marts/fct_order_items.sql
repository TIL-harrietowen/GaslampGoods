with 

order_items as (

    select * from {{ ref('stg_order_items') }}

),

orders as (
    
    select * from {{ ref('int_orders')}}
),

products as (

    select * from {{ ref('stg_products') }}

),

supplies as (

  select * from {{ ref('stg_supplies') }}

),

order_supplies_summary as (

  select
    product_id,
    sum(supply_cost) as supply_cost

  from supplies

  group by product_id
),



joined as (
    select
        order_items.*,
        orders.location_id,
        orders.location_name,
        orders.location_opened_at,
        orders.customer_id,
        orders.customer_name,
        orders.ordered_at,
        orders.order_total,
        orders.tax_paid,
        orders.subtotal,
        products.product_name,
        products.product_type,
        products.product_description,
        products.product_price,
        products.is_lifestyle_and_goods,
        products.is_food_and_drink,
        order_supplies_summary.supply_cost,

    from order_items

    left join orders on order_items.order_id  = orders.order_id
    
    left join products on order_items.product_id = products.product_id
    
    left join order_supplies_summary on order_items.product_id = order_supplies_summary.product_id
    
)

select * from joined