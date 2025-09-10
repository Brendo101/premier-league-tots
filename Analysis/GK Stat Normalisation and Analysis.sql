--GK Stat Normalisation and Analysis

With Filtered AS (
Select * 
FROM dbo.SoccerPlayerStats
WHERE Minutes >= 1800
AND Pos1 = 'GK'
)

, normalized AS (
SELECT 
	TOTS,
	Player,
	Squad,
	Pos1,
	Minutes,
	(CAST(GA AS float) - MIN(GA) OVER())/ NULLIF(MAX(GA) OVER () - MIN(GA) OVER(), 0) AS norm_GoalsAllowed
FROM Filtered)

SELECT * FROM normalized
ORDER BY norm_GoalsAllowed DESC

-- TO BE CONTINUED