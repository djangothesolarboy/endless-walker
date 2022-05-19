function Pickup:new(...)
	--! todo collision detection, base stats, special stat/effect
	self.w, self.h = 8, 8
end

function Pickup:draw()
end

-- expands circle then back to normal
-- could be used for when an item is picked up
--
-- function love.load()
--     timer = Timer()
--     circle = {radius = 24}
--     timer:after(2, function()
--         timer:tween(6, circle, {radius = 96}, 'in-out-cubic', function()
--             timer:tween(6, circle, {radius = 24}, 'in-out-cubic')
--         end)
--     end)
-- end