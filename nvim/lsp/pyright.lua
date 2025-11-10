return {
    -- Command and arguments to start the server.
    cmd = { 'pyright-langserver', '--stdio' },

    -- Filetypes to automatically attach to.
    filetypes = { 'python' },

    -- Root directory detection
    root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile' },

    -- Settings to send to the server
    settings = {
        ['python'] = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true
            }
        }
    }
}
