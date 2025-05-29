-- models/marts/dim_matches.sql
with ranked as (
  select *,
    row_number() over (partition by match_id order by match_date desc) as row_num
  from {{ ref('stg_ipl_match_data') }}
)

select
  match_id,
  match_date,
  city,
  gender,
  match_type,
  match_number,
  season,
  toss_decision,
  toss_winner,
  venue,
  winner,
  match_result,
  method,
  overs
from ranked
where row_num = 1
