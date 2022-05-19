function Player:new(...)
	...
	self.timer:every(0.24, function() -- 0.24 base wepspd(20sec)
		self:shoot()
	end)
end

function Player:update(dt)

end