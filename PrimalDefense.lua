-- Initialize the SavedVariables table
--PrimalDefenseSVar = {}

-- A handful of tables to keep track of the game state and other fun things
-- GameState =
	-- {
		-- player =
			-- {
				-- level = 0,
				-- gold = 75,
				-- essence = 0,
				-- blessings =
					-- {
						-- ["FIRE"] = 0,
						-- ["ICE"] = 0,
						-- ["SHADOW"] = 0
					-- }
			-- },
		-- enemies = {},
		-- levelInProgress = false
	-- }
-- local MapPath =
	-- {
		-- { 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0 },
		-- { 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0 },
		-- { 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0 },
		-- { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		-- { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		-- { 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0 },
		-- { 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0 },
		-- { 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0 },
		-- { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0 },
		-- { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0 },
		-- { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0 },
		-- { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		-- { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
		-- { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
		-- { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	-- }
-- local MapTiles = {}
-- local CursorState =
	-- {
		-- towerType = nil,
		-- rotatePeriod = 20,
		-- elapsed = 0
	-- }
-- local SelectedTile = nil

local L = PDLocals

function PrimalDefense_OnLoad(self)
	-- Initialize slash command handler
	SLASH_PrimalDefense1 = "/primal"
	SlashCmdList["PrimalDefense"] =
		function(msg)
			PrimalDefense_SlashCommandHandler(self, msg)
		end
		
	self:RegisterForDrag"LeftButton"
	
	-- Create tiles for each grassy section on the map to place towers on
	for i = 1, #MapPath do
		for j = 1, #MapPath[i] do
			if ( MapPath[i][j] == 0 ) then
				local tileFrame = CreateFrame("Button", "PrimalDefense_MapTile"..i.."-"..j, PrimalDefense, "PrimalDefense_MapTileTemplate")
				tileFrame:SetPoint("TOPLEFT", "PrimalDefense_Map", "TOPLEFT", ( j - 1 ) * 32 + 4, -( ( i - 1 ) * 32 + 4 ))
				tileFrame.tower = nil
				tinsert(MapTiles, tileFrame)
			end
		end
	end
	
	-- temporary until help frame is done
	PrimalDefense_Help:Hide()
end

function PrimalDefense_OnShow(self)
	if ( SelectedTile == nil ) then
		self:EnableKeyboard(false)
	else
		self:EnableKeyboard(true)
	end
end

function PrimalDefense_OnUpdate(self, elapsed)
	-- All code in here will be executed each time a frame is rendered
	if ( PrimalDefense_MapRange:IsVisible() ) then
		CursorState.elapsed = CursorState.elapsed + elapsed
		if ( CursorState.elapsed >= CursorState.rotatePeriod ) then
			CursorState.elapsed = CursorState.elapsed - CursorState.rotatePeriod
		end
		PrimalDefense_Rotate(PrimalDefense_MapRangeTexture, CursorState.elapsed / CursorState.rotatePeriod * 360)
	end
	
	if ( GameState.levelInProgress and not GameState.paused ) then
		-- update our game objects
		for i=#GameState.enemies, 1, -1 do
			GameState.enemies[i]:Update(elapsed)
			if ( GameState.enemies[i].health <= 0 ) then
				GameState.player.gold = GameState.player.gold + GameState.enemies[i].reward
				PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
				GameState.player.essence = GameState.player.essence + 1
				PrimalDefense_Essence:SetText("|cffffffff"..L["Essence"]..": "..GameState.player.essence.."|r")
				PrimalDefense_UpdateCostTexts()
				PrimalDefense_UpdateBlessingsTexts()
				GameState.enemies[i].texture:Hide()
				tremove(GameState.enemies, i)
			end
		end
		
		PrimalDefense_ReorderEnemies()
		
		if ( GameState.player.lives <= 0 ) then
			GameState.paused = true
			PrimalDefense_GameOverDialog:Show()
		end
		
		for i=#PrimalDefense_Animations, 1, -1 do
			if ( PrimalDefense_Animations[i]:Update(elapsed) == false ) then
				tremove(PrimalDefense_Animations, i)
			end
		end
		
		for i=1, #MapPath do
			for j=1, #MapPath[i] do
				if ( MapPath[i][j] == 0 ) then
					local tile = getglobal("PrimalDefense_MapTile"..i.."-"..j)
					if ( tile.tower ) then
						tile.tower:Update(elapsed)
					end
				end
			end
		end
		
		if ( #GameState.enemies == 0 ) then
			GameState.levelInProgress = false
			PrimalDefense_Start:Enable()
			for i=#PrimalDefense_Animations, 1, -1 do
				PrimalDefense_Animations[i].texture:Hide()
				tremove(PrimalDefense_Animations, i)
			end
			GameState.player.gold = floor(GameState.player.gold * PRIMALDEFENSE_INTERESTRATE)
			PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
			PrimalDefense_UpdateCostTexts()
			local gpl = GameState.player.level
			if ( ( gpl == 8 ) or ( gpl == 13 ) or ( gpl == 18 ) or ( gpl == 23 ) or ( gpl == 28 ) or ( gpl == 33 ) or ( gpl == 39 ) or ( gpl == 40 ) ) then
				GameState.player.essence = GameState.player.essence + 9
				PrimalDefense_Essence:SetText("|cffffffff"..L["Essence"]..": "..GameState.player.essence.."|r")
				PrimalDefense_UpdateBlessingsTexts()
			end
		end
	end
end

function PrimalDefense_ReorderEnemies()
	for i=1, #GameState.enemies - 1 do
		if ( GameState.enemies[i].nextWaypoint < GameState.enemies[i + 1].nextWaypoint ) then
			local t = GameState.enemies[i]
			GameState.enemies[i] = GameState.enemies[i + 1]
			GameState.enemies[i + 1] = t
		end
	end
end

function PrimalDefense_SlashCommandHandler(self, msg)
	local cmd = strlower(msg:match("(%S*).*"))
	
	if ( self:IsVisible() ) then
		self:Hide()
	else
		self:Show()
	end
end

function PrimalDefense_OnKeyDown(self, key)
	if ( key == "ESCAPE" ) then
		CursorState.towerType = nil
		PrimalDefense_MapRange:Hide()
		SelectedTile = nil
		PrimalDefense_Sidebar:Hide()
		PrimalDefense:EnableKeyboard(false)
		
		for i=1, #MapPath do
			for j=1, #MapPath[i] do
				if ( MapPath[i][j] == 0 ) then
					local tile = getglobal("PrimalDefense_MapTile"..i.."-"..j)
					if ( tile.previewTower ) then
						getglobal(tile:GetName().."Tower"):Hide()
						break
					end
				end
			end
		end
	elseif ( key == "X" and SelectedTile ~= nil ) then
		-- Destroy selected tower
		PrimalDefense_SellSelectedTower()
	elseif ( key == "U" and SelectedTile ~= nil and PrimalDefense_SidebarUpgrade:IsVisible() ) then
		-- Upgrade the selected tower if possible
		PrimalDefense_UpgradeSelectedTower()
	end
end

function PrimalDefense_MapTileOnEnter(self)
	if ( self.tower == nil and CursorState.towerType ~= nil ) then
		PrimalDefense_MapRange:Show()
		PrimalDefense_MapRange:SetScale(PrimalDefense_TowerMasterData[CursorState.towerType][1].range / 50)
		PrimalDefense_MapRange:SetPoint("CENTER", self, "CENTER")
		PrimalDefense_MapRange:SetAlpha(0.75)
		local tower = getglobal(self:GetName().."Tower")
		tower:SetTexture(PrimalDefense_TowerMasterData[CursorState.towerType][1].texture)
		tower:Show()
		self:SetAlpha(0.75)
		self.previewTower = true
	end
end

function PrimalDefense_MapTileOnLeave(self)
	if ( self.previewTower ) then
		PrimalDefense_MapRange:Hide()
		getglobal(self:GetName().."Tower"):Hide()
		self.previewTower = false
	end
end

function PrimalDefense_MapTileOnClick(self)
	if ( self.tower ) then
		SelectedTile = self
		CursorState.towerType = nil
		PrimalDefense_MapRange:Show()
		PrimalDefense_MapRange:SetPoint("CENTER", self, "CENTER")
		PrimalDefense_MapRange:SetScale(PrimalDefense_TowerMasterData[self.tower.type][self.tower.level].range / 50)
		PrimalDefense_SidebarTower:SetText(self.tower.type:sub(1, 1)..self.tower.type:sub(2):lower().." Tower")
		PrimalDefense_SidebarLevel:SetText("|cffffffff"..L["Level"]..": "..self.tower.level.."|r")
		PrimalDefense_SidebarRange:SetText("|cffffffff"..L["Range"]..": "..PrimalDefense_TowerMasterData[self.tower.type][self.tower.level].range.."|r")
		PrimalDefense_SidebarDamage:SetText("|cffffffff"..L["Damage"]..": "..PrimalDefense_TowerMasterData[self.tower.type][self.tower.level].damage.."|r")
		PrimalDefense_SidebarSpeed:SetText("|cffffffff"..L["Speed"]..": "..PrimalDefense_TowerMasterData[self.tower.type][self.tower.level].delay.."|r")
		PrimalDefense_SidebarAbility:SetText("|cffffffff"..L["Ability"]..": "..PrimalDefense_TowerMasterData[self.tower.type][self.tower.level].ability.."|r")
		if ( ( self.tower.level == 3 ) and ( GameState.player.blessings["FIRE"] == 3 ) and ( GameState.player.blessings["ICE"] == 3 ) and ( GameState.player.blessings["SHADOW"] == 3 ) ) then
			PrimalDefense_SidebarUpgradeTexture:SetTexture(PrimalDefense_TowerMasterData["MASTERY"][1].texture)
			PrimalDefense_SidebarUpgrade:Show()
			if ( PrimalDefense_HaveUpgradeResources("MASTERY", 0) ) then
				PrimalDefense_SidebarUpgrade:SetAlpha(1)
				PrimalDefense_SidebarUpgradeText:SetText("|cffffffff"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			else
				PrimalDefense_SidebarUpgrade:SetAlpha(0.5)
				PrimalDefense_SidebarUpgradeText:SetText("|cffff0000"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			end
		elseif ( self.tower.level ~= #PrimalDefense_TowerMasterData[self.tower.type] ) then
			PrimalDefense_SidebarUpgradeTexture:SetTexture(PrimalDefense_TowerMasterData[self.tower.type][self.tower.level + 1].texture)
			PrimalDefense_SidebarUpgrade:Show()
			if ( PrimalDefense_HaveUpgradeResources(self.tower.type, self.tower.level) ) then
				PrimalDefense_SidebarUpgrade:SetAlpha(1)
				PrimalDefense_SidebarUpgradeText:SetText("|cffffffff"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			else
				PrimalDefense_SidebarUpgrade:SetAlpha(0.5)
				PrimalDefense_SidebarUpgradeText:SetText("|cffff0000"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			end
		else
			PrimalDefense_SidebarUpgrade:Hide()
		end
		PrimalDefense_Sidebar:Show()
		PrimalDefense:EnableKeyboard(true)
	elseif ( CursorState.towerType ~= nil ) then
		-- Build tower
		GameState.player.gold = GameState.player.gold - PrimalDefense_TowerMasterData[CursorState.towerType][1].cost
		PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
		PrimalDefense_UpdateCostTexts()
		local tileX, tileY = self:GetName():match("PrimalDefense_MapTile(%d*)-(%d*)")
		self.tower = PrimalDefense_CreateTower(CursorState.towerType, 1, tileX, tileY)
		local tower = getglobal(self:GetName().."Tower")
		tower:SetTexture(PrimalDefense_TowerMasterData[self.tower.type][1].texture)
		tower:Show()
		tower:SetAlpha(1)
		PrimalDefense_MapRange:Hide()
		self.previewTower = false
		CursorState.towerType = nil
		PrimalDefense:EnableKeyboard(false)
	else
		SelectedTile = nil
		PrimalDefense_MapRange:Hide()
		PrimalDefense_Sidebar:Hide()
		PrimalDefense:EnableKeyboard(false)
	end
end

function PrimalDefense_BuildTowersOnEnter(self, towerType)
	local title, rest = PrimalDefense_TooltipData["towers"][towerType][1]:match("(.*)~(.*)")
	PrimalDefense_Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	PrimalDefense_Tooltip:AddLine(title, 1, 1, 0)
	PrimalDefense_Tooltip:AddLine(rest, 1, 1, 1, 1)
	PrimalDefense_Tooltip:Show()
end

function PrimalDefense_BlessingsOnEnter(self, blessingType)
	local title, rest = PrimalDefense_TooltipData["blessings"][blessingType][1]:match("(.*)~(.*)")
	PrimalDefense_Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	PrimalDefense_Tooltip:AddLine(title, 1, 1, 0)
	PrimalDefense_Tooltip:AddLine(rest, 1, 1, 1, 1)
	PrimalDefense_Tooltip:Show()
end

function PrimalDefense_SidebarOnEnter(self, action)
	local title, rest
	PrimalDefense_Tooltip:SetOwner(self, "ANCHOR_CURSOR")
	if ( action == "SELL" ) then
		title, rest = PrimalDefense_TooltipData["actions"]["SELLTOWER"]:match("(.*)~(.*)")
	elseif ( action == "UPGRADE" ) then
		title = PrimalDefense_TooltipData["actions"]["UPGRADETOWER"]
		if ( SelectedTile.tower.level == 3 ) then
			rest = PrimalDefense_TooltipData["towers"]["MASTERY"][1]
		else
			rest = PrimalDefense_TooltipData["towers"][SelectedTile.tower.type][SelectedTile.tower.level + 1]
		end
	end
	PrimalDefense_Tooltip:AddLine(title, 1, 1, 0)
	PrimalDefense_Tooltip:AddLine(rest, 1, 1, 1, 1)
	PrimalDefense_Tooltip:Show()
end

function PrimalDefense_HideTooltip()
	PrimalDefense_Tooltip:Hide()
end

function PrimalDefense_BuildTowersOnClick(self)
	if ( self:GetAlpha() == 1 ) then
		SelectedTile = nil
		CursorState.towerType = self:GetName():match("PrimalDefense_BuildTowers(.*)"):upper()
		PrimalDefense_Sidebar:Hide()
		PrimalDefense:EnableKeyboard(true)
	end
end

function PrimalDefense_BlessingsOnClick(self)
	if ( self:GetAlpha() == 1 ) then
		GameState.player.essence = GameState.player.essence - 30
		PrimalDefense_Essence:SetText("|cffffffff"..L["Essence"]..": "..GameState.player.essence.."|r")
		local element = self:GetName():match("PrimalDefense_Blessings(.*)"):upper()
		GameState.player.blessings[element] = GameState.player.blessings[element] + 1
		PrimalDefense_UpdateBlessingsTexts()
		PrimalDefense_UpdateCostTexts()
		if ( ( GameState.player.blessings["FIRE"] == 3 ) and ( GameState.player.blessings["ICE"] == 3 ) and ( GameState.player.blessings["SHADOW"] == 3 ) ) then
			GameState.player.blessings["MASTERY"] = 1
		end
	end
end

function PrimalDefense_HaveUpgradeResources(towerType, towerLevel)
	if ( GameState.player.gold >= PrimalDefense_TowerMasterData[towerType][towerLevel + 1].cost ) then
		if ( ( towerType == "CANNON" ) or ( towerType == "ARROW" ) ) then
			return true
		else
			if ( GameState.player.blessings[towerType] >= ( towerLevel + 1 ) ) then
				return true
			end
		end
	end
	
	return false
end

function PrimalDefense_UpgradeSelectedTower()
	if ( ( ( SelectedTile.tower.level == 3 ) and ( PrimalDefense_HaveUpgradeResources("MASTERY", 0) ) ) or PrimalDefense_HaveUpgradeResources(SelectedTile.tower.type, SelectedTile.tower.level) ) then
		local ntype, nlvl
		if ( SelectedTile.tower.level == 3 ) then
			ntype = "MASTERY"
			nlvl = 1
		else
			ntype = SelectedTile.tower.type
			nlvl = SelectedTile.tower.level + 1
		end
		GameState.player.gold = GameState.player.gold - PrimalDefense_TowerMasterData[ntype][nlvl].cost
		local tileX, tileY = SelectedTile:GetName():match("PrimalDefense_MapTile(%d*)-(%d*)")
		SelectedTile.tower = PrimalDefense_CreateTower(ntype, nlvl, tileX, tileY)
		-- Fix the sidebar information
		PrimalDefense_SidebarTower:SetText(SelectedTile.tower.type:sub(1, 1)..SelectedTile.tower.type:sub(2):lower().." Tower")
		PrimalDefense_SidebarLevel:SetText("|cffffffff"..L["Level"]..": "..SelectedTile.tower.level.."|r")
		PrimalDefense_SidebarRange:SetText("|cffffffff"..L["Range"]..": "..PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].range.."|r")
		PrimalDefense_SidebarDamage:SetText("|cffffffff"..L["Damage"]..": "..PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].damage.."|r")
		PrimalDefense_SidebarSpeed:SetText("|cffffffff"..L["Speed"]..": "..PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].delay.."|r")
		PrimalDefense_SidebarAbility:SetText("|cffffffff"..L["Ability"]..": "..PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].ability.."|r")
		if ( SelectedTile.tower.level ~= #PrimalDefense_TowerMasterData[SelectedTile.tower.type] ) then
			PrimalDefense_SidebarUpgradeTexture:SetTexture(PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level + 1].texture)
			PrimalDefense_SidebarUpgrade:Show()
			if ( PrimalDefense_HaveUpgradeResources(SelectedTile.tower.type, SelectedTile.tower.level) ) then
				PrimalDefense_SidebarUpgrade:SetAlpha(1)
				PrimalDefense_SidebarUpgradeText:SetText("|cffffffff"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			else
				PrimalDefense_SidebarUpgrade:SetAlpha(0.5)
				PrimalDefense_SidebarUpgradeText:SetText("|cffff0000"..PrimalDefense_SidebarUpgradeText:GetText().."|r")
			end
		else
			PrimalDefense_SidebarUpgrade:Hide()
		end
		-- And fix these, too
		PrimalDefense_UpdateCostTexts()
		PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
		local tower = getglobal(SelectedTile:GetName().."Tower")
		tower:SetTexture(PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].texture)
		PrimalDefense_MapTileOnClick(SelectedTile)
	end
end

function PrimalDefense_SellSelectedTower()
	GameState.player.gold = GameState.player.gold + ceil(PrimalDefense_TowerMasterData[SelectedTile.tower.type][SelectedTile.tower.level].cost * 0.75)
	PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
	PrimalDefense_UpdateCostTexts()
	getglobal(SelectedTile:GetName().."Tower"):Hide()
	SelectedTile.tower = nil
	SelectedTile = nil
	PrimalDefense_MapRange:Hide()
	PrimalDefense_Sidebar:Hide()
	PrimalDefense:EnableKeyboard(false)
end

function PrimalDefense_Rotate(texture, degrees)
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy

	ULx = ( ( cos(degrees) * -0.5 ) - ( sin(degrees) * 0.5 ) ) + 0.5
	ULy = -( ( ( sin(degrees) * -0.5 ) + ( cos(degrees) * 0.5 ) ) - 0.5 )
	LLx = ( cos(degrees) * -0.5 ) - ( sin(degrees) * -0.5 ) + 0.5
	LLy = -( ( ( sin(degrees) * -0.5 ) + ( cos(degrees) * -0.5 ) ) - 0.5 )
	URx = ( cos(degrees) * 0.5 ) - ( sin(degrees) * 0.5 ) + 0.5
	URy = -( ( ( sin(degrees) * 0.5 ) + ( cos(degrees) * 0.5 ) ) - 0.5 )
	LRx = ( cos(degrees) * 0.5 ) - ( sin(degrees) * -0.5 ) + 0.5
	LRy = -( ( ( sin(degrees) * 0.5 ) + ( cos(degrees) * -0.5 ) ) - 0.5 )
	
	texture:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

function PrimalDefense_UpdateCostTexts()
	-- update cost texts to show or gray out based on current funds
	if ( GameState.player.gold < PrimalDefense_TowerMasterData["CANNON"][1].cost ) then
		PrimalDefense_BuildTowersCannonText:SetText("|cff8f8f8f"..L["Cannon"].."|r")
		PrimalDefense_BuildTowersCannonCost:SetText("|cffff0000- "..PrimalDefense_TowerMasterData["CANNON"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersCannon:SetAlpha(0.5)
	else
		PrimalDefense_BuildTowersCannonText:SetText("|cffffffff"..L["Cannon"].."|r")
		PrimalDefense_BuildTowersCannonCost:SetText("|cffffff00-|r |cffffffff"..PrimalDefense_TowerMasterData["CANNON"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersCannon:SetAlpha(1)
	end
	
	if ( GameState.player.gold < PrimalDefense_TowerMasterData["ARROW"][1].cost ) then
		PrimalDefense_BuildTowersArrowText:SetText("|cff8f8f8f"..L["Arrow"].."|r")
		PrimalDefense_BuildTowersArrowCost:SetText("|cffff0000- "..PrimalDefense_TowerMasterData["ARROW"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersArrow:SetAlpha(0.5)
	else
		PrimalDefense_BuildTowersArrowText:SetText("|cffffffff"..L["Arrow"].."|r")
		PrimalDefense_BuildTowersArrowCost:SetText("|cffffff00-|r |cffffffff"..PrimalDefense_TowerMasterData["ARROW"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersArrow:SetAlpha(1)
	end
	
	if ( ( GameState.player.blessings["FIRE"] > 0 ) and ( GameState.player.gold >= PrimalDefense_TowerMasterData["FIRE"][1].cost ) ) then
		PrimalDefense_BuildTowersFireText:SetText("|cffffffff"..L["Fire"].."|r")
		PrimalDefense_BuildTowersFireCost:SetText("|cffffff00-|r |cffffffff"..PrimalDefense_TowerMasterData["FIRE"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersFire:SetAlpha(1)
	else
		PrimalDefense_BuildTowersFireText:SetText("|cff8f8f8f"..L["Fire"].."|r")
		PrimalDefense_BuildTowersFire:SetAlpha(0.5)
		if ( GameState.player.blessings["FIRE"] == 0 ) then
			PrimalDefense_BuildTowersFireCost:SetText("|cffff0000- "..L["Requires Blessing"].."|r")
		else
			PrimalDefense_BuildTowersFireCost:SetText("|cffff0000- "..PrimalDefense_TowerMasterData["FIRE"][1].cost.." "..L["Gold"].."|r")
		end
	end
	
	if ( ( GameState.player.blessings["ICE"] > 0 ) and ( GameState.player.gold >= PrimalDefense_TowerMasterData["ICE"][1].cost ) ) then
		PrimalDefense_BuildTowersIceText:SetText("|cffffffff"..L["Ice"].."|r")
		PrimalDefense_BuildTowersIceCost:SetText("|cffffff00-|r |cffffffff"..PrimalDefense_TowerMasterData["ICE"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersIce:SetAlpha(1)
	else
		PrimalDefense_BuildTowersIceText:SetText("|cff8f8f8f"..L["Ice"].."|r")
		PrimalDefense_BuildTowersIce:SetAlpha(0.5)
		if ( GameState.player.blessings["ICE"] == 0 ) then
			PrimalDefense_BuildTowersIceCost:SetText("|cffff0000- "..L["Requires Blessing"].."|r")
		else
			PrimalDefense_BuildTowersIceCost:SetText("|cffff0000- "..PrimalDefense_TowerMasterData["ICE"][1].cost.." "..L["Gold"].."|r")
		end
	end
	
	if ( ( GameState.player.blessings["SHADOW"] > 0 ) and ( GameState.player.gold >= PrimalDefense_TowerMasterData["SHADOW"][1].cost ) ) then
		PrimalDefense_BuildTowersShadowText:SetText("|cffffffff"..L["Shadow"].."|r")
		PrimalDefense_BuildTowersShadowCost:SetText("|cffffff00-|r |cffffffff"..PrimalDefense_TowerMasterData["SHADOW"][1].cost.." "..L["Gold"].."|r")
		PrimalDefense_BuildTowersShadow:SetAlpha(1)
	else
		PrimalDefense_BuildTowersShadowText:SetText("|cff8f8f8f"..L["Shadow"].."|r")
		PrimalDefense_BuildTowersShadow:SetAlpha(0.5)
		if ( GameState.player.blessings["SHADOW"] == 0 ) then
			PrimalDefense_BuildTowersShadowCost:SetText("|cffff0000- "..L["Requires Blessing"].."|r")
		else
			PrimalDefense_BuildTowersShadowCost:SetText("|cffff0000- "..PrimalDefense_TowerMasterData["SHADOW"][1].cost.." "..L["Gold"].."|r")
		end
	end
end

function PrimalDefense_UpdateBlessingsTexts()
	if ( GameState.player.blessings["FIRE"] < 3 ) then
		PrimalDefense_BlessingsFireText:SetText("|cffffffff"..L["Fury of Skoll"].." "..(GameState.player.blessings["FIRE"] + 1).."|r")
		PrimalDefense_BlessingsFireCost:SetText("|cffffff00-|r |cffffffff30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsFireCost:Show()
		PrimalDefense_BlessingsFire:SetAlpha(1)
	else
		PrimalDefense_BlessingsFireText:SetText("|cff8f8f8f"..L["You are fully blessed."].."|r")
		PrimalDefense_BlessingsFireCost:Hide()
		PrimalDefense_BlessingsFire:SetAlpha(0.5)
	end
	
	if ( GameState.player.blessings["ICE"] < 3 ) then
		PrimalDefense_BlessingsIceText:SetText("|cffffffff"..L["Song of Lorelei"].." "..(GameState.player.blessings["ICE"] + 1).."|r")
		PrimalDefense_BlessingsIceCost:SetText("|cffffff00-|r |cffffffff30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsIceCost:Show()
		PrimalDefense_BlessingsIce:SetAlpha(1)
	else
		PrimalDefense_BlessingsIceText:SetText("|cff8f8f8f"..L["You are fully blessed."].."|r")
		PrimalDefense_BlessingsIceCost:Hide()
		PrimalDefense_BlessingsIce:SetAlpha(0.5)
	end
	
	if ( GameState.player.blessings["SHADOW"] < 3 ) then
		PrimalDefense_BlessingsShadowText:SetText("|cffffffff"..L["Blight of the Abyss"].." "..(GameState.player.blessings["SHADOW"] + 1).."|r")
		PrimalDefense_BlessingsShadowCost:SetText("|cffffff00-|r |cffffffff30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsShadowCost:Show()
		PrimalDefense_BlessingsShadow:SetAlpha(1)
	else
		PrimalDefense_BlessingsShadowText:SetText("|cff8f8f8f"..L["You are fully blessed."].."|r")
		PrimalDefense_BlessingsShadowCost:Hide()
		PrimalDefense_BlessingsShadow:SetAlpha(0.5)
	end
	
	if ( GameState.player.essence < 30 ) then
		PrimalDefense_BlessingsFireText:SetText("|cff8f8f8f"..PrimalDefense_BlessingsFireText:GetText():sub(11))
		PrimalDefense_BlessingsIceText:SetText("|cff8f8f8f"..PrimalDefense_BlessingsIceText:GetText():sub(11))
		PrimalDefense_BlessingsShadowText:SetText("|cff8f8f8f"..PrimalDefense_BlessingsShadowText:GetText():sub(11))
		PrimalDefense_BlessingsFireCost:SetText("|cffff0000- 30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsIceCost:SetText("|cffff0000- 30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsShadowCost:SetText("|cffff0000- 30 "..L["Essence"].."|r")
		PrimalDefense_BlessingsFire:SetAlpha(0.5)
		PrimalDefense_BlessingsIce:SetAlpha(0.5)
		PrimalDefense_BlessingsShadow:SetAlpha(0.5)
	end
end

function PrimalDefense_ResetGameState()
	GameState.player.level = 0
	GameState.player.lives = 20
	GameState.player.gold = 75
	GameState.player.essence = 0
	GameState.player.blessings.FIRE = 0
	GameState.player.blessings.ICE = 0
	GameState.player.blessings.SHADOW = 0
	GameState.player.blessings.MASTERY = 0
	GameState.projectiles = {}
	for i=1, #GameState.enemies do
		GameState.enemies[i].texture:SetTexture(nil)
		GameState.enemies[i].healthBar:Hide()
	end
	GameState.enemies = {}
	GameState.levelInProgress = false
	GameState.paused = false
	
	for i = 1, #MapTiles do
		MapTiles[i].tower = nil
		getglobal(MapTiles[i]:GetName().."Tower"):Hide()
	end
	
	for i = #PrimalDefense_Animations, 1, -1 do
		PrimalDefense_Animations[i].texture:Hide()
		tremove(PrimalDefense_Animations, i)
	end
	
	PrimalDefense_Level:SetText("|cffffffff"..L["Level"]..": "..GameState.player.level.."|r")
	PrimalDefense_Lives:SetText("|cffffffff"..L["Lives"]..": "..GameState.player.lives.."|r")
	PrimalDefense_Gold:SetText("|cffffffff"..L["Gold"]..": "..GameState.player.gold.."|r")
	PrimalDefense_Essence:SetText("|cffffffff"..L["Essence"]..": "..GameState.player.essence.."|r")
	
	PrimalDefense_BlessingsFireText:SetText("|cff8f8f8f"..L["Fury of Skoll"].."|r")
	PrimalDefense_BlessingsIceText:SetText("|cff8f8f8f"..L["Song of Lorelei"].."|r")
	PrimalDefense_BlessingsShadowText:SetText("|cff8f8f8f"..L["Blight of the Abyss"].."|r")
	PrimalDefense_BlessingsFireCost:Show()
	PrimalDefense_BlessingsIceCost:Show()
	PrimalDefense_BlessingsShadowCost:Show()
	
	SelectedTile = nil
	PrimalDefense_MapRange:Hide()
	PrimalDefense_Sidebar:Hide()
	
	PrimalDefense_UpdateCostTexts()
	PrimalDefense_UpdateBlessingsTexts()
	
	PrimalDefense_Start:Enable()
	
	PrimalDefense:EnableKeyboard(false)
	
	PrimalDefense_MessageText:SetText("|cffffffff"..L["Welcome to Primal Defense!"].."|r")
end

function PrimalDefense_StartLevel()
	if ( GameState.player.level == #PrimalDefense_EnemyMasterData ) then
		PrimalDefense_MessageText:SetText("|cffffffff"..L["You've saved the Amirans from destruction!  All too easy..."])
		return
	end

	for i=1, #MapPath do
		for j=1, #MapPath[i] do
			if ( MapPath[i][j] == 0 ) then
				local tile = getglobal("PrimalDefense_MapTile"..i.."-"..j)
				if ( tile.tower ) then
					tile.tower.elapsed = 0
				end
			end
		end
	end

	GameState.levelInProgress = true
	GameState.player.level = GameState.player.level + 1
	PrimalDefense_Level:SetText("|cffffffff"..L["Level"]..": "..GameState.player.level.."|r")
	PrimalDefense_Start:Disable()
	
	--for i=1, 10 do
		--tinsert(GameState.enemies, PrimalDefense_CreateEnemy(PrimalDefense_Map, "Interface/Icons/Spell_Nature_Polymorph", 100 + ( GameState.player.level - 1 ) * 50, 60, 4 * 32 - 12, 35 * i, GameState.player.level * 2, {}))		
	--end
	local curlvl = GameState.player.level
	local pd_emd = PrimalDefense_EnemyMasterData
	for i=1, PrimalDefense_EnemyMasterData[curlvl].num do
		tinsert(GameState.enemies, PrimalDefense_CreateEnemy(PrimalDefense_Map, pd_emd[curlvl].texture, pd_emd[curlvl].health, pd_emd[curlvl].speed, 4 * 32 - 12, 35 * i, pd_emd[curlvl].reward, pd_emd[curlvl].immunities))
	end
	
	PrimalDefense_MessageText:SetText("|cffffffff"..pd_emd[curlvl].description.."|r")
end
