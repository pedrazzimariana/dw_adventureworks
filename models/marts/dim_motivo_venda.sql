with 
    motivo_venda as (
        select *
        from {{ ref('stg_erp__motivo_venda') }}
    )

    , joining_motivo_venda as (
        select
            row_number() over (order by motivo_venda.id_motivo_venda) as sk_motivo_venda -- auto-incremental surrogate key
            , motivo_venda.id_motivo_venda	
            , motivo_venda.motivo_venda		
            , motivo_venda.categoria_motivo				
        from motivo_venda
        
    )

select *
from joining_motivo_venda