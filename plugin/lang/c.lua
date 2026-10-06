require("lazyload").defer(function()
    local dap = require "dap"

    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = "OpenDebugAD7",
    }

    dap.configurations.c = {
        {
            name = "Launch current file",
            type = "cppdbg",
            request = "launch",
            preLaunchTask = "Build current file",
            postDebugTask = "Remove current binary",
            program = "${relativeFileDirname}/${fileBasenameNoExtension}",
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
        },
        {
            name = "Launch select file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
        },
    }
    dap.configurations.cpp = dap.configurations.c

    local overseer = require "overseer"

    overseer.register_template {
        name = "Build current file",
        builder = function()
            return {
                cmd = { vim.bo.filetype == "cpp" and "g++" or "gcc" },
                args = {
                    "-g",
                    "-lm",
                    vim.fn.expand "%:p",
                    "-o",
                    vim.fn.expand "%:p:h" .. "/" .. vim.fn.expand "%:t:r",
                },
            }
        end,
        condition = { "c", "cpp" },
    }
    overseer.register_template {
        name = "Remove current binary",
        builder = function()
            return {
                cmd = { "rm" },
                args = { vim.fn.expand "%:p:h" .. "/" .. vim.fn.expand "%:t:r" },
            }
        end,
        condition = { filetype = { "c", "cpp" } },
    }
end)
