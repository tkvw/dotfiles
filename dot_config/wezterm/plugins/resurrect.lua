local wezterm = require("wezterm")
--local plugin = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local plugin = wezterm.plugin.require("https://github.com/tkvw/resurrect.wezterm")

local options = {
	periodic_save_interval_seconds = 60 * 15,
	resurrect_current_workspace_on_startup = false,
}

return function(config)
	plugin.state_manager.periodic_save({
		interval_seconds = options.periodic_save_interval_seconds,
		save_workspaces = true,
		save_windows = true,
		save_tabs = true,
		save_current_state = options.resurrect_current_workspace_on_startup,
	})

	wezterm.on("resurrect.error", function(err)
		wezterm.log_error("ERROR!")
		wezterm.gui.gui_windows()[1]:toast_notification("resurrect", err, nil, 3000)
	end)

	wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, id)
		local workspace_state = plugin.workspace_state
		local state = plugin.state_manager.load_state(id, "workspace")
		if not state then
			return
		end
		workspace_state.restore_workspace(state, {
			window = window,
			relative = true,
			restore_text = true,

			resize_window = false,
			on_pane_restore = plugin.tab_state.default_on_pane_restore,
		})
	end)

	wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function()
		local workspace_state = plugin.workspace_state.get_workspace_state()
		plugin.state_manager.save_state(workspace_state)
	end)

	if options.resurrect_current_workspace_on_startup then
		wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(_, id)
			plugin.state_manager.write_current_state(id, "workspace")
		end)

		wezterm.on("gui-startup", function()
			plugin.state_manager.resurrect_on_gui_startup()
		end)
	else
		plugin.state_manager.clear_current_state()
	end

	table.insert(config.keys, {
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resurrect",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	})
	config.key_tables.resurrect = {
		{
			key = "s",
			action = wezterm.action_callback(function()
				plugin.state_manager.save_state(plugin.workspace_state.get_workspace_state())
			end),
		},
	}
end
