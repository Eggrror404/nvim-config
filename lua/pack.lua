---@class PluginSpec : vim.pack.Spec
---@field eager? boolean
---@field opts? table
---@field setup? fun(opts: table)

---@param spec PluginSpec
local function load_plugin(spec)
    vim.pack.add { spec }
    if spec.setup then
        spec.setup(spec.opts or {})
    end
end

local deferred = {}
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        for _, spec in ipairs(deferred) do
            load_plugin(spec)
        end
        deferred = nil
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
