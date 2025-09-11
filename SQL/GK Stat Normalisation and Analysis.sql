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
	(CAST(GA AS float) - MAX(GA) OVER())/ NULLIF(MIN(GA) OVER () - MAX(GA) OVER(), 0) AS norm_GoalsAllowed,
	CAST(1 - (CAST(PSxG AS decimal(10,2)) - MIN(PSxG) OVER()) / NULLIF(MAX(PSxG) OVER() - MIN(PSxG) OVER(), 0)AS decimal(6,3)) AS norm_PSxG,
	CAST((CAST(PSxGallowed90 AS decimal(10,2)) - MIN(PSxGallowed90) OVER()) / NULLIF(MAX(PSxGallowed90) OVER() - MIN(PSxGallowed90) OVER(), 0) as decimal(6,3)) as norm_PSxGallowed90,
	CAST((CAST(PSxGperShotonTarget AS decimal(10,2)) - MIN(PSxGperShotonTarget) OVER()) / NULLIF(MAX(PSxGperShotonTarget) OVER() - MIN(PSxGperShotonTarget) OVER(), 0) as decimal(6,3)) as norm_PSxGperShotonTarget
FROM Filtered)

SELECT * FROM normalized
ORDER BY norm_GoalsAllowed DESC

-- TO BE CONTINUED