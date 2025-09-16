--GK Stat Normalisation and Analysis

With Filtered AS (
	Select * 
	FROM dbo.SoccerPlayerStats
	WHERE Minutes >= 1800
	AND Pos1 = 'GK'
),
PassComp AS (
	SELECT 
		*,
		(CAST(passescompetedover40yards as decimal(10,4)) / NULLIF (passesattemtedover40yards,0)) * 100 as passcomp40
	FROM Filtered
),
ErrorsPerMinute AS (
	Select *,
		CAST(Errors * 1.0/NULLIF(Minutes,0) as decimal(10,4)) as ErrorsPM
	From PassComp),
Normalized AS (
SELECT 
	TOTS,
	Player,
	Squad,
	Pos1,
	Minutes,
	MP,
	Nineties,
	(CAST(GA AS float) - MAX(GA) OVER())/ NULLIF(MIN(GA) OVER () - MAX(GA) OVER(), 0) AS norm_GoalsAllowed, -- Goals Allowed
	CAST(1 - (CAST(PSxG AS decimal(10,2)) - MIN(PSxG) OVER()) / NULLIF(MAX(PSxG) OVER() - MIN(PSxG) OVER(), 0)AS decimal(6,3)) AS norm_PSxG, -- Post Shot xG
	CAST((CAST(PSxGallowed90 AS decimal(10,2)) - MIN(PSxGallowed90) OVER()) / NULLIF(MAX(PSxGallowed90) OVER() - MIN(PSxGallowed90) OVER(), 0) as decimal(6,3)) as norm_PSxGallowed90, -- Post Shot xG allowed per 90
	CAST((CAST(PSxGperShotonTarget AS decimal(10,2)) - MIN(PSxGperShotonTarget) OVER()) / NULLIF(MAX(PSxGperShotonTarget) OVER() - MIN(PSxGperShotonTarget) OVER(), 0) as decimal(6,3)) as norm_PSxGperShotonTarget, -- Post Shot xG per shot on target
	CAST((CAST(PSxGminusgoalsallowed AS decimal(10,2)) - MIN(PSxGminusgoalsallowed) OVER()) / NULLIF(MAX(PSxGminusgoalsallowed) OVER() - MIN(PSxGminusgoalsallowed) OVER(), 0) as decimal(6,3)) as norm_PSxGminusgoalsallowed, -- Post Shot xG Minus Goals Allowed

	(CAST(crossesstopped AS float) - MAX(crossesstopped) OVER())/ NULLIF(MIN(crossesstopped) OVER () - MAX(crossesstopped) OVER(), 0) AS norm_crossesstopped, -- Crosses Stopped
	CAST((CAST(crossstopperc AS decimal(10,2)) - MIN(crossstopperc) OVER()) / NULLIF(MAX(crossstopperc) OVER() - MIN(crossstopperc) OVER(), 0) as decimal(6,3)) as norm_crossstopperc, -- Cross Stop Percentage

	CAST((CAST(defactionoutsidepen90 AS decimal(10,2)) - MIN(defactionoutsidepen90) OVER()) / NULLIF(MAX(defactionoutsidepen90) OVER() - MIN(defactionoutsidepen90) OVER(), 0) as decimal(6,3)) as norm_defactionoutsidepen90, -- Defensive Actions Outside Pen Area 90 Minutes

	CAST((passcomp40 - MIN(passcomp40) OVER()) / NULLIF(MAX(passcomp40) OVER() - MIN(passcomp40) OVER(), 0) AS decimal(6,3)) as norm_passcomp40, -- Pass Rate Completion Over 40 Yards

	(CAST(Touches AS float) - MIN(Touches) OVER())/ NULLIF(MAX(Touches) OVER () - MIN(Touches) OVER(), 0) AS norm_Touches, -- Ball Touches

	(CAST(ErrorsPM AS float) - MAX(ErrorsPM) OVER())/ NULLIF(MIN(ErrorsPM) OVER () - MAX(ErrorsPM) OVER(), 0) AS norm_Errors -- Mistakes Leading To Opponents Shot
	
FROM ErrorsPerMinute)

SELECT 
TOTS,
Player,
Squad,
Pos1, 
Minutes,
MP,
Nineties,
CAST(0.2 * norm_PSxG + --NB
0.05 * norm_PSxGallowed90 +
0.1 * norm_PSxGperShotonTarget +
0.1 * norm_PSxGminusgoalsallowed +
0.1 * norm_crossstopperc +
0.05 * norm_defactionoutsidepen90 + 
0.2 * norm_passcomp40 + --NB
0.2 * norm_errors as Decimal(10,2)) as TotalScore --NB

FROM normalized

Order By TotalScore DESC

-- Add total Goals Allowed as well as PSxGMinusGoalsAllowed to show a visualisation of goals allowed and goals that shouldve been allowed

-- Save percentage, PSxG and distribution accuracy top 3