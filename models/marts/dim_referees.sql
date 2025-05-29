-- ==============================
-- models/marts/dim_referees.sql
-- ==============================
select distinct
  match_referees_id as referee_id,
  match_referees as referee_name
from {{ ref('stg_ipl_match_data') }}