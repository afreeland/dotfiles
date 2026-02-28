return {
    -- Command and arguments to start the server.
    cmd = { "dart", "language-server", "--protocol=lsp" },

    -- Filetypes to automatically attach to.
    filetypes = { "dart" },

    -- Optional: Enable Flutter-specific features.
    init_options = {
        closingLabels = true,
        flutterOutline = true,
        outline = true,
        suggestFromUnimportedLibraries = true,
    },
}
