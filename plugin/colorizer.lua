require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/catgoose/nvim-colorizer.lua" },
    }

    require("colorizer").setup {
        options = {
            parsers = {
                css_fn = true,
                names = { enabled = false },
                hex = { enabled = true },
                tailwind = { lsp = true },
            },
        },
        filetypes = {
            "*",
            css = { names = { enabled = true } },
        },
    }
end)
