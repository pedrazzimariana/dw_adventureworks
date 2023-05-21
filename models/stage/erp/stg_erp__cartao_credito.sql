with 
    fonte_cartao_credito as (
        select *
        from {{ source('source_adventure','sales_creditcard') }}
    )

    , rev_cartao_credito as (
        select
            cast(creditcardid as int) as id_cartao_credito									
            , cast(cardtype as string) as tipo_cartao																		    
    from fonte_cartao_credito
)

select *
from rev_cartao_credito