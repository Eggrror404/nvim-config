require("pack").add {
    {
        src = "https://github.com/folke/which-key.nvim",
        opts = {
            icons = { mappings = false },
            spec = {
                { "<leader>s", group = "Search" },
                { "<leader>u", group = "Toggle" },
                { "<leader>G", group = "GitHub" },
            },
        },
        setup = "which-key",
    },
}
