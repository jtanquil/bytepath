-- draw a polygon w/given vertices
PolygonRoom = Object:extend()

function PolygonRoom:new(vertices)
  self.vertices = vertices
end

function PolygonRoom:update(dt)

end

function PolygonRoom:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.polygon('fill', self.vertices)
end