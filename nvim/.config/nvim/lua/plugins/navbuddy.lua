return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>nv", "<cmd>Navbuddy<cr>", desc = "Nav" },
  },
  config = function()
    local actions = require("nvim-navbuddy.actions")
    local navbuddy = require("nvim-navbuddy")
    navbuddy.setup({
      window = {
        border = "double",
      },
      lsp = { auto_attach = true },
      mappings = {
        ["<esc>"] = actions.close(), -- Close and cursor to original location
        ["q"] = actions.close(),

        ["j"] = actions.next_sibling(), -- down
        ["k"] = actions.previous_sibling(), -- up

        ["h"] = actions.parent(), -- Move to left panel
        ["l"] = actions.children(), -- Move to right panel
        ["0"] = actions.root(), -- Move to first panel
        ["r"] = actions.rename(), -- Rename currently focused symbol

        ["d"] = actions.delete(), -- Delete scope

        ["f"] = actions.fold_create(), -- Create fold of current scope
        ["F"] = actions.fold_delete(),
        ["<enter>"] = actions.select(), -- Goto selected symbol
        ["t"] = actions.telescope({ -- Fuzzy finder at current level.
          layout_config = { -- All options that can be
            height = 0.60, -- passed to telescope.nvim's
            width = 0.60, -- default can be passed here.
            prompt_position = "top",
            preview_width = 0.50,
          },
          layout_strategy = "horizontal",
        }),

        ["g?"] = actions.help(), -- Open mappings help window
      },
    })
  end,
}
