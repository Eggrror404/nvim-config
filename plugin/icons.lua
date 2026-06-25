require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    }
end, { sync = true }) -- Oil loads icons
