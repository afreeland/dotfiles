return {
  -- Command and arguments to start the server.
  -- Binary ships with the `vscode-langservers-extracted` Homebrew formula.
  cmd = { 'vscode-eslint-language-server', '--stdio' },

  -- Filetypes to automatically attach to.
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },

  -- This monorepo uses an eslint config at the root (flat config or .eslintrc).
  -- Anchor there so the server picks up the workspace-wide ruleset.
  root_markers = {
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    'package.json',
    '.git',
  },

  -- The eslint server requires these settings keys to be present; without a
  -- `settings` table it silently fails to start. Values mirror the VS Code
  -- ESLint extension defaults.
  settings = {
    validate = 'on',
    packageManager = nil, -- auto-detect (npm here)
    useESLintClass = false,
    experimental = { useFlatConfig = false }, -- set true if repo is flat-config only
    codeActionOnSave = {
      enable = false, -- flip to true + mode='all' to fix-on-save
      mode = 'all',
    },
    format = false, -- let prettier/eslint --fix own formatting, not the LSP
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = { shortenToSingleLine = false },
    nodePath = '',
    workingDirectory = { mode = 'location' },
  },

  -- The eslint server resolves config relative to the workspace folder it is
  -- given, so report the root dir explicitly.
  on_init = function(client)
    client.config.settings.workspaceFolder = {
      uri = client.workspace_folders and client.workspace_folders[1].uri,
      name = 'workspace',
    }
  end,
}
