with 
    fonte_info_pessoal as (
        select *
        from {{ source('source_adventure','person_person') }}
    )

    , rev_info_pessoal as (
        select
            cast(businessentityid as int) as id_entidade_negocio					
            , cast(persontype as string) as categoria										
            , cast(title as string) as titulo_nome
            , cast(firstname as string) as primeiro_nome
            , cast(middlename as string) as nome_meio
            , cast(lastname as string) as ultimo_nome
            , cast(suffix as string) as sufixo_nome 																	    
    from fonte_info_pessoal
)

select *
from rev_info_pessoal