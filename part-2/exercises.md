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