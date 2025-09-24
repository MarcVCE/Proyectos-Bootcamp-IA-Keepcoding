select 
  calls_ivr_id,
  billing_account_id
from keepcoding.ivr_detail
qualify row_number() over (
  partition by cast(calls_ivr_id as string) 
  order by 
    case 
      when upper(billing_account_id) = 'UNKNOWN' then 1  -- Prioridad baja para 'UNKNOWN'
      else 0 -- Prioridad alta para otros valores
    end asc, 
    billing_account_id asc 
) = 1