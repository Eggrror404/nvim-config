require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/nvim-mini/mini.statusline" },
    }

    local statusline = require "mini.statusline"
    statusline.setup {
        use_icons = true,
    }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
        return "%2l:%-2v" -- LINE:COLUMN
    end
end, { sync = true })
