Stage = Object:extend()

function Stage:new()
	self.area = Area(self)
	self.main_canvas = love.graphics.newCanvas(gw, gh)
end

function Stage:update(dt)

end

function Stage:draw()
	love.graphics.setCanvas(self.main_canvas)
	love.graphics.clear()
		cam:attach(0, 0, gw, gh)
		love.graphics.setLineStyle('rough')
		love.graphics.circle('line', gw/2, gh/2, 50)
		self.area:draw()
		cam:detach()
	love.graphics.setCanvas()

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.setBlendMode('alpha', 'premultiplied')
	love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
	love.graphics.setBlendMode('alpha')
end