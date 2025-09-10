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

      -- Errors / discipline
      [errors],
      [CrdY],
      [CrdR],

      -- Progression & buildup
      [ProgPasses],
      [ProgCarries],
      [Touches],

      -- Attacking contribution (small)
      [nonpengoals],
      [Ast],
      [shotcreatingactions]

FROM [dbo].[SoccerPlayerStats]
WHERE Pos1 = 'DF';
