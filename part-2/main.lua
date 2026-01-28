Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
M = require 'libraries/moses/moses'

start_time = love.timer.getTime()

function love.load()
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)

  input = Input()
  -- input:bind('mouse1', function() print(love.math.random()) end)
  -- input:bind('=', 'add')
  -- input:bind('a', 'add')
  -- input:bind('=', 'diff')

  -- sum = 0
  -- diff = 0

  timer = Timer()

  -- 21. Using only a for loop and one declaration of the after function inside
  -- that loop, print 10 random numbers to the screen with an interval of 0.5
  -- seconds between each print.
  -- for i = 1, 10 do
  --   timer:after(0.5 * i, function() print(love.math.random()) end)
  -- end

  -- 22. Using only the tween function, tween the w attribute of the first
  -- rectangle over 1 second using the in-out-cubic tween mode. After that is
  -- done, tween the h attribute of the second rectangle over 1 second using the
  -- in-out-cubic tween mode. After that is done, tween both rectangles back to
  -- their original attributes over 2 seconds using the in-out-cubic tween mode.
  -- rect_1 = {x = 400, y = 300, w = 50, h = 200}
  -- rect_2 = {x = 400, y = 300, w = 200, h = 50}

  -- timer:tween(1, rect_1, {w = 0}, 'in-out-cubic', function()
  --   timer:tween(1, rect_2, {h = 0}, 'in-out-cubic', function()
  --     timer:tween(2, rect_1, {w = 50}, 'in-out-cubic')
  --     timer:tween(2, rect_2, {h = 50}, 'in-out-cubic')
  --   end)
  -- end)

  -- 23. For this exercise you should create an HP bar. Whenever the user
  -- presses the d key the HP bar should simulate damage taken.
  -- r_1, g_1, b_1, a_1 = love.math.colorFromBytes(255, 96, 95)
  -- r_2, g_2, b_2, a_2 = love.math.colorFromBytes(222, 65, 65)
  -- max_health = 200
  -- top_health_bar = {x = 400 - max_health/2, y = 300, w = max_health, h = 50}
  -- bottom_health_bar = {x = 400 - max_health/2, y = 300, w = max_health, h = 50}

  -- input:bind('d', 'dmg')

  -- 24. Taking the previous example of the expanding and shrinking circle, it
  -- expands once and then shrinks once. How would you change the code so that
  -- it expands and shrinks continually forever?
  -- 25. Accomplish the results of the previous exercise using only the after function.
  test_circle = Circle(400, 300, 50)
  -- shrink = true

  -- timer:after(1, function(f)
  --   timer:tween(1, test_circle, {radius = shrink and 25 or 50}, 'in-out-cubic')
  --   shrink = (not shrink) and true or false
  --   timer:after(1, f)
  -- end)

  -- 26. Bind the e key to expand the circle when pressed and the s key to
  -- shrink the circle when pressed. Each new key press should cancel any
  -- expansion/shrinking that is still happening.
  -- input:bind('e', 'expand')
  -- input:bind('s', 'shrink')
  -- expand_handle = nil
  -- shrink_handle = nil

  -- 27. Using only the tween function and without placing the a variable inside
  -- another table, how would you tween its value to 20 over 1 second using the
  -- linear tween mode?
  -- a = 10
  -- timer:tween(1, _G, {a = 20}, 'linear')
end


function love.update(dt)
  -- if input:down('add', 0.25) then
  --   sum = sum + 1
  --   print(sum)
  -- end

  -- if input:down('diff', 0.25) then
  --   diff = diff - 1
  --   print(diff)
  -- end

  -- if input:pressed('dmg') then
  --   timer:tween(1, top_health_bar, {w = top_health_bar.w - max_health / 4}, 'in-out-cubic', function()
  --     timer:after(1/60, function()
  --       timer:tween(1, bottom_health_bar, {w = bottom_health_bar.w - max_health/4}, 'in-out-cubic')
  --     end)
  --   end)
  -- end

  -- if input:pressed('expand') then
  --   if shrink_handle then timer:cancel(shrink_handle) end
  --   if expand_handle then timer:cancel(expand_handle) end

  --   expand_handle = timer:tween(5, test_circle, {radius = test_circle.radius * 1.25}, 'in-out-cubic')
  -- end

  -- if input:pressed('shrink') then
  --   if shrink_handle then timer:cancel(shrink_handle) end
  --   if expand_handle then timer:cancel(expand_handle) end

  --   shrink_handle = timer:tween(5, test_circle, {radius = test_circle.radius * 0.75}, 'in-out-cubic')
  -- end

  -- print(_G.a)

  timer:update(dt)
end

function recursiveEnumerate(folder, file_list)
  local items = love.filesystem.getDirectoryItems(folder)

  for _, item in ipairs(items) do
    local file = folder .. '/' .. item
    file_type = love.filesystem.getInfo(file).type

    if file_type == 'file' then
      table.insert(file_list, file)

    elseif file_type == 'directory' then
      recursiveEnumerate(file, file_list)
    end
  end
end

function requireFiles(files)
  for _, file in ipairs(files) do
    local file = file:sub(1, -5)
    require(file)
  end
end

function love.draw()
  test_circle:update(1)

  -- test_hypercircle = HyperCircle(400, 300, 50, 10, 120)
  -- test_hypercircle:update(1)

  -- attrTest = AttributeMethod()
  -- print(attrTest.attFirst, attrTest.fnFirst)
  -- attrTest:fnFirst()

  -- love.graphics.rectangle('fill', rect_1.x - rect_1.w/2, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
  -- love.graphics.rectangle('fill', rect_2.x - rect_2.w/2, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)
  
  -- love.graphics.setColor(r_2, g_2, b_2, a_2)
  -- love.graphics.rectangle('fill', bottom_health_bar.x, bottom_health_bar.y - bottom_health_bar.h/2, bottom_health_bar.w, bottom_health_bar.h)
  -- love.graphics.setColor(r_1, g_1, b_1, a_1)
  -- love.graphics.rectangle('fill', top_health_bar.x, top_health_bar.y - top_health_bar.h/2, top_health_bar.w, top_health_bar.h)
end

-- 10. Create a function that returns a table that contains the attributes `a`,
-- `b`, `c` and `sum`. `a`, `b` and `c` should be initiated to 1, 2 and 3 
-- respectively, and `sum` should be a function that adds `a`, `b` and `c` 
-- together. The final result of the sum should be stored in the `c` attribute of
-- the table (meaning, after you do everything, the table should have an attribute 
-- `c` with the value 6 in it).

-- function returnTable()
--   return {
--       a = 1,
--       b = 2,
--       c = 3,
--       sum = function(self) self.c = self.a + self.b + self.c end,
--   }
-- end

-- testTable = returnTable()
-- testTable:sum()

-- print(testTable.a, testTable.b, testTable.c)

a = {1, 2, '3', 4, '5', 6, 7, true, 9, 10, 11, a = 1, b = 2, c = 3, {1, 2, 3}}
b = {1, 1, 3, 4, 5, 6, 7, false}
c = {'1', '2', '3', 4, 5, 6}
d = {1, 4, 3, 4, 5, 6}

-- 28. Print the contents of the a table to the console using the each function.
M.each(a, print)

-- 29. Count the number of 1 values inside the b table.
print("---")
print(M.count(b, 1))

-- 30. Add 1 to all the values of the d table using the map function.
print("---")
for k, v in pairs(M.map(d, function(v) return v + 1 end)) do
  print(k, v)
end

-- 31. Using the map function, apply the following transformation to the a
-- table: if the value is a number, it should be doubled; if the value is a 
-- string, it should have 'xD' concatenated to it; if the value is a boolean,
-- it should have its value flipped; and finally, if the value is a table it
-- should be omitted.
print("---")
for k, v in pairs(M.map(a, function(v)
  if type(v) == 'number' then
    return v * 2
  elseif type(v) == 'string' then
    return v .. 'xD'
  elseif type(v) == 'boolean' then
    return not v
  end
end)) do
    print(k, v)
end

-- 32. Sum all the values of the d list. The result should be 23.
print("---")
print(M.reduce(d, function(a, b) return a + b end, 0))

-- 33. Suppose you have the following code:

-- if _____ then
--     print('table contains the value 9')
-- end

-- Which function from the library should be used in the underscored spot to 
-- verify if the `b` table contains or doesn't contain the value 9?
print("---")
if M.include(b, 9) then
  print('table contains the value 9')
end

-- 34. Find the first index in which the value 7 is found in the c table.
print("---")
print(M.detect(c, 7))

-- 35. Filer the d table so that only numbers lower than 5 remain.
print("---")
for k, v in pairs(M.select(d, function(v) return v < 5 end)) do
  print(k, v)
end

-- 36. Filter the c table so that only strings remain.
print("---")
for k, v in pairs(M.select(c, function(v) return type(v) == 'string' end)) do
  print(k, v)
end

-- 37. Check if all values of the c and d tables are numbers or not. It should
-- return false for the first and true for the second.
print("---")
print("c: " .. tostring(M.all(c, function(v) return type(v) == 'number' end)))
print("d: " .. tostring(M.all(d, function(v) return type(v) == 'number' end)))

-- 38. Shuffle the d table randomly.
print("---")
for k, v in pairs(M.shuffle(d, 3413)) do
  print(k, v)
end

-- 39. Reverse the d table.
print("---")
for k, v in pairs(M.reverse(d)) do
  print(k, v)
end

-- 40. Remove all occurrences of the values 1 and 4 from the d table.
print("---")
for k, v in pairs(M.reject(d, function(v) return v == 1 or v == 4 end)) do
  print(k, v)
end

-- 41. Create a combination of the b, c and d tables that doesn't have any
-- duplicates.
print("---")
for k, v in pairs(M.union(b, c, d)) do
  print(k, v)
end

-- 42. Find the common values of the b and d tables.
print("---")
for k, v in pairs(M.intersection(b, d)) do
  print(k, v)
end

-- 43. Append the b table to the d table.
print("---")
for k, v in pairs(M.append(d, b)) do
  print(k, v)
end