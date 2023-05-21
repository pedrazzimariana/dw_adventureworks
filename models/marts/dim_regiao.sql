with 
    endereco as (
        select *		
        from {{ ref('stg_erp__endereco') }}
    )

    , estado as (
        select *
        from {{ ref('stg_erp__estado') }}
    )

     , estado_pais as (
        select *
        from {{ ref('stg_erp__estado_pais') }}
    )

    , joining_regiao as (
        select
            row_number() over (order by endereco.id_endereco) as sk_endereco -- auto-incremental surrogate key
            , endereco.id_endereco
            , endereco.endereco			
            , endereco.complemento_endereco
            , endereco.cidade
            , endereco.fk_estado
            , endereco.localizacao_espacial
            , estado.id_estado
            , estado.cod_estado
            , estado.codfk_estado_pais
            , estado.nome_estado
            , estado.fk_territorio
            , estado_pais.codid_estado_pais
            , estado_pais.nome_estado_pais						
        from endereco
        left join estado on estado.id_estado = endereco.fk_estado
        left join estado_pais on estado_pais.codid_estado_pais = estado.codfk_estado_pais
    )

select *
from joining_regiao