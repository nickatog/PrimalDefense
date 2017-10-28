PrimalDefense_DebuffActions =
	{
		["ICE"] =
			{
				[1] =
					{
						["APPLY"] =
							function(self)
								self.target.speed = self.target.speed * 0.7
							end,
						["FADE"] =
							function(self)
								self.target.speed = self.target.speed / 0.7
							end
					},
				[2] =
					{
						["APPLY"] =
							function(self)
								self.target.speed = self.target.speed * 0.7
							end,
						["FADE"] =
							function(self)
								self.target.speed = self.target.speed / 0.7
							end
					},
				[3] =
					{
						["APPLY"] =
							function(self)
								self.target.speed = self.target.speed * 0.7
							end,
						["FADE"] =
							function(self)
								self.target.speed = self.target.speed / 0.7
							end
					}
			},
		["SHADOW"] =
			{
				[1] =
					{
						["APPLY"] =
							function(self)
								
							end,
						["FADE"] =
							function(self)
							
							end
					},
				[2] =
					{
						["APPLY"] =
							function(self)
								
							end,
						["FADE"] =
							function(self)
							
							end
					},
				[3] =
					{
						["APPLY"] =
							function(self)
							
							end,
						["FADE"] =
							function(self)
							
							end
					}
			}
	}

function PrimalDefense_CreateDebuff(towerType, level, duration, target)
	local function Update(self, elapsed)
		self.elapsed = self.elapsed + elapsed
		
		self.target.health = self.target.health - ( self.dotdamage * ( elapsed / self.duration ) )
		
		if ( self.elapsed >= self.duration ) then
			self:OnFade()
			return false
		end
		
		return true
	end

	local debuff = {}
	
	debuff.type = towerType
	debuff.level = level
	debuff.duration = duration
	debuff.elapsed = 0
	debuff.target = target
	
	if ( towerType == "SHADOW" ) then
		debuff.dotdamage = PrimalDefense_TowerMasterData[towerType][level].damage
	else
		debuff.dotdamage = 0
	end
	
	debuff.OnApply = PrimalDefense_DebuffActions[towerType][level]["APPLY"]
	debuff.OnFade = PrimalDefense_DebuffActions[towerType][level]["FADE"]
	debuff.Update = Update
	
	debuff:OnApply()
	
	return debuff
end
