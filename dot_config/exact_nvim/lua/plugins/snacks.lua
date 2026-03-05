return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- show .dotfiles
            ignored = false, -- show gitignored files
          },
          files = {
            hidden = true,
          },
        },
      },
    },
  },
}
