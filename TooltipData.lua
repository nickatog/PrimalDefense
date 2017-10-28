local L = PDLocals

PrimalDefense_TooltipData =
	{
		["towers"] =
			{
				["CANNON"] =
					{
						[1] = L["Cannon Tower~A basic physical damage tower.  Cannot hit flying enemies.  Upgradeable for higher damage."],
						[2] = string.format(L["%1$d gold\nMore damage.  Boom."], PrimalDefense_TowerMasterData["CANNON"][2].cost),
						[3] = string.format(L["%1$d gold\nEven more damage."], PrimalDefense_TowerMasterData["CANNON"][3].cost)
					},
				["ARROW"] =
					{
						[1] = L["Arrow Tower~A simple tower which can attack both land and air units.  Upgradeable for higher damage."],
						[2] = string.format(L["%1$d gold\nMore Damage.  Pew pew."], PrimalDefense_TowerMasterData["ARROW"][2].cost),
						[3] = string.format(L["%1$d gold\nEven more damage."], PrimalDefense_TowerMasterData["ARROW"][3].cost)
					},
				["FIRE"] =
					{
						[1] = L["Fire Tower~A tower with the ability to char the flesh of enemies.  Early levels deal splash damage.  Upgradeable to AoE damage."],
						[2] = string.format(L["%1$d gold\nFires an explosive shell which explodes on impact for more splash damage."], PrimalDefense_TowerMasterData["FIRE"][2].cost),
						[3] = string.format(L["%1$d gold\nEngulfs the surrounding area, dealing damage to all enemies nearby."], PrimalDefense_TowerMasterData["FIRE"][3].cost)
					},
				["ICE"] =
					{
						[1] = L["Ice Tower~A frozen tower that chills the spirit of attackers.  Early levels slow their targets, while later levels slow all enemies in the area."],
						[2] = string.format(L["%1$d gold\nFires an enchanted missile that slows the speed of attackers and deals more damage."], PrimalDefense_TowerMasterData["ICE"][2].cost),
						[3] = string.format(L["%1$d gold\nChills the ground, slowing the speed of all enemies nearby but deals no damage."], PrimalDefense_TowerMasterData["ICE"][3].cost)
					},
				["SHADOW"] =
					{
						[1] = L["Shadow Tower~A tower of darkness that consumes the soul of infidels.  Inflicts a high amount of damage over time, but multiple shadow effects do not stack.  Higher levels deal more damage."],
						[2] = string.format(L["%1$d gold\nFires a plagued bolt that inflicts more damage over time."], PrimalDefense_TowerMasterData["SHADOW"][2].cost),
						[3] = string.format(L["%1$d gold\nFires a plagued bolt that deals significantly more damage over time."], PrimalDefense_TowerMasterData["SHADOW"][3].cost)
					},
				["MASTERY"] =
					{
						[1] = string.format(L["%1$d gold\nChaotic energy infuses this tower, enabling it to deal significant single-target damage that pierces all immunities."], PrimalDefense_TowerMasterData["MASTERY"][1].cost)
					}
			},
		["actions"] =
			{
				["SELLTOWER"] = L["Sell (|cffffffffX|r)~Sell this tower for a 75% refund of the current level\'s cost."],
				["UPGRADETOWER"] = L["Upgrade (|cffffffffU|r)"]
			},
		["blessings"] =
			{
				["FIRE"] =
					{
						[1] = L["The Fury of Skoll~A fiery rage burns within the Amiran builders, allowing the creation of fire towers."]
					},
				["ICE"] =
					{
						[1] = L["The Song of Lorelei~By harnessing the enchanted melody of the river maiden, the Amiran builders are able to craft ice towers."]
					},
				["SHADOW"] =
					{
						[1] = L["The Blight of the Abyss~Forces from the great unknown compel the Amiran builders, granting the ability to forge shadow towers."]
					}
			}
	}
