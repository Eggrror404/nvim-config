require("pack").add {
    {
        src = "https://github.com/mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {},
        },
        setup = function(opts)
            local lint = require "lint"
            lint.linters_by_ft = opts.linters_by_ft

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    if vim.bo.modifiable then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
}
