debug = true

function love.load()
	require 'player'
	require 'bullets'
	-- require('img')
	player.img = love.graphics.newImage('img/sheep-0.png')
	bulletImg = love.graphics.newImage('img/bullet.png')
end

function love.update(dt)
	-- time out bullets
	canShootTimer = canShootTimer - (1 * dt)
	if (canShootTimer < 0) then
		canShoot = true
	end
	
	if love.keyboard.isDown('right', 'd') then
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
			player.img = love.graphics.newImage('img/sheep-0.png')
		end
	elseif love.keyboard.isDown('left', 'a') then
		if player.x > 0 then
			player.x = player.x - (player.speed * dt)
			player.img = love.graphics.newImage('img/sheep-1.png')
		end
	end
	if love.keyboard.isDown('down', 's') then
		if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
			player.y = player.y + (player.speed * dt)
		end
	elseif love.keyboard.isDown('up', 'w') then
		if player.y > 0 then
			player.y = player.y - (player.speed * dt)
		end
	end

	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	if love.keyboard.isDown('space') and canShoot then
		newBullet = { x = player.x + (player.img:getWidth()/2),y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
	end

	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - (250 * dt)

		if bullet.y < 0 then -- remove bullet from off screen
			table.remove(bullets, i)
		end
	end
	--! todo - find way to restart 
	-- if love.keyboard.isDown('r') then
	-- 	love.run()
	-- end
end

function love.draw()
	love.graphics.draw(player.img, player.x, player.y)

	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
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