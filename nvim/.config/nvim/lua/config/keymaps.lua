-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local snacks = require("snacks")

vim.keymap.set("n", "<leader>?", require("telescope.builtin").live_grep, { desc = "[?] Find in all files" })
vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set(
  "n", -- mode
  "<leader>fp", -- key to bind
  function()
    vim.fn.setreg("*", vim.fn.expand("%")) -- copy file path to clipboard
    vim.notify("File path copied to clipboard", vim.log.levels.INFO) -- display notification
  end,
  { noremap = true, silent = true, desc = "Copy file path relative to root" } -- options
)
vim.keymap.set("n", "<leader>gb", ":ToggleBlame window<CR>", { noremap = true, silent = true })
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume last telescope session" }
)
vim.keymap.set(
  "n",
  "<leader>fhh",
  ":Telescope file_history history<CR>",
  { noremap = true, silent = true, desc = "View the file's history" }
)
vim.keymap.set(
  "n",
  "<leader>fhl",
  ":Telescope file_history log<CR>",
  { noremap = true, silent = true, desc = "View the file's history incrementally" }
)
vim.keymap.set(
  "n",
  "<leader>fhb",
  ":Telescope file_history backup<CR>",
  { noremap = true, silent = true, desc = "Backup file (possibly with tag)" }
)
vim.keymap.set(
  "n",
  "<leader>fhf",
  ":Telescope file_history files<CR>",
  { noremap = true, silent = true, desc = "View every file in the repo" }
)
vim.keymap.set(
  "n",
  "<leader>fhq",
  ":Telescope file_history query<CR>",
  { noremap = true, silent = true, desc = "Query the repo" }
)
vim.keymap.set("n", "<leader>gdl", ":DiffviewFileHistory<CR>", { noremap = true, silent = true, desc = "View history" })
vim.keymap.set(
  "n",
  "<leader>gdf",
  ":DiffviewFileHistory %<CR>",
  { noremap = true, silent = true, desc = "View file history" }
)
vim.keymap.set("n", "<leader>gde", ":DiffviewOpen <CR>", { noremap = true, silent = true, desc = "Open current index" })
vim.keymap.set("n", "<leader>gdd", ":DiffviewClose<CR>", { noremap = true, silent = true, desc = "Close Diffview" })
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- git-worktree
vim.keymap.set(
  "n",
  "<leader>gwl",
  require("telescope").extensions.git_worktree.git_worktrees,
  { noremap = true, silent = true, desc = "List worktrees" }
)
vim.keymap.set(
  "n",
  "<leader>gwc",
  require("telescope").extensions.git_worktree.create_git_worktree,
  { noremap = true, silent = true, desc = "List worktrees" }
)

local function toggle_dim()
  if snacks.dim.enabled then
    snacks.dim.disable()
  else
    snacks.dim.enable()
  end
end

vim.keymap.set("n", "<leader>uxd", toggle_dim, { noremap = true, desc = "Toggle scope dimming" })
