local env = require("config.env")
return {
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    cond = env.is_tmux or env.is_wezterm,
    opts = {
      multiplezer_integration = env.is_wezterm and "wezterm" or env.is_tmux and "tmux" or nil,
    },
    keys = {
      {
        "<C-h>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").move_cursor_left()<CR>',
        desc = "Go to window on the left",
      },
      {
        "<C-j>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").move_cursor_down()<CR>',
        desc = "Go to window on the bottom",
      },
      {
        "<C-k>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").move_cursor_up()<CR>',
        desc = "Go to window on the top",
      },
      {
        "<C-l>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").move_cursor_right()<CR>',
        desc = "Go to window on the right",
      },
      {
        "<C-\\>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").move_cursor_previous()<CR>',
        desc = "Go to previous window",
      },
    },
  },
}
