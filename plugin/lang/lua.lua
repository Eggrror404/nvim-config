require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/folke/lazydev.nvim" },
    }

    require("lazydev").setup {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "snacks.nvim", words = { "Snacks" } },
        },
    }
end)
