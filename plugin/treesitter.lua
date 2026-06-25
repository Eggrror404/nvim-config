vim.pack.add {
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
    },
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter" then
            vim.cmd "TSUpdate"
        end
    end,
})

-- Auto-install parsers and starts treesitter highlighting
-- source: https://github.com/fredrikaverpil/dotfiles/tree/main/nvim-fredrik

--- Install a parser via nvim-treesitter.
---@param lang string parser/language name
---@param callback fun(err?: any)
---@return boolean success
local function install_parser(lang, callback)
    local parsers = require "nvim-treesitter.parsers"
    if not parsers[lang] then
        return false
    end
    require("nvim-treesitter").install({ lang }):await(callback)
    return true
end

--- Auto-start treesitter highlighting for every buffer.
--- Registered at plugin/ sourcing time (step 11) so it runs before LSP's
--- FileType handlers (registered at VimEnter), preventing race conditions
--- with plugins that use treesitter queries on LspAttach.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
    callback = function(event)
        local bufnr = event.buf
        local ft = event.match
        if ft == "" then
            return
        end

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end

        local ok = pcall(vim.treesitter.start, bufnr, lang)
        if ok then
            return
        end

        install_parser(lang, function()
            pcall(vim.treesitter.start, bufnr, lang)
        end)
    end,
})
