-- helpers.lua
-- Minimal helper module for WezTerm config loading
--
-- Usage:
--   local h = require("helpers")
--
--   h.os.windows  -- true/false
--   h.os.linux    -- true/false
--   h.os.macos    -- true/false
--
--   h.append_config(config, "config.appearance")
--     Module can return a table (shallow merged) or a function (called with config)
--
--   h.load_plugin(config, "plugins.tabline")
--     Module must return a function (called with config)

local wezterm = require("wezterm")
local M = {}

-- OS detection
M.os = {
	windows = wezterm.target_triple:find("windows") ~= nil,
	linux = wezterm.target_triple:find("linux") ~= nil,
	macos = wezterm.target_triple:find("darwin") ~= nil,
}

-- Load a config module and apply it
-- Supports both table returns (shallow merge) and function returns (called with config)
function M.append_config(config, mod_name)
	local ok, mod = pcall(require, mod_name)
	if not ok then
		wezterm.log_error("helpers: failed to load " .. mod_name .. ": " .. tostring(mod))
		return
	end
	if type(mod) == "function" then
		mod(config)
	elseif type(mod) == "table" then
		for k, v in pairs(mod) do
			config[k] = v
		end
	end
	wezterm.log_info("helpers: config loaded -> " .. mod_name)
end

-- Load a plugin module and apply it
-- Module must return a function that receives config
function M.load_plugin(config, mod_name)
	local ok, mod = pcall(require, mod_name)
	if not ok then
		wezterm.log_error("helpers: failed to load " .. mod_name .. ": " .. tostring(mod))
		return
	end
	if type(mod) == "function" then
		mod(config)
		wezterm.log_info("helpers: plugin loaded -> " .. mod_name)
	else
		wezterm.log_error("helpers: plugin must return a function -> " .. mod_name)
	end
end

return M
