require("pack").add {
    {
        src = "https://github.com/folke/which-key.nvim",
        opts = {
            icons = { mappings = false },
            spec = {
                { "<leader>s", group = "Search" },
                { "<leader>g", group = "GitHub" },
                { "<leader>u", group = "Toggle" },
            },
        },
        setup = "which-key",
    },
}
