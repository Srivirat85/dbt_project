-- models/stadium_info.sql
{{ config(materialized="table") }}

with
    new_stadiums as (
        select distinct
            md5(
                concat(coalesce(venue, 'NULL'), '|', coalesce(city, 'NULL'))
            ) as stadium_id,
            venue as stadium_name,
            city as stadium_city
        from {{ source("DBT_PROJECT", "IPL_MATCH_DATA") }}
    )

-- Select clause depends on whether it's an incremental run or a full refresh.
select ns.stadium_id, ns.stadium_name, ns.stadium_city
from new_stadiums ns
order by
    ns.stadium_name,
    ns.stadium_city

    -- -- For incremental loads, filter out records that are already in the table.
    -- {% if is_incremental() %}
    -- LEFT JOIN {{ this }} existing
    -- ON ns.stadium_id = existing.stadium_id
    -- WHERE existing.stadium_id IS NULL
    -- {% endif %}
    
