SELECT 
      [Player],
      [Squad],
      [Pos1],
      [Minutes],
      [MP],
      [Nineties],

      -- Goals & finishing
      [nonpengoals],
      [nonpengoals90],
      [xpectedGoals],
      [npxG90],
      [gls90],

      -- Assists & creativity
      [Ast],
      [ast90],
      [shotcreatingactions],
      [glcreatingaction],
      [xpectedAssistedGoals],
      [xAG90],

      -- Progression & involvement
      [ProgCarries],
      [ProgPasses],
      [ProgPassesReceived],
      [Touches],
      [Carries],

      -- 1v1 ability
      [TakeOnAttempted],
      [TakeOnSucc],
      [TakeOnSuccPercen],

      -- Negatives
      [Dispossessed],
      [Miscontrols]

FROM [dbo].[SoccerPlayerStats]
WHERE Pos1 = 'FW';
