-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- SSH domains - WezTerm will automatically read from ~/.ssh/config
config.ssh_domains = {}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.color_scheme = 'Tokyo Night'

-- Clean, intuitive keybindings for Linux/macOS consistency
config.keys = {
    -- Pane navigation (vim-style hjkl)
    {
        key = 'h',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'CTRL',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = ';',
        mods = 'CTRL',
        action = wezterm.action.TogglePaneZoomState
    },

    -- Pane splitting (intuitive character shapes)
    {
        key = '\\',
        mods = 'CTRL',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    -- Tab navigation and management
    {
        key = 'H',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = 'L',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'T',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = true },
    },

    -- Pane resizing (vim-style with ALT modifier to avoid conflicts)
    {
        key = 'h',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'j',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
    {
        key = 'k',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
        key = 'l',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },

    -- Standard copy/paste (Linux style)
    {
        key = 'c',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CopyTo 'Clipboard',
    },
    {
        key = 'v',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.PasteFrom 'Clipboard',
    },
    {
        key = 'x',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CopyTo 'Clipboard',
    },

    -- Additional Linux-style shortcuts
    {
        key = 'a',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SendString '\x01', -- Select all
    },
    {
        key = 'z',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SendString '\x1a', -- Undo
    },

    -- Font sizing (standard zoom shortcuts)
    {
        key = '=',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.IncreaseFontSize,
    },
    {
        key = '-',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.DecreaseFontSize,
    },
    {
        key = '0',
        mods = 'CTRL',
        action = wezterm.action.ResetFontSize,
    },

    -- Reload configuration
    {
        key = 'R',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },

    -- SSH connections (leverages ~/.ssh/config)
    {
        key = 'E',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowLauncher,
    },
    {
        key = 's',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { 'wezterm', 'ssh' },
        },
    },
}

-- Finally, return the configuration to wezterm:
return config
