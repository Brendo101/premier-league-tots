SELECT 
      [Player],
      [Squad],
      [Pos1],
      [Minutes],
      [MP],
      [Nineties],

      -- Passing & progression
      [ProgPasses],
      [ProgCarries],
      [ProgPassesReceived],
      [PassesReceived],
      [Touches],

      -- Chance creation
      [shotcreatingactions],
      [glcreatingaction],
      [xpectedAssistedGoals],
      [xAG90],

      -- Defensive contributions
      [tackles],
      [TklWon],
      [intercepts],

      -- Attacking support
      [Ast],
      [ast90],
      [nonpengoals],
      [npxG90],

      -- Negatives
      [Dispossessed],
      [Miscontrols],
      [errors]

FROM [dbo].[SoccerPlayerStats]
WHERE Pos1 = 'MF';
