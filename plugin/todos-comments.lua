require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/folke/todo-comments.nvim" },
    }

    require("todo-comments").setup()
end)
