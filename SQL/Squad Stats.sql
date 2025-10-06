SELECT 
    Squad,
    AVG(Age) AS Avg_Age,
    SUM(Gls) AS Total_Goals,
    CAST(SUM(Gls) * 1.0 / 38 AS decimal(10,2)) AS Goals_per_Match,
    COUNT(Player) AS Total_Players,
    COUNT(CASE WHEN Pos1 = 'FW' THEN 1 END) AS Forwards,
    COUNT(CASE WHEN Pos1 = 'MF' THEN 1 END) AS Midfielders,
    COUNT(CASE WHEN Pos1 = 'DF' THEN 1 END) AS Defenders,
    COUNT(CASE WHEN Pos1 = 'GK' THEN 1 END) AS Goalkeepers,
    MAX(Age) AS Oldest_Player,
    Min(Age) AS Youngest_Player,
    SUM(pensattempted) as Penalties_Awarded,
    SUM(pensscored) as Penalties_Scored,
    SUM(minutes) as Minutes_Played
FROM SoccerPlayerStats
GROUP BY Squad;
