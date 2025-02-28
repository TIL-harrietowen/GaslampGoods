with

source as (

    select * from {{ source('gaslamp_goods', 'payment') }}

),

renamed as (

    select

        ----------  ids
        id as payment_id,
        orderid as order_id,

        ---------- properties
        paymentmethod as payment_method,
        status,
        amount,

        ---------- timestamps
        created as payment_created_at,
        _batched_at as payment_batched_at


    from source

)

select * from renamed