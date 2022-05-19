local input = {}
require 'bullets'

--------------------------------------------------------------------------------
--                             KEYBOARD CONTROLS                              --
--------------------------------------------------------------------------------

function input.keyboard(player,dt)
	shoot = love.audio.newSource('snds/menu.wav', 'static')

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('left','a') then
        if player.x>0 then -- binds player to map
            player.x=player.x-(player.speed*dt)
        end
    elseif love.keyboard.isDown('right','d') then
        if player.x<(love.graphics.getWidth()-player.img:getWidth()) then
            player.x=player.x+(player.speed*dt)
        end
    end

    if love.keyboard.isDown('up','w') then
        if player.y>0 then
            player.y=player.y-(player.speed*dt)
        end
    elseif love.keyboard.isDown('s','down') then
        if player.y<(love.graphics.getHeight()-player.img:getHeight()) then
            player.y=player.y+(player.speed*dt)
        end
    end

	if love.keyboard.isDown('space') and canShoot then
		newBullet = { x = player.x + (player.img:getWidth()/2),y = player.y, img = bulletImg }
		table.insert(bullets, newBullet)
		canShoot = false
		canShootTimer = canShootTimerMax
		love.audio.play(shoot)
	end

	--! todo - find way to restart
	-- if love.keyboard.isDown('r') then
	-- 	love.run()
	-- end
end

--------------------------------------------------------------------------------
--                             CONTROLLER SUPPORT                             --
--------------------------------------------------------------------------------

function input.gamepad(player, dt, controller)
    if controller:isGamepadDown('back') then
        love.event.push('quit')
    end
    --! todo: get map of buttons
    	--! todo: add shoot button
    -- dpad
    if controller:isGamepadDown('dpleft') then
        if player.x>0 then
            player.x=player.x-(player.speed*dt)
        end
    elseif controller:isGamepadDown('dpright') then
        if player.x<(love.graphics.getWidth()-player.img:getWidth()) then
            player.x=player.x+(player.speed*dt)
        end
    end
    if controller:isGamepadDown('dpup') then
        if player.y>0 then
            player.y=player.y-(player.speed*dt)
        end
    elseif controller:isGamepadDown('dpdown') then
        if player.y<(love.graphics.getHeight()-player.img:getHeight()) then
            player.y=player.y+(player.speed*dt)
        end
    end
    -- joystick
    ly=controller:getGamepadAxis('lefty')
    lx=controller:getGamepadAxis('leftx')
    if lx>0.1 then
        if player.x<(love.graphics.getWidth()-player.img:getWidth()) then
            player.x=player.x+(player.speed*dt)
        end
    elseif lx<-0.1 then
        if player.x>0 then
            player.x=player.x-(player.speed*dt)
        end
    end

    if ly>0.1 then
        if player.y<(love.graphics.getHeight()-player.img:getHeight()) then
            player.y=player.y+(player.speed*dt)
        end
    elseif ly<-0.1 then
        if player.y>0 then
            player.y=player.y-(player.speed*dt)
        end
    end
end

return input