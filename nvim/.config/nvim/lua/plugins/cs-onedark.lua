return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  name = "onedark",
  config = function()
    require("onedark").setup({
      style = "darker",
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
    })
  end,
}
