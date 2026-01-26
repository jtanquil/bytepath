Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'

start_time = love.timer.getTime()

function love.load()
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)

  input = Input()
  -- input:bind('mouse1', function() print(love.math.random()) end)
  input:bind('=', 'add')
  input:bind('a', 'add')
  input:bind('=', 'diff')

  sum = 0
  diff = 0
end


function love.update(dt)
  if input:down('add', 0.25) then
    sum = sum + 1
    print(sum)
  end

  if input:down('diff', 0.25) then
    diff = diff - 1
    print(diff)
  end
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
  -- test_circle = Circle(400, 300, 50)
  -- test_circle:update(1)

  test_hypercircle = HyperCircle(400, 300, 50, 10, 120)
  test_hypercircle:update(1)

  -- attrTest = AttributeMethod()
  -- print(attrTest.attFirst, attrTest.fnFirst)
  -- attrTest:fnFirst()
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