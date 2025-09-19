With Filtered AS (
	Select * 
	From dbo.SoccerPlayerStats
	WHERE Minutes > 1800
	AND Pos1 = 'MF'
),

AlteredToRate AS (
	Select
		TOTS,
		PremFanTots,
		Player,
		Squad,
		Pos1, 
		Minutes,
		MP,
		Nineties,
		xAG90,
		ast90

	From Filtered
)

Select * From AlteredToRate