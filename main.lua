debug = true
local input = require 'input'

function love.load()
	love.graphics.setDefaultFilter('nearest')
	camera = require 'libs/hump/camera'
	Timer = require 'libs/hump/timer'
	require 'player'
	require 'bullets'
	sti = require 'libs/Simple-Tiled-Implementation/sti'
	Object = require 'libs/classic/classic'

	controller = nil
	rooms = {}
	current_room = nil
	resize(2)
	bgm = love.audio.newSource('snds/chrono-chip.mp3', 'stream')
	cam = camera()
	if love.keyboard.isDown('f3') then cam:shake(4, 60, 1) end
	-- input:bind('f3', function() camera:shake(4, 60, 1) end)
	-- input:bind('f3', function () camera:shake(4, 60, 1) end)
	player.img = love.graphics.newImage('imgs/player-0.png')
	bulletImg = love.graphics.newImage('imgs/bullet.png')
	loadMap()
	timer = Timer()
	love.audio.setVolume(.1)
	-- love.audio.play(bgm)

	local joysticks = love.joystick.getJoysticks()
    for i, joystick in ipairs(joysticks) do
        love.graphics.print(joystick:getName(), 10, i*20)
        controller = joystick
        break
    end
end

function love.update(dt)
	timer:update(dt)
	gameMap:update(dt)
	-- time out bullets
	canShootTimer = canShootTimer - (1 * dt)
	if (canShootTimer < 0) then
		canShoot = true
	end

	cam:update(dt)
	input.keyboard(player, dt)
	if joysticks then
		input.gamepad(player, dt, controller)
	end

	if current_room then current_room:update(dt) end

	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		if bullet.y < 0 then -- remove bullet from off screen
			table.remove(bullets, i)
		end
	end

end

function love.draw()
	version_text = 'v0.1'
	love.graphics.setColor(250, 250, 250)
	love.graphics.print(version_text, 250, 250, 0, 2, 2)
	cam:attach()
		if current_room then current_room:draw(dt) end
		gameMap:drawLayer(gameMap.layers['Tile Layer 1'])
		love.graphics.draw(player.img, player.x, player.y)

		for i, bullet in ipairs(bullets) do
			love.graphics.draw(bullet.img, bullet.x, bullet.y)
		end
	cam:detach()
end

-- Fixed Delta Time loop
function love.run()
	if love.math then love.math.setRandomSeed(os.time()) end
	if love.load then love.load(arg) end
 
	local dt = 1/60
 
	-- Main loop time.
	while true do
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
 
		if love.timer then love.timer.sleep(0.001) end
	end
end

function loadMap()
	gameMap = sti('maps/map1.lua')
end

function addRoom(room_type, room_name, ...)
	local room = _G[room_type](room_name, ...)
	rooms[room_name] = room
	return room
end

function goToRoom(room_type, room_name, ...)
	if current_room and rooms[room_name] then
		if current_room.deactivate then current_room:deactivate() end
		current_room = rooms[room_name]
		if current_room.activate then current_room:activate() end
	else current_room = addRoom(room_type, room_name, ...) end
end

function resize(s)
	love.window.setMode(s*gw, s*gh)
	sx, sy = s, s
end