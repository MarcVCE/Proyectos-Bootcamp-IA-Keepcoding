select 
  calls_ivr_id,
  customer_phone
from keepcoding.ivr_detail
qualify row_number() over (
  partition by cast(calls_ivr_id as string) 
  order by 
    case 
      when upper(customer_phone) = 'UNKNOWN' then 1  -- Prioridad baja para 'UNKNOWN'
      else 0 -- Prioridad alta para otros valores
    end asc, 
    customer_phone asc 
) = 1