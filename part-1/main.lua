t = 0
step = 0

-- test effect of vsync
function love.load()
  love.window.setMode(800, 600, { vsync = 1 })
end

function love.update(dt)
  t = t + dt
  step = step + 1
end

function love.draw()
  love.graphics.print("time: " .. t, 400, 300)
  love.graphics.print("steps: " .. step, 400, 325)
  love.graphics.print("avg delta: " .. t / step, 400, 350)
  love.graphics.print("last delta: " .. love.timer.getDelta(), 400, 375)
end