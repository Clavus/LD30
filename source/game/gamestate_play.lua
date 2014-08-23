
local play = gamestate.new("play")
local gui, player, world, physics
local last_mousex, last_mousey

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
	
	for i = 0, 10 do
		local person = level:createEntity( "Person", world )
		
		local dir = math.randomRange( 0, math.pi * ((i % 2) + math.random()) )
		local vec = angle.forward( dir ) * (40 * i - (10 + 20 * math.random()))
		
		person:setPos( vec.x, vec.y )
	end
	
	last_mousex, last_mousey = screen.getMousePosition()
	
end

function play:enter()

end

function play:leave()

end

function play:update( dt )
	
	local mx, my = screen.getMousePosition()
	local dmx, dmy = mx - last_mousex, my - last_mousey
	last_mousex, last_mousey = mx, my
	
	if (input:mouseIsDown( MOUSE.RIGHT )) then
		
		level:getCamera():move( -dmx, -dmy )
		
	end
	
	level:update( dt )
	gui:update( dt )
	
	
end

function play:draw()

	level:draw()
	gui:draw()
	
end

return play