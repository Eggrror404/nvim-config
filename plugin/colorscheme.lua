require("lazyload").defer(function()
    vim.pack.add {
        {
            src = "https://github.com/rose-pine/neovim",
            name = "rose-pine",
        },
    }

    require("rose-pine").setup {
        variant = "main",
        styles = {
            transparency = true,
        },
    }
    vim.cmd.colorscheme "rose-pine"
end, { sync = true })
