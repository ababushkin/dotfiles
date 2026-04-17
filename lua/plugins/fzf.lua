return {
  { "junegunn/fzf", build = "./install --all" },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { "FZF", "Files", "Tags", "Buffers", "Rg", "GFiles" },
    init = function()
      vim.cmd([[
        cabbrev f FZF
        cabbrev t Tags
      ]])
    end,
  },
}
