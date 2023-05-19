with 
    fonte_produtos as (
        select *
        from {{ source('source_adventure','production_product') }}
    )

    , rev_produtos as (
        select
            cast(productid as int) as id_produto
            , cast(name as string) as prod_nome 		
            , cast(productnumber as string) as prod_codigo								
            , cast(color as string) as prod_cor	
            , cast(safetystocklevel as int) prod_estoque						
            , cast(standardcost as numeric) as prod_custo_producao
            , cast(listprice as numeric) as prod_custo_venda				
            , cast(daystomanufacture as int) as prod_prazo_fabricacao					
            , cast(productline as string) as prod_linha	
            , cast(class as string) as prod_classe	
            , cast(style as string) as prod_estilo
            , cast(productsubcategoryid as int) as prod_id_subcategoria					
            , cast(sellstartdate as timestamp) as vendaprod_data_inicio		
            , cast(sellenddate as timestamp) as vendaprod_data_fim						    
    from fonte_produtos
)

select *
from rev_produtos

    