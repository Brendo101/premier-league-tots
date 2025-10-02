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
		CAST(ProgPasses as decimal(10,4)) / NULLIF(Minutes,0) as ProgPassespermin,
		CAST(ProgPassesReceived as decimal(10,4)) / NULLIF(Minutes,0) as ProgPassesReceivedpermin,
		CAST(Touches as decimal(10,4)) / NULLIF(Minutes,0) as Touchespermin,
		CAST(Carries as decimal(10,4)) / NULLIF(Minutes,0) as Carriespermin,
		CAST(TakeOnAttempted as decimal(10,4)) / NULLIF(Minutes,0) as TakeOnAttemptedpermin,
		CAST(TakeOnSucc as decimal(10,4)) / NULLIF(Minutes,0) as TakeOnSuccpermin,
		CAST(Dispossessed as decimal(10,4)) / NULLIF(Minutes,0) as Dispossessedpermin,
		CAST(Miscontrols as decimal(10,4)) / NULLIF(Minutes,0) as Miscontrolspermin
	FROM Filtered)

Select 
	TOTS,
	PremFanTots,
	Player,
	Squad,
	Pos1,
	Minutes,
	MP,
	Nineties,
	CAST((nonpengoalspermin - MIN(nonpengoalspermin) OVER()) / NULLIF(MAX(nonpengoalspermin) OVER() - MIN(nonpengoalspermin) OVER(), 0) as Decimal(10,4)) as norm_nonpengoalspermin,
	CAST((astpermin - MIN(astpermin) OVER()) / NULLIF(MAX(astpermin) OVER() - MIN(astpermin) OVER(), 0) as Decimal(10,4)) as norm_astpermin,
	CAST((shotcreatingactionspermin - MIN(shotcreatingactionspermin) OVER()) / NULLIF(MAX(shotcreatingactionspermin) OVER() - MIN(shotcreatingactionspermin) OVER(), 0) as Decimal(10,4)) as norm_shotcreatingactionspermin,
	CAST((glcreatingactionpermin - MIN(glcreatingactionpermin) OVER()) / NULLIF(MAX(glcreatingactionpermin) OVER() - MIN(glcreatingactionpermin) OVER(), 0) as Decimal(10,4)) as norm_glcreatingactionpermin,
	CAST((ProgCarriespermin - MIN(ProgCarriespermin) OVER()) / NULLIF(MAX(ProgCarriespermin) OVER() - MIN(ProgCarriespermin) OVER(), 0) as Decimal(10,4)) as norm_ProgCarriespermin,
	CAST((ProgPassespermin - MIN(ProgPassespermin) OVER()) / NULLIF(MAX(ProgPassespermin) OVER() - MIN(ProgPassespermin) OVER(), 0) as Decimal(10,4)) as norm_ProgPassespermin,
	CAST((ProgPassesReceivedpermin - MIN(ProgPassesReceivedpermin) OVER()) / NULLIF(MAX(ProgPassesReceivedpermin) OVER() - MIN(ProgPassesReceivedpermin) OVER(), 0) as Decimal(10,4)) as norm_ProgPassesReceivedpermin,
	CAST((Touchespermin - MIN(Touchespermin) OVER()) / NULLIF(MAX(Touchespermin) OVER() - MIN(Touchespermin) OVER(), 0) as Decimal(10,4)) as norm_Touchespermin,
	CAST((Carriespermin - MIN(Carriespermin) OVER()) / NULLIF(MAX(Carriespermin) OVER() - MIN(Carriespermin) OVER(), 0) as Decimal(10,4)) as norm_Carriespermin,
	CAST((TakeOnAttemptedpermin - MIN(TakeOnAttemptedpermin) OVER()) / NULLIF(MAX(TakeOnAttemptedpermin) OVER() - MIN(TakeOnAttemptedpermin) OVER(), 0) as Decimal(10,4)) as norm_TakeOnAttemptedpermin,
	CAST((TakeOnSuccpermin - MIN(TakeOnSuccpermin) OVER()) / NULLIF(MAX(TakeOnSuccpermin) OVER() - MIN(TakeOnSuccpermin) OVER(), 0) as Decimal(10,4)) as norm_TakeOnSuccpermin
From AlteredToRate