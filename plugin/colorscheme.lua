require("pack").add {
    {
        src = "https://github.com/rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "main",
            styles = {
                transparency = true,
            },
        },
        setup = function(opts)
            require("rose-pine").setup(opts)
            vim.cmd.colorscheme "rose-pine"
        end,
    },
}
