with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

customer_orders as (

    select
        customer_id,
        count(order_id) as orders_count,
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
        COALESCE(cust_ord.orders_count,0) as orders_per_customer,
        cust_ord.first_order_date,
        cust_ord.most_recent_order_date,
        COALESCE(cust_ord.lifetime_value,0) as customer_lifetime_value
    from customers

    left join customer_orders as cust_ord 
        on customers.customer_id = cust_ord.customer_id

)

select * from final
