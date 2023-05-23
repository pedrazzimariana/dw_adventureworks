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
            row_number() over (order by clientes.id_cliente) as sk_cliente -- auto-incremental surrogate key
            , clientes.id_cliente
            , clientes.id_entidade_negocio		
            , clientes.id_loja
            , clientes.id_territorio
            , info_pessoal.categoria			
            , info_pessoal.titulo_nome
            , info_pessoal.primeiro_nome
            , info_pessoal.nome_meio
            , info_pessoal.ultimo_nome
            , info_pessoal.sufixo_nome 					
        from clientes
        inner join info_pessoal on clientes.id_entidade_negocio = info_pessoal.id_entidade_negocio
    )

select *
from joining_clientes