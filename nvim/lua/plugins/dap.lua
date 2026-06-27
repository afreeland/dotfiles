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
-- Guarded: a missing or malformed launch.json (e.g. JSONC comments nvim-dap
-- can't parse) otherwise throws and aborts all of init.lua.
local ok, err = pcall(function()
    require('dap.ext.vscode').load_launchjs(nil, { go = { 'go' } })
end)
if not ok then
    vim.notify('nvim-dap: skipped launch.json (' .. tostring(err) .. ')', vim.log.levels.WARN)
end

-- Pipe program stdout/stderr through the DAP connection so dapui console shows output
local dap = require('dap')
for _, config in ipairs(dap.configurations.go or {}) do
    config.outputMode = 'remote'
end

-- Auto open/close DAP UI
local dap, dapui = require('dap'), require('dapui')
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

