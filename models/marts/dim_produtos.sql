with 
    produtos as (
        select *		
        from {{ ref('stg_erp__produto') }}
    )

    , joining_produto as (
        select
            row_number() over (order by produtos.id_produto) as sk_produto -- auto-incremental surrogate key
            , produtos.id_produto
            , produtos.id_subcategoria
            , produtos.prod_nome 		
            , produtos.prod_codigo								
            , produtos.prod_cor	
            , produtos.prod_estoque						
            , produtos.prod_custo_producao
            , produtos.prod_custo_venda								
            , produtos.prod_linha	
            , produtos.prod_classe			
            , produtos.vendaprod_data_inicio		
            , produtos.vendaprod_data_fim		
        from produtos

    )

select *
from joining_produto