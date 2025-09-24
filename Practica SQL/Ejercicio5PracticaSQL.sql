select 
  calls_ivr_id,
  document_type,
  document_identification,
from keepcoding.ivr_detail
qualify row_number() over (
  partition by cast(calls_ivr_id as string) 
  order by 
    case 
      when upper(document_type) = 'UNKNOWN' then 1  -- Prioridad baja para 'UNKNOWN'
      else 0 -- Prioridad alta para otros valores
    end asc, 
    document_type asc 
) = 1


