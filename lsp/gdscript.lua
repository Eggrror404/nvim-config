return {
    on_attach = function(client)
        if not client.root_dir then
            return
        end
        local sock = client.root_dir .. "/.godot/nvim.sock"
        if not vim.uv.fs_stat(sock) then
            vim.fn.serverstart(client.root_dir .. "/.godot/nvim.sock")
        end
    end,
}
