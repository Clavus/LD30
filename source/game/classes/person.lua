
local Person = class("Person", Entity)
Person:include( PhysicsActor )
Person:include( CollisionResolver )

local state = {
	neutral = { face = ":|", color = Color.Gray },

	depressed = { face = "._.", color = Color.SlateBlue },
	sad = { face = ":(", color = Color.SteelBlue },
	content = { face = ":)", color = Color.ForestGreen },
	happy = { face = ":D", color = Color.Lime },
	
	angry = { face = ">:(", color = Color.Maroon },
	uncaring = { face = ":/", color = Color.Brown },
	interested = { face = ":o", color = Color.Pink },
	loving = { face = ":3", color = Color.PaleVioletRed }
}

function Person:initialize( world )

	Entity.initialize( self )
	PhysicsActor.initialize( self, world )
	
	self.radius = 32
	self.shape = love.physics.newCircleShape( self.radius )
	
	local fixture = love.physics.newFixture( self:getBody(), self.shape )
	
	self.emotion = util.choose("happiness", "loving")
	self.base_emotionscale = util.choose(0.2, 0.45, 0.7, 0.95)
	self.boost_emotionscale = 0
	self:computeState()
	
	local impulse = angle.forward( math.random() * math.pi * 2 ) * (math.random() * 100)
	
	self:getBody():applyLinearImpulse( impulse.x, impulse.y )
	
	self.connections = {}
	
end

function Person:update()

	

end

function Person:draw()
	
	local font = love.graphics.getFont()
	local fw, fh = font:getWidth( state[self.state].face ), font:getHeight()
	local ang = self:getAngle()
	local d = math.sqrt( fw * fw + fh * fh ) / 2
	local fx, fy = (angle.forward( ang + (math.pi / 4) ) * d):unpack()
	
	local oldcol = { love.graphics.getColor() }
	
	love.graphics.setColor( state[self.state].color:unpack() )
			
	local x, y = self:getPos()
	love.graphics.circle( "line", x, y, self.radius, 32 )
	love.graphics.print( state[self.state].face, x - fx, y - fy, ang )
	
	love.graphics.print( self:getEntIndex(), x - 6, y - 22 )
	
	--love.graphics.line( x, y, x - fx, y - fy )
	--love.graphics.line( x, y, x + 4, y )
	--love.graphics.line( x, y, x, y + 4 )
	--love.graphics.print( (ang % (math.pi * 2)), x, y - 40 )
	
	love.graphics.setColor( unpack( oldcol ) )
	
end

function Person:computeState()
	
	local scale = self:getEmotionScale()
	self.state = "neutral"
	
	if (self.emotion == "happiness") then
		if (scale < 0.25) then self.state = "depressed"
		elseif (scale < 0.5) then self.state = "sad"
		elseif (scale >= 0.5) then self.state = "content"
		elseif (scale >= 0.75) then self.state = "happy"
		end
	else
		if (scale < 0.25) then self.state = "angry"
		elseif (scale < 0.5) then self.state = "uncaring"
		elseif (scale >= 0.5) then self.state = "interested"
		elseif (scale >= 0.75) then self.state = "loving"
		end
	end
	
end

function Person:getEmotionScale()
	
	return self.base_emotionscale + self.boost_emotionscale
	
end

function Person:connectTo( otherPerson )
	
	if (self:isConnectedTo( otherPerson )) then return end
	
	local conn = level:createEntity( "Connection", self, otherPerson )
	table.insert( self.connections, conn )
	table.insert( otherPerson.connections, conn )
	
	-- give emotion boost
	if (otherPerson.emotion == self.emotion) then
		local diff = otherPerson:getEmotionScale() - self:getEmotionScale()
		
		if (diff > 0) then
			self.boost_emotionscale = self.boost_emotionscale + 0.25
		else
			otherPerson.boost_emotionscale = otherPerson.boost_emotionscale + 0.25
		end
	end	
	
	self:computeState()
	otherPerson:computeState()
	
end

function Person:isConnectedTo( otherPerson )
	
	for k, v in pairs( self.connections ) do
		
		if (v:getPerson1() == otherPerson or v:getPerson2() == otherPerson) then
			return true
		end
		
	end
	
	return false
	
end

function Person:setRadius( r )

	self.radius = r
	self.shape:setRadius( r )

end

function Person:getRadius()

	return self.radius

end

function Person:beginContactWith( other, contact, myFixture, otherFixture, selfIsFirst )

	if (other:isInstanceOf( Person )) then
		timer.add( 0, function() self:connectTo( other ) end )
	end

end

return Person