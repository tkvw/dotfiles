return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- toont .dotfiles
            ignored = false, -- toont gitignored files
          },
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
