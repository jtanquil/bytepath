-- 11. If a class has a method with the name of `someMethod` can there be an 
-- attribute of the same name? If not, why not?

AttributeMethod = Object:extend()

function AttributeMethod:new()
  self.attFirst = 1
  self.attFirst = function() print("hi") end
  self.fnFirst = function() print("hello") end
  self.fnFirst = 2
end

function AttributeMethod:fnFirst()
  print("hi there")
end