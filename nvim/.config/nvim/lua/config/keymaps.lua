vim.keymap.set(
  "n", -- mode
  "<leader>fP", -- key to bind
  function()
    vim.fn.setreg("*", vim.fn.expand("%")) -- copy file path to clipboard
    vim.notify("File path copied to clipboard", vim.log.levels.INFO) -- display notification
  end,
  { noremap = true, silent = true, desc = "Copy file path relative to root" } -- options
)

vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
