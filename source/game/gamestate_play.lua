
local play = gamestate.new("play")
local gui, player, world, physics
local last_mousex, last_mousey, grabbed_person, spectate_person

local current_level_num = 1
local available_levels = {}
local num_levels = 6
local switching_level = false

local fade_color = { alpha = 0 }

function play:init()
	
	-- Create level with physics world
	
	for i=1, num_levels do
		self:preloadLevel( i )
	end
	
	self:startLevel( 1 )
	
	--[[for i = 0, 30 do
		local person = level:createEntity( "Person", world )
		
		local dir = math.randomRange( math.pi * (i % 2), math.pi * (i % 2 + 1) )
		local vec = angle.forward( dir ) * (40 * i - (10 + 20 * math.random()))
		
		person:setPos( vec.x, vec.y )
	end]]--
	
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
	
	local state = self
	input:addKeyPressCallback("restart", "r", function()
		
		print("restarting")
		state:switchToLevel( current_level_num )
		
	end)
	
	signal.register("connection_made", function( person, otherPerson )
		if ( switching_level ) then return end
		-- check if everyone's happy
		local done = true		
		for k, person in pairs( level:getEntitiesByClass( Person ) ) do
			if (person:getEmotionScale() < 0.5) then
				done = false
				break
			end
		end
		
		if (done) then
			timer.add(1, function()
				state:switchToLevel( current_level_num + 1 )
			end)
		end
		
	end)
	
	input:registerAction( "switch_level" )
	input:bindActionToKey( "switch_level", "1" )
	input:bindActionToKey( "switch_level", "2" )
	input:bindActionToKey( "switch_level", "3" )
	input:bindActionToKey( "switch_level", "4" )
	input:bindActionToKey( "switch_level", "5" )
	input:bindActionToKey( "switch_level", "6" )
	input:bindActionToKey( "switch_level", "7" )
	input:bindActionToKey( "switch_level", "8" )
	input:bindActionToKey( "switch_level", "9" )
	
	input:addActionPressCallback("switch_level", "switch_level", function(input_type, btn, joystick)
		print("Switch action")
		state:switchToLevel( tonumber(btn) )
	end)
	
end

function play:preloadLevel( num )
	
	local ldata = TiledLevelData(FOLDER.ASSETS.."level"..num)
	local loaded_level = Level(ldata, true)
	
	love.physics.setMeter(loaded_level:getPixelsPerMeter())
	
	local loaded_physics = Box2DPhysicsSystem( true )
	loaded_physics:initDefaultCollisionCallbacks()
	loaded_level:addPhysicsSystem( loaded_physics )
	
	local loaded_world = loaded_physics:getWorld()
	loaded_world:setGravity(0, 0)
	
	available_levels[num] = { level = loaded_level, physics = loaded_physics, world = loaded_world, gui = GUI() }
	
	print("Loaded level "..num.." data")
	
end

function play:switchToLevel( num )
	
	if (num > num_levels) then num = 1 end
	if ( switching_level ) then return end
	switching_level = true
	
	local state = self
	print("Switching to level "..num)
	timer.tween(1, fade_color, { alpha = 255 }, 'in-out-quad', function()
		state:preloadLevel( num )
		state:startLevel( num )
		level:loadObjects()
	end)
	
end

function play:startLevel( num )
	
	current_level_num = num
	
	switching_level = false
	timer.tween(0.25, fade_color, { alpha = 0 }, 'in-out-quad')
	
	level = available_levels[num].level
	physics = available_levels[num].physics
	world = available_levels[num].world
	gui = available_levels[num].gui
	
end

function play:enter()
	
	level:loadObjects()
	
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
	
			--love.graphics.line( wmx, wmy, bx, by )
			
			graphics.arrow( bx, by, wmx, wmy, 20, 16 )
			
			love.graphics.setColor( unpack( oldcol ) )
		end		
	end )
	
	love.graphics.setColor( 255, 255, 255, fade_color.alpha )
	love.graphics.rectangle( "fill", 0, 0, screen.getRenderWidth(), screen.getRenderHeight() )
	love.graphics.setColor( Color.White:unpack() )
	
end

-- called upon map load, handle Tiled objects
function play:createLevelEntity( level, entData )
	
	local ent
	if entData.type == "Wall" or entData.type == "Trigger" then
	
		ent = level:createEntity(entData.type, world, entData.properties)
		if entData.w == nil then
			ent:buildFromPolygon(entData.polygon)
		else
			ent:buildFromSquare(entData.w,entData.h)
		end
		
		ent:setPos(entData.x, entData.y)
		
	elseif entData.type == "Person" then
		
		local person = level:createEntity(entData.type, world, entData.properties)
		person:setPos(entData.x + entData.w / 2, entData.y + entData.h / 2)
		person:setState( entData.properties.emotion or person.emotion, entData.properties.state or person.state )
		
		local impulse = Vector( tonumber(entData.properties.impulse_x) or 0, tonumber(entData.properties.impulse_y) or 0 )
		person:getBody():applyLinearImpulse( impulse.x, impulse.y )
		
	elseif entData.type == "CameraStartPos" then
		
		level:getCamera():setPos(entData.x, entData.y)
		
	elseif entData.type == "Text" then

		local text = entData.properties.string or "undefined text"
		local color_str = entData.properties.color or "White"
		local color = Color[color_str] or Color.White
		
		local textent = level:createEntity("TextLine", text, color)
		textent:setPos(entData.x + entData.w / 2, entData.y + entData.h / 2)
	
	end	
	
end


return play