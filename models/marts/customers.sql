with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

customer_orders as (

    select
        customer_id,
        round((count(order_id)/4),0) as orders_count,
        min(ordered_at) as first_order_date,
        max(ordered_at) as most_recent_order_date,
        sum(order_total) as lifetime_value
    from orders
    group by 1
),

final as (
    select
        customers.customer_id,
        customers.customer_name,
        COALESCE(customer_orders.orders_count,0) as orders_per_customer,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        COALESCE(customer_orders.lifetime_value,0) as customer_lifetime_value
    from customer_orders

    left join customers
        on customer_orders.customer_id = customers.customer_id

)

select * from final
order by orders_per_customer desc
