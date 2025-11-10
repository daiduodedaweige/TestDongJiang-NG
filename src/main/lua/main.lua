local env = require "env"
local clock = env.clock

local chi_txreq = env.chi_txreq
local chi_txrsp = env.chi_txrsp
local chi_txdat = env.chi_txdat
local chi_txsnp = env.chi_txsnp

local chi_rxreq = env.chi_rxreq
local chi_rxrsp = env.chi_rxrsp
local chi_rxdat = env.chi_rxdat
local chi_rxsnp = env.chi_rxsnp

local function basic_test()
    clock:posedge()
    chi_rxreq.valid.value = 1
    chi_rxreq.ready.value = 1
    clock:posedge()

end

fork {
    main_task = function()
        sim.dump_wave()
        -- env.dut_reset()
        basic_test()
        sim.finish()
    end
}