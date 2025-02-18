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

-- CodeCompanion
vim.keymap.set({ "n", "v" }, "<leader>a", "", { noremap = true, desc = "CodeCompanion" })
vim.keymap.set(
  { "n", "v" },
  "<leader>aa",
  ":CodeCompanionActions<CR>",
  { noremap = true, desc = "CodeCompanion actions" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>ac",
  ":CodeCompanionChat Toggle<CR>",
  { noremap = true, desc = "CodeCompanion chat" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>ad",
  ":CodeCompanionChat Add<CR>",
  { noremap = true, desc = "CodeCompanion add to chat" }
)
vim.keymap.set("v", "<leader>ai", function()
  local prompt = vim.fn.input("Prompt: ")
  if prompt ~= "" then
    vim.cmd(string.format(":'<,'>CodeCompanion /buffer %s", prompt))
  end
end, { desc = "CodeCompanion inline" })
