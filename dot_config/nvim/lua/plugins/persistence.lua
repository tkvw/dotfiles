return {
  -- Lua
  {
    "folke/persistence.nvim",
    enabled = true,
    --event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    },
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    enabled = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      -- log_level = 'debug',
      pre_restore_cmds = {
        function()
          local pickers = Snacks.picker.get({ source = "explorer" })
          if pickers and pickers[1] then
            pickers[1]:close()
          end
        end,
      },
    },
  },
}
