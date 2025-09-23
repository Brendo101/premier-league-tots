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
		ast90,
		CAST(ProgPasses as decimal(10,4)) / NULLIF(Minutes,0) as ProgPassespermin,
		CAST(ProgCarries as decimal(10,4)) / NULLIF(Minutes,0) as ProgCarriespermin,
		CAST(ProgPassesReceived as decimal(10,4)) / NULLIF(Minutes,0) as ProgPassesReceivedpermin,
		CAST(PassesReceived as decimal(10,4)) / NULLIF(Minutes,0) as PassesReceivedpermin,
		CAST(Touches as decimal(10,4)) / NULLIF(Minutes,0) as Touchespermin,
		CAST(shotcreatingactions as decimal(10,4)) / NULLIF(Minutes,0) as shotcreatingactionspermin,
		CAST(glcreatingaction as decimal(10,4)) / NULLIF(Minutes,0) as glcreatingactionpermin,
		CAST(tackles as decimal(10,4)) / NULLIF(Minutes,0) as tacklespermin,
		CAST(TklWon as decimal(10,4)) / NULLIF(Minutes,0) as tklwonpermin,
		CAST(intercepts as decimal(10,4)) / NULLIF(Minutes,0) as interceptspermin,
		CAST(Ast as decimal(10,4)) / NULLIF(Minutes,0) as Astpermin,
		CAST(nonpengoals as decimal(10,4)) / NULLIF(Minutes,0) as nonpengoalspermin,
		CAST(Dispossessed as decimal(10,4)) / NULLIF(Minutes,0) as dispossessedpermin,
		CAST(Miscontrols as decimal(10,4)) / NULLIF(Minutes,0) as miscontrolspermin,
		CAST(errors as decimal(10,4)) / NULLIF(Minutes,0) as errorspermin

	From Filtered
)

Select * From AlteredToRate