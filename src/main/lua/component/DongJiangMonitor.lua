local class = require "pl.class"

local DongJiangMonitor = class()

function DongJiangMonitor:_init(name, txreq, txrsp, txdat, txsnp, rxreq, rxrsp, rxdat, rxsnp, db, verbose, enable)
    self.name = name
    self.verbose = verbose
    self.enable = enable

    self.txreq = txreq
    self.txrsp = txrsp
    self.txdat = txdat
    self.txsnp = txsnp
    self.rxreq = rxreq
    self.rxrsp = rxrsp
    self.rxdat = rxdat
    self.rxsnp = rxsnp

    self._log_name_prefix = "[" .. self.name .. "]"
    self.tasks = {}

    self.cycles = 0


    self.txreq_chnl_name = self.name .. "__txreq"
    self.txrsp_chnl_name = self.name .. "__txrsp"
    self.txdat_chnl_name = self.name .. "__txdat"
    self.txsnp_chnl_name = self.name .. "__txsnp"
    self.rxreq_chnl_name = self.name .. "__rxreq"
    self.rxrsp_chnl_name = self.name .. "__rxrsp"
    self.rxdat_chnl_name = self.name .. "__rxdat"
end

function DongJiangMonitor:_log(...)
    print(f("[%d]\t%s", self.cycles, self._log_name_prefix), ...)
end

------------------------------
-----------   sample signals
------------------------------

-- get bundle value functions
local function safe_get(b, name, getter)
    local ok, v = pcall(function()
        local sig = b[name]
        if not sig then return nil end
        if getter == "hex" then
            return sig.get_hex_str and sig:get_hex_str() or nil
        else
            return sig.get and sig:get() or nil
        end
    end)
    return ok and v or nil
end

-- log information functions
local function log_req(self, tag, b)
    self:_log(
        tag,
        (safe_get(b, "opcode") and OpcodeREQ(safe_get(b, "opcode"))) or "<NA>",
        ("addr: %s"):format(to_hex_str(safe_get(b, "addr") or 0)),
        ("srcID:%s tgtID:%s txnID:%s"):format(
            tostring(safe_get(b, "srcID")),
            tostring(safe_get(b, "tgtID")),
            tostring(safe_get(b, "txnID"))
        )
    )
end

local function log_rsp(self, tag, b)
    self:_log(
        tag,
        (safe_get(b, "opcode") and OpcodeRSP(safe_get(b, "opcode"))) or "<NA>",
        ("resp:%s err:%s"):format(tostring(safe_get(b, "resp")), tostring(safe_get(b, "respErr"))),
        ("srcID:%s tgtID:%s txnID:%s dbID:%s"):format(
            tostring(safe_get(b, "srcID")),
            tostring(safe_get(b, "tgtID")),
            tostring(safe_get(b, "txnID")),
            tostring(safe_get(b, "dbID"))
        )
    )
end

local function log_dat(self, tag, b)
    self:_log(
        tag,
        (safe_get(b, "opcode") and OpcodeDAT(safe_get(b, "opcode"))) or "<NA>",
        ("dataID:%s dbID:%s"):format(tostring(safe_get(b, "dataID")), tostring(safe_get(b, "dbID"))),
        ("resp:%s err:%s"):format(tostring(safe_get(b, "resp")), tostring(safe_get(b, "respErr")))
    )
    local data_hex = safe_get(b, "data", "hex")
    local be_hex   = safe_get(b, "be",   "hex")
    if data_hex then self:_log(tag, "data=" .. data_hex) end
    if be_hex   then self:_log(tag, "be="   .. be_hex)   end
end

local function log_snp(self, tag, b)
    self:_log(
        tag,
        opcode_str,
        ("addr:%s"):format(to_hex_str(safe_get(b, "addr") or 0)),
        ("srcID:%s tgtID:%s txnID:%s"):format(
            tostring(safe_get(b, "srcID")),
            tostring(safe_get(b, "tgtID")),
            tostring(safe_get(b, "txnID"))
        )
    )
    local snpAttr = safe_get(b, "snpAttr")
    if snpAttr then self:_log(tag, ("snpAttr:%s"):format(tostring(snpAttr))) end
end

-- sample functions
function DongJiangMonitor:sample_all(cycles)

    self.cycles = cycles

    self:sample_txreq()
    self:sample_txrsp()
    self:sample_txdat()
    self:sample_txsnp()
    self:sample_rxreq()
    self:sample_rxrsp()
    self:sample_rxdat()
    self:sample_rxsnp()

end

function DongJiangMonitor:sample_txreq()
    local b = self.txreq
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_req(self, "[TXREQ]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_txrsp()
    local b = self.txrsp
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_rsp(self, "[TXRSP]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_txdat()
    local b = self.txdat
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_dat(self, "[TXDAT]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_txsnp()
    local b = self.txsnp
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_snp(self, "[TXSNP]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_rxreq()
    local b = self.rxreq
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_req(self, "[RXREQ]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_rxrsp()
    local b = self.rxrsp
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_rsp(self, "[RXRSP]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_rxdat()
    local b = self.rxdat
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_dat(self, "[RXDAT]", b)
        end
        -- monitor work
        do
            
        end
    end
end

function DongJiangMonitor:sample_rxsnp()
    local b = self.rxsnp
    if b.valid:is(1) and b.ready:is(1) then
        if self.verbose then
            log_snp(self, "[RXSNP]", b)
        end
        -- monitor work
        do
            
        end
    end
end

return DongJiangMonitor