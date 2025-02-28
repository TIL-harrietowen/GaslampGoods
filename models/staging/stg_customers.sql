with

source as (

    select * from {{ source('gaslamp_goods', 'customers') }}

),

renamed as (

    select

        ----------  ids
        id as customer_id,

        ---------- properties
        name

    from source

)

select * from renamed