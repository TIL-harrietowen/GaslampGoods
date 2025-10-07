{{
    config(
        materialization ="incremental",
        incremental_strategy ="append"
    )
}}

with

orders as (

    select * from {{ ref('stg_orders') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

stores as (

    select * from {{ ref('stg_stores') }}

),

joined as (

    select
        orders.*,
        customers.customer_name,
        stores.location_name,
        stores.opened_at as location_opened_at

    from orders

    left join customers on orders.customer_id = customers.customer_id
    left join stores on orders.location_id = stores.location_id
)

select * from joined