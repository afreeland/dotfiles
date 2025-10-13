return {
  -- Command and arguments to start the server.
  cmd = { 'gopls' },

  -- Filetypes to automatically attach to.
  filetypes = { 'go' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either a "go.mod" or a
  -- "go.work" file. Files that share a root directory will reuse
  -- the connection to the same LSP server.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { 'go.mod', 'go.work'}, '.git' },

  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for gopls 
  -- can be found here https://go.dev/gopls/editor/vim#a-hrefneovim-config-idneovim-configconfiguration
  settings = {
      gopls = {
        analyses = {
            unusedparams = true,
            unusedwrite = true,
            shadow = true,
            nilness = true,
            unusedvariable = true,
        },
        staticcheck = true,
        vulncheck = "Imports",
        gofumpt = true,
        -- Enhanced auto-import settings
        completeUnimported = true,
        usePlaceholders = true,
        expandWorkspaceToModule = true,
        -- Better completion and import suggestions
        completionDocumentation = true,
        -- More helpful diagnostics
        diagnosticsDelay = "250ms",
        diagnosticsTrigger = "Save",
      }
  }
}
