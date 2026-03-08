-- Inspired by https://github.com/MowlandCodes/my-wezterm-config/blob/main/wezterm.lua
local wezterm = require("wezterm") ---@type Wezterm
local act = wezterm.action
local font = wezterm.font
local config = wezterm.config_builder() ---@type Config

config.default_prog = { "mise", "x", "--", "nu" }
config.launch_menu = {}
config.wsl_domains = {
  {
    name = "WSL:Ubuntu Bash",
    distribution = "Ubuntu",
    default_cwd = "~",
  },
  {
    name = "WSL:Ubuntu Nushell",
    distribution = "Ubuntu",
    default_cwd = "~",
    default_prog = { "/home/dennie/.local/share/mise/shims/nu" },
  },
}
config.font = font("MesloLGS NF")
config.font_size = 9

-- Transparent background
-- config.window_background_opacity = 0.9
-- or scheme ...
config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "C64"

config.initial_cols = 120
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.use_dead_keys = false
-- this sets SSH_AUTH_SOCK to the correct value when using wezterm ssh client
-- we don't want to use the ssh agent from the host system, so we disable it
config.mux_enable_ssh_agent = false
-- Cursor Style
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 60
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"
config.force_reverse_video_cursor = false
-- Panes
config.inactive_pane_hsb = {
  saturation = 0.4,
  brightness = 0.5,
}
-- Tab Styles
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
-- Key Bindings
local mod = {
  SUPER = "ALT|CTRL",
  SUPER_REV = "ALT|CTRL|SHIFT",
}
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 3500 }
config.disable_default_key_bindings = true
config.keys = {
  { key = "t",           mods = "LEADER",  action = act.SpawnTab("CurrentPaneDomain") },
  { key = "c",           mods = "LEADER",  action = act.CloseCurrentPane({ confirm = false }) },
  { key = "C",           mods = "LEADER",  action = act.CloseCurrentTab({ confirm = true }) },
  { key = "Q",           mods = "LEADER",  action = act.QuitApplication },
  { key = "F",           mods = "LEADER",  action = act.ToggleFullScreen },
  { key = "f",           mods = "LEADER",  action = act.TogglePaneZoomState },
  { key = "h",           mods = "LEADER",  action = act.SplitPane({ direction = "Left" }) },
  { key = "l",           mods = "LEADER",  action = act.SplitPane({ direction = "Right" }) },
  { key = "j",           mods = "LEADER",  action = act.SplitPane({ direction = "Down" }) },
  { key = "k",           mods = "LEADER",  action = act.SplitPane({ direction = "Up" }) },
  { key = "k",           mods = mod.SUPER, action = act.ActivatePaneDirection("Up") },
  { key = "j",           mods = mod.SUPER, action = act.ActivatePaneDirection("Down") },
  { key = "h",           mods = mod.SUPER, action = act.ActivatePaneDirection("Left") },
  { key = "l",           mods = mod.SUPER, action = act.ActivatePaneDirection("Right") },

  { key = "UpArrow",     mods = mod.SUPER, action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "DownArrow",   mods = mod.SUPER, action = act.AdjustPaneSize({ "Down", 5 }) },
  { key = "LeftArrow",   mods = mod.SUPER, action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "RightArrow",  mods = mod.SUPER, action = act.AdjustPaneSize({ "Right", 5 }) },

  { key = "p",           mods = "LEADER",  action = act.ActivateTabRelative(-1) },
  { key = "n",           mods = "LEADER",  action = act.ActivateTabRelative(1) },
  { key = "F3",          mods = "NONE",    action = act.ShowLauncher },
  { key = "F4",          mods = "NONE",    action = act.ShowDebugOverlay },
  { key = "|",           mods = "LEADER",  action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "\\",          mods = "LEADER",  action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  ---------------------- Editing Text ----------------------
  { mods = "CTRL|SHIFT", key = "c",        action = act.CopyTo("Clipboard") },
  { mods = "CTRL|SHIFT", key = "v",        action = act.PasteFrom("Clipboard") },
}

for i = 0, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = wezterm.action.ActivateTab(i),
  })
end

local tabline = require("plugins.tabline")
tabline(config)

-- Show leader key in status bar when active
-- wezterm.on("update-right-status", function(window, _)
--   local SOLID_LEFT_ARROW = ""
--   local prefix = ""
--
--   if window:leader_is_active() then
--     prefix = " " .. utf8.char(0x1f47e) .. " "
--     SOLID_LEFT_ARROW = utf8.char(0xe0b2)
--
--     if window:active_tab():tab_id() ~= 0 then
--       ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
--     end
--
--     if window:active_tab():tab_id() == 0 then
--       ARROW_FOREGROUND = { Foreground = { Color = "#C6A0F6" } }
--     end
--   end
--
--   window:set_left_status(wezterm.format({
--     { Background = { Color = "#b7bdf8" } },
--     { Text = prefix },
--     ARROW_FOREGROUND,
--     { Text = SOLID_LEFT_ARROW },
--   }))
-- end)
-- Plugins
-- local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
--
-- smart_splits.apply_to_config(config, {
--   direction_keys = {
--     move = { "h", "j", "k", "l" },
--     resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
--   },
--   modifiers = {
--     move = "CTRL",
--     resize = "CTRL",
--   },
-- })

-- local h = require("utils.config")
--
-- h.append_config(config, "configs.colors")
-- h.append_config(config, "configs.domains")
-- h.append_config(config, "configs.fonts")
-- h.append_config(config, "configs.keybindings")
-- h.append_config(config, "configs.general")
-- h.append_config(config, "configs.launch")
-- h.append_config(config, "configs.ui")
--
-- h.load_plugin(config, "plugins.resurrect")
-- h.load_plugin(config, "plugins.workspace_switcher")
-- h.load_plugin(config, "plugins.smart_splits")
-- h.load_plugin(config, "plugins.tabline")
--
return config
