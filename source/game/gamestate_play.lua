
local play = gamestate.new("play")
local gui, level, player, world, physics

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
	
	for i = 0, 20 do
		local person = level:createEntity( "Person", world )
		
		local dir = math.randomRange( 0, 2 * math.pi )
		local vec = angle.forward( dir ) * (60 * i - (10 + 20 * math.random()))
		
		person:setPos( vec.x, vec.y )
	end
	
end

function play:enter()

end

function play:leave()

end

function play:update( dt )
	
	level:update( dt )
	gui:update( dt )
	
	
end

function play:draw()

	level:draw()
	gui:draw()
	
end

return play