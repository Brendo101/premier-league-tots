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
	MP,
	Nineties,
	(CAST(GA AS float) - MAX(GA) OVER())/ NULLIF(MIN(GA) OVER () - MAX(GA) OVER(), 0) AS norm_GoalsAllowed,
	CAST(1 - (CAST(PSxG AS decimal(10,2)) - MIN(PSxG) OVER()) / NULLIF(MAX(PSxG) OVER() - MIN(PSxG) OVER(), 0)AS decimal(6,3)) AS norm_PSxG,
	CAST((CAST(PSxGallowed90 AS decimal(10,2)) - MIN(PSxGallowed90) OVER()) / NULLIF(MAX(PSxGallowed90) OVER() - MIN(PSxGallowed90) OVER(), 0) as decimal(6,3)) as norm_PSxGallowed90,
	CAST((CAST(PSxGperShotonTarget AS decimal(10,2)) - MIN(PSxGperShotonTarget) OVER()) / NULLIF(MAX(PSxGperShotonTarget) OVER() - MIN(PSxGperShotonTarget) OVER(), 0) as decimal(6,3)) as norm_PSxGperShotonTarget,
	CAST((CAST(PSxGminusgoalsallowed AS decimal(10,2)) - MIN(PSxGminusgoalsallowed) OVER()) / NULLIF(MAX(PSxGminusgoalsallowed) OVER() - MIN(PSxGminusgoalsallowed) OVER(), 0) as decimal(6,3)) as norm_PSxGminusgoalsallowed,
	(CAST(crossesstopped AS float) - MAX(crossesstopped) OVER())/ NULLIF(MIN(crossesstopped) OVER () - MAX(crossesstopped) OVER(), 0) AS norm_crossesstopped,
	CAST((CAST(crossstopperc AS decimal(10,2)) - MIN(crossstopperc) OVER()) / NULLIF(MAX(crossstopperc) OVER() - MIN(crossstopperc) OVER(), 0) as decimal(6,3)) as norm_crossstopperc,
	CAST((CAST(defactionoutsidepen90 AS decimal(10,2)) - MIN(defactionoutsidepen90) OVER()) / NULLIF(MAX(defactionoutsidepen90) OVER() - MIN(defactionoutsidepen90) OVER(), 0) as decimal(6,3)) as norm_defactionoutsidepen90
FROM Filtered)

SELECT * FROM normalized
ORDER BY norm_GoalsAllowed DESC

-- TO BE CONTINUED