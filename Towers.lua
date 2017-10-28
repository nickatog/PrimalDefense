local L = PDLocals

PrimalDefense_TowerActions =
	{
		["SHOOT_FIRST_TARGET"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												target.health = target.health - dmg
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								break
							end
						end
					end
				end
			end,
		["SHOOT_FIRST_TARGET_AND_EXPLODE"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												for i=1, #GameState.enemies do
													local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
													if ( dist <= 65 ) then
														GameState.enemies[i].health = GameState.enemies[i].health - dmg
													end
												end
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								break
							end
						end
					end
				end
			end,
		["SHOOT_AND_SLOW_FIRST_NON"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local skip = false
								for j=1, #GameState.enemies[i].debuffs do
									if ( GameState.enemies[i].debuffs[j].type == "ICE" ) then
										skip = true
										break
									end
								end
							
								if ( skip == false ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								local ttype = self.type
								local tlevel = self.level
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												target.health = target.health - dmg
												tinsert(target.debuffs, PrimalDefense_CreateDebuff(ttype, tlevel, 5, target))
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								return
								end
							end
						end
					end
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								local ttype = self.type
								local tlevel = self.level
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												target.health = target.health - dmg
												for i=#target.debuffs, 1, -1 do
													if ( target.debuffs[i].type == "ICE" ) then
														target.debuffs[i].elapsed = 0
														break
													end
												end
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								break
							end
						end
					end
				end
			end,
		["SHOOT_AND_DOT_FIRST_NON"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local skip = false
								for j=1, #GameState.enemies[i].debuffs do
									if ( GameState.enemies[i].debuffs[j].type == "SHADOW" and GameState.enemies[i].debuffs[j].level == self.level ) then
										skip = true
										break
									end
								end
							
								if ( skip == false ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								local ttype = self.type
								local tlevel = self.level
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												tinsert(target.debuffs, PrimalDefense_CreateDebuff(ttype, tlevel, 3, target))
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								return
								end
							end
						end
					end
					for i = 1, #GameState.enemies do
						if ( not GameState.enemies[i]:IsImmune(self.type) ) then
							local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
							
							if ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) then
								local degrees = 0
						
								if ( GameState.enemies[i].posX < self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q II
										degrees = -( asin( ( self.posX - GameState.enemies[i].posX ) / dist ) )
									else -- Q III
										degrees = -( asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90 )
									end
								elseif ( GameState.enemies[i].posX > self.posX ) then
									if ( GameState.enemies[i].posY >= self.posY ) then -- Q I
										degrees = asin( ( GameState.enemies[i].posX - self.posX ) / dist )
									else -- Q IV
										degrees = asin( ( self.posY - GameState.enemies[i].posY ) / dist ) + 90
									end
								elseif ( GameState.enemies[i].posY > self.posY ) then
									degrees = 0
								end
						
								local ttype = self.type
								local tlevel = self.level
								tinsert(PrimalDefense_Animations,
										PrimalDefense_CreateAnimation(dist / 400,
											function(self, elapsed)
												self.posX = self.posX + self.normX * elapsed * 400
												self.posY = self.posY + self.normY * elapsed * 400
											end,
											function(self, params)
												local target, dmg = unpack(params)
												for i=#target.debuffs, 1, -1 do
													if ( target.debuffs[i].type == "SHADOW" and target.debuffs[i].level == tlevel ) then
														target.debuffs[i].elapsed = 0
														break
													end
												end
											end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
											PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
											degrees, self.posX, self.posY,
											(GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
						
								self.elapsed = 0
								break
							end
						end
					end
				end
			end,
		["AE_DMG"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
						
						if ( ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) and ( not GameState.enemies[i]:IsImmune(self.type) ) ) then
							GameState.enemies[i].health = GameState.enemies[i].health - PrimalDefense_TowerMasterData[self.type][self.level].damage
							-- tinsert(PrimalDefense_Animations,
									-- PrimalDefense_CreateAnimation(dist / 400,
										-- function(self, elapsed)
											-- self.posX = self.posX + self.normX * elapsed * 400
											-- self.posY = self.posY + self.normY * elapsed * 400
										-- end,
										-- function(self, params)
											-- local target, dmg = unpack(params)
											-- target.health = target.health - dmg
										-- end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
										-- PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
										-- 0, self.posX, self.posY,
										-- (GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
					
							self.elapsed = 0
						end
					end
				end
			end,
		["AE_SLOW"] =
			function(self)
				if ( self.elapsed >= PrimalDefense_TowerMasterData[self.type][self.level].delay ) then
					for i = 1, #GameState.enemies do
						local dist = sqrt( ( self.posX - GameState.enemies[i].posX ) ^ 2 + ( self.posY - GameState.enemies[i].posY ) ^ 2 )
						
						if ( ( dist <= PrimalDefense_TowerMasterData[self.type][self.level].range ) and ( not GameState.enemies[i]:IsImmune(self.type) ) ) then
							local hasDebuff = false
							for j=1, #GameState.enemies[i].debuffs do
								if ( GameState.enemies[i].debuffs[j].type == "ICE" ) then
									GameState.enemies[i].debuffs[j].elapsed = 0
									hasDebuff = true
									break
								end
							end
							if ( hasDebuff == false ) then
								tinsert(GameState.enemies[i].debuffs, PrimalDefense_CreateDebuff(self.type, self.level, 5, GameState.enemies[i]))
							end
							-- tinsert(PrimalDefense_Animations,
									-- PrimalDefense_CreateAnimation(dist / 400,
										-- function(self, elapsed)
											-- self.posX = self.posX + self.normX * elapsed * 400
											-- self.posY = self.posY + self.normY * elapsed * 400
										-- end,
										-- function(self, params)
											-- local target, dmg = unpack(params)
											-- target.health = target.health - dmg
										-- end, { GameState.enemies[i], PrimalDefense_TowerMasterData[self.type][self.level].damage },
										-- PrimalDefense_Map, PrimalDefense_TowerMasterData[self.type][self.level].projectiletexture,
										-- 0, self.posX, self.posY,
										-- (GameState.enemies[i].posX - self.posX) / dist, (GameState.enemies[i].posY - self.posY) / dist))
					
							self.elapsed = 0
						end
					end
				end
			end
	}
	
PrimalDefense_TowerMasterData =
	{
		["CANNON"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/Ability_Vehicle_SiegeEngineCannon",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\cannonBall",
						["damage"] = 30,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 20,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					},
				[2] =
					{
						["texture"] = "Interface/Icons/Ability_Vehicle_DemolisherFlameCatapult",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\cannonBall",
						["damage"] = 105,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 50,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					},
				[3] =
					{
						["texture"] = "Interface/Icons/Ability_Vehicle_LiquidPyrite",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\cannonBall",
						["damage"] = 300,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 125,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					}
			},
		["ARROW"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/INV_Misc_Ammo_Arrow_01",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\metalArrow",
						["damage"] = 15,
						["range"] = 128,
						["delay"] = 0.75,
						["cost"] = 15,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					},
				[2] =
					{
						["texture"] = "Interface/Icons/Ability_Hunter_CriticalShot",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\metalArrow",
						["damage"] = 55,
						["range"] = 128,
						["delay"] = 0.75,
						["cost"] = 40,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					},
				[3] =
					{
						["texture"] = "Interface/Icons/Ability_Hunter_ChimeraShot2",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\metalArrow",
						["damage"] = 155,
						["range"] = 128,
						["delay"] = 0.75,
						["cost"] = 100,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					}
			},
		["FIRE"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/Spell_Fire_SearingTotem",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\fireBall",
						["damage"] = 25,
						["range"] = 96,
						["delay"] = 1,
						["cost"] = 35,
						["ability"] = L["Splash damage"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET_AND_EXPLODE"
					},
				[2] =
					{
						["texture"] = "Interface/Icons/Spell_Fire_SoulBurn",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\fireBall",
						["damage"] = 80,
						["range"] = 96,
						["delay"] = 1,
						["cost"] = 70,
						["ability"] = L["Splash damage"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET_AND_EXPLODE"
					},
				[3] =
					{
						["texture"] = "Interface/Icons/Spell_Fire_Volcano",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\fireBall",
						["damage"] = 150,
						["range"] = 96,
						["delay"] = 1,
						["cost"] = 200,
						["ability"] = L["AoE damage"],
						["primaryAttack"] = "AE_DMG"
					}
			},
		["ICE"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/Spell_Fire_BluePyroblast",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\iceShard",
						["damage"] = 30,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 35,
						["ability"] = L["Single slow"],
						["primaryAttack"] = "SHOOT_AND_SLOW_FIRST_NON"
					},
				[2] =
					{
						["texture"] = "Interface/Icons/Spell_DeathKnight_IceTouch",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\iceShard",
						["damage"] = 70,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 70,
						["ability"] = L["Single slow"],
						["primaryAttack"] = "SHOOT_AND_SLOW_FIRST_NON"
					},
				[3] =
					{
						["texture"] = "Interface/Icons/Spell_Fire_BlueFlameRing",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\iceShard",
						["damage"] = 0,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 200,
						["ability"] = L["AoE slow"],
						["primaryAttack"] = "AE_SLOW"
					}
			},
		["SHADOW"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/Spell_Shadow_PainSpike",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\plagueBolt",
						["damage"] = 60,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 35,
						["ability"] = L["None"],
						["primaryAttack"] = "SHOOT_AND_DOT_FIRST_NON"
					},
				[2] =
					{
						["texture"] = "Interface/Icons/Spell_Shadow_ShadowWordPain",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\plagueBolt",
						["damage"] = 250,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 70,
						["ability"] = L["DoT damage"],
						["primaryAttack"] = "SHOOT_AND_DOT_FIRST_NON"
					},
				[3] =
					{
						["texture"] = "Interface/Icons/Spell_Shadow_DeathsEmbrace",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\plagueBolt",
						["damage"] = 750,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 200,
						["ability"] = L["Heavy DoT damage"],
						["primaryAttack"] = "SHOOT_AND_DOT_FIRST_NON"
					}
			},
		["MASTERY"] =
			{
				[1] =
					{
						["texture"] = "Interface/Icons/Ability_Mage_MissileBarrage",
						["projectiletexture"] = "Interface\\AddOns\\PrimalDefense\\chaosBolt",
						["damage"] = 1200,
						["range"] = 128,
						["delay"] = 1,
						["cost"] = 300,
						["ability"] = L["Chaos Damage"],
						["primaryAttack"] = "SHOOT_FIRST_TARGET"
					}
			}
	}

function PrimalDefense_CreateTower(towerType, level, tileX, tileY)
	local function Update(self, elapsed)
		self.elapsed = self.elapsed + elapsed
		self:primaryAttack()
	end

	local newTower = {}
	
	newTower.type = towerType
	newTower.level = level
	newTower.posX = ( tileY - 1 ) * 32 + 19
	newTower.posY = -( ( tileX - 1 ) * 32 + 19 )
	newTower.elapsed = 0
	newTower.buffs = {}
	newTower.primaryAttack = PrimalDefense_TowerActions[PrimalDefense_TowerMasterData[towerType][level].primaryAttack]
	
	newTower.Update = Update
	
	return newTower
end
