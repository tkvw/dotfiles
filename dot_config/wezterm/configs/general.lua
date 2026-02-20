local platform = require("utils.platform")

local config = {
	exit_behavior = "CloseOnCleanExit", -- if the shell program exited with a successful status
	exit_behavior_messaging = "Verbose",
	status_update_interval = 1000,
	audible_bell = "Disabled",
	default_workspace = "default",
	scrollback_lines = 20000,
	mux_enable_ssh_agent = false,
}

if platform.is_windows then
	config.use_dead_keys = true
end

return config
