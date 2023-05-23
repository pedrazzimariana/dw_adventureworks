with 
    cartao_credito as (
        select *		
        from {{ ref('stg_erp__cartao_credito') }}
    )

    , joining_cartao_credito as (
        select
            row_number() over (order by cartao_credito.id_cartao_credito) as sk_cartao_credito -- auto-incremental surrogate key
            , cartao_credito.id_cartao_credito
            , cartao_credito.tipo_cartao	
        from cartao_credito
    )

select *
from joining_cartao_credito