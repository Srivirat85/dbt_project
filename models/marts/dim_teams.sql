-- models/marts/dim_teams.sql
with teams as (
  select team_1 as team_name from {{ ref('stg_ipl_match_data') }}
  union
  select team_2 from {{ ref('stg_ipl_match_data') }}
)

select distinct team_name
from teams
where team_name is not null
