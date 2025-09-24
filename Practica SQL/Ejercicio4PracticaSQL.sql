select 
    calls_ivr_id,
    case
        when calls_vdn_label like 'ATC%' then 'FRONT'
        when calls_vdn_label like 'TECH%' then 'TECH'
        when calls_vdn_label like 'ABSORPTION%' then 'ABSORPTION'
        else 'RESTO'
    end as vdn_aggregation
from keepcoding.ivr_detail;