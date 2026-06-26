local maps = {
    {
        "<F5>",
        function()
            require("dap").continue()
        end,
        desc = "Start/Continue",
    },
    {
        "<F1>",
        function()
            require("dap").step_into()
        end,
        desc = "Step Into",
    },
    {
        "<F2>",
        function()
            require("dap").step_over()
        end,
        desc = "Step Over",
    },
    {
        "<F3>",
        function()
            require("dap").step_out()
        end,
        desc = "Step Out",
    },
    {
        "<leader>b",
        function()
            require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
    },
    {
        "<leader>B",
        function()
            require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Set breakpoint with condition",
    },
    {
        "<F7>",
        "<cmd>DapViewToggle!<cr>",
        desc = "Toggle DAP view UI",
    },
    {
        "<M-K>",
        "<cmd>DapViewHover<cr>",
        desc = "DAP view hover",
        mode = { "n", "v" },
    },
}

require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://codeberg.org/mfussenegger/nvim-dap" },
        {
            src = "https://github.com/igorlfs/nvim-dap-view",
            version = vim.version.range "1.*",
        },
        {
            src = "https://github.com/stevearc/overseer.nvim",
        },
    }

    require("dap-view").setup {
        winbar = {
            sections = { "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
            controls = {
                enabled = true,
            },
        },
        virtual_text = {
            enabled = true,
            position = "eol",
        },
        auto_toggle = "keep_terminal",
    }

    require("overseer").setup()

    for _, map in ipairs(maps) do
        vim.keymap.set(map.mode or "n", map[1], map[2], { desc = map.desc })
    end
end)
