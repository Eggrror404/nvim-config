local cmd = vim.api.nvim_create_user_command

cmd("Profile", function()
    local profile = _G.profile
    if profile == nil then
        return
    end

    table.sort(profile, function(a, b)
        return a.time < b.time
    end)
    vim.print(vim.inspect(profile))
end, { desc = "Print plugin profile results" })
