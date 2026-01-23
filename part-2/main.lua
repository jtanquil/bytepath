Object = require 'libraries/classic/classic'
start_time = love.timer.getTime()

function love.load()
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)
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
end