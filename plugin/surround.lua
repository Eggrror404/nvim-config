require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/nvim-mini/mini.surround" },
    }

    require("mini.surround").setup()
end)
