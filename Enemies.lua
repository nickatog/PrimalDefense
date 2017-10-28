local L = PDLocals

PrimalDefense_MapWaypoints =
	{
		{ 100, "down" }, { -84, "left" }, { 50, "down" }, { -244, "right" }, { 148, "up" },
		{ -180, "right" }, { 244, "down" }, { -340, "left" }, { 50, "down" }, { -436, "right" },
		{ 340, "up" }, { -84, "left" }, { 212, "up" }, { 0, nil }
	}

PrimalDefense_EnemyMasterData =
	{
		-- Tier 1: 500 point intervals
		[1] =
			{
				["num"] = 10,
				["health"] = 100,
				["speed"] = 60,
				["reward"] = 1,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Spell_Nature_Polymorph",
				["description"] = L["Sheep: 100 health, 1 gold each."]
			},
		[2] =
			{
				["num"] = 10,
				["health"] = 150,
				["speed"] = 60,
				["reward"] = 2,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Druid_Cower",
				["description"] = L["Cats: 150 health, 2 gold each."]
			},
		[3] =
			{
				["num"] = 10,
				["health"] = 200,
				["speed"] = 60,
				["reward"] = 2,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Hunter_CobraStrikes",
				["description"] = L["Snakes: 200 health, 2 gold each."]
			},
		[4] =
			{
				["num"] = 10,
				["health"] = 125,
				["speed"] = 60,
				["reward"] = 3,
				["immunities"] = { "CANNON" },
				["texture"] = "Interface/Icons/Ability_Hunter_Pet_Bat",
				["description"] = L["Bats: 125 health, 3 gold each.  Immune to cannon towers!"]
			},
		[5] =
			{
				["num"] = 10,
				["health"] = 300,
				["speed"] = 60,
				["reward"] = 3,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Hunter_Pet_Boar",
				["description"] = L["Boars: 300 health, 3 gold each."]
			},
		[6] =
			{
				["num"] = 10,
				["health"] = 300,
				["speed"] = 80,
				["reward"] = 4,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Druid_SkinTeeth",
				["description"] = L["Panthers: 300 health, 4 gold each.  Increased speed!"]
			},
		[7] =
			{
				["num"] = 10,
				["health"] = 400,
				["speed"] = 60,
				["reward"] = 4,
				["immunities"] = {},
				["texture"] = "Interface/Icons/ABILITY_DRUID_DEMORALIZINGROAR",
				["description"] = L["Bears: 400 health, 4 gold each.  Boss next level!"]
			},
		[8] =
			{
				["num"] = 1,
				["health"] = 4500,
				["speed"] = 50,
				["reward"] = 50,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Druid_Enrage",
				["description"] = L["BOSS - Angry Cow: 4500 health, 50 gold."]
			},
		-- Tier 2: 1000 point intervals
		[9] =
			{
				["num"] = 15,
				["health"] = 350,
				["speed"] = 60,
				["reward"] = 6,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Gnome_Female",
				["description"] = L["Gnomes: 350 health, 6 gold each.  Increased group size!"]
			},
		[10] =
			{
				["num"] = 10,
				["health"] = 650,
				["speed"] = 60,
				["reward"] = 7,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Dwarf_Male",
				["description"] = L["Dwarves: 650 health, 7 gold each."]
			},
		[11] =
			{
				["num"] = 10,
				["health"] = 650,
				["speed"] = 80,
				["reward"] = 8,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Human_Female",
				["description"] = L["Humans: 650 health, 8 gold each.  Increased speed!"]
			},
		[12] =
			{
				["num"] = 10,
				["health"] = 850,
				["speed"] = 60,
				["reward"] = 9,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Nightelf_Male",
				["description"] = L["Night Elves: 850 health, 9 gold each.  Boss next level!"]
			},
		[13] =
			{
				["num"] = 1,
				["health"] = 9500,
				["speed"] = 50,
				["reward"] = 100,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Warrior_InnerRage",
				["description"] = L["BOSS - Knight: 9500 health, 100 gold."]
			},
		-- Tier 3: 2500 point intervals
		[14] =
			{
				["num"] = 10,
				["health"] = 950,
				["speed"] = 60,
				["reward"] = 11,
				["immunities"] = { "CANNON" },
				["texture"] = "Interface/Icons/Ability_Mount_Gyrocoptor",
				["description"] = L["Gyrocopters: 950 health, 11 gold each.  Immune to cannon towers!"]
			},
		[15] =
			{
				["num"] = 10,
				["health"] = 1450,
				["speed"] = 60,
				["reward"] = 12,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Warrior_EndlessRage",
				["description"] = L["Bloodlusted Orcs: 1450 health, 12 gold each."]
			},
		[16] =
			{
				["num"] = 10,
				["health"] = 1450,
				["speed"] = 60,
				["reward"] = 13,
				["immunities"] = { "FIRE" },
				["texture"] = "Interface/Icons/Ability_Warlock_EmpoweredImp",
				["description"] = L["Imps: 1450 health, 13 gold each.  Immune to fire towers!"]
			},
		[17] =
			{
				["num"] = 10,
				["health"] = 1950,
				["speed"] = 60,
				["reward"] = 14,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Creature_Poison_05",
				["description"] = L["Leeches: 1950 health, 14 gold each.  Boss next level!"]
			},
		[18] =
			{
				["num"] = 1,
				["health"] = 22500,
				["speed"] = 50,
				["reward"] = 150,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Racial_Avatar",
				["description"] = L["BOSS - Avatar: 22500 health, 150 gold."]
			},
		-- Tier 4: 5000 point intervals
		[19] =
			{
				["num"] = 15,
				["health"] = 1800,
				["speed"] = 60,
				["reward"] = 16,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Bloodelf_Female",
				["description"] = L["Blood Elves: 1800 health, 16 gold each.  Increased group size!"]
			},
		[20] =
			{
				["num"] = 10,
				["health"] = 3250,
				["speed"] = 60,
				["reward"] = 17,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Troll_Male",
				["description"] = L["Trolls: 3250 health, 17 gold each."]
			},
		[21] =
			{
				["num"] = 10,
				["health"] = 3250,
				["speed"] = 80,
				["reward"] = 18,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Undead_Female",
				["description"] = L["Forsaken: 3250 health, 18 gold each.  Increased speed!"]
			},
		[22] =
			{
				["num"] = 10,
				["health"] = 4250,
				["speed"] = 60,
				["reward"] = 19,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Character_Tauren_Male",
				["description"] = L["Tauren: 4250 health, 19 gold each.  Boss next level!"]
			},
		[23] =
			{
				["num"] = 1,
				["health"] = 47500,
				["speed"] = 50,
				["reward"] = 200,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Mount_SpectralTiger",
				["description"] = L["BOSS - Spectral Tiger: 47500 health, 200 gold."]
			},
		-- Tier 5: 10000 point intervals (9k?<--)
		[24] =
			{
				["num"] = 10,
				["health"] = 4750,
				["speed"] = 60,
				["reward"] = 23,
				["immunities"] = { "SHADOW" },
				["texture"] = "Interface/Icons/Ability_Warlock_DemonicEmpowerment",
				["description"] = L["Demons: 4750 health, 23 gold each.  Immune to shadow towers!"]
			},
		[25] =
			{
				["num"] = 10,
				["health"] = 6550,
				["speed"] = 60,
				["reward"] = 26,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Spell_DeathKnight_ArmyOfTheDead",
				["description"] = L["Ghouls: 6550 health, 26 gold each."]
			},
		[26] =
			{
				["num"] = 10,
				["health"] = 6550,
				["speed"] = 60,
				["reward"] = 29,
				["immunities"] = { "ICE" },
				["texture"] = "Interface/Icons/Spell_Frost_FrostArmor",
				["description"] = L["Frozen Corpses: 6550 health, 29 gold each.  Immune to ice towers!"]
			},
		[27] =
			{
				["num"] = 10,
				["health"] = 8350,
				["speed"] = 60,
				["reward"] = 32,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Spell_Holy_GuardianSpirit",
				["description"] = L["Soultakers: 8350 health, 32 gold each.  Boss next level!"]
			},
		[28] =
			{
				["num"] = 1,
				["health"] = 92500,
				["speed"] = 50,
				["reward"] = 350,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Boss_Illidan",
				["description"] = L["Illidan: 92500 health, 350 gold."]
			},
		-- Tier 6: 20000 point intervals (16k?<--)
		[29] =
			{
				["num"] = 10,
				["health"] = 9250,
				["speed"] = 60,
				["reward"] = 39,
				["immunities"] = { "FIRE" },
				["texture"] = "Interface/Icons/Spell_Fire_LavaSpawn",
				["description"] = L["Lava Spawns: 9250 health, 39 gold each.  Immune to fire towers!"]
			},
		[30] =
			{
				["num"] = 10,
				["health"] = 10850,
				["speed"] = 60,
				["reward"] = 43,
				["immunities"] = { "SHADOW" },
				["texture"] = "Interface/Icons/Ability_Warlock_ImprovedSoulLeech",
				["description"] = L["Abyssal Fiends: 10850 health, 43 gold each.  Immune to shadow towers!"]
			},
		[31] =
			{
				["num"] = 10,
				["health"] = 12450,
				["speed"] = 60,
				["reward"] = 47,
				["immunities"] = { "ICE" },
				["texture"] = "Interface/Icons/Spell_Frost_SummonWaterElemental",
				["description"] = L["Water Elementals: 12450 health, 47 gold each.  Immune to ice towers!"]
			},
		[32] =
			{
				["num"] = 10,
				["health"] = 15650,
				["speed"] = 60,
				["reward"] = 51,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Ability_Mount_NetherDrakeElite",
				["description"] = L["Nether Drakes: 15750 health, 51 gold each.  Boss next level!"]
			},
		[33] =
			{
				["num"] = 1,
				["health"] = 172500,
				["speed"] = 50,
				["reward"] = 550,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Boss_Kiljaedan",
				["description"] = L["Kil'Jaedan: 172500 health, 550 gold."]
			},
		-- Tier 7: 50000 point intervals (-->30/40k?)
		[34] =
			{
				["num"] = 10,
				["health"] = 17250,
				["speed"] = 60,
				["reward"] = 62,
				["immunities"] = { "FIRE" },
				["texture"] = "Interface/Icons/INV_Misc_Head_Dragon_01",
				["description"] = L["Red Dragons: 17250 health, 62 gold.  Immune to fire towers!"]
			},
		[35] =
			{
				["num"] = 10,
				["health"] = 20250,
				["speed"] = 60,
				["reward"] = 70,
				["immunities"] = { "SHADOW" },
				["texture"] = "Interface/Icons/INV_Misc_Head_Dragon_Black",
				["description"] = L["Black Dragons: 20250 health, 70 gold.  Immune to shadow towers!"]
			},
		[36] =
			{
				["num"] = 10,
				["health"] = 23250,
				["speed"] = 60,
				["reward"] = 77,
				["immunities"] = { "ICE" },
				["texture"] = "Interface/Icons/INV_Misc_Head_Dragon_Blue",
				["description"] = L["Blue Dragons: 23250 health, 77 gold.  Immune to ice towers!"]
			},
		[37] =
			{
				["num"] = 10,
				["health"] = 29250,
				["speed"] = 60,
				["reward"] = 85,
				["immunities"] = {},
				["texture"] = "Interface/Icons/INV_Misc_Head_Dragon_Bronze",
				["description"] = L["Bronze Dragons: 29250 health, 85 gold."]
			},
		[38] =
			{
				["num"] = 10,
				["health"] = 32250,
				["speed"] = 60,
				["reward"] = 92,
				["immunities"] = {},
				["texture"] = "Interface/Icons/INV_Misc_Head_Dragon_Green",
				["description"] = L["Green Dragons: 32250 health, 92 gold.  Boss next level!"]
			},
		[39] =
			{
				["num"] = 1,
				["health"] = 350000,
				["speed"] = 50,
				["reward"] = 1000,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Boss_CThun",
				["description"] = L["C\'Thun: 350000 health, 1000 gold.  Boss next level!"]
			},
		[40] =
			{
				["num"] = 1,
				["health"] = 500000,
				["speed"] = 50,
				["reward"] = 1500,
				["immunities"] = {},
				["texture"] = "Interface/Icons/Achievement_Boss_YoggSaron_01",
				["description"] = L["Yogg Saron: 500000 health, 1500 gold.  One more level!"]
			},
		-- Bonus level
		[41] =
			{
				["num"] = 25,
				["health"] = 50000,
				["speed"] = 60,
				["reward"] = 1000,
				["immunities"] = {},
				["texture"] = "Interface/Icons/INV_Misc_Toy_07",
				["description"] = L["Hula Girls: 50000 health, 1000 gold each.  Good luck!"]
			},
	}
	
function PrimalDefense_CreateEnemy(textureParent, texture, health, speed, posX, posY, reward, immunities)
	local function Update(self, elapsed)
		if ( self.direction == "down" ) then
			self.posY = self.posY - ( self.speed * elapsed )
			
			if ( self.posY <= PrimalDefense_MapWaypoints[self.nextWaypoint][1] ) then
				self.posY = PrimalDefense_MapWaypoints[self.nextWaypoint][1]
				self.direction = PrimalDefense_MapWaypoints[self.nextWaypoint][2]
				self.nextWaypoint = self.nextWaypoint + 1
			end
		elseif ( self.direction == "up" ) then
			self.posY = self.posY + ( self.speed * elapsed )
			
			if ( self.posY >= PrimalDefense_MapWaypoints[self.nextWaypoint][1] ) then
				self.posY = PrimalDefense_MapWaypoints[self.nextWaypoint][1]
				self.direction = PrimalDefense_MapWaypoints[self.nextWaypoint][2]
				self.nextWaypoint = self.nextWaypoint + 1
				
				if ( self.nextWaypoint > #PrimalDefense_MapWaypoints ) then
					self.nextWaypoint = 2
					self.posX = 116
					self.posY = PrimalDefense_MapWaypoints[1][1]
					self.direction = PrimalDefense_MapWaypoints[1][2]
					GameState.player.lives = GameState.player.lives - 1
					PrimalDefense_Lives:SetText("|cffffffff"..L["Lives"]..": "..GameState.player.lives.."|r")
				end
			end
		elseif ( self.direction == "left" ) then
			self.posX = self.posX - ( self.speed * elapsed )
			
			if ( self.posX <= PrimalDefense_MapWaypoints[self.nextWaypoint][1] ) then
				self.posX = PrimalDefense_MapWaypoints[self.nextWaypoint][1]
				self.direction = PrimalDefense_MapWaypoints[self.nextWaypoint][2]
				self.nextWaypoint = self.nextWaypoint + 1
			end
		else -- "right"
			self.posX = self.posX + ( self.speed * elapsed )
			
			if ( self.posX >= PrimalDefense_MapWaypoints[self.nextWaypoint][1] ) then
				self.posX = PrimalDefense_MapWaypoints[self.nextWaypoint][1]
				self.direction = PrimalDefense_MapWaypoints[self.nextWaypoint][2]
				self.nextWaypoint = self.nextWaypoint + 1
			end
		end
		
		self.texture:SetPoint("CENTER", self.texture:GetParent(), "TOPLEFT", self.posX, self.posY)
		self.healthBar:SetPoint("CENTER", self.healthBar:GetParent(), "TOPLEFT", self.posX, self.posY + 20)
		
		if ( self.posY > 0 ) then
			self.texture:Hide()
			self.healthBar:Hide()
		else
			self.texture:Show()
			if ( GameState.showHealth ) then
				self.healthBar:Show()
			end
		end
		
		for i = #self.debuffs, 1, -1 do
			if ( self.debuffs[i]:Update(elapsed) == false ) then
				tremove(self.debuffs, i)
			end
		end
		
		self.healthBar:SetValue(self.health)
	end
	
	local function IsImmune(self, damageType)
		for _,v in pairs(self.immunities) do
			if ( v == damageType ) then
				return true
			end
		end
		
		return false
	end

	local enemy = {}
	
	enemy.texture = textureParent:CreateTexture(nil, "ARTWORK")
	enemy.texture:SetTexture(texture)
	enemy.texture:SetHeight(28)
	enemy.texture:SetWidth(28)
	enemy.texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	enemy.texture:SetPoint("CENTER", textureParent, "TOPLEFT", posX, posY)
	enemy.texture:Hide()
	enemy.healthBar = CreateFrame("StatusBar", nil, textureParent)
	enemy.healthBar:SetHeight(4)
	enemy.healthBar:SetWidth(28)
	enemy.healthBar:SetPoint("CENTER", textureParent, "TOPLEFT", posX, posY + 20)
	enemy.healthBar:SetMinMaxValues(0, health)
	enemy.healthBar:SetValue(health)
	enemy.healthBar:SetStatusBarTexture("Interface/TargetingFrame/UI-StatusBar")
	enemy.healthBar:SetStatusBarColor(1, 0.2, 0.2)
	enemy.healthBar:Hide()
	enemy.maxHealth = health
	enemy.health = health
	enemy.speed = speed
	enemy.posX = posX
	enemy.posY = posY
	enemy.direction = "down"
	enemy.reward = reward
	enemy.immunities = immunities
	enemy.debuffs = {}
	enemy.Update = Update
	enemy.IsImmune = IsImmune
	
	enemy.direction = "down"
	enemy.nextWaypoint = 2
	
	return enemy
end
