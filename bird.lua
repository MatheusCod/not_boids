Bird = {}

function Bird:new(o, radius, angularSpeed, speed, fovRadius, fovSideAngle)
  local o = o or {}
  setmetatable(o, self)
  self.__index = self

  o.border = fovRadius * 0.5

  o.x = love.math.random(-o.border, windowWidth + o.border)
  o.y = love.math.random(-o.border, windowHeight + o.border)
  o.radius = radius
  o.angle = love.math.random(0, 2 * math.pi)
  o.angularSpeed = angularSpeed
  o.speed = speed

  o.head = {
    radius = math.ceil(o.radius / 8),
    x = o.x + o.radius * math.cos(o.angle),
    y = o.y + o.radius * math.sin(o.angle)
  }

  o.fov = {
    radius = fovRadius,
    sideAngle = fovSideAngle
  }
  table.insert(
    o.fov,
    {
      beginArcAngle = o.angle - o.fov.sideAngle,
      endArcAngle = o.angle + o.fov.sideAngle
    }
  )

  o.rightWing = {
    angleMut = (2 / 3) * math.pi,
    x = o.x + o.radius * math.cos(o.angle + math.pi * 0.7),
    y = o.y + o.radius * math.sin(o.angle + math.pi * 0.7)
  }
  o.leftWing = {
    angleMut = (4 / 3) * math.pi,
    x = o.x + o.radius * math.cos(o.angle + math.pi * 1.3),
    y = o.y + o.radius * math.sin(o.angle + math.pi * 1.3)
  }
  o.bodyCenter = {
    x = o.x,
    y = o.y
  }

  return o
end

function Bird:update(dt)
  if self.angle > 2 * math.pi then
    self.angle = 0
  elseif self.angle < 0 then
    self.angle =  2 * math.pi
  end
  -- if love.keyboard.isDown('d') then
  --   self.angle = self.angle + self.angularSpeed * dt
  -- end
  -- if love.keyboard.isDown('a') then
  --   self.angle = self.angle - self.angularSpeed * dt
  -- end

  if (self.y < -self.border) then
    self.y = windowHeight + self.border
  end
  if (self.y > windowHeight + self.border) then
    self.y = -self.border
  end
  if (self.x < -self.border) then
    self.x = windowWidth + self.border
  end
  if (self.x > windowWidth + self.border) then
    self.x = -self.border
  end

  self.x = self.x + self.speed * math.cos(self.angle) * dt
  self.y = self.y + self.speed * math.sin(self.angle) * dt

  self.head.x = self.x + self.radius * math.cos(self.angle)
  self.head.y = self.y + self.radius * math.sin(self.angle)
  self.leftWing.x = self.x + self.radius * math.cos(self.angle + self.leftWing.angleMut)
  self.leftWing.y = self.y + self.radius * math.sin(self.angle + self.leftWing.angleMut)
  self.rightWing.x = self.x + self.radius * math.cos(self.angle + self.rightWing.angleMut)
  self.rightWing.y = self.y + self.radius * math.sin(self.angle + self.rightWing.angleMut)
  self.bodyCenter.x = self.x
  self.bodyCenter.y = self.y

  self.fov.beginArcAngle = self.angle - self.fov.sideAngle
  self.fov.endArcAngle = self.angle + self.fov.sideAngle
end

function Bird:draw()
  -- Body
  love.graphics.setColor(1, 1, 1)
  love.graphics.polygon(
    'fill',
    self.head.x,
    self.head.y,
    self.rightWing.x,
    self.rightWing.y,
    self.bodyCenter.x,
    self.bodyCenter.y,
    self.leftWing.x,
    self.leftWing.y
  )
  -- FOV
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.arc(
  --   'line',
  --   self.head.x,
  --   self.head.y,
  --   self.fov.radius,
  --   self.fov.beginArcAngle,
  --   self.fov.endArcAngle
  -- )
end

return Bird
