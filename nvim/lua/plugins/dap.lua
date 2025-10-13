vim.pack.add({ "https://github.com/mfussenegger/nvim-dap.git" })
vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio.git" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui.git" })

-- Setup DAP UI
require('dapui').setup()

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

