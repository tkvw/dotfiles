local wezterm = require("wezterm")
local platform = require("utils.platform")

local config = {
  default_prog = { "mise", "x", "--", "nu" },
  launch_menu = {
    {
      label = "WSL Bash",
      args = { "wsl.exe", "-e", "bash" }
    },
    {
      label = "WSL Nushell",
      args = { "wsl.exe", "-e", "nu" }
    }
  },
  {
    label = "WSL Bash login",
    args = { "wsl.exe", "-e", "bash", "-l" }
  }

}

return config
