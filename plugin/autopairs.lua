require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/windwp/nvim-autopairs" },
        { src = "https://github.com/windwp/nvim-ts-autotag" },
    }

    require("nvim-ts-autotag").setup()
    require("nvim-autopairs").setup()
end)
