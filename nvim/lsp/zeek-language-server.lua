return {
  cmd = { 'zeek-language-server' },

  filetypes = { 'zeek' },

  -- Zeek scripts rarely ship a single project marker; .git is a safe default.
  root_markers = { '.git' },

  -- See https://github.com/bbannier/zeek-language-server#configuration
  init_options = {
    inlay_hints_parameters = true,
    inlay_hints_variables = true,
    references = false,
    rename = false,
    semantic_highlighting = true,
    debug_ast_nodes = false,
  },
}
