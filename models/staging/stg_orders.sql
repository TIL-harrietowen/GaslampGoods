{{
    config(
        materialized = 'table',
        unique_key = 'order_id'
    )
}}

with

source as (

    select * from {{ source('gaslamp_goods', 'orders') }}

),

renamed as (

    select

        ----------  ids
        id as order_id,
        store_id as location_id,
        customer as customer_id,

        ---------- properties
        order_total,
        tax_paid,
        subtotal,

        ---------- timestamps
        ordered_at

    from source

)

select * from renamed