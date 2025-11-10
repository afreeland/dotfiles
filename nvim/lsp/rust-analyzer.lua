return {
    -- Command and arguments to start the server.
    cmd = { 'rust-analyzer' },

    -- Filetypes to automatically attach to.
    filetypes = { 'rust' },

    -- Root directory detection
    root_markers = { 'Cargo.toml', 'Cargo.lock' },

    -- Settings to send to the server
    settings = {
        ["rust-analyzer"] = {
            -- Enable all the standard features
            checkOnSave = {
                command = "clippy",
                extraArgs = { "--", "-W", "clippy::all" }
            },

            -- Cargo features
            cargo = {
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },

            -- Proc macro support
            procMacro = {
                enable = true,
            },

            -- Inlay hints
            inlayHints = {
                enable = true,
                parameterHints = true,
                typeHints = true,
                chainingHints = true,
            },

            -- Completion
            completion = {
                autoimport = {
                    enable = true,
                },
                autoself = {
                    enable = true,
                },
            },

            -- Diagnostics
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
        }
    }
}
