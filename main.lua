Player = require 'player'
Bird = require 'bird'
Points = require 'points'

function love.load()
  love.window.setTitle('Angle')
  windowWidth = 600
  windowHeight = 600
  love.window.setMode(windowWidth, windowHeight)

  -- player = Player:new(nil)
  birds = {}
  birds.amount = 100
  for i=1,birds.amount do
    birds[i] = Bird:new(nil, 10, 3.5, 350, 100, math.pi / 4)
  end
  bird = Bird:new(nil, 10, 3.5, 350, 100, math.pi / 4)
  points = Points:new(nil)
end

function love.update(dt)
  -- player:update(dt)
  bird:update(dt)

  for i=1,points.amount do
    points[i].color = {1, 0, 0}
  end

  for i=1,birds.amount do
    birds[i]:update(dt)
    local maxDistance = birds[i].fov.radius
    local choosedAngle = nil
    local changeDirection = false
    for j=1,birds.amount do
      if (i ~= j) then
        local deltaX = (birds[j].x - birds[i].head.x)
        local deltaY = (birds[j].y - birds[i].head.y)

        local betweenAngle = math.atan(deltaY / deltaX)
        if deltaX < 0 then
          betweenAngle = betweenAngle + math.pi
        end
        if (betweenAngle < 0 and deltaX > 0) then
          betweenAngle = betweenAngle + 2*math.pi
        end

        local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))

        local normalCase = (
          betweenAngle >= birds[i].fov.beginArcAngle and betweenAngle <= birds[i].fov.endArcAngle
        )
        local biggerEndCase = (
          (birds[i].fov.endArcAngle > 2 * math.pi) and
          (betweenAngle < (birds[i].fov.endArcAngle - 2*math.pi))
        )
        local smallerBeginCase = (
          (birds[i].fov.beginArcAngle < 0) and betweenAngle > (birds[i].fov.beginArcAngle + 2*math.pi)
        )
        if (
          distance <= birds[i].fov.radius and
          (normalCase or biggerEndCase or smallerBeginCase)
        ) then
          birds[j].color = {0, 1, 0}

        end
        if distance < maxDistance and distance <= birds[i].fov.radius and normalCase then
          choosedAngle = betweenAngle
          changeDirection = true
        end
      end

      if changeDirection then
        if birds[i].angle > choosedAngle then
          birds[i].angle = birds[i].angle - birds[i].angularSpeed * dt
        end
        if birds[i].angle < choosedAngle then
          birds[i].angle = birds[i].angle + birds[i].angularSpeed * dt
        end
      end
    end
  end

  -- for i=1,points.amount do
  --   points[i].color = {1, 0, 0}
  -- end
  --
  -- for i=1,birds.amount do
  --   birds[i]:update(dt)
  --   local maxDistance = birds[i].fov.radius
  --   local choosedAngle = nil
  --   local changeDirection = false
  --   for j=1,points.amount do
  --     local deltaX = (points[j].x - birds[i].head.x)
  --     local deltaY = (points[j].y - birds[i].head.y)
  --
  --     local betweenAngle = math.atan(deltaY / deltaX)
  --     if deltaX < 0 then
  --       betweenAngle = betweenAngle + math.pi
  --     end
  --     if (betweenAngle < 0 and deltaX > 0) then
  --       betweenAngle = betweenAngle + 2*math.pi
  --     end
  --
  --     local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))
  --
  --     local normalCase = (
  --       betweenAngle >= birds[i].fov.beginArcAngle and betweenAngle <= birds[i].fov.endArcAngle
  --     )
  --     local biggerEndCase = (
  --       (player.fov.endArcAngle > 2 * math.pi) and
  --       (betweenAngle < (birds[i].fov.endArcAngle - 2*math.pi))
  --     )
  --     local smallerBeginCase = (
  --       (birds[i].fov.beginArcAngle < 0) and betweenAngle > (birds[i].fov.beginArcAngle + 2*math.pi)
  --     )
  --     if (
  --       distance <= birds[i].fov.radius and
  --       (normalCase or biggerEndCase or smallerBeginCase)
  --     ) then
  --       points[j].color = {0, 1, 0}
  --
  --     end
  --     if distance < maxDistance and distance <= birds[i].fov.radius and normalCase then
  --       choosedAngle = betweenAngle
  --       changeDirection = true
  --     end
  --   end
  --
  --   if changeDirection then
  --     if birds[i].angle > choosedAngle then
  --       birds[i].angle = birds[i].angle - birds[i].angularSpeed * dt
  --     end
  --     if birds[i].angle < choosedAngle then
  --       birds[i].angle = birds[i].angle + birds[i].angularSpeed * dt
  --     end
  --   end
  -- end

  -- local maxDistance = bird.fov.radius
  -- local choosedAngle = nil
  -- local changeDirection = false
  -- for i=1,points.amount do
  --   local deltaX = (points[i].x - bird.head.x)
  --   local deltaY = (points[i].y - bird.head.y)
  --
  --   local betweenAngle = math.atan(deltaY / deltaX)
  --   if deltaX < 0 then
  --     betweenAngle = betweenAngle + math.pi
  --   end
  --   if (betweenAngle < 0 and deltaX > 0) then
  --     betweenAngle = betweenAngle + 2*math.pi
  --   end
  --
  --   local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))
  --
  --   points[i].color = {1, 0, 0}
  --   local normalCase = (
  --     betweenAngle >= bird.fov.beginArcAngle and betweenAngle <= bird.fov.endArcAngle
  --   )
  --   local biggerEndCase = (
  --     (player.fov.endArcAngle > 2 * math.pi) and
  --     (betweenAngle < (bird.fov.endArcAngle - 2*math.pi))
  --   )
  --   local smallerBeginCase = (
  --     (bird.fov.beginArcAngle < 0) and betweenAngle > (bird.fov.beginArcAngle + 2*math.pi)
  --   )
  --   if (
  --     distance <= bird.fov.radius and
  --     (normalCase or biggerEndCase or smallerBeginCase)
  --   ) then
  --     points[i].color = {0, 1, 0}
  --
  --   end
  --   if distance < maxDistance and distance <= bird.fov.radius and normalCase then
  --     choosedAngle = betweenAngle
  --     changeDirection = true
  --   end
  -- end
  --
  -- if changeDirection then
  --   if bird.angle > choosedAngle then
  --     bird.angle = bird.angle - bird.angularSpeed * dt
  --   end
  --   if bird.angle < choosedAngle then
  --     bird.angle = bird.angle + bird.angularSpeed * dt
  --   end
  -- end

  -- for i=1,points.amount do
  --   local deltaX = (points[i].x - player.head.x)
  --   local deltaY = (points[i].y - player.head.y)
  --
  --   local betweenAngle = math.atan(deltaY / deltaX)
  --   if deltaX < 0 then
  --     betweenAngle = betweenAngle + math.pi
  --   end
  --   if (betweenAngle < 0 and deltaX > 0) then
  --     betweenAngle = betweenAngle + 2*math.pi
  --   end
  --
  --   local distance = math.sqrt((deltaX * deltaX) + (deltaY * deltaY))
  --
  --   points[i].color = {1, 0, 0}
  --   local normalCase = (
  --     betweenAngle >= player.fov.beginArcAngle and betweenAngle <= player.fov.endArcAngle
  --   )
  --   local biggerEndCase = (
  --     (player.fov.endArcAngle > 2 * math.pi) and
  --     (betweenAngle < (player.fov.endArcAngle - 2*math.pi))
  --   )
  --   local smallerBeginCase = (
  --     (player.fov.beginArcAngle < 0) and betweenAngle > (player.fov.beginArcAngle + 2*math.pi)
  --   )
  --   if (
  --     distance <= player.fov.radius and
  --     (normalCase or biggerEndCase or smallerBeginCase)
  --   ) then
  --     points[i].color = {0, 1, 0}
  --   end
  -- end
end

function love.draw()
  -- points:draw()
  bird:draw()
  -- player:draw()

  for i=1,birds.amount do
    birds[i]:draw()
  end
end
