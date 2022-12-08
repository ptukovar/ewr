CREATE table player_position (
    position_id int not null identity primary key,
    position varchar(10) not null
)

insert into player_position (position)
select distinct primaryPosition
from player_info

alter table player_info
add primaryPosition_id int null

alter table player_info
add constraint FK_primaryPosition_id
    foreign key (primaryPosition_id)
references player_position(position_id)

update player_info set primaryPosition_id = (select position_id
                                            from player_position
                                            where position=primaryPosition)

alter table player_info add totalVenues int null

update player_info set player_info.totalVenues = (select count(distinct venue)
                                                  from player_info pi
                                                  JOIN game_skater_stats gss on pi.player_id = gss.player_id
                                                  JOIN game g on g.game_id = gss.game_id
                                                  group by pi.player_id
                                                  HAVING pi.player_id=player_info.player_id)

alter table player_info
    add age int

update player_info
set age = DATEDIFF(year, birthDate, GETDATE())

alter table player_info
    alter column age int not null

alter table game_plays
    add constraint check_goals_test
        check (goals_away >= 0 AND goals_away <=50 AND goals_home >= 0 AND goals_home <=50)

create table game_penalty
(
    penalty_id  int IDENTITY not null
        constraint game_penalty_pk
            primary key,
    game_id     int not null
        constraint game_penalty_game_null_fk
            references game (game_id),
    player_id   int not null
        constraint game_penalty_player_info_null_fk
            references player_info (player_id),
    penaltyType varchar(50),
    dateTime    varchar(15)
)
insert into game_penalty (game_id, player_id, penaltyType, dateTime)

select distinct game_id, player_id, secondaryType, dateTime
from game_plays
join game_plays_players gpp on game_plays.play_id = gpp.play_id
where event = 'Penalty' AND playerType = 'PenaltyOn'

update player_info set primaryPosition_id = (select position_id
                                            from player_position
                                            where position=primaryPosition)
select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter'


delete
from game_plays_players
where play_id IN (
    select play_id
    from game_plays
    join game g on g.game_id = game_plays.game_id
    where year(g.date_time_GMT) = 2000 AND g.venue = 'FleetCenter')


delete
from game_plays
where game_id IN (select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter')

delete
from game_goalie_stats
where game_id IN (select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter')

delete
from game_skater_stats
where game_id IN (select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter')

delete
from game_teams_stats
where game_id IN (select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter')

delete
from game_officials
where game_id IN (select game_id
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter')

delete
from game
where year(date_time_GMT) = 2000 AND venue = 'FleetCenter'
alter table player_info add totalVenues int null
update player_info set player_info.totalVenues = (select count(distinct venue)
                                                  from player_info pi
                                                  JOIN game_skater_stats gss on pi.player_id = gss.player_id
                                                  JOIN game g on g.game_id = gss.game_id
                                                  group by pi.player_id
                                                  HAVING pi.player_id=player_info.player_id)
