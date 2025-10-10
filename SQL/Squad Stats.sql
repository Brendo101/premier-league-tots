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
    COUNT(CASE WHEN TOTS = 'Yes' THEN 1 END) AS TOTS_Count,
    COUNT(CASE WHEN PremFanTOTS = 'Yes' THEN 1 END) AS FanTOTS_Count,
   CAST(AVG(CASE WHEN Pos1 = 'FW' THEN CAST(Gls AS decimal(10,2)) END) AS decimal(10,2)) AS Avg_Goals_FW,
    CAST(AVG(CASE WHEN Pos1 = 'MF' THEN CAST(Gls AS decimal(10,2)) END) AS decimal(10,2)) AS Avg_Goals_MF,
    CAST(AVG(CASE WHEN Pos1 = 'DF' THEN CAST(Gls AS decimal(10,2)) END) AS decimal(10,2)) AS Avg_Goals_DF,
    CAST(AVG(CASE WHEN Pos1 = 'GK' THEN CAST(Gls AS decimal(10,2)) END) AS decimal(10,2)) AS Avg_Goals_GK,
    MAX(Age) AS Oldest_Player,
    Min(Age) AS Youngest_Player,
    SUM(pensattempted) as Penalties_Awarded,
    SUM(pensscored) as Penalties_Scored,
    SUM(minutes) as Minutes_Played,
    CAST(SUM(Minutes) * 1.0 / COUNT(Player) AS decimal(10,2)) AS Avg_Minutes_Per_Player
FROM SoccerPlayerStats
GROUP BY Squad;
