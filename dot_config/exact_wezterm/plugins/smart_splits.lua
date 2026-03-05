local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

return function(config)
	smart_splits.apply_to_config(config, {
		-- Use the default config: https://github.com/mrjones2014/smart-splits.nvim?tab=readme-ov-file#wezterm
	})
end
