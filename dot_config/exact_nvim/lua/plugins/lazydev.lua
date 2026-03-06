return {
  {
    "DrKJeff16/wezterm-types",
    version = false, -- Get the latest version
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "DrKJeff16/wezterm-types" },

    opts = {
      library = {
        -- Other library configs...
        { path = "wezterm-types", mods = { "wezterm" } },
      },
      enabled = function(root_dir)
        local chezmoi_dir = vim.fs.normalize(vim.fn.expand("~/.local/share/chezmoi"))
        local is_chezmoi = root_dir and root_dir:find(chezmoi_dir, 1, true) ~= nil
        -- vim.notify(
        --   "root_dir: " .. (root_dir or "nil") .. " | chezmoi: " .. tostring(is_chezmoi) .. " | dir " .. chezmoi_dir
        -- )
        return is_chezmoi
      end,
    },
  },
}
