require("pack").add {
    {
        src = "https://github.com/folke/lazydev.nvim",
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
