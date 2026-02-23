return {
  {
    "coder/claudecode.nvim",
    enabled = false,
    opts = {},
    keys = {
      { "<leader>aa", "", desc = "+Antrophic Claude", mode = { "n", "v" } },
      { "<leader>aac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>aaf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>aar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aaC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>aab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>aas", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>aas",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aaa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>aad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
