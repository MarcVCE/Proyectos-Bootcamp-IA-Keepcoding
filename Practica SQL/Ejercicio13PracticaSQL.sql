create or replace function keepcoding.clean_integer(integer_value int64)
returns int64 as (
  coalesce(integer_value, -999999)
);