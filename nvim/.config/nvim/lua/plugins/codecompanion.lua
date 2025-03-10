local fmt = string.format

-- CodeCompanion.nvim configuration
-- This plugin provides AI assistance capabilities in Neovim
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        tools = {
          ["mcp"] = {
            callback = function()
              return require("mcphub.extensions.codecompanion")
            end,
            description = "Call tools and resources from the MCP Servers",
            opts = {
              requires_approval = true,
            },
          },
        },
        adapter = "anthropic",
        inline = "anthropic",
        keymaps = {
          close = {
            modes = { n = "<C-x>", i = "<C-x>" },
          },
        },
      },
      inline = {
        layout = "vertical", -- vertical|horizontal|buffer
        adapter = "anthropic",
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
      -- Global keymaps for CodeCompanion functionality
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
      -- Configure Anthropic (Claude) as the primary AI provider
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "",
          },
          schema = {
            model = {
              default = "claude-3-7-sonnet-20250219",
            },
          },
        })
      end,
      -- Configure Qwen as an alternative model via Ollama
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
    -- Custom prompt templates for different use cases
    prompt_library = {
      ["Code Review"] = {
        strategy = "chat",
        description = "Get code review from an LLM",
        opts = {
          modes = { "n", "v" },
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
                .. " developer. I want you to review the code, give me a rating for the provided code, and give me suggestions that improve the code quality only if the provided code is not great. Do not suggest improvements for the sake of suggestions."
            end,
          },
          {
            role = "user",
            -- Retrieve and send the staged git diff to the LLM for review
            content = function()
              local handle = io.popen("git diff --staged")
              if not handle then
                return "Error: Could not get git diff"
              end
              local diff = handle:read("*a")
              handle:close()
              if not diff or diff == "" then
                return "No staged changes found in git"
              end

              return "I have the following code:\n\n```diff\n" .. diff .. "\n```"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },

      ["Documentation & Flowcharts"] = {
        strategy = "chat",
        description = "Get documentation and flowchart generation assistance",
        opts = {
          modes = { "n", "v" },
          short_name = "api_doc",
          auto_submit = false,
        },
        prompts = {
          {
            role = "system",
            content = function(context)
              return "Act as a senior "
                .. context.filetype
                .. " engineer. We're going to build documentations, flow charts, and pseudo code for APIs, to map exactly what happens inside each API. I will begin by giving you context of the controller file and specify which action we'll be focusing on at a time. Before building the pseudocode, documentation, or flow chart, I want you to go through the provided code and list down all files you need from me to provide better context. You will not being building documentations, pseudocode or flowcharts until I say so. We'll focus only on building context initially and stop after you have enough to confidently tell me what happens in an API. When buidling documentations, pseudocode or flowchart, I want you to build it in grave detail to understand the flows. If multiple updates are being made to the same models, group it together in the pseudocode or flowchart to avoid clutter."
            end,
          },
          {
            role = "user",
            content = function(context)
              local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
              return "Use the following piece of code as a starting point to deteremine all context required to build the documentation or flowchart"
                .. "\n"
                .. text
                .. "\n```\n\n"
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },

      ["Documentation Generator"] = {
        strategy = "workflow",
        description = "Generate comprehensive documentation with context building",
        opts = {
          index = 1,
          is_default = true,
          short_name = "docgen",
        },
        prompts = {
          -- Initial setup prompts - multi-step workflow to gather context before documentation
          {
            {
              role = "system",
              content = function(context)
                return string.format(
                  [[You are an expert %s developer and documentation specialist. Your task is to help build comprehensive documentation by first gathering all necessary context. Follow these steps:
1. Analyze provided code to identify dependencies
2. Request specific files needed for context
3. Build complete understanding of the codebase
4. Generate documentation or flowcharts as requested
]],
                  context.filetype
                )
              end,
              opts = { visible = false },
            },
            {
              role = "system",
              content = "Please provide a list of all files in your project (you can use `find . -type f` or similar command). I'll help identify which files we need for documentation.",
              opts = { auto_submit = false },
            },
            {
              role = "system",
              content = "Please provide the main piece of code you want to document. This will be our starting point.",
              opts = { auto_submit = false },
            },

            {
              role = "user",
              content = "Here is the piece of code",
              opts = { auto_submit = false },
            },
          },
          -- Code analysis prompt
          -- Context building prompt
          {
            {
              role = "system",
              content = "I'll analyze the code and identify missing context. For each method, service, or dependency I find, I'll list the files we need to examine.",
              opts = {
                auto_submit = true,
                type = "persistent",
              },
            },
          },
          -- File reference prompt
          {
            {
              role = "system",
              content = function(context)
                return string.format(
                  [[From the files you listed earlier, I'll identify which ones we need to examine. For each file I identify as relevant, I'll:
1. Add it as a reference using #file{path}
2. Analyze its contents for additional context
3. Identify any new dependencies

Current filetype: %s]],
                  context.filetype
                )
              end,
              opts = {
                auto_submit = true,
                type = "persistent",
              },
            },
          },
          -- Context summary prompt
          {
            {
              role = "system",
              content = "Now I'll summarize all the files and context we've gathered. Please confirm if this is sufficient or if we need more information.",
              opts = { auto_submit = false },
            },
          },
          -- Final documentation prompt
          {
            {
              role = "system",
              content = "Would you like me to generate:\n1. Technical documentation\n2. Flow charts\n3. Both\n\nPlease specify your choice and any particular focus areas.",
              opts = { auto_submit = false },
            },
          },
        },
      },
      ["Precise Execution"] = {
        strategy = "chat",
        description = "Get focused, precise assistance with specific coding tasks",
        opts = {
          modes = { "n", "v" },
          short_name = "precise",
          auto_submit = false,
        },
        prompts = {
          {
            role = "system",
            content = function()
              return "Execute your commands precisely as instructed without unnecessary elaboration. Maintain contextual awareness of previous actions to avoid redundant work. Analyze tasks thoroughly before implementation. Provide solutions optimized for clarity and effectiveness. Respect the current state of your codebase when suggesting modifications. Identify when a requested action has already been completed. Adapt to your coding style and preferences. Focus exclusively on the specific task at hand. Maintain consistency across multiple iterations of similar requests. Prioritize practical functionality over theoretical explanations unless asked"
            end,
          },
          {
            role = "user",
            content = function()
              return "I need assistance with the following task: \n"
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
