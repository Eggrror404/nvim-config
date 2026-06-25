require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/mason-org/mason.nvim" },
    }

    require("mason").setup()
end)
