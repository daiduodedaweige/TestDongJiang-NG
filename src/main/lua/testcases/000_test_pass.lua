local env = require "env"
local clock = env.clock
local posedge = env.posedge


local function basic_test()
    for _ = 1, math.random(100, 150) do
    end

    clock:posedge(5000)
end



---@type TestCase
local tc = {
    tasks = {
        basic_test
    },
}

return tc