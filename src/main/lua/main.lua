local env = require "env"


fork {
    main_task = function()
        sim.dump_wave()
        -- env.dut_reset()
        sim.finish()
    end
}