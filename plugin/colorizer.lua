require("pack").add {
    {
        src = "https://github.com/catgoose/nvim-colorizer.lua",
        opts = {
            options = {
                parsers = {
                    css_fn = true,
                    names = { enabled = false },
                    hex = { enabled = true },
                    tailwind = { lsp = true },
                },
            },
            filetypes = {
                "*",
                css = { names = { enabled = true } },
            },
        },
        setup = "colorizer",
    },
}
