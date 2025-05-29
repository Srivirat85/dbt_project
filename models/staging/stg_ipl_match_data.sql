-- ==============================
-- models/staging/stg_ipl_match_data.sql
-- ==============================

with raw as (
  select * from {{ source('DBT_PROJECT', 'IPL_MATCH_DATA') }}
)

select
  -- Match-Level Fields
  match_id,
  coalesce(dates_1, dates_2, dates_3, dates_4, dates_5, dates_6) as match_date,
  city,
  gender,
  match_type,
  match_number,
  season,
  team_type,
  team_1,
  team_2,
  toss_decision,
  toss_winner,
  venue,
  winner,
  match_result,
  method,
  overs,
  player_of_match,
  player_of_match_id,
  umpire_1,
  umpire_1_id,
  umpire_2,
  umpire_2_id,
  tv_umpires,
  tv_umpires_id,
  reserve_umpires,
  reserve_umpires_id,
  match_referees,
  match_referees_id,
  event_name,
  event_stage,

  -- Team Player Info
  team_1_player_1, team_1_player_1_id,
  team_1_player_2, team_1_player_2_id,
  team_1_player_3, team_1_player_3_id,
  team_1_player_4, team_1_player_4_id,
  team_1_player_5, team_1_player_5_id,
  team_1_player_6, team_1_player_6_id,
  team_1_player_7, team_1_player_7_id,
  team_1_player_8, team_1_player_8_id,
  team_1_player_9, team_1_player_9_id,
  team_1_player_10, team_1_player_10_id,
  team_1_player_11, team_1_player_11_id,
  team_2_player_1, team_2_player_1_id,
  team_2_player_2, team_2_player_2_id,
  team_2_player_3, team_2_player_3_id,
  team_2_player_4, team_2_player_4_id,
  team_2_player_5, team_2_player_5_id,
  team_2_player_6, team_2_player_6_id,
  team_2_player_7, team_2_player_7_id,
  team_2_player_8, team_2_player_8_id,
  team_2_player_9, team_2_player_9_id,
  team_2_player_10, team_2_player_10_id,
  team_2_player_11, team_2_player_11_id,

  -- Delivery-Level Info
  innings,
  super_over,
  team,
  over_number,
  delivery_number,
  batter,
  bowler,
  non_striker,
  replacement_in,
  replacement_out,
  replacement_team,
  replacement_reason,
  runs_batter,
  runs_extras,
  runs_total,
  powerplay,

  -- Wicket Info
  wicket_kind,
  wicket_player_out,
  wicket_fielder_1,
  wicket_fielder_2,

  -- Extras Info
  extras_wides,
  extras_noballs,
  extras_byes,
  extras_legbyes,
  extras_penalty,

  -- Review Info
  review_by,
  review_umpire,
  review_batter,
  review_decision,
  review_type,
  review_umpires_call,

  -- Target Info
  target_remaining,
  balls_remaining

from raw
