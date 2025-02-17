local fmt = string.format

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
        adapter = "qwen",
        prompts = {
          -- The prompt to send to the LLM when a user initiates the inline strategy and it needs to convert to a chat
          inline_to_chat = function(context)
            return fmt(
              [[I want you to act as an expert and senior developer in the %s language. I will ask you questions, perhaps giving you code examples, and I want you to advise me with explanations and code where necessary.]],
              context.filetype
            )
          end,
        },
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
    prompt_library = {
      ["Code Review"] = {
        strategy = "chat",
        description = "Get code review from an LLM",
        opts = {
          modes = { "v" },
          short_name = "review",
          auto_submit = true,
          stop_context_insertion = true,
          user_prompt = false,
        },
        prompts = {
          {
            role = "system",
            content = function(context)
              return "I want you to act as a senior "
                .. context.filetype
                .. " developer. I want you to review the code and give me suggestions that improve the code quality."
            end,
          },
          {
            role = "user",
            content = function(context)
              local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

              return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
    },
  },
}
