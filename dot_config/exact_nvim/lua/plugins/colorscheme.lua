return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = function(_, opts)
      opts.transparent_background = true
      opts.float = {
        transparent = true,
      }
      local bg = vim.o.background
      if bg == "dark" then
        opts.flavour = "mocha"
        -- opts.dim_inactive = { enabled = true, shade = "light", percentage = 0.8 }
        -- opts.color_overrides = {
        --   all = {
        --     base = "#000000",
        --   },
        -- }
      else
        opts.flavour = "latte"
      end
    end,
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.special.bufferline").get_theme()
      end
    end,
  },
  { "miikanissi/modus-themes.nvim", priority = 1000, opts = {
    variant = "deuteranopia",
  } },
  {
    "ellisonleao/gruvbox.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
