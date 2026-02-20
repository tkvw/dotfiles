local wezterm = require("wezterm")

local plugin = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
return function(config)
	-- apply_to_config only adds keys, no way to override, so skip this step
	--plugin.apply_to_config(config)
	table.insert(config.keys, {
		key = "s",
		mods = "ALT",
		action = plugin.switch_workspace(),
	})

	plugin.workspace_formatter = function(label)
		return wezterm.format({
			{ Attribute = { Italic = true } },
			{ Foreground = { Color = config.colors.ansi[3] } },
			{ Background = { Color = config.colors.background } },
			{ Text = "󱂬 : " .. label },
		})
	end
end
