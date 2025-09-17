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
		Cast(errors as decimal(10,4)) / NULLIF(Minutes,0) as errorspermin --errors that lead to shot on goal
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
		CAST((clearancespermin - MIN(clearancespermin) OVER()) / NULLIF(MAX(clearancespermin) OVER() - MIN(clearancespermin) OVER(), 0) as Decimal(10,4)) as norm_clearances,
		CAST((challengeslostpermin - MAX(challengeslostpermin) OVER ()) / NULLIF(MIN(challengeslostpermin) OVER() - MAX(challengeslostpermin) OVER(), 0) as Decimal(10,4)) as norm_challengeslost,
		CAST((yellowcardspermin - MAX(yellowcardspermin) OVER ()) / NULLIF(MIN(yellowcardspermin) OVER () - MAX(yellowcardspermin) OVER(), 0) as Decimal(10,4)) as norm_yellowcards,
		CAST((redcardspermin - MAX(redcardspermin) OVER ()) / NULLIF(MIN(redcardspermin) OVER () - MAX(redcardspermin) OVER(), 0) as Decimal(10,4)) as norm_redcards,
		CAST((tklwinpercpermin - MIN(tklwinpercpermin) OVER()) / NULLIF(MAX(tklwinpercpermin) OVER() - MIN(tklwinpercpermin) OVER(), 0) as Decimal(10,4)) as norm_tklwinperc,
		CAST((shotsblockedpermin - MIN(shotsblockedpermin) OVER()) / NULLIF(MAX(shotsblockedpermin) OVER() - MIN(shotsblockedpermin) OVER(), 0) as Decimal(10,4)) as norm_shotsblocked,
		CAST((dispossessedpermin - MAX(dispossessedpermin) OVER ()) / NULLIF(MIN(dispossessedpermin) OVER () - MAX(dispossessedpermin) OVER(), 0) as Decimal(10,4)) as norm_dispossessed,
		CAST((progpassespermin - MIN(progpassespermin) OVER()) / NULLIF(MAX(progpassespermin) OVER() - MIN(progpassespermin) OVER(), 0) as Decimal(10,4)) as norm_progpasses,
		CAST((touchespermin - MIN(touchespermin) OVER()) / NULLIF(MAX(touchespermin) OVER() - MIN(touchespermin) OVER(), 0) as Decimal(10,4)) as norm_touches,
		CAST((errorspermin - MAX(errorspermin) OVER ()) / NULLIF(MIN(errorspermin) OVER () - MAX(errorspermin) OVER(), 0) as Decimal(10,4)) as norm_errors
From AddingRates)

SELECT * From Normalized

	


-- CrdR, CrdY, clearances (create per minute), challengeslost (number of unsuccessful attempts to challenge dribbling player), 
-- tackles, tklwon (tklwin%), shotsblocked, percentdribblerstackled, dispossessed, progpasses, progcarries, touches, 

-- All transformations in Alteredtorate is to deal with absolute values and players having played more minutes, to ensure its all on a level field