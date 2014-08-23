
local play = gamestate.new("play")
local gui, player, world, physics
local last_mousex, last_mousey, grabbed_person, spectate_person

function play:init()

	-- Create GUI
	gui = GUI()
	
	-- Create level with physics world
	
	level = Level(LevelData())
	
	love.physics.setMeter(level:getPixelsPerMeter())
	
	physics = Box2DPhysicsSystem( true )
	physics:initDefaultCollisionCallbacks()
	level:addPhysicsSystem( physics )
	
	world = physics:getWorld()
	world:setGravity(0, 0)
	
	for i = 0, 30 do
		local person = level:createEntity( "Person", world )
		
		local dir = math.randomRange( math.pi * (i % 2), math.pi * (i % 2 + 1) )
		local vec = angle.forward( dir ) * (40 * i - (10 + 20 * math.random()))
		
		person:setPos( vec.x, vec.y )
	end
	
	last_mousex, last_mousey = screen.getMousePosition()
	
	input:addMousePressCallback("zoomin", MOUSE.WHEELUP, function()
		local cam = level:getCamera()
		local sx, sy = cam:getScale()
		if (sx > 3) then return end
		cam:setScale(sx + 0.1, sy + 0.1)
		cam:setPos( (Vector(cam:getPos())*0.9 + Vector(cam:getMouseWorldPos()) * 0.1):unpack() )
	end)
	
	input:addMousePressCallback("zoomout", MOUSE.WHEELDOWN, function()
		local cam = level:getCamera()
		local sx, sy = cam:getScale()
		if (sx < 0.2) then return end
		cam:setScale(sx - 0.1, sy - 0.1)
		cam:setPos( (Vector(cam:getPos())*0.9 + Vector(cam:getMouseWorldPos()) * 0.1):unpack() )
	end)
	
	input:addMouseReleaseCallback("spectate", MOUSE.RIGHT, function(btn, timediff)
		if (timediff > 0.1) then return end
		spectate_person = nil
		
		local wmx, wmy = level:getCamera():getMouseWorldPos()
	
		world:queryBoundingBox( wmx, wmy, wmx+1, wmy+1, function( fix )
			if (fix:testPoint( wmx, wmy )) then
				local owner = fix:getUserData() or fix:getBody():getUserData()
				if (owner:isInstanceOf( Person )) then
					spectate_person = owner
					return true
				end
			end
			return false
		end )
		
	end)
	
end

function play:enter()

end

function play:leave()

end

function play:update( dt )
	
	-- Camera spectate
	if (spectate_person) then
		level:getCamera():setPos(spectate_person:getPos())
	end
	
	-- Camera draggin
	local mx, my = screen.getMousePosition()
	local dmx, dmy = mx - last_mousex, my - last_mousey
	last_mousex, last_mousey = mx, my
	
	if (input:mouseIsDown( MOUSE.RIGHT )) then
		
		local sx, sy = level:getCamera():getScale()
		
		spectate_person = nil
		level:getCamera():move( -dmx / sx, -dmy / sy )
		
	end
	
	-- Pushing people
	if (input:mouseIsPressed( MOUSE.LEFT )) then
		local wmx, wmy = level:getCamera():getMouseWorldPos()
	
		world:queryBoundingBox( wmx, wmy, wmx+1, wmy+1, function( fix )
			if (fix:testPoint( wmx, wmy )) then
				local owner = fix:getUserData() or fix:getBody():getUserData()
				if (owner:isInstanceOf( Person )) then
					print("Selected "..owner:getEntIndex())
					grabbed_person = owner
					return true
				end
			end
			return false
		end )
		
	end
	
	if (input:mouseIsReleased( MOUSE.LEFT )) then
		if (grabbed_person) then
			local wmx, wmy = level:getCamera():getMouseWorldPos()
			local body = grabbed_person:getBody()
			local bx, by = grabbed_person:getPos()
			local lvec = Vector( wmx - bx, wmy - by ) * 3
			
			body:applyLinearImpulse( lvec:unpack() )
			
			grabbed_person = nil
		end
	end	
	
	level:update( dt )
	gui:update( dt )
	
	
end

function play:draw()

	level:draw()
	gui:draw()
	
	level:getCamera():draw( function()
		if (grabbed_person) then
			local wmx, wmy = level:getCamera():getMouseWorldPos()
			local bx, by = grabbed_person:getPos()
			
			local oldcol = { love.graphics.getColor() }
			love.graphics.setColor( 200, 255, 200 )
	
			love.graphics.line( wmx, wmy, bx, by )
	
			love.graphics.setColor( unpack( oldcol ) )
		end		
	end )
	
end

return play