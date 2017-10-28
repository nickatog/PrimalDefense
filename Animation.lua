PrimalDefense_Animations = {}

function PrimalDefense_CreateAnimation(duration, updateFunc, finalFunc, finalParam, textureParent, texture, rotation, posX, posY, normX, normY)
	local function Update(self, elapsed)
		self:updateFunc(elapsed)
		self.texture:SetPoint("CENTER", self.texture:GetParent(), "TOPLEFT", self.posX, self.posY)
		self.elapsed = self.elapsed + elapsed
		
		if ( self.elapsed >= self.duration ) then
			self:finalFunc(finalParam)
			self.texture:Hide()
			return false
		end
		
		return true
	end

	local animation = {}
	
	animation.duration = duration
	animation.elapsed = 0
	animation.updateFunc = updateFunc
	animation.finalFunc = finalFunc
	animation.finalParam = finalParam
	animation.texture = textureParent:CreateTexture(nil, "OVERLAY")
	animation.texture:SetTexture(texture)
	PrimalDefense_Rotate(animation.texture, rotation)
	animation.texture:SetPoint("CENTER", textureParent, "TOPLEFT", posX, posY)
	animation.texture:Show()
	animation.posX = posX
	animation.posY = posY
	animation.normX = normX
	animation.normY = normY
	
	animation.Update = Update
	
	return animation
end
