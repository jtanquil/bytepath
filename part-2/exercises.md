### Part 2 Exercises

8. What is the purpose of the `:` operator in Lua? How is it different from `.` and when should either be used?

The `:` operator is Lua's way of implementing a version of execution context (`self` or `this` in other languages), and it can be used in function declarations of object/class methods and function invocations in place of the `.` operator:
- when used in the function declarations of constructors or instance methods, the function signature `test:fn(...)` is the equivalent of `test.fn(self, ...)`, so it adds the variable `self` to the scope defined by the function `fn`. The value of `self` depends on how the function is called, similar to the value of `this` in Javascript
- when used in a function invocation instead of `.`, the function invocation `test:fn(...)` is equivalent to `test.fn(test, ...)`, effectively passing the caller `test` as `self`. The two common examples are
  - functions such as constructors or class methods that pass a class `Class` as `self` (`TestClass:new(...)` => `TestClass.new(TestClass, ...)`, for creating a new instance of `TestClass`)
  - instance methods that pass the calling instance as `self` (`instanceOfSelf:method(...)` => `instanceOfSelf.method(instanceOfSelf, ...)`)

When a method defined with `:` is invoked with `.` then the first argument is used as `self` which can cause some issues if the first argument is not set correctly; this issue can arise when using the Classic library and attempting to call parent instance methods.

9. Suppose we have the following code:

```lua
function createCounterTable()
    return {
        value = 1,
        increment = function(self) self.value = self.value + 1 end,
    }
end

function love.load()
    counter_table = createCounterTable()
    counter_table:increment()
end
```

What is the value of `counter_table.value`? Why does the `increment` function receive an argument named `self`? Could this argument be named something else? And what is the variable that `self` represents in this example?

The value of `counter_table.value` is `1` when initially returned by the invocation of `createCounterTable`, and it is incremented to `2` by the call to `counter_table:increment` on the next line. `increment` receives an argument called `self` as part of its signature because it is written to be an instance method of the object returned by `createCounterTable`; when `increment` is called with the `:` operator, the calling object, `counter_table`, is passed as the first argument to `increment`. `self` could be named something else but this is the standard name for the variable since it is meant to represent the instance or class on which the function is invoked, i.e. the `self` (or `this`, from other languages) invoking the function.

11. If a class has a method with the name of `someMethod` can there be an attribute of the same name? If not, why not?

If a class has an attribute with the same name as a class method, then the attribute name takes precedence once assigned. In particular this means that attempting to invoke the method will cause an error if the value of the attribute isn't a function. The reason is because attributes are assigned to an instance of a class, whereas instance methods are set as attributes to the metatable assigned to the class instance, so when an attribute with that name is referenced, the instance's attribute is retrieved before the instance method:

```lua
-- instance method w/attributeName, ignored
classInstance metatable { attributeName = function( ... ) ... } 
^
-- retrieves attribute w/name attributeName
instance of classInstance { attributeName = ..., } 
^
classInstance.attributeName
```

12. What is the global table in Lua?

The global table `_G` is a special table in Lua programs that contains all of the global variables in the program.

13. Based on the way we made classes be automatically loaded, whenever one class inherits from another we have code that looks like this:

```lua
SomeClass = ParentClass:extend()
```

Is there any guarantee that when this line is being processed the `ParentClass` variable is already defined? Or, to put it another way, is there any guarantee that `ParentClass` is required before `SomeClass`? If yes, what is that guarantee? If not, what could be done to fix this problem?

There is no guarantee that `ParentClass` will be required before `SomeClass`; in particular, `love.filesystem.getDirectoryItems(folder)` returns the `items` in alphabetical order, so if `SomeClass` appears before its `ParentClass` in that order then an error will occur. Naming files in alphabetical order, or ensuring that `ParentClass` will appear before `SomeClass` with respect to this ordering (with the understanding that these recursive calls will run the scripts found in this order), will ensure that no issues will occur.

14. Suppose that all class files do not define the class globally but do so locally, like:

```lua
local ClassName = Object:extend()
...
return ClassName
```

How would the `requireFiles` function need to be changed so that we could still automatically load all classes?

Assigning each returned `ClassName` to the global table `_G` will ensure that the classes will be available throughout the program.