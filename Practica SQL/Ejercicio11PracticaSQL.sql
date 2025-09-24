select 
  calls_ivr_id,
  calls_phone_number,
  max(case 
    when (select count(*) from keepcoding.ivr_detail previous_or_future_call
          where previous_or_future_call.calls_phone_number = current_call.calls_phone_number
            and previous_or_future_call.calls_start_date between current_call.calls_start_date - interval 24 
            hour and current_call.calls_start_date
            and previous_or_future_call.calls_ivr_id != current_call.calls_ivr_id) > 0 
    then 1 else 0 end
  ) as repeated_phone_24H,
  max(case 
    when (select count(*) from keepcoding.ivr_detail previous_or_future_call
          where previous_or_future_call.calls_phone_number = current_call.calls_phone_number
            and previous_or_future_call.calls_start_date between current_call.calls_start_date 
            and current_call.calls_start_date + interval 24 hour
            and previous_or_future_call.calls_ivr_id != current_call.calls_ivr_id) > 0 
    then 1 else 0 end
  ) as cause_recall_phone_24H
from keepcoding.ivr_detail current_call
group by calls_ivr_id, calls_phone_number;