-- 6. Create a Circle class that receives x, y and radius arguments in its 
-- constructor, has x, y, radius and creation_time attributes and has update and 
-- draw methods. The x, y and radius attributes should be initialized to the values 
-- passed in from the constructor and the creation_time attribute should be 
-- initialized to the relative time the instance was created (see love.timer). The 
-- update method should receive a dt argument and the draw function should draw a 
-- white filled circle centered at x, y with radius radius (see love.graphics). 
-- An instance of this Circle class should be created at position 400, 300 with 
-- radius 50. It should also be updated and drawn to the screen. This is what the 
-- screen should look like:

Circle = Object:extend()

function Circle:new(x, y, radius)
  self.x = x
  self.y = y
  self.radius = radius
  self.creation_time = love.timer.getTime()
end

function Circle:update(dt)

end

function Circle:draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle('fill', self.x, self.y, self.radius)
end