-- return {
--   "goolord/alpha-nvim",
--   opts = function(_, opts)
--     local logo = [[
-- ██████╗ ██████╗ ██╗ ██████╗ ██████╗  ██████╗ ████████╗
-- ██╔══██╗██╔══██╗██║██╔════╝ ██╔══██╗██╔═══██╗╚══██╔══╝
-- ██║  ██║██████╔╝██║██║  ███╗██████╔╝██║   ██║   ██║
-- ██║  ██║██╔══██╗██║██║   ██║██╔═══╝ ██║   ██║   ██║
-- ██████╔╝██████╔╝██║╚██████╔╝██║     ╚██████╔╝   ██║
-- ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝ ╚═╝      ╚═════╝    ╚═╝
--
--     ]]
--     opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
--   end,
-- }

-- return {
--   "goolord/alpha-nvim",
--   opts = function(_, opts)
--     local logo = [[
--     I use neovim, btw
--     ]]
--     opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
--   end,
-- }

return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[
███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗
████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║
██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║
██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║
██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║
╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
    ]]
    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
