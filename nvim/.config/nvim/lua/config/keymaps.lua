vim.keymap.set(
  "n", -- mode
  "<leader>fP", -- key to bind
  function()
    vim.fn.setreg("*", vim.fn.expand("%")) -- copy file path to clipboard
    vim.notify("File path copied to clipboard", vim.log.levels.INFO) -- display notification
  end,
  { noremap = true, silent = true, desc = "Copy file path relative to root" } -- options
)

-- Diffview
vim.keymap.set("n", "<leader>gD", "", { noremap = true, desc = "GitAdvanced" })
vim.keymap.set("n", "<leader>gDo", ":DiffviewOpen<CR>", { noremap = true, desc = "Open Diffview" })
vim.keymap.set("n", "<leader>gDl", ":DiffviewFileHistory<CR>", { noremap = true, silent = true, desc = "View history" })
vim.keymap.set(
  "n",
  "<leader>gDf",
  ":DiffviewFileHistory %<CR>",
  { noremap = true, silent = true, desc = "View file history" }
)
vim.keymap.set({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action({})
end, { noremap = true, silent = true })

-- Open opencode in right split
vim.keymap.set('n', '<leader>ao', function()
  -- Check if 'opencode' command exists
  local opencode_exists = vim.fn.system('command -v opencode'):match('opencode')
  if not opencode_exists then
    vim.notify("'opencode' command not found. Please install it to use this feature.", vim.log.levels.ERROR)
    return
  end
  -- Open a vertical split on the right
  vim.cmd('vsplit')
  -- Open a terminal in the new split and run 'opencode'
  vim.cmd('terminal opencode')
  -- Get the window ID of the terminal
  local terminal_win = vim.api.nvim_get_current_win()
  -- Move cursor explicitly to the terminal window
  vim.api.nvim_set_current_win(terminal_win)
  -- Enter terminal insert mode to make it interactable
  vim.cmd('startinsert')
end, { desc = 'Open opencode in right split' })
