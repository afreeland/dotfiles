vim.pack.add({ "https://github.com/mfussenegger/nvim-dap.git" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio.git" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui.git" })

-- Setup DAP UI
require('dapui').setup({
    layouts = {
        {
            elements = {
                { id = "scopes",      size = 0.4 },
                { id = "breakpoints", size = 0.2 },
                { id = "stacks",      size = 0.2 },
                { id = "watches",     size = 0.2 },
            },
            size = 50,
            position = "left",
        },
        {
            elements = {
                { id = "repl",    size = 0.5 },
                { id = "console", size = 0.5 },
            },
            size = 15,
            position = "bottom",
        },
    },
})

-- Load .vscode/launch.json configs from project root.
-- VS Code's launch.json is JSONC (allows // and /* */ comments), but nvim-dap
-- decodes it with strict vim.json.decode, which chokes on those comments. The
-- loader exposes json_decode as a swappable field, so wrap it to strip comments
-- first. This keeps the shared launch.json exactly as VS Code users expect.
local vscode = require('dap.ext.vscode')
vscode.json_decode = function(str)
    -- Drop // line comments and /* */ block comments outside of strings.
    local stripped = str
        :gsub('/%*.-%*/', '')                 -- block comments
        :gsub('([^:])//[^\n\r]*', '%1')       -- line comments (skip :// in URLs)
    return vim.json.decode(stripped)
end

-- load_launchjs() APPENDS to dap.configurations without deduping, so re-sourcing
-- this file (:luafile, config reload, switching projects) stacks duplicate
-- "Launch fleetd" entries in the picker. Snapshot the built-ins once, then reset
-- to that snapshot before every (re)load so the result is always idempotent.
local dap = require('dap')
if _G.__dap_builtin_go_configs == nil then
    _G.__dap_builtin_go_configs = vim.deepcopy(dap.configurations.go or {})
end
dap.configurations.go = vim.deepcopy(_G.__dap_builtin_go_configs)

local ok, err = pcall(function()
    vscode.load_launchjs(nil, { go = { 'go' } })
end)
if not ok then
    vim.notify('nvim-dap: skipped launch.json (' .. tostring(err) .. ')', vim.log.levels.WARN)
end

-- Pipe program stdout/stderr through the DAP connection so dapui console shows output
for _, config in ipairs(dap.configurations.go or {}) do
    config.outputMode = 'remote'
end

-- Auto open/close DAP UI
local dapui = require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

