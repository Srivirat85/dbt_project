-- models/marts/dim_players.sql

with all_players as (

    select player_of_match_id as player_id, player_of_match as player_name
    from {{ ref('stg_ipl_match_data') }}

    union all select team_1_player_1_id, team_1_player_1 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_2_id, team_1_player_2 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_3_id, team_1_player_3 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_4_id, team_1_player_4 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_5_id, team_1_player_5 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_6_id, team_1_player_6 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_7_id, team_1_player_7 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_8_id, team_1_player_8 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_9_id, team_1_player_9 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_10_id, team_1_player_10 from {{ ref('stg_ipl_match_data') }}
    union all select team_1_player_11_id, team_1_player_11 from {{ ref('stg_ipl_match_data') }}

    union all select team_2_player_1_id, team_2_player_1 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_2_id, team_2_player_2 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_3_id, team_2_player_3 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_4_id, team_2_player_4 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_5_id, team_2_player_5 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_6_id, team_2_player_6 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_7_id, team_2_player_7 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_8_id, team_2_player_8 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_9_id, team_2_player_9 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_10_id, team_2_player_10 from {{ ref('stg_ipl_match_data') }}
    union all select team_2_player_11_id, team_2_player_11 from {{ ref('stg_ipl_match_data') }}

),
-- Count how many times each player_id and player_name pair occurs
player_name_counts as (
    select
        player_id,
        player_name,
        count(*) as name_count
    from all_players
    where player_id is not null
    group by player_id, player_name
),
-- Pick the most frequent name per player_id
ranked_names as (
    select
        player_id,
        player_name,
        row_number() over (
            partition by player_id order by name_count desc, player_name
        ) as name_rank
    from player_name_counts
)

select
    player_id,
    player_name
from ranked_names
where name_rank = 1
