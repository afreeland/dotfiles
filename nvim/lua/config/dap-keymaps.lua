-- DAP Debugging keybindings
vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<leader>d<Space>', require('dap').continue, { desc = 'Debug: Continue to Next Breakpoint' })
vim.keymap.set('n', '<leader>di', require('dap').step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<leader>do', require('dap').step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<leader>du', require('dap').step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>dB', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Set Conditional Breakpoint' })
vim.keymap.set('n', '<leader>dl', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = 'Debug: Set Log Point' })
vim.keymap.set('n', '<leader>dr', require('dap').repl.open, { desc = 'Debug: Open REPL' })
vim.keymap.set('n', '<leader>dR', require('dap').run_last, { desc = 'Debug: Run Last' })
vim.keymap.set('n', '<leader>dt', require('dap-go').debug_test, { desc = 'Debug: Debug Test' })
vim.keymap.set('n', '<leader>dT', require('dap-go').debug_last_test, { desc = 'Debug: Debug Last Test' })
vim.keymap.set('n', '<leader>ds', require('dap').terminate, { desc = 'Debug: Stop' })
vim.keymap.set('n', '<leader>dS', require('dap').clear_breakpoints, { desc = 'Debug: Clear Breakpoints' })
vim.keymap.set('n', '<leader>dn', function()
    -- Show available configurations and let user pick
    local configs = require('dap').configurations.go
    if configs and #configs > 0 then
        vim.ui.select(configs, {
            prompt = 'Select debug configuration:',
            format_item = function(config)
                return config.name or config.type
            end,
        }, function(selected)
            if selected then
                require('dap').run(selected)
            end
        end)
    else
        vim.notify('No Go debug configurations found', vim.log.levels.WARN)
    end
end, { desc = 'Debug: New Session' })

-- DAP UI keybindings
vim.keymap.set('n', '<leader>dv', require('dapui').toggle, { desc = 'Debug: Toggle DAP UI' })
vim.keymap.set('n', '<leader>de', require('dapui').eval, { desc = 'Debug: Evaluate Expression' })
vim.keymap.set('n', '<leader>dE', function()
    require('dapui').eval(vim.fn.input('Expression: '))
end, { desc = 'Debug: Evaluate Expression (Input)' })

-- Additional useful DAP keybindings
vim.keymap.set('n', '<leader>dp', require('dap').pause, { desc = 'Debug: Pause' })
vim.keymap.set('n', '<leader>dC', require('dap').close, { desc = 'Debug: Close Session' })
vim.keymap.set('n', '<leader>dH', require('dap').disconnect, { desc = 'Debug: Disconnect' })
vim.keymap.set('n', '<leader>dA', require('dap').attach, { desc = 'Debug: Attach to Process' })
vim.keymap.set('n', '<leader>dL', require('dap').list_breakpoints, { desc = 'Debug: List Breakpoints' })
vim.keymap.set('n', '<leader>dM', require('dap').set_exception_breakpoints, { desc = 'Debug: Set Exception Breakpoints' })

-- Reset our our UI view, typically gets jacked with quickfix/location list, grep, tree, etc.,
vim.keymap.set('n', '<leader>dz', function()
    require("dapui").open({ reset = true })
end, { desc = "Reset DAP UI" })
