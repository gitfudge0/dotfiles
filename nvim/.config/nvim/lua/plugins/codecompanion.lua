return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "qwen",
        inline = "qwen",
        keymaps = {
          close = {
            modes = {
              n = "q",
            },
            index = 3,
            callback = "keymaps.close",
            description = "Close Chat",
          },
          stop = {
            modes = {
              n = "<C-c",
            },
            index = 4,
            callback = "keymaps.stop",
            description = "Stop Request",
          },
        },
      },
      inline = {
        layout = "vertical", -- vertical|horizontal|buffer
        keymaps = {
          accept_change = {
            modes = { n = "ga" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "gr" },
            description = "Reject the suggested change",
          },
        },
      },
      keys = {
        {
          "<leader>ac",
          "<cmd>CodeCompanionActions<cr>",
          mode = { "n", "v" },
          noremap = true,
          silent = true,
          desc = "CodeCompanion actions",
        },
        {
          "<leader>aa",
          "<cmd>CodeCompanionChat Toggle<cr>",
          mode = { "n", "v" },
          noremap = true,
          silent = true,
          desc = "CodeCompanion chat",
        },
        {
          "<leader>ad",
          "<cmd>CodeCompanionChat Add<cr>",
          mode = "v",
          noremap = true,
          silent = true,
          desc = "CodeCompanion add to chat",
        },
      },
    },
    adapters = {
      qwen = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "qwen", -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = "qwen2.5-coder:latest",
            },
          },
        })
      end,
    },
    opts = {
      log_level = "DEBUG",
    },
    display = {
      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = "vertical", -- vertical|horizontal split for default provider
        opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
        provider = "mini_diff", -- default|mini_diff
      },
    },
  },
}
