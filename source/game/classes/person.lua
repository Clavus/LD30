
local Person = class("Person", Entity)
Person:include( PhysicsActor )
Person:include( CollisionResolver )

local state = {
	neutral = { face = ":|", color = Color.Gray },

	depressed = { face = "._.", color = Color.SlateBlue },
	sad = { face = ":(", color = Color.lerp(Color.SlateBlue, Color.PowderBlue, 0.333) },
	content = { face = ":)", color = Color.lerp(Color.SlateBlue, Color.PowderBlue, 0.666) },
	happy = { face = ":D", color = Color.PowderBlue },
	
	angry = { face = ">:(", color = Color.Maroon },
	uncaring = { face = ":/", color = Color.lerp(Color.Maroon, Color.Pink, 0.333) },
	interested = { face = ";)", color = Color.lerp(Color.Maroon, Color.Pink, 0.666) },
	loving = { face = ":3", color = Color.Pink }
}

local face_font = love.graphics.newFont( 24 )

function Person:initialize( world )

	Entity.initialize( self )
	PhysicsActor.initialize( self, world )
	
	self.physworld = world
	self.radius = 32
	self.shape = love.physics.newCircleShape( self.radius )
	
	self.fixture = love.physics.newFixture( self:getBody(), self.shape )
	
	self.emotion = util.choose("happiness", "loving")
	self.base_emotionscale = util.choose(0.2, 0.45, 0.7, 0.95)
	self.boost_emotionscale = 0
	self:computeState()
	
	--local impulse = angle.forward( math.random() * math.pi * 2 ) * (math.random() * 100)
	--self:getBody():applyLinearImpulse( impulse.x, impulse.y )
	
	self.connections = {}

end

function Person:setState( emotion, state )
	
	self.emotion = emotion
	self.state = state
	self.boost_emotionscale = 0
	
	if (self.state == "depressed" or self.state == "angry") then
		self.base_emotionscale = 0.2
	elseif (self.state == "sad" or self.state == "uncaring") then
		self.base_emotionscale = 0.45
	elseif (self.state == "content" or self.state == "interested") then
		self.base_emotionscale = 0.7
	else
		self.base_emotionscale = 0.95
	end
	
	self:computeState()
	
end

function Person:update( dt )

	if (self.state == "angry" or self.state == "uncaring") then
		
		local px, py = self:getPos()
		local push_distance = 180
		
		self.physworld:queryBoundingBox( px - push_distance, py - push_distance, px + push_distance, py + push_distance, function( fix )
			local force = 500
			if (self.state == "uncaring") then force = 250 end
			local other = fix:getUserData() or fix:getBody():getUserData()
			if (other:isInstanceOf( Person ) and other ~= self and not self:isConnectedTo(other)) then
				local dvec = Vector(self:getPos()) - Vector(other:getPos())
				
				if (dvec:length() < push_distance ) then
					self:getBody():applyForce( (dvec:normalize() * force):unpack() )
				end
			end
			return false
		end )
		
	end	

end

function Person:draw()
	
	local fw, fh = face_font:getWidth( state[self.state].face ), face_font:getHeight()
	local ang = self:getAngle()
	local d = math.sqrt( fw * fw + fh * fh ) / 2
	local fx, fy = (angle.forward( ang + (math.pi / 4) ) * d):unpack()
	
	local oldcol = { love.graphics.getColor() }
	local oldfont = love.graphics.getFont()
	
	love.graphics.setColor( state[self.state].color:unpack() )
	love.graphics.setFont( face_font )
	
	local x, y = self:getPos()
	love.graphics.circle( "line", x, y, self.radius, 32 )
	love.graphics.print( state[self.state].face, x - fx, y - fy, ang )
	
	--love.graphics.print( self:getEntIndex(), x - 6, y - 22 )
	
	--love.graphics.line( x, y, x - fx, y - fy )
	--love.graphics.line( x, y, x + 4, y )
	--love.graphics.line( x, y, x, y + 4 )
	--love.graphics.print( (ang % (math.pi * 2)), x, y - 40 )
	
	love.graphics.setColor( unpack( oldcol ) )
	love.graphics.setFont( oldfont )
	
end

function Person:computeState()
	
	local scale = self:getEmotionScale()
	self.state = "neutral"
	
	self:getBody():setLinearDamping( 0 )
	self.fixture:setRestitution( 1.0 )
	
	if (self.emotion == "happiness") then
		if (scale < 0.25) then 
			self.state = "depressed"
			self:getBody():setLinearDamping( 10 )
			self.fixture:setRestitution( 0.2 )
		elseif (scale < 0.5) then 
			self.state = "sad"
			self:getBody():setLinearDamping( 0.5 )
			self.fixture:setRestitution( 0.5 )
		elseif (scale >= 0.5 and scale < 0.75) then self.state = "content"
		elseif (scale >= 0.75) then self.state = "happy"
		end
	else
		if (scale < 0.25) then self.state = "angry"
		elseif (scale < 0.5) then self.state = "uncaring"
		elseif (scale >= 0.5 and scale < 0.75) then self.state = "interested"
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
			if (otherPerson:getEmotionScale() >= 0.75) then
				self.boost_emotionscale = math.min(0.95, self.boost_emotionscale + 0.5)
			elseif (otherPerson:getEmotionScale() >= 0.5) then
				self.boost_emotionscale = math.min(0.95, self.boost_emotionscale + 0.25)
			end
		elseif (diff < 0) then
			if (self:getEmotionScale() >= 0.75) then
				otherPerson.boost_emotionscale = math.min(0.95, otherPerson.boost_emotionscale + 0.5)
			elseif (self:getEmotionScale() >= 0.5) then
				otherPerson.boost_emotionscale = math.min(0.95, otherPerson.boost_emotionscale + 0.25)
			end
		end
	end	
	
	self:computeState()
	otherPerson:computeState()
	
	signal.emit("connection_made", self, otherPerson)
	
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