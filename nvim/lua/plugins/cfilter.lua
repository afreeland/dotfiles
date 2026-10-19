-- Native :Cfilter/:Lfilter (quickfix pruning) plus two convenience wrappers so
-- we stop retyping the same noise alternation. Everything below still drives the
-- built-in :Cfilter! under the hood — we just prebuild the pattern.
vim.cmd.packadd('cfilter')

-- Single source of truth for "not a true code path". Each entry carries both
-- forms because the two commands need different syntaxes:
--   * vim = a Vim-regex fragment, matched against a quickfix entry's file+text
--           (used by :Cprune, which post-filters an existing list)
--   * glob = a ripgrep --glob exclusion, so noise never enters the list at all
--           (used by :Csearch, which runs the search itself)
local NOISE = {
  { vim = [[_test\.go]],   glob = '!*_test.go' },
  { vim = [[\.json]],      glob = '!*.json' },
  { vim = [[\.ya?ml]],     glob = '!*.{yaml,yml}' }, -- \v mode: bare ? = optional
  { vim = [[docs/]],       glob = '!docs/**' },
  { vim = [[\.pb\.go]],    glob = '!*.pb.go' },      -- protobuf generated
  { vim = [[generated\.go]], glob = '!*generated.go' }, -- gqlgen generated
}

-- Escape a user-supplied literal term so it drops cleanly into a \v alternation.
local function escape_term(s)
  return (s:gsub('[\\/.*$^~%[%]()|{}+?]', '\\%0'))
end

-- :Cprune [extra terms...] — remove noise from the CURRENT quickfix list.
-- With no args it uses NOISE; extra args are added as literal exclusions on top,
-- e.g. :Cprune mock fixture  also drops anything matching "mock" or "fixture".
vim.api.nvim_create_user_command('Cprune', function(opts)
  local terms = {}
  for _, n in ipairs(NOISE) do
    terms[#terms + 1] = n.vim
  end
  for _, arg in ipairs(opts.fargs) do
    terms[#terms + 1] = escape_term(arg)
  end
  -- \v = very magic (readable alternation). The cfilter plugin only accepts
  -- ' " / as pattern delimiters, so wrap in single quotes (our pattern never
  -- contains one). Interior '/' in docs/ is fine since it isn't the delimiter.
  local pat = string.format([[\v(%s)]], table.concat(terms, '|'))
  local before = #vim.fn.getqflist()
  vim.cmd(string.format("Cfilter! '%s'", pat))
  local after = #vim.fn.getqflist()
  vim.notify(string.format('Cprune: %d -> %d (dropped %d)', before, after, before - after))
end, { nargs = '*', desc = 'Prune non-code noise from the quickfix list' })

-- :Csearch {query} — ripgrep for {query} across the tree with NOISE excluded up
-- front, loading matches straight into quickfix. This is the "start fresh" path;
-- :Cprune is the "clean up what LSP/:grep already gave me" path.
vim.api.nvim_create_user_command('Csearch', function(opts)
  local globs = {}
  for _, n in ipairs(NOISE) do
    globs[#globs + 1] = "-g '" .. n.glob .. "'"
  end
  -- --vimgrep gives file:line:col:text, exactly what errorformat expects.
  local cmd = string.format(
    "rg --vimgrep %s -- %s",
    table.concat(globs, ' '),
    vim.fn.shellescape(opts.args)
  )
  local lines = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 and #lines == 0 then
    vim.notify('Csearch: no matches for ' .. opts.args, vim.log.levels.WARN)
    return
  end
  vim.fn.setqflist({}, ' ', { title = 'Csearch: ' .. opts.args, lines = lines })
  vim.cmd('copen')
  vim.notify(string.format('Csearch: %d match(es)', #lines))
end, { nargs = '+', desc = 'ripgrep into quickfix, excluding non-code noise' })
