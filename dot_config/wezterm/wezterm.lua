local wezterm = require("wezterm")
local config = wezterm.config_builder()

local h = require("utils.config")

h.append_config(config, "configs.colors")
h.append_config(config, "configs.domains")
h.append_config(config, "configs.fonts")
h.append_config(config, "configs.keybindings")
h.append_config(config, "configs.general")
h.append_config(config, "configs.launch")
h.append_config(config, "configs.ui")

h.load_plugin(config, "plugins.resurrect")
h.load_plugin(config, "plugins.workspace_switcher")
h.load_plugin(config, "plugins.smart_splits")
h.load_plugin(config, "plugins.tabline")

return config
