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
),

Normalised as 
(Select 	
	
	TOTS,
	PremFanTots,
	Player,
	Squad,
	Pos1, 
	Minutes,
	MP,
	Nineties,
	CAST((xAG90 - MIN(xAG90) OVER()) / NULLIF(MAX(xAG90) OVER() - MIN(xAG90) OVER(), 0) as Decimal(10,4)) as norm_xAG90, -- Expected Assisted Goals
	CAST((ast90 - MIN(ast90) OVER()) / NULLIF(MAX(ast90) OVER() - MIN(ast90) OVER(), 0) as Decimal(10,4)) as norm_ast90,  -- Assists per 90
	CAST((ProgPassespermin - MIN(ProgPassespermin) OVER()) / NULLIF(MAX(ProgPassespermin) OVER() - MIN(ProgPassespermin) OVER(), 0) as Decimal(10,4)) as norm_ProgPassespermin,
	CAST((ProgCarriespermin - MIN(ProgCarriespermin) OVER()) / NULLIF(MAX(ProgCarriespermin) OVER() - MIN(ProgCarriespermin) OVER(), 0) as Decimal(10,4)) as norm_ProgCarriespermin,
	CAST((ProgPassesReceivedpermin - MIN(ProgPassesReceivedpermin) OVER()) / NULLIF(MAX(ProgPassesReceivedpermin) OVER() - MIN(ProgPassesReceivedpermin) OVER(), 0) as Decimal(10,4)) as norm_ProgPassesReceivedpermin,
	CAST((Touchespermin - MIN(Touchespermin) OVER()) / NULLIF(MAX(Touchespermin) OVER() - MIN(Touchespermin) OVER(), 0) as Decimal(10,4)) as norm_Touchespermin,
	CAST((shotcreatingactionspermin - MIN(shotcreatingactionspermin) OVER()) / NULLIF(MAX(shotcreatingactionspermin) OVER() - MIN(shotcreatingactionspermin) OVER(), 0) as Decimal(10,4)) as norm_shotcreatingactionspermin,
	CAST((glcreatingactionpermin - MIN(glcreatingactionpermin) OVER()) / NULLIF(MAX(glcreatingactionpermin) OVER() - MIN(glcreatingactionpermin) OVER(), 0) as Decimal(10,4)) as norm_glcreatingactionpermin,
	CAST((tacklespermin - MIN(tacklespermin) OVER()) / NULLIF(MAX(tacklespermin) OVER() - MIN(tacklespermin) OVER(), 0) as Decimal(10,4)) as norm_tacklespermin,
	CAST((tklwonpermin - MIN(tklwonpermin) OVER()) / NULLIF(MAX(tklwonpermin) OVER() - MIN(tklwonpermin) OVER(), 0) as Decimal(10,4)) as norm_tklwonpermin,
	CAST((interceptspermin - MIN(interceptspermin) OVER()) / NULLIF(MAX(interceptspermin) OVER() - MIN(interceptspermin) OVER(), 0) as Decimal(10,4)) as norm_interceptspermin,
	CAST((Astpermin - MIN(Astpermin) OVER()) / NULLIF(MAX(Astpermin) OVER() - MIN(Astpermin) OVER(), 0) as Decimal(10,4)) as norm_Astpermin,
	CAST((nonpengoalspermin - MIN(nonpengoalspermin) OVER()) / NULLIF(MAX(nonpengoalspermin) OVER() - MIN(nonpengoalspermin) OVER(), 0) as Decimal(10,4)) as norm_nonpengoalspermin,
	CAST((dispossessedpermin - MAX(dispossessedpermin) OVER ()) / NULLIF(MIN(dispossessedpermin) OVER () - MAX(dispossessedpermin) OVER(), 0) as Decimal(10,4)) as norm_dispossessed,
	CAST((miscontrolspermin - MAX(miscontrolspermin) OVER ()) / NULLIF(MIN(miscontrolspermin) OVER () - MAX(miscontrolspermin) OVER(), 0) as Decimal(10,4)) as norm_miscontrolspermin,
	CAST((errorspermin - MAX(errorspermin) OVER ()) / NULLIF(MIN(errorspermin) OVER () - MAX(errorspermin) OVER(), 0) as Decimal(10,4)) as norm_errorspermin

From AlteredToRate)

Select 
	TOTS,
	PremFanTots,
	Player,
	Squad,
	Pos1, 
	Minutes,
	MP,
	Nineties
From Normalised