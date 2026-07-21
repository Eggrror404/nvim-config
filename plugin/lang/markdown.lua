require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/noisesfromspace/touchup.nvim" },
    }

    require("touchup").setup {
        bullets = { icons = { "", "", "󰣏", "󱀝" } },
    }
end)
