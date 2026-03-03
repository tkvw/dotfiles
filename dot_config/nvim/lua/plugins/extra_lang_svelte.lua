return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.configurations.svelte = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Svelte App",
          runtimeExecutable = "node",
          runtimeArgs = function()
            local projectFolder = vim.fs.root(0, { "package.json" })
            return { projectFolder .. "/node_modules/vite/bin/vite.js", "dev" }
          end,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to SvelteKit",
          port = 9229,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end,
  },
}
