gw = 480
gh = 270
sx = 1
sy = 1

function love.conf(t)
	t.identity = nil -- name of save directory
	t.title = 'Endless Walker'
	t.window.resizable = false
	t.window.width = gw
	t.window.height = gh
	t.console = true
	t.window.icon = 'imgs/player-0.png'
end