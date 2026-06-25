require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/rcarriga/nvim-notify" },
    }

    require("notify").setup {
        background_colour = "#000000",
    }

    vim.notify = require "notify"
end)
