local formatters_by_ft = {
    lua = { "stylua" },

    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    c = { "clang-format" },
    cpp = { "clang-format" },

    python = { "ruff_format" },

    ["javascript"] = { "prettierd" },
    ["javascriptreact"] = { "prettierd" },
    ["typescript"] = { "prettierd" },
    ["typescriptreact"] = { "prettierd" },
    ["vue"] = { "prettierd" },
    ["css"] = { "prettierd" },
    ["scss"] = { "prettierd" },
    ["less"] = { "prettierd" },
    ["html"] = { "prettierd" },
    ["json"] = { "prettierd" },
    ["jsonc"] = { "prettierd" },
    ["yaml"] = { "prettierd" },
    ["markdown"] = { "prettierd" },
    ["markdown.mdx"] = { "prettierd" },
    ["graphql"] = { "prettierd" },
    ["handlebars"] = { "prettierd" },
    ["svelte"] = { "prettierd" },
    ["astro"] = { "prettierd" },
}

local formatters = {
    shfmt = {
        prepend_args = { "-i", "2" },
    },
}

require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/stevearc/conform.nvim" },
    }

    require("conform").setup {
        -- src: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#autoformat-with-extra-features
        format_on_save = function(bufnr)
            -- Disable autoformat on certain filetypes
            local ignore_filetypes = {}
            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        formatters_by_ft = formatters_by_ft,
        formatters = formatters,
    }

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.keymap.set("n", "<leader>f", function()
        require("conform").format { async = true }
    end, { desc = "Format buffer" })
    vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<cr>", { desc = "Toggle autoformat" })

    local notify_record = nil
    local notify_autoformat = function()
        notify_record = vim.notify(
            string.format(
                "Global format-on-save: `%s`\nBuffer format-on-save: `%s`",
                vim.g.disable_autoformat and " Disabled" or " Enabled",
                vim.b.disable_autoformat and " Disabled" or " Enabled"
            ),
            vim.log.levels.INFO,
            {
                title = "AutoFormat Toggle",
                replace = notify_record,
                on_open = function(win)
                    vim.wo[win].conceallevel = 3
                    vim.wo[win].concealcursor = "n"
                    vim.wo[win].spell = false
                    local buf = vim.api.nvim_win_get_buf(win)
                    vim.treesitter.start(buf, "markdown")
                end,
                on_close = function()
                    notify_record = nil
                end,
            }
        )
    end

    -- src: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#command-to-toggle-format-on-save
    vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
        else
            vim.g.disable_autoformat = true
        end
        notify_autoformat()
    end, {
        desc = "Disable autoformat-on-save",
        bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        notify_autoformat()
    end, {
        desc = "Re-enable autoformat-on-save",
    })
    vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
            vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
            vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
        notify_autoformat()
    end, { desc = "Toggle autoformat-on-save", bang = true })
end)
