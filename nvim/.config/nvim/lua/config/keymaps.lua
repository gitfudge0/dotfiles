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
vim.keymap.set("n", "<leader>ao", function()
  -- Check if 'opencode' command exists
  local opencode_exists = vim.fn.system("command -v opencode"):match("opencode")
  if not opencode_exists then
    vim.notify("'opencode' command not found. Please install it to use this feature.", vim.log.levels.ERROR)
    return
  end
  -- Open a vertical split on the right
  vim.cmd("vsplit")
  -- Open a terminal in the new split and run 'opencode'
  vim.cmd("terminal opencode")
  -- Get the window ID of the terminal
  local terminal_win = vim.api.nvim_get_current_win()
  -- Move cursor explicitly to the terminal window
  vim.api.nvim_set_current_win(terminal_win)
  -- Enter terminal insert mode to make it interactable
  vim.cmd("startinsert")
  -- Add ability to move between open windows
end, { desc = "Open opencode in right split" })

-- Open copilot panel with <leader>op
vim.keymap.set("n", "<leader>ap", ":Copilot panel<CR>", { noremap = true, silent = true, desc = "Open Copilot Panel" })

-- Terminal: <C-Space> exits to normal mode
vim.keymap.set("t", "<C-Space>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Terminal normal mode" })

-- Visual: <leader>yl copies file:line-range to clipboard
vim.keymap.set("v", "<leader>yl", function()
  -- Get project root (current working directory)
  local project_root = vim.fn.getcwd()
  -- Get absolute file path and make it relative to project root
  local abs_path = vim.fn.expand("%:p")
  local rel_path = abs_path:sub(#project_root + 2) -- +2 to remove "/" after root
  -- Get visual selection line range
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local range_str = "L" .. tostring(start_line) .. "-" .. tostring(end_line)
  -- Format and copy
  local result = rel_path .. ":" .. range_str
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result, vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Copy file:line-range to clipboard" })
