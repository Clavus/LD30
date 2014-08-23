
local Person = class("Person", Entity)
Person:include( PhysicsActor )
Person:include( CollisionResolver )

function Person:initialize( world )

	Entity.initialize( self )
	PhysicsActor.initialize( self, world )
	
	self.radius = 32
	self.shape = love.physics.newCircleShape( self.radius )
	
	local fixture = love.physics.newFixture( self:getBody(), self.shape )
	
end

function Person:update()

	

end

function Person:draw()
	
	local x, y = self:getPos()
	love.graphics.circle( "line", x, y, self.radius, 32 )
	
end

function Person:setRadius( r )

	self.radius = r
	self.shape:setRadius( r )

end

return Person