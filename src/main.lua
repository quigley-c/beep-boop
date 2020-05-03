
function love.load()

	--map = 
	--map.spawn = 

	--map.spawn.x = 100
	--map.spawn.y = 100

	love.window.setFullscreen(false)

	player = { x, y, spd, img}

	player.x = player.x or 100
	player.y = player.y or 100
	player.spd = player.speed or 60

	image = love.graphics.newImage("player.png")
	animation = new_animation(love.graphics.newImage("player.png"), 32, 32, 1)

	love.graphics.setNewFont(12)
end

function new_animation(img, framew, frameh, dur)
	local animation = {}
	animation.spriteSheet = image
	animation.quads = {}

	for y = 0, image:getHeight() - frameh, frameh do
		for x = 0, img:getWidth() - framew, framew do
			table.insert(animation.quads, love.graphics.newQuad(x, y, framew, frameh, img:getDimensions()))
		end
	end

	animation.duration = dur or 1
	animation.currentTime = 0

	return animation
end

function love.update(dt)
	if love.keyboard.isDown("left") then
		player.x = player.x - player.spd * dt
	end
	if love.keyboard.isDown("up") then
		player.y = player.y - player.spd * dt
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.spd * dt
	end
	if love.keyboard.isDown("right") then
		player.x = player.x + player.spd * dt
	end

	animation.currentTime = animation.currentTime + dt
	if animation.currentTime >= animation.duration then
		animation.currentTime = animation.currentTime - animation.duration
	end
end

function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
end


function love.draw()
	local cur_frame = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
	love.graphics.draw(animation.spriteSheet, animation.quads[cur_frame],  player.x, player.y)

end
