With Filtered AS (
	Select * 
	From dbo.SoccerPlayerStats
	WHERE Minutes > 1800
	AND Pos1 = 'FW'
),

AlteredToRate AS(
	Select 
		TOTS,
		PremFanTots,
		Player,
		Squad,
		Pos1,
		Minutes,
		MP,
		Nineties,
		nonpengoals90,
		xpectedGoals,
		npxG90,
		gls90,
		ast90,
		xpectedAssistedGoals,
		xAG90,
		TakeOnSuccPercen,
		CAST(nonpengoals as decimal(10,4)) / NULLIF(Minutes,0) as nonpengoalspermin,
		CAST(ast as decimal(10,4)) / NULLIF(Minutes,0) as astpermin,
		CAST(shotcreatingactions as decimal(10,4)) / NULLIF(Minutes,0) as shotcreatingactionspermin,
		CAST(glcreatingaction as decimal(10,4)) / NULLIF(Minutes,0) as glcreatingactionpermin,
		CAST(ProgCarries as decimal(10,4)) / NULLIF(Minutes,0) as ProgCarriespermin,
		CAST(ProgPasses as decimal(10,4)) / NULLIF(Minutes,0) as ProgPassespermin
	FROM Filtered)

	Select * From AlteredToRate