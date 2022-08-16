Points = {}

function Points:new(o)
  local o = o or {}
  setmetatable(o, self)
  self.__index = self

  o.amount = 20
  for i=1,o.amount do
    o[i] = {}
    o[i].x = love.math.random(
      0,
      windowWidth
    )
    o[i].y = love.math.random(
      0,
      windowHeight
    )
    o[i].color = {1, 0, 0}
  end

  return o
end

function Points:update(o)
end

function Points:draw(o)
  for i=1,self.amount do
    love.graphics.setColor(
      self[i].color[1],
      self[i].color[2],
      self[i].color[3]
    )
    love.graphics.points(self[i].x, self[i].y)
  end
end

return Points
