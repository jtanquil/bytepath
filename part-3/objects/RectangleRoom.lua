RectangleRoom = Object:extend()

function RectangleRoom:new(x, y, width, height)
  self.x, self.y, self.width, self.height = x, y, width, height
end

function RectangleRoom:update(dt)

end

function RectangleRoom:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.rectangle('fill', self.x - self.width/2, self.y - self.height/2, self.width, self.height)
end