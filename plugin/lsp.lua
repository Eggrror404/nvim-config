require("lazyload").defer(function()
    vim.pack.add {
        { src = "https://github.com/mason-org/mason.nvim" },
        { src = "https://github.com/neovim/nvim-lspconfig" },
        { src = "https://github.com/j-hui/fidget.nvim" },
    }

    -- Mason sets PATH for installed LSPs to be found by lsp.enable
    -- otherwise lsp-attach on the startup file breaks
    require("mason").setup()
    require("fidget").setup {}

    -- enable LSPs here
    vim.lsp.enable {
        "lua_ls",
    }

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            local buf = event.buf

            if client then
                -- LSP folding (override treesitter default from init.lua)
                if client:supports_method("textDocument/foldingRange", buf) then
                    local win = vim.api.nvim_get_current_win()
                    vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
                end

                -- Workspace diagnostics
                if client:supports_method("workspace/diagnostic", buf) then
                    vim.lsp.buf.workspace_diagnostics { client_id = client.id }
                end

                -- Inline completion
                if client:supports_method("textDocument/inlineCompletion", buf) then
                    vim.lsp.inline_completion.enable(true)
                end

                -- Linked editing (e.g., paired HTML tags)
                if client:supports_method("textDocument/linkedEditingRange", buf) then
                    vim.lsp.linked_editing_range.enable(true, { bufnr = buf })
                end

                -- Inline color swatches
                if client:supports_method("textDocument/documentColor", buf) then
                    vim.lsp.document_color.enable(true, { bufnr = buf })
                end

                -- Document symbol highlights
                if client:supports_method("textDocument/documentHighlight", buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                        buf = buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                        buf = buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end

            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "LSP Hover" })
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = buf, desc = "LSP Rename" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
            vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { buffer = buf, desc = "Run codelens" })
            vim.keymap.set("n", "<leader>cR", "<cmd>lsp restart<cr>", { desc = "Restart LSP" })
            vim.keymap.set({ "n", "x" }, "<M-o>", function()
                vim.lsp.buf.selection_range(1)
            end, { buffer = buf, desc = "Expand selection (LSP)" })
            vim.keymap.set("x", "<M-i>", function()
                vim.lsp.buf.selection_range(-1)
            end, { buffer = buf, desc = "Shrink selection (LSP)" })
            vim.keymap.set("n", "<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
            end, { buffer = buf, desc = "Toggle inlay hints" })
            vim.keymap.set("n", "<leader>ul", function()
                local enabled = not vim.lsp.codelens.is_enabled()
                vim.lsp.codelens.enable(enabled)
                vim.notify("Codelens: " .. (enabled and "on" or "off"))
            end, { buffer = buf, desc = "Toggle codelens" })
        end,
    })

    -- Reset on detach so :lsp restart/:lsp stop don't leave stale state.
    vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach-cleanup", { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then
                return
            end

            -- highlights autocmd
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = args.buf }

            -- diagnostics
            local prefix = ("nvim.lsp.%s.%d"):format(client.name, client.id)
            for namespace, metadata in pairs(vim.diagnostic.get_namespaces()) do
                local name = metadata.name or ""
                if name == prefix or vim.startswith(name, prefix .. ".") then
                    vim.diagnostic.reset(namespace)
                end
            end
        end,
    })
end)
