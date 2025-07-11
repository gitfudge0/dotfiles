# AGENTS.md - Neovim Configuration

## Build/Lint/Test Commands
- **Format Lua**: `stylua .` (uses stylua.toml config)
- **Check syntax**: `nvim --headless -c "luafile init.lua" -c "qa"`
- **No specific test framework** - this is a Neovim configuration, not a testable codebase

## Code Style Guidelines

### Formatting
- **Indentation**: 2 spaces (configured in stylua.toml)
- **Line width**: 120 characters max
- **No trailing whitespace**

### Lua Conventions
- Use `return { ... }` for plugin configurations
- Plugin specs follow LazyVim structure with `opts`, `config`, `dependencies`
- Use double quotes for strings consistently
- Comment style: `-- Single line` and `--[[ Multi-line ]]`

### File Organization
- `lua/config/` - Core Neovim configuration (options, keymaps, autocmds)
- `lua/plugins/` - Individual plugin configurations
- Each plugin gets its own file named after the plugin
- Use descriptive filenames (e.g., `nvim-cmp.lua`, `onedark.lua`)

### Variable Naming
- Use snake_case for Lua variables and functions
- Use descriptive names for configuration options
- Prefix vim options with `vim.opt.` or `vim.g.`