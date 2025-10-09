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
	FROM Filtered),

normalised as (Select 
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
	CAST((TakeOnSuccpermin - MIN(TakeOnSuccpermin) OVER()) / NULLIF(MAX(TakeOnSuccpermin) OVER() - MIN(TakeOnSuccpermin) OVER(), 0) as Decimal(10,4)) as norm_TakeOnSuccpermin,
	CAST((Dispossessedpermin - MAX(Dispossessedpermin) OVER ()) / NULLIF(MIN(Dispossessedpermin) OVER () - MAX(Dispossessedpermin) OVER(), 0) as Decimal(10,4)) as norm_Dispossessedpermin,
	CAST((Miscontrolspermin - MAX(Miscontrolspermin) OVER ()) / NULLIF(MIN(Miscontrolspermin) OVER () - MAX(Miscontrolspermin) OVER(), 0) as Decimal(10,4)) as norm_Miscontrolspermin,
	CAST((TakeOnSuccPercen - MIN(TakeOnSuccPercen) OVER()) / NULLIF(MAX(TakeOnSuccPercen) OVER() - MIN(TakeOnSuccPercen) OVER(), 0) as Decimal(10,4)) as norm_TakeOnSuccPercen,
	CAST((xAG90 - MIN(xAG90) OVER()) / NULLIF(MAX(xAG90) OVER() - MIN(xAG90) OVER(), 0) as Decimal(10,4)) as norm_xAG90,
	CAST((xpectedAssistedGoals - MIN(xpectedAssistedGoals) OVER()) / NULLIF(MAX(xpectedAssistedGoals) OVER() - MIN(xpectedAssistedGoals) OVER(), 0) as Decimal(10,4)) as norm_xpectedAssistedGoals,
	CAST((ast90 - MIN(ast90) OVER()) / NULLIF(MAX(ast90) OVER() - MIN(ast90) OVER(), 0) as Decimal(10,4)) as norm_ast90,
	CAST((gls90 - MIN(gls90) OVER()) / NULLIF(MAX(gls90) OVER() - MIN(gls90) OVER(), 0) as Decimal(10,4)) as norm_gls90,
	CAST((npxG90 - MIN(npxG90) OVER()) / NULLIF(MAX(npxG90) OVER() - MIN(npxG90) OVER(), 0) as Decimal(10,4)) as norm_npxG90,
	CAST((xpectedGoals - MIN(xpectedGoals) OVER()) / NULLIF(MAX(xpectedGoals) OVER() - MIN(xpectedGoals) OVER(), 0) as Decimal(10,4)) as norm_xpectedGoals,
	CAST((nonpengoals90 - MIN(nonpengoals90) OVER()) / NULLIF(MAX(nonpengoals90) OVER() - MIN(nonpengoals90) OVER(), 0) as Decimal(10,4)) as norm_nonpengoals90
From AlteredToRate)

Select 
	TOTS,
	PremFanTots,
	Player,
	Squad,
	Pos1,
	Minutes,
	MP,
	Nineties,
	CAST(
  0.12 * norm_nonpengoalspermin +
  0.10 * norm_npxG90 +
  0.08 * norm_gls90 +
  0.07 * norm_xpectedgoals +
  0.08 * norm_xAG90 +
  0.07 * norm_xpectedassistedgoals +
  0.06 * norm_astpermin +
  0.07 * norm_shotcreatingactionspermin +
  0.05 * norm_glcreatingactionpermin +
  0.05 * norm_progcarriespermin +
  0.03 * norm_progpassespermin +
  0.04 * norm_ProgPassesReceivedpermin +
  0.03 * norm_touchespermin +
  0.02 * norm_takeonattemptedpermin +
  0.03 * norm_takeonsuccpermin +
  0.06 * norm_Dispossessedpermin +
  0.04 * norm_miscontrolspermin
AS decimal(10,4)) AS CompositeScore


From normalised
ORDER BY CompositeScore DESC

-- Split into Finishing 45%
-- Creation 25%
-- Progression 20%
-- Retention 10%