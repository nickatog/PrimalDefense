-- Initialize the SavedVariables table
PrimalDefenseSVar = {}

PRIMALDEFENSE_INTERESTRATE = 1.05

-- A handful of tables to keep track of the game state and other fun things
GameState =
	{
		player =
			{
				level = 0,
				lives = 20,
				gold = 75,
				essence = 0,
				blessings =
					{
						["FIRE"] = 0,
						["ICE"] = 0,
						["SHADOW"] = 0,
						["MASTERY"] = 0
					}
			},
		enemies = {},
		levelInProgress = false,
		paused = false,
		showHealth = true
	}
MapPath =
	{
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0 },
		{ 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0 },
		{ 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 },
		{ 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	}
MapTiles = {}
CursorState =
	{
		towerType = nil,
		rotatePeriod = 20,
		elapsed = 0
	}
SelectedTile = nil