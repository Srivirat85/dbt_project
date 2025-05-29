-- models/marts/dim_umpires.sql
with umpires as (
  select umpire_1_id as umpire_id, umpire_1 as umpire_name from {{ ref('stg_ipl_match_data') }}
  union
  select umpire_2_id, umpire_2 from {{ ref('stg_ipl_match_data') }}
  union
  select tv_umpires_id, tv_umpires from {{ ref('stg_ipl_match_data') }}
  union
  select reserve_umpires_id, reserve_umpires from {{ ref('stg_ipl_match_data') }}
  union
  select match_referees_id, match_referees from {{ ref('stg_ipl_match_data') }}
)

select distinct umpire_id, umpire_name
from umpires
where umpire_id is not null
