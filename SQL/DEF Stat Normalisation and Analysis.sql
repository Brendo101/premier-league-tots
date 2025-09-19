With Filtered AS (
	Select * 
	From dbo.SoccerPlayerStats
	WHERE Minutes > 1800
	AND Pos1 = 'DF'
),

AlteredtoRate AS (
	select
		TOTS,
		PremFanTots,
		Player,
		Squad,
		Pos1, 
		Minutes,
		MP,
		Nineties,
		Percentdribblerstackled,
		CAST(clearances as decimal(10,4)) / NULLIF(Minutes,0) as clearancespermin, -- Have to cast at least 1 of them as decimal before division to get an answer, otherwise just float/float
		Cast(Challengeslost as decimal(10,4)) / NULLIF(Minutes,0) as challengeslostpermin,
		Cast(crdY as decimal(10,4)) / NULLIF(Minutes,0) as yellowcardspermin, --yellowcards
		Cast(crdR as decimal(10,4)) / NULLIF(Minutes,0) as redcardspermin, --redcards
		Cast(tackles as decimal(10,4)) / NULLIF(Minutes,0) as tklspermin, --tkls
		Cast(TklWon as decimal(10,4)) / NULLIF(Minutes,0) as tklswonpermin, --tklwin
		--Cast(Challengeslost as decimal(10,4)) / NULLIF(Minutes,0) as tklwinpercpermin, --tklwin%

		Cast(shotsblocked as decimal(10,4)) / NULLIF(Minutes,0) as shotsblockedpermin, --shotsblocked
		Cast(Dispossessed as decimal(10,4)) / NULLIF(Minutes,0) as dispossessedpermin, --dispossessed
		Cast(ProgPasses as decimal(10,4)) / NULLIF(Minutes,0) as progpassespermin, --progpasses
		Cast(ProgCarries as decimal(10,4)) / NULLIF(Minutes,0) as progcarriespermin, --progcarries
		Cast(Touches as decimal(10,4)) / NULLIF(Minutes,0) as touchespermin, --touches
		Cast(errors as decimal(10,4)) / NULLIF(Minutes,0) as errorspermin, --errors that lead to shot on goal
		Cast(passesblocked as decimal(10,4)) / NULLIF(Minutes,0) as passesblockedpermin,
		Cast(intercepts as decimal(10,4)) / NULLIF(Minutes,0) as interceptspermin

	
	From Filtered
),

AddingRates AS (
	Select 
		*,
		tklspermin/NULLIF(tklswonpermin, 0) as tklwinpercpermin
	FROM AlteredtoRate
),

Normalized AS (
	SELECT
		TOTS,
		PremFanTots,
		Player,
		Squad,
		Pos1, 
		Minutes,
		MP,
		Nineties,
		/*6%*/CAST((clearancespermin - MIN(clearancespermin) OVER()) / NULLIF(MAX(clearancespermin) OVER() - MIN(clearancespermin) OVER(), 0) as Decimal(10,4)) as norm_clearances,
		/*10%*/CAST((challengeslostpermin - MAX(challengeslostpermin) OVER ()) / NULLIF(MIN(challengeslostpermin) OVER() - MAX(challengeslostpermin) OVER(), 0) as Decimal(10,4)) as norm_challengeslost,
		/*1%*/CAST((yellowcardspermin - MAX(yellowcardspermin) OVER ()) / NULLIF(MIN(yellowcardspermin) OVER () - MAX(yellowcardspermin) OVER(), 0) as Decimal(10,4)) as norm_yellowcards,
		/*3%*/CAST((redcardspermin - MAX(redcardspermin) OVER ()) / NULLIF(MIN(redcardspermin) OVER () - MAX(redcardspermin) OVER(), 0) as Decimal(10,4)) as norm_redcards,
		/*10%*/CAST((tklwinpercpermin - MIN(tklwinpercpermin) OVER()) / NULLIF(MAX(tklwinpercpermin) OVER() - MIN(tklwinpercpermin) OVER(), 0) as Decimal(10,4)) as norm_tklwinperc,
		/*7%*/CAST((shotsblockedpermin - MIN(shotsblockedpermin) OVER()) / NULLIF(MAX(shotsblockedpermin) OVER() - MIN(shotsblockedpermin) OVER(), 0) as Decimal(10,4)) as norm_shotsblocked,
		/*5%*/CAST((dispossessedpermin - MAX(dispossessedpermin) OVER ()) / NULLIF(MIN(dispossessedpermin) OVER () - MAX(dispossessedpermin) OVER(), 0) as Decimal(10,4)) as norm_dispossessed,
		/*12%*/CAST((progpassespermin - MIN(progpassespermin) OVER()) / NULLIF(MAX(progpassespermin) OVER() - MIN(progpassespermin) OVER(), 0) as Decimal(10,4)) as norm_progpasses,
		/*10%*/CAST((progcarriespermin - MIN(progcarriespermin) OVER()) / NULLIF(MAX(progcarriespermin) OVER() - MIN(progcarriespermin) OVER(), 0) as Decimal(10,4)) as norm_progcarries,
		/*8%*/CAST((touchespermin - MIN(touchespermin) OVER()) / NULLIF(MAX(touchespermin) OVER() - MIN(touchespermin) OVER(), 0) as Decimal(10,4)) as norm_touches,
		/*12%*/CAST((errorspermin - MAX(errorspermin) OVER ()) / NULLIF(MIN(errorspermin) OVER () - MAX(errorspermin) OVER(), 0) as Decimal(10,4)) as norm_errors,
		/*5%*/CAST((passesblockedpermin - MIN(passesblockedpermin) OVER()) / NULLIF(MAX(passesblockedpermin) OVER() - MIN(passesblockedpermin) OVER(), 0) as Decimal(10,4)) as norm_passesblocked,
		/*7%*/CAST((percentdribblerstackled - MIN(percentdribblerstackled) OVER()) / NULLIF(MAX(percentdribblerstackled) OVER() - MIN(percentdribblerstackled) OVER(), 0) as Decimal(10,4)) as norm_dribblerstackledperc,
		/*4%*/CAST((interceptspermin - MIN(interceptspermin) OVER()) / NULLIF(MAX(interceptspermin) OVER() - MIN(interceptspermin) OVER(), 0) as Decimal(10,4)) as norm_interceptspermin
		--passesblocked
		--percentdribblerstackled


From AddingRates)

--SELECT * From Normalized

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
	0.06 * norm_clearances +
	0.10 * norm_challengeslost +
	0.01 * norm_yellowcards +
	0.03 *  norm_redcards +
	0.10 * norm_tklwinperc +
	0.07 * norm_shotsblocked +
	0.05 * norm_dispossessed +
	0.10 * norm_progcarries +
	0.12 * norm_progpasses +
	0.08 * norm_touches +
	0.12 * norm_errors +
	0.05 * norm_passesblocked +
	0.07 * norm_dribblerstackledperc +
	0.04 * norm_interceptspermin

	as decimal(10,2)) as TotalScore

From Normalized

ORDER BY TotalScore DESC

	


-- CrdR, CrdY, clearances (create per minute), challengeslost (number of unsuccessful attempts to challenge dribbling player), 
-- tackles, tklwon (tklwin%), shotsblocked, percentdribblerstackled, dispossessed, progpasses, progcarries, touches, 

-- All transformations in Alteredtorate is to deal with absolute values and players having played more minutes, to ensure its all on a level field