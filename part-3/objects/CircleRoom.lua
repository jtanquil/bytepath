CircleRoom = Object:extend()

function CircleRoom:new(x, y, radius)
  self.x, self.y, self.radius = x, y, radius
end

function CircleRoom:update(dt)

end

function CircleRoom:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle('fill', self.x, self.y, self.radius)
end