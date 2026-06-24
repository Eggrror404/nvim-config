require("pack").add {
    {
        src = "https://github.com/rcarriga/nvim-notify",
        opts = {
            background_colour = "#000000",
        },
        setup = function(opts)
            require("notify").setup(opts)
            vim.notify = require "notify"
        end,
    },
}
