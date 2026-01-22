-- 5. Implement the Free the Physics loop from the Fix Your Timestep article by
-- changing love.run.
function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0
	local FIXED_TIMESTEP = 1.0 / 60.0

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end

		-- Update dt, as we'll be passing it to update
		local acc = 0
		local prev_state = state

		if love.timer then 
			dt = love.timer.step() 
			acc = dt
		end

		-- Call update and draw
		-- update on fixed timestep until remainder
		-- then do linear interpolation on the remainder and render that
		while acc >= FIXED_TIMESTEP do
			if love.update then love.update(FIXED_TIMESTEP) end -- will pass 0 if love.timer is disabled
			acc = acc - FIXED_TIMESTEP
		end

		local alpha = acc / FIXED_TIMESTEP
		state = state * alpha + prev_state * (1.0 - alpha)

		if love.graphics and love.graphics.isActive() then
			love.graphics.origin()
			love.graphics.clear(love.graphics.getBackgroundColor())

			if love.draw then love.draw() end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end

t = 0
-- mimic linear interpolation on state
state = 0

function love.update(dt)
  t = t + dt
  state = state + 1
end

function love.draw()
  love.graphics.print("time: " .. t, 400, 300)
  love.graphics.print("state: " .. state, 400, 325)
  love.graphics.print("avg delta: " .. t / state, 400, 350)
  love.graphics.print("last delta: " .. love.timer.getDelta(), 400, 375)
end