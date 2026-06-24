---@class PluginSpec : vim.pack.Spec
---@field eager? boolean
---@field opts? table
---@field setup? string | fun(opts: table)

local profile = { total = 0, arglist = vim.fn.argv(-1) }

---@param spec PluginSpec
local function load_plugin(spec)
    local start = vim.uv.hrtime()

    vim.pack.add { spec }
    if type(spec.setup) == "string" then
        require(spec.setup).setup(spec.opts or {})
    elseif type(spec.setup) == "function" then
        spec.setup(spec.opts or {})
    end

    local time = (vim.uv.hrtime() - start) / 1e6
    profile[#profile + 1] = {
        name = spec.name or spec.src,
        eager = spec.eager,
        time = time,
    }
    profile.total = profile.total + time
end

local deferred = {}
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        for _, spec in ipairs(deferred) do
            load_plugin(spec)
        end
        deferred = nil
        _G.profile = profile

        -- table.sort(profile, function(a, b)
        --     return a.time < b.time
        -- end)
        -- vim.print(vim.inspect(profile))
    end,
})

local M = {}

--- Thin vim.pack.add wrapper that defers loading plugin and handles calling setup
--- Note: Plugins are loaded in list order, so make sure the sequence matches dependency requirements.
---@param specs PluginSpec[]
function M.add(specs)
    for _, spec in ipairs(specs) do
        if deferred and not spec.eager then
            table.insert(deferred, spec)
        else
            load_plugin(spec)
        end
    end
end

return M
