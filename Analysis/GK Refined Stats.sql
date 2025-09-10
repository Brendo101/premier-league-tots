SELECT 
      [Player],
      [Squad],
      [Pos1],
      [Minutes],
      [MP],
      [Nineties],

      -- Core shot-stopping
      [GA],
      [PSxG],
      [PSxGallowed90],
      [PSxGperShotonTarget],
      [PSxGminusgoalsallowed],

      -- Crosses / area control
      [crossesfaced],
      [crossesstopped],
      [crossstopperc],

      -- Sweeper actions
      [defactionsoutsidepenarea],
      [defactionoutsidepen90],

      -- Distribution
      [passesattemtedover40yards],
      [passescompetedover40yards],
      [AvgLenpassinYards],

      -- Possession
      [Touches],
      [DefPenTouches],
      [Def3rdTouches],
      [Mid3rdTouches],
      [Att3rdTouches],

      -- Errors / negatives
      [errors],
      [OG],
      [PKA]

FROM [dbo].[SoccerPlayerStats]
WHERE Pos1 = 'GK';