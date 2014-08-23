
local Person = class("Person", Entity)
Person:include( PhysicsActor )
Person:include( CollisionResolver )

function Person:initialize( world )

	Entity.initialize( self )
	PhysicsActor.initialize( self, world )
	
	self.radius = 32
	self.shape = love.physics.newCircleShape( self.radius )
	
	local fixture = love.physics.newFixture( self:getBody(), self.shape )
	
	self.face = util.choose( ":|", ":)", ":D", "._.", ":3", ">:)" )
	
	local impulse = angle.forward( math.random() * math.pi * 2 ) * (math.random() * 100)
	
	self:getBody():applyLinearImpulse( impulse.x, impulse.y )
	
	self.connections = {}
	
end

function Person:update()

	

end

function Person:draw()
	
	local font = love.graphics.getFont()
	local fw, fh = font:getWidth( self.face ), font:getHeight()
	local ang = currentTime()
	local d = math.sqrt( fw * fw + fh * fh ) / 2
	local fx, fy = (angle.forward( ang + (math.pi / 4) ) * d):unpack()
	
	local x, y = self:getPos()
	love.graphics.circle( "line", x, y, self.radius, 32 )
	love.graphics.print( self.face, x - fx, y - fy, ang )
	
	love.graphics.print( self:getEntIndex(), x - 6, y - 22 )
	
	--love.graphics.line( x, y, x - fx, y - fy )
	--love.graphics.line( x, y, x + 4, y )
	--love.graphics.line( x, y, x, y + 4 )
	--love.graphics.print( (ang % (math.pi * 2)), x, y - 40 )
	
end

function Person:connectTo( otherPerson )
	
	if (self:isConnectedTo( otherPerson )) then return end
	
	print(self:getEntIndex().." and "..otherPerson:getEntIndex().." connected!")
	
	local conn = level:createEntity( "Connection", self, otherPerson )
	table.insert( self.connections, conn )
	table.insert( otherPerson.connections, conn )

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

function Person:beginContactWith( other, contact, myFixture, otherFixture, selfIsFirst )

	if (other:isInstanceOf( Person )) then
		timer.add( 0, function() self:connectTo( other ) end )
	end

end

return Person