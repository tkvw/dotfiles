--- @module "roslyn.config"
--- @type RoslynNvimConfig
local options = {}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
        csharp_ls = { enabled = false },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    enabled = false,
    ft = "cs",
    config = function()
      vim.lsp.config("roslyn", {
        cmd = {
          "dotnet",
          vim.fs.abspath("~/.local/share/nvim/roslyn/Microsoft.CodeAnalysis.LanguageServer.dll"),
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--stdio",
        },
      })
      require("roslyn").setup(options)
    end,
  },
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("easy-dotnet").setup()
    end,
  },
}
