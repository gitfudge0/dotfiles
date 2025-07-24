-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("cmp").setup({
  completion = {
    autocomplete = false,
  },
})
