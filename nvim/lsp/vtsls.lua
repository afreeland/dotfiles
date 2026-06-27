return {
  -- Command and arguments to start the server.
  -- vtsls wraps the official VS Code TypeScript server, so monorepo
  -- project-reference and tsconfig `paths` resolution match VS Code.
  cmd = { 'vtsls', '--stdio' },

  -- Filetypes to automatically attach to.
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },

  -- Anchor the root at the monorepo root (where nx.json / tsconfig.base.json
  -- live) so a single tsserver instance sees all the `@gamma/*`, `@fleet/*`,
  -- `@investigator/*` path aliases. Falls back to package.json for plain repos.
  root_markers = { 'nx.json', 'tsconfig.base.json', 'package.json', '.git' },

  -- Settings schema: https://github.com/yioneko/vtsls
  -- (vtsls nests the VS Code typescript/javascript option trees verbatim.)
  settings = {
    vtsls = {
      -- Route jump-to-definition through "Go to Source Definition" so it lands
      -- in real source across `@gamma/*` aliases instead of bundled .d.ts files.
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      -- Favor non-relative imports so auto-import uses `@gamma/*` style aliases
      -- instead of ../../../ chains, matching this codebase's conventions.
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      -- Surface suggestions for unused/unimported symbols.
      suggest = {
        completeFunctionCalls = true,
      },
      updateImportsOnFileMove = { enabled = 'always' },
    },
    javascript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
      inlayHints = {
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      updateImportsOnFileMove = { enabled = 'always' },
    },
  },
}
