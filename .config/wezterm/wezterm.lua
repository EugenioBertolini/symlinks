local wezterm = require "wezterm"

-- Integration with neovim panes
local function isViProcess(pane)
  return pane:get_title():find "n?vim" ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  local vim_pane_changed = false
  if isViProcess(pane) then
    local before = pane:get_cursor_position()
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      wezterm.action.SendKey { key = vim_direction, mods = "CTRL" },
      pane
    )
    wezterm.sleep_ms(20)
    local after = pane:get_cursor_position()
    if before.x ~= after.x and before.y ~= after.y then
      vim_pane_changed = true
    end
  end
  if not vim_pane_changed then
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditionalActivatePane(window, pane, "Down", "j")
end)

-- Allow working with both the current release and the nightly
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- change colorscheme
config.colors = wezterm.plugin.require("https://github.com/EugenioBertolini/wezterm-colors").moon.colors()
config.inactive_pane_hsb = { hue = 1.0, saturation = 1.0, brightness = 0.8 }
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.95

-- configure important settings
config.audible_bell = "Disabled"
config.scrollback_lines = 200000
config.enable_scroll_bar = false
config.enable_kitty_graphics = true
config.default_domain = "local"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "nu" }
end

-- change font
config.font = wezterm.font {
  family = "JetBrains Mono Nerd Font",
  weight = "Medium",
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
}
config.font_size = 11
config.line_height = 1.0

-- set leader key
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 10000 }

-- change keybinds
config.disable_default_key_bindings = true
config.keys = {
  -- send CTRL+Space to terminal anyway
  { key = "a", mods = "LEADER|CTRL", action = wezterm.action { SendKey = { key = "a", mods = "CTRL" } } },
  -- reload config
  { key = "r", mods = "LEADER", action = "ReloadConfiguration" },
  -- fullscreen and font size
  { key = "m", mods = "LEADER", action = "ToggleFullScreen" },
  { key = ";", mods = "SHIFT|CTRL", action = "IncreaseFontSize" },
  { key = "-", mods = "SHIFT|CTRL", action = "DecreaseFontSize" },
  { key = "0", mods = "SHIFT|CTRL", action = "ResetFontSize" },
  -- split, navigate, and resize panes
  { key = "^", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "\\", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "-", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = false } } },
  { key = "b", mods = "LEADER", action = wezterm.action { RotatePanes = "CounterClockwise" } },
  { key = "n", mods = "LEADER", action = wezterm.action { RotatePanes = "Clockwise" } },
  { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
  { key = "h", mods = "CTRL", action = wezterm.action.EmitEvent "ActivatePaneDirection-left" },
  { key = "j", mods = "CTRL", action = wezterm.action.EmitEvent "ActivatePaneDirection-down" },
  { key = "k", mods = "CTRL", action = wezterm.action.EmitEvent "ActivatePaneDirection-up" },
  { key = "l", mods = "CTRL", action = wezterm.action.EmitEvent "ActivatePaneDirection-right" },
  { key = "LeftArrow", mods = "SHIFT|CTRL", action = wezterm.action { AdjustPaneSize = { "Left", 4 } } },
  { key = "DownArrow", mods = "SHIFT|CTRL", action = wezterm.action { AdjustPaneSize = { "Down", 2 } } },
  { key = "UpArrow", mods = "SHIFT|CTRL", action = wezterm.action { AdjustPaneSize = { "Up", 2 } } },
  { key = "RightArrow", mods = "SHIFT|CTRL", action = wezterm.action { AdjustPaneSize = { "Right", 4 } } },
  -- spawn and navigate tabs
  { key = "Enter", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "w", mods = "LEADER", action = wezterm.action { CloseCurrentTab = { confirm = false } } },
  { key = "[", mods = "LEADER", action = wezterm.action { ActivateTabRelative = -1 } },
  { key = "]", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
  { key = "l", mods = "LEADER", action = "ShowLauncher" },
  { key = "s", mods = "LEADER", action = "ShowTabNavigator" },
  -- search, copy, and paste
  { key = "f", mods = "SHIFT|CTRL", action = wezterm.action { Search = { CaseSensitiveString = "" } } },
  { key = "c", mods = "SHIFT|CTRL", action = wezterm.action { CopyTo = "Clipboard" } },
  { key = "v", mods = "SHIFT|CTRL", action = wezterm.action { PasteFrom = "Clipboard" } },
  { key = "Insert", mods = "SHIFT", action = wezterm.action { PasteFrom = "PrimarySelection" } },
  -- other
  { key = "UpArrow", mods = "SHIFT", action = wezterm.action { ScrollByPage = -1 } },
  { key = "DownArrow", mods = "SHIFT", action = wezterm.action { ScrollByPage = 1 } },
  { key = "Space", mods = "SHIFT", action = "ScrollToBottom" },
  { key = ",", mods = "LEADER", action = wezterm.action { ScrollToPrompt = -1 } },
  { key = ".", mods = "LEADER", action = wezterm.action { ScrollToPrompt = 1 } },
  { key = "l", mods = "SHIFT|LEADER", action = wezterm.action.ShowDebugOverlay },
}

local bar = wezterm.plugin.require "https://github.com/EugenioBertolini/wezterm-rosepine-bar"
bar.apply_to_config(config, {
  position = "top",
  left_separator = "   ",
  pane_icon = "󰣇",
})

return config
