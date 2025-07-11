return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "right", -- | top | left | right | horizontal | vertical
          ratio = 0.5,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          accept = "<Tab>", -- Use <Tab> to accept the suggestion
          accept_word = false,
          accept_line = false,
          next = "<C-]>", -- Use <C-]> to go to the next suggestion
          prev = "<C-[>", -- Use <C-[> to go to the previous suggestion
          dismiss = "<C-Tab>", -- Use <C-Tab> to dismiss the suggestion
        },
      },
    })
  end,
}
