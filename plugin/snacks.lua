local maps = {
    {
        "<leader>c",
        function()
            Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
    },
    {
        "<C-/>",
        function()
            Snacks.terminal.toggle()
        end,
        desc = "Open a terminal",
        mode = { "n", "t" },
    },
    {
        "<leader>g",
        function()
            Snacks.lazygit()
        end,
        desc = "Open lazygit",
    },
    -- picker
    {
        "<leader>sf",
        function()
            Snacks.picker.files {
                matcher = {
                    cwd_bonus = true, -- boost cwd matches
                    frecency = true, -- use frecency boosting
                    sort_empty = true, -- sort even when the filter is empty
                },
            }
        end,
        desc = "Files",
    },
    {
        "<leader>sb",
        function()
            Snacks.picker.buffers()
        end,
        desc = "Buffers",
    },
    {
        "<leader>sg",
        function()
            Snacks.picker.grep()
        end,
        desc = "Grep",
    },
    {
        "<leader>sw",
        function()
            Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
    },
    {
        "<leader>sd",
        function()
            Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
    },
    {
        "<leader>sD",
        function()
            Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
    },
    {
        "<leader>sh",
        function()
            Snacks.picker.help()
        end,
        desc = "Help Pages",
    },
    {
        "<leader>sk",
        function()
            Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
    },
    {
        "<leader>sl",
        function()
            Snacks.picker.loclist()
        end,
        desc = "Location List",
    },
    {
        "<leader>sm",
        function()
            Snacks.picker.marks()
        end,
        desc = "Marks",
    },
    {
        "<leader>sM",
        function()
            Snacks.picker.man()
        end,
        desc = "Man Pages",
    },
    {
        "<leader>sq",
        function()
            Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
    },
    {
        "<leader>sR",
        function()
            Snacks.picker.resume()
        end,
        desc = "Resume",
    },
    {
        "<leader>su",
        function()
            Snacks.picker.undo()
        end,
        desc = "Undo History",
    },
    -- gh
    {
        "<leader>gi",
        function()
            Snacks.picker.gh_issue()
        end,
        desc = "GitHub Issues (open)",
    },
    {
        "<leader>gI",
        function()
            Snacks.picker.gh_issue { state = "all" }
        end,
        desc = "GitHub Issues (all)",
    },
    {
        "<leader>gp",
        function()
            Snacks.picker.gh_pr()
        end,
        desc = "GitHub Pull Requests (open)",
    },
    {
        "<leader>gP",
        function()
            Snacks.picker.gh_pr { state = "all" }
        end,
        desc = "GitHub Pull Requests (all)",
    },
    -- LSP
    {
        "gd",
        function()
            Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
    },
    {
        "gD",
        function()
            Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
    },
    {
        "gr",
        function()
            Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
    },
    {
        "gI",
        function()
            Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
    },
    {
        "gy",
        function()
            Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto Type Definition",
    },
    {
        "<leader>ss",
        function()
            Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
    },
    {
        "<leader>sS",
        function()
            Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
    },
}

require("pack").add {
    {
        src = "https://github.com/folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            bufdelete = { enabled = true },
            indent = {
                enabled = true,
                animate = { enabled = false },
            },
            input = { enabeld = true, icon_pos = false },
            lazygit = { enabled = true, configure = false, win = { border = "rounded" } },
            picker = { enabled = true },
            quickfile = { enabled = true },
            rename = { enabled = true },
            terminial = { enabled = true },

            styles = {
                input = {
                    title_pos = "left",
                    width = 30,
                    relative = "cursor",
                    row = -3,
                    col = 0,
                },
            },
        },
        setup = function(opts)
            require("snacks").setup(opts)

            for _, map in ipairs(maps) do
                local mapopts = {}
                for key, val in pairs(map) do
                    if type(key) ~= "number" and key ~= "mode" then
                        mapopts[key] = val
                    end
                end
                vim.keymap.set(map.mode or "n", map[1], map[2], mapopts)
            end
        end,
    },
}
