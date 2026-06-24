require("pack").add {
    {
        src = "https://github.com/nvim-mini/mini.statusline",
        opts = {},
        setup = function()
            local statusline = require "mini.statusline"
            statusline.setup {
                use_icons = true,
            }

            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v" -- LINE:COLUMN
            end
        end,
    },
}
