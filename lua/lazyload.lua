local deferred = {}
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        for _, entry in ipairs(deferred) do
            if not entry.sync then
                vim.schedule(entry.fn)
            end
        end
        for _, entry in ipairs(deferred) do
            if entry.sync then
                entry.fn()
            end
        end
        deferred = nil
    end,
})

local M = {}

--- Defer function call to VimEnter event
---@param fn fun()
---@param opts? { sync?: boolean }
function M.defer(fn, opts)
    local sync = opts and opts.sync or false
    if deferred then
        table.insert(deferred, { fn = fn, sync = sync })
    elseif sync then
        fn()
    else
        vim.schedule(fn)
    end
end

return M
