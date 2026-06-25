local function on_attach(bufnr)
    local gitsigns = require "gitsigns"

    local function map(modes, lhs, rhs, opts)
        opts = opts or {}
        opts.buf = bufnr
        vim.keymap.set(modes, lhs, rhs, opts)
    end

    map("n", "]h", function()
        gitsigns.nav_hunk "next"
    end, { desc = "Next hunk" })
    map("n", "[j", function()
        gitsigns.nav_hunk "prev"
    end, { desc = "Previous hunk" })

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

    map("v", "<leader>hs", function()
        gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Stage selection" })

    map("v", "<leader>hr", function()
        gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "Reset selection" })

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk diff" })

    map("n", "<leader>hb", function()
        gitsigns.blame_line { full = true }
    end, { desc = "Blame line" })

    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff buffer" })

    map("n", "<leader>hq", gitsigns.setqflist, { desc = "Quickfix hunksin buffer" })
    map("n", "<leader>hQ", function()
        gitsigns.setqflist "all"
    end, { desc = "Quickfix all hunks" })

    -- Toggles
    map("n", "<leader>ud", function()
        gitsigns.toggle_word_diff()
        gitsigns.toggle_linehl()
    end, { desc = "Toggle word diff" })
end

require("pack").add {
    {
        src = "https://github.com/lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = on_attach,
        },
        setup = "gitsigns",
    },
}
