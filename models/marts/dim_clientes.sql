with 
    clientes as (
        select *		
        from {{ ref('stg_erp__cliente') }}
    )

    , info_pessoal as (
        select *
        from {{ ref('stg_erp__info_pessoal') }}
    )

    , joining_clientes as (
        select
            row_number() over (order by info_pessoal.id_entidade_negocio) as sk_entidade_negocio -- auto-incremental surrogate key
            , clientes.id_cliente		
            , clientes.fk_entidade_negocio
            , clientes.fk_loja
            , clientes.fk_territorio
            , info_pessoal.id_entidade_negocio
            , info_pessoal.categoria			
            , info_pessoal.titulo_nome
            , info_pessoal.primeiro_nome
            , info_pessoal.nome_meio
            , info_pessoal.ultimo_nome
            , info_pessoal.sufixo_nome 					
        from info_pessoal
        inner join clientes on clientes.fk_entidade_negocio = info_pessoal.id_entidade_negocio
    )

select *
from joining_clientes