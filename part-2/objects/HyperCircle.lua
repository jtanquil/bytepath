-- 7. Create an HyperCircle class that inherits from the Circle class. An 
-- HyperCircle is just like a Circle, except it also has an outer ring drawn around 
-- it. It should receive additional arguments line_width and outer_radius in its 
-- constructor. An instance of this HyperCircle class should be created at position 
-- 400, 300 with radius 50, line width 10 and outer radius 120. This is what the 
-- screen should look like:

HyperCircle = Circle:extend()

function HyperCircle:new(x, y, radius, line_width, outer_radius)
  HyperCircle.super.new(self, x, y, radius)
  self.line_width = line_width
  self.outer_radius = outer_radius
end

function HyperCircle:update(dt)
  HyperCircle.super.update(self, dt)
end

function HyperCircle:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle('fill', self.x, self.y, self.outer_radius)
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle('fill', self.x, self.y, self.outer_radius - self.line_width)
  self.super.draw(self)
end