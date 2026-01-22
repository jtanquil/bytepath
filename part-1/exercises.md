### Part 1 Exercises

1. What is the role that Vsync plays in the game loop? It is enabled by default and you can disable it by calling `love.window.setMode` with the `vsync` attribute set to false.

Vsync limits the rate at which the game loop renders frames to match the refresh rate of the monitor. 