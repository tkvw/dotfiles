local env = require("config.env")
return {
  {
    "mrjones2014/smart-splits.nvim",
    enabled = false,
    event = "VeryLazy",
    cond = env.is_tmux or env.is_wezterm,
    opts = {
      multiplezer_integration = env.is_wezterm and "wezterm" or env.is_tmux and "tmux" or nil,
    },
    keys = {
      {
        "<C-Left>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").resize_left()<CR>',
        desc = "Resize split, move pane left",
      },
      {
        "<C-Down>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").resize_down()<CR>',
        desc = "Resize split, move pane down",
      },
      {
        "<C-Up>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").resize_up()<CR>',
        desc = "Resize split, move pane up",
      },
      {
        "<C-Right>",
        mode = { "n", "c", "v", "t" },
        '<Cmd>lua require("smart-splits").resize_right()<CR>',
        desc = "Resize split, move pane right",
      },
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
