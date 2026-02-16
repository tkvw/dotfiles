-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>a", "", { desc = "+ai" })
map("n", "<leader>ac", "", { desc = "copilot" })
map("n", "<leader>act", function()
  vim.cmd("Copilot toggle")
end, { desc = "Toggle Copilot" })
