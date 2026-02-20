--local wezterm = require("wezterm")
local platform = require("utils.platform")

local wsl_domains = {}

if platform.is_win then
	wsl_domains = {
		{
			name = "Ubuntu",
			distribution = "Ubuntu",
			username = "dennie",
			default_cwd = "/home/dennie",
			default_prog = { "bash" },
		},
	}
end

return {
	wsl_domains = wsl_domains,
}
