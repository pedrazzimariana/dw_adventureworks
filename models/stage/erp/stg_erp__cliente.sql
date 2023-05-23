with 
    fonte_cliente as (
        select *
        from {{ source('source_adventure','sales_customer') }}
    )

    , rev_cliente as (
        select
            cast(customerid as int) as id_cliente					
            , cast(personid as int) as id_entidade_negocio										
            , cast(storeid as int) as id_loja
            , cast(territoryid as int) as id_territorio													    
    from fonte_cliente
)

select *
from rev_cliente