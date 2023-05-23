with 
    fonte_endereco as (
        select *
        from {{ source('source_adventure','person_address') }}
    )

    , rev_endereco as (
        select
            cast(addressid as int) as id_endereco
            , cast(stateprovinceid as int) as id_estado					
            , cast(addressline1 as string) as endereco					
            , cast(addressline2 as string) as complemento_endereco					
            , cast(city as string) as cidade							
            , cast(spatiallocation as string) as localizacao_espacial																						    
    from fonte_endereco
)

select *
from rev_endereco