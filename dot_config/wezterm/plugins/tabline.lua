local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local nf = wezterm.nerdfonts

local GLYPH_KEY_TABLE = nf.md_table_key --[[ '󱏅' ]]
local GLYPH_KEY = nf.md_key --[[ '󰌆' ]]

local function show_leader(window)
  local name = window:active_key_table()
  if name then
    return GLYPH_KEY_TABLE
  end
  return window:leader_is_active() and GLYPH_KEY or ""
end

return function(config)
  tabline.setup({
    sections = {
      tabline_a = { "mode", show_leader },
      tabline_x = {},
    },
    options = {
      component_separators = "",
    },
  })

  tabline.apply_to_config(config)
end
