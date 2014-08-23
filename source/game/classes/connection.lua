
local Connection = class("Connection", Entity)

function Connection:initialize( person1, person2 )

	Entity.initialize( self )
	
	self.person1 = person1
	self.person2 = person2
	
	local x1, y1 = person1:getPos()
	local x2, y2 = person2:getPos()
	self.joint = love.physics.newRopeJoint( person1:getBody(), person2:getBody(), x1, y1, x2, y2, 64, true )
	
end

function Connection:update()

end

function Connection:draw()

	local oldcol = { love.graphics.getColor() }
	love.graphics.setColor( 255, 200, 200 )
	
	love.graphics.line( self.joint:getAnchors() )
	
	love.graphics.setColor( unpack( oldcol ) )
	
end

function Connection:getPerson1()

	return self.person1

end

function Connection:getPerson2()

	return self.person2

end

return Connection