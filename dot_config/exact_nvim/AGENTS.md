# AGENTS.md - Neovim Configuration Guide for AI Coding Agents

## Project Overview

This is a **Neovim configuration** built on the [LazyVim](https://github.com/LazyVim/LazyVim) framework.

- **Language**: Lua (Neovim's native configuration language)
- **Architecture**: Plugin-based with lazy.nvim plugin manager
- **Framework**: LazyVim (opinionated Neovim starter with sensible defaults)
- **AI Integration**: GitHub Copilot + OpenCode.nvim for AI-assisted development
- **Shell**: Nushell (nu) integration
- **Languages Supported**: Lua, .NET/C#, Svelte, Typst, Nushell

**Important**: This is NOT a traditional software project with builds/tests. It's a Neovim configuration that's loaded at editor runtime.

## Commands

### Configuration Management

**Reload configuration**:
```vim
:source $MYVIMRC
" Or restart Neovim
```

**Update plugins**:
```vim
:Lazy update
```

**Check plugin status**:
```vim
:Lazy
```

**Health checks**:
```vim
:checkhealth
:checkhealth lazy
:checkhealth opencode
```

### Formatting

**Format current file** (via conform.nvim):
- Keymap: `<leader>cf` in normal mode
- Or use Mason-installed formatters

**Format Lua files with StyLua** (command line):
```bash
stylua lua/
stylua --check lua/  # Check without modifying
```

### LSP & Tooling

**Install LSP servers/formatters/linters**:
```vim
:Mason
```

**LSP info for current buffer**:
```vim
:LspInfo
```

### Testing

**Manual testing**: Restart Neovim after making configuration changes to ensure they load correctly and don't cause errors.

**Syntax check Lua files**:
```bash
luac -p lua/config/options.lua
```

## Code Style Guidelines

### File Structure

```
nvim/
├── init.lua                    # Entry point - bootstraps config
├── lua/
│   ├── config/                 # Core Neovim configuration
│   │   ├── autocmds.lua       # Auto-commands
│   │   ├── keymaps.lua        # Custom keybindings
│   │   ├── lazy.lua           # Plugin manager setup
│   │   └── options.lua        # Neovim options (vim.opt.*)
│   └── plugins/                # Plugin specifications (auto-loaded)
│       ├── opencode.lua       # Individual plugin configs
│       └── *.lua              # Each file = plugin spec(s)
├── stylua.toml                 # Lua formatter configuration
├── .neoconf.json              # Lua LSP configuration
└── lazy-lock.json             # Plugin version lockfile (like package-lock.json)
```

### Formatting Rules

**From `stylua.toml`**:
- **Indentation**: 2 spaces (NOT tabs)
- **Line width**: 120 characters maximum
- **Formatter**: StyLua (auto-installed via Mason)

**Whitespace**:
- No trailing whitespace
- Single blank line at end of file
- Blank lines between logical sections

### Lua Language Conventions

**Variable scope**:
```lua
-- ✅ Use local by default
local my_var = "value"

-- ❌ Avoid globals unless necessary
my_global = "value"

-- ✅ Module-level constants
local M = {}
```

**Naming conventions**:
- **Variables/functions**: `snake_case`
- **Constants**: `UPPER_SNAKE_CASE`
- **Plugin files**: `kebab-case.lua`
- **Private functions**: prefix with `_` (e.g., `_internal_helper`)

**String literals**:
```lua
-- ✅ Prefer double quotes
local str = "hello world"

-- ✅ Single quotes for strings with double quotes inside
local html = '<div class="container"></div>'
```

### Imports and Requires

```lua
-- ✅ Standard require pattern
local opencode = require("opencode")

-- ✅ Lazy require (for performance)
local function do_something()
  local module = require("module")
  module.action()
end

-- ✅ Protected call for optional dependencies
local ok, module = pcall(require, "optional.module")
if ok then
  module.setup()
end
```

### Plugin Configuration Pattern

**Basic plugin spec**:
```lua
-- lua/plugins/example.lua
return {
  {
    "author/plugin-name",
    dependencies = { "other/plugin" },
    event = "VeryLazy",  -- Lazy-load on event
    config = function()
      require("plugin-name").setup({
        -- options here
      })
    end,
  },
}
```

**Multiple plugins in one file**:
```lua
return {
  { "plugin/one", opts = {} },
  { "plugin/two", opts = {} },
}
```

**Override LazyVim defaults**:
```lua
return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Override default LazyVim settings
    },
  },
}
```

### Type Annotations

Use LuaLS annotations for better IDE support:

```lua
---@type opencode.Opts
vim.g.opencode_opts = {
  -- Configuration with intellisense
}

---@module 'snacks'
local snacks = require("snacks")

---@param bufnr number Buffer number
---@param opts table Options table
---@return boolean success Whether operation succeeded
local function my_function(bufnr, opts)
  -- implementation
end
```

### Error Handling

```lua
-- ✅ Use pcall for operations that might fail
local ok, result = pcall(function()
  return risky_operation()
end)

if not ok then
  vim.notify("Operation failed: " .. result, vim.log.levels.ERROR)
  return
end

-- ✅ Check vim API return values
local buf = vim.api.nvim_create_buf(false, true)
if buf == 0 then
  vim.notify("Failed to create buffer", vim.log.levels.ERROR)
  return
end

-- ✅ Validate inputs
local function set_option(name, value)
  if not name or not value then
    error("name and value are required")
  end
  vim.opt[name] = value
end
```

### Comments

```lua
-- Single-line comment

--[[ Multi-line comment
     spanning multiple lines
     for longer explanations
]]

--- Documentation comment (LuaLS style)
--- This function does something important
---@param arg1 string First argument
---@return boolean Whether successful
local function documented_function(arg1)
  -- implementation
end
```

## LazyVim-Specific Guidelines

### Extending vs. Replacing

**✅ DO**: Extend LazyVim defaults
```lua
-- lua/config/options.lua
-- These ADD to LazyVim defaults
vim.opt.shell = "nu"
```

**❌ DON'T**: Replace entire configurations without understanding defaults

### Reference Upstream Defaults

Before customizing, check LazyVim defaults:
- Options: `https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua`
- Keymaps: `https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua`
- Autocmds: `https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua`

### LazyVim Extras

Enable language/feature support via extras (defined in `lazyvim.json`):
```lua
-- Enable via :LazyExtras UI, or edit lazyvim.json
{
  "extras": [
    "lazyvim.plugins.extras.lang.typescript",
    "lazyvim.plugins.extras.ai.copilot"
  ]
}
```

### Plugin Spec Merging

LazyVim automatically merges your plugin specs with defaults. You only need to specify what you're changing:
```lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Only specify the opts you want to change
    opts = {
      ensure_installed = { "lua", "rust" },  -- Adds to defaults
    },
  },
}
```

## Best Practices

1. **Keep it minimal**: LazyVim provides excellent defaults. Only customize what you need.
2. **Document keymaps**: Use the `desc` field in `vim.keymap.set()` for which-key integration.
3. **Test after changes**: Restart Neovim after editing configs to catch syntax errors early.
4. **Use lazy-loading**: Leverage `event`, `ft`, `keys`, `cmd` for better startup performance.
5. **Version control**: Commit `lazy-lock.json` to ensure reproducible plugin versions.
6. **Check health**: Run `:checkhealth` after installing new plugins or LSP servers.
7. **Read plugin docs**: Check plugin README/docs before configuring (many have sensible defaults).

## Common Patterns

### Adding a Keymap
```lua
-- lua/config/keymaps.lua
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
```

### Setting Vim Options
```lua
-- lua/config/options.lua
vim.opt.relativenumber = true
vim.opt.wrap = false
```

### Adding an Autocmd
```lua
-- lua/config/autocmds.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
  end,
})
```

### Installing a New Plugin
```lua
-- lua/plugins/my-plugin.lua
return {
  {
    "author/plugin-name",
    event = "VeryLazy",
    opts = {},
  },
}
```

## Resources

- **LazyVim Docs**: https://lazyvim.github.io
- **Neovim Docs**: `:help` or https://neovim.io/doc/user/
- **Lazy.nvim Docs**: https://github.com/folke/lazy.nvim
- **OpenCode Docs**: See plugin README or `:help opencode`
