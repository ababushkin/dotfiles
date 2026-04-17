return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("gruvbox").setup({ contrast = "hard" })
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
