local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'AdventureTime'
config.font = wezterm.font 'CaskaydiaCove Nerd Font'
config.font_size = 14.0

config.scrollback_lines = 3500
config.enable_scroll_bar = true

-- Window Background Opacity
config.window_background_opacity = 0.9

-- Styling Inactive Panes
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.disable_default_key_bindings = true
config.leader = { key = 'z', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- send key leader (important)
    { key = 'z', mods = 'LEADER|CTRL', action = act.SendKey { key = 'z', mods = 'CTRL' }},
    -- system default
    { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
    -- font size
    { key = 'h', mods = 'CMD', action = act.HideApplication },
    { key = '+', mods = 'CMD', action = act.IncreaseFontSize },
    { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
    { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
    { key = '0', mods = 'CMD', action = act.ResetFontSize },
    -- tab focus
    { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) },
    { key = 'f', mods = 'CMD', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'n', mods = 'CMD', action = act.SpawnWindow },
    { key = 'q', mods = 'CMD', action = act.QuitApplication },
    { key = 'r', mods = 'SHIFT|CMD', action = act.ReloadConfiguration },
    { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'P', mods = 'SHIFT|CMD', action = act.ActivateCommandPalette },
    -- pane split
    { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
    -- pane zoom
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
    -- pane focus
    { key = 'LeftArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Left'},
    { key = 'DownArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Down'},
    { key = 'UpArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Up'},
    { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection'Right'},
    -- enter mode: resize_pane
    { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable { name = 'resize_pane', one_shot = false }},
    -- close current pane
    { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = true }, },
    { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane { confirm = true }, },
}
config.key_tables = {
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },
    search_mode = {
        { key = 'Enter', mods = 'NONE', action = act.CopyMode 'NextMatch' },
        { key = 'Enter', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
        { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
        { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
        { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
        { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
        { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
        { key = 'PageUp', mods = 'NONE', action = act.CopyMode 'PriorMatchPage' },
        { key = 'PageDown', mods = 'NONE', action = act.CopyMode 'NextMatchPage' },
        { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
        { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
    },
}

return config
