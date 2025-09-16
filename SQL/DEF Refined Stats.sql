SELECT 
      [Player],
      [Squad],
      [Pos1],
      [Minutes],
      [MP],
      [Nineties],

      -- Core defensive actions
      [tackles],
      [TklWon],
      [intercepts],
      [clearances],
      [shotsblocked],
      [passesblocked],
      [challengeslost],
      [percentdribblerstackled],

      -- Errors / discipline
      errors,
      [CrdY],
      [CrdR],
      [Dispossessed]

      -- Progression & buildup
      [ProgPasses],
      [ProgCarries],
      [Touches]

FROM [dbo].[SoccerPlayerStats]
WHERE Pos1 = 'DF';

-- CrdR, CrdY, clearances (create per minute), challengeslost (number of unsuccessful attempts to challenge dribbling player), 
-- tackles, tklwon (tklwin%), shotsblocked, percentdribblerstackled, dispossessed, progpasses, progcarries, touches, 