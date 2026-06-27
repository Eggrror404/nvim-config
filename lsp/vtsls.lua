return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    settings = {
        complete_function_calls = true,
        vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
                completion = {
                    enableServerSideFuzzyMatch = true,
                },
            },
        },
        -- typescript and javascript shares the config
        typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
        },
        javascript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
                completeFunctionCalls = true,
            },
            inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
            },
        },
    },
    keys = {
        {
            "gD",
            function()
                local params = vim.lsp.util.make_position_params()
                require("utils").lsp.execute {
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                    open = true,
                }
            end,
            desc = "Goto Source Definition",
        },
        {
            "gR",
            function()
                require("utils").lsp.trouble_open {
                    command = "typescript.findAllFileReferences",
                    arguments = { vim.uri_from_bufnr(0) },
                    open = true,
                }
            end,
            desc = "File References",
        },
        {
            "<leader>lo",
            require("utils").lsp.action["source.organizeImports"],
            desc = "Organize Imports",
        },
        {
            "<leader>lM",
            require("utils").lsp.action["source.addMissingImports.ts"],
            desc = "Add missing imports",
        },
        {
            "<leader>lu",
            require("utils").lsp.action["source.removeUnused.ts"],
            desc = "Remove unused imports",
        },
        {
            "<leader>lD",
            require("utils").lsp.action["source.fixAll.ts"],
            desc = "Fix all diagnostics",
        },
        {
            "<leader>lV",
            function()
                require("utils").lsp.execute { command = "typescript.selectTypeScriptVersion" }
            end,
            desc = "Select TS workspace version",
        },
    },
}
