create or replace table keepcoding.ivr_detail as 
    select
        ca.ivr_id as calls_ivr_id,
        ca.phone_number as calls_phone_number,
        ca.ivr_result as calls_ivr_result,
        ca.vdn_label as calls_vdn_label,
        ca.start_date as calls_start_date,
        FORMAT_TIMESTAMP('%Y%m%d', ca.start_date) as calls_start_date_id,
        ca.end_date as calls_end_date,
        FORMAT_TIMESTAMP('%Y%m%d', ca.end_date) as calls_end_date_id,
        ca.total_duration as calls_total_duration,
        ca.customer_segment as calls_customer_segment,
        ca.ivr_language as calls_ivr_language,
        ca.steps_module as calls_steps_module,
        ca.module_aggregation as calls_module_aggregation,
        mod.module_sequece as module_sequece,
        mod.module_name as module_name,
        mod.module_duration as module_duration,
        mod.module_result as module_result,
        st.step_sequence as step_sequence,
        st.step_name as step_name,
        st.step_result as step_result,
        st.step_description_error as step_description_error,
        st.document_type as document_type,
        st.document_identification as document_identification,
        st.customer_phone as customer_phone,
        st.billing_account_id as billing_account_id
    from keepcoding.ivr_calls ca
    inner join keepcoding.ivr_modules mod on ca.ivr_id = mod.ivr_id
    inner join keepcoding.ivr_steps st on ca.ivr_id = st.ivr_id
    ;

select * from keepcoding.ivr_detail;