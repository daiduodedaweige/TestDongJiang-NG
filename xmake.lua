---@diagnostic disable

local sim = os.getenv("SIM") or "vcs"
local prj_dir = os.curdir()
local build_dir = path.join(prj_dir, "build")
local zhujiang_dir = path.join(prj_dir, "Zhujiang-NG")
local rtl_dir = path.join(prj_dir, "Zhujiang-NG", "build", "rtl")
local dj_top_dir = path.join(prj_dir, "build", "DongJiangTop")
local lua_dir = path.join(prj_dir, "src", "main", "lua")
local tc_dir = path.join(lua_dir, "testcases")
local cp_dir = path.join(lua_dir, "component")
local env_dir = path.join(lua_dir, "env")

local function TestDongJiangCommon()
    add_rules("verilua")

    -- set top module
    set_values("cfg.top", "HomeWrapper")

    -- set sim tool
    if sim == "iverilog" then
        add_toolchains("@iverilog")
    elseif sim == "vcs" then
        add_toolchains("@vcs")
    elseif sim == "verilator" then
        add_toolchains("@verilator")
    end

    -- set needed files
    add_files(
        dj_top_dir .. "/rtl/*.sv",
        prj_dir .. "/*.lua",
        cp_dir .. "/*.lua",
        env_dir .. "/*.lua",
        tc_dir .. "/*.lua",
        lua_dir .. "/*.lua"
    )

    -- set main

    -- set cfg
    set_values("cfg.user_cfg", env_dir .. "/cfg.lua")

    -- set run TC
    local TC = os.getenv("TC")
    if TC then
        local tc_id = TC:sub(1, 3)
        local tc_filename = nil

        local files = os.files(path.join(tc_dir, "*.lua"))
        for _, file in ipairs(files) do
            local filename = path.filename(file)
            if filename:startswith(tc_id) then
                tc_filename = filename
                add_runenvs("TC_NAME", path.basename(tc_filename))
            end
        end

        set_values("cfg.lua_main", lua_dir .. "/tc_main.lua")
    else
        set_values("cfg.lua_main", lua_dir .. "/main.lua")
    end
end

target("TestDongJiang", function()
    TestDongJiangCommon()
end)

target("DongJiangTop", function()
    set_kind("phony")
    set_default(false)
    on_build(function ()
        os.tryrm(path.join(dj_top_dir, "*"))
        os.tryrm(path.join(build_dir, "*"))
        os.cd(zhujiang_dir)
        os.exec("xmake rtl -P . -M Home")
        os.mkdir(path.join(dj_top_dir, "rtl"))
        os.mv(path.join(rtl_dir, "*v"), path.join(dj_top_dir, "rtl"))
    end)
end)

target("init", function()
    set_kind("phony")
    set_default(false)
    on_run(function()
        -- TODO:
    end)
end)
