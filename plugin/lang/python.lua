require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/linux-cultist/venv-selector.nvim" },
    }

    require "venv-selector"
end)
