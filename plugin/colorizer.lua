require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/catgoose/nvim-colorizer.lua" },
    }

    require("colorizer").setup {
        options = {
            parsers = {
                css_fn = true,
                names = { enable = false },
                hex = { default = true },
                tailwind = { lsp = true },
            },
        },
        filetypes = {
            "*",
            css = { names = { enable = true } },
        },
    }
end)
