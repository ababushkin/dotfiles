return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile" },
  opts = {
    hijack_cursor = true,
    filters = { dotfiles = false, git_ignored = false },
    renderer = {
      highlight_git = true,
      indent_markers = { enable = true },
    },
    git = { enable = true },
    view = { width = 35 },
  },
}
