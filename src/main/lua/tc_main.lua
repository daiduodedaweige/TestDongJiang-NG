
---@class TestCase
---@field tasks table<number, function>

local tc_name = assert(os.getenv("TC_NAME"), "failed to get TC_NAME")

fork {
    tc_main_task = function()
        if os.getenv("DUMP") then
            sim.dump_wave(tc_name .. ".vcd")
        end
        print(tc_name)
        ---@type TestCase
        local tc = require(tc_name)

        local env = require "env"
        -- env.dut_reset()
        -- env.initialize_all()

        local task_count = #tc.tasks
        for i = 1, task_count do
            tc.tasks[i]()
        end

        print("<TC FINISH>")
        sim.finish()
    end
}
