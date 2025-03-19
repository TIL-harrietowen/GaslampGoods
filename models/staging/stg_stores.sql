with

source as (

    select * from {{ source('gaslamp_goods', 'raw_stores') }}

),

renamed as (

    select

        ----------  ids
        id as location_id,

        ---------- properties
        name as location_name,

        ---------- timestamps
        opened_at

    from source

)

select * from renamed