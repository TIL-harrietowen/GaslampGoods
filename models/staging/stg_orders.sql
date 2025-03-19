with

source as (

    select * from {{ source('gaslamp_goods', 'raw_orders') }}

),

renamed as (

    select

        ----------  ids
        id as order_id,
        store_id as location_id,
        customer as customer_id,

        ---------- timestamps
        ordered_at,

        ---------- properties
        order_total,
        tax_paid,
        subtotal

    from source

)

select * from renamed