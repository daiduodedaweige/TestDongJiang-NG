local clock = dut.clock:chdl()
local DJMonitor = require "DongJiangMonitor"
-- signal bundle definition
local dj = dut.u_DongJiangTop.dj

local chi_txreq = dj:auto_bundle{ prefix = "txreq" }
local chi_txrsp = dj:auto_bundle{ prefix = "txrsp" }
local chi_txdat = dj:auto_bundle{ prefix = "txdat" }
local chi_txsnp = dj:auto_bundle{ prefix = "txsnp" }
local chi_rxreq = dj:auto_bundle{ prefix = "rxreq" }
local chi_rxrsp = dj:auto_bundle{ prefix = "rxrsp" }
local chi_rxdat = dj:auto_bundle{ prefix = "rxdat" }
local chi_rxsnp = dj:auto_bundle{ prefix = "rxsnp" }

-- Database definition
local dj_chi_db
do
    
end

-- DongJiangMonitor definition
local dj_mon
do
    dj_mon = DJMonitor(
        "dj_mon",
        chi_txreq,
        chi_txrsp,
        chi_txdat,
        chi_txsnp,
        chi_rxreq,
        chi_rxrsp,
        chi_rxdat,
        chi_rxsnp,
        dj_chi_db,
        verbose,
        enable
    )
end

return{
    clock = clock,
    dj_mon = dj_mon,
    chi_txreq = chi_txreq,
    chi_txrsp = chi_txrsp,
    chi_txdat = chi_txdat,
    chi_txsnp = chi_txsnp,
    chi_rxreq = chi_rxreq,
    chi_rxrsp = chi_rxrsp,
    chi_rxdat = chi_rxdat,
    chi_rxsnp = chi_rxsnp,
}