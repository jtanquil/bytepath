Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'

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

function love.load()
  local object_files = {}
  recursiveEnumerate('objects', object_files)
  requireFiles(object_files)

  current_room = nil

  input = Input()
  input:bind('f1', 'circle')
  input:bind('f2', 'rectangle')
  input:bind('f3', 'polygon')
end


function love.update(dt)
  if input:pressed('circle') then
    gotoRoom('CircleRoom', 400, 300, 50)
  elseif input:pressed('rectangle') then
    gotoRoom('RectangleRoom', 400, 300, 200, 100)
  elseif input:pressed('polygon') then
    gotoRoom('PolygonRoom', {100, 100, 200, 100, 150, 200})
  end

  if current_room then current_room:update(dt) end
end

function love.draw()
  if current_room then current_room:draw() end
end

function gotoRoom(room_type, ...)
  current_room = _G[room_type](...)
end