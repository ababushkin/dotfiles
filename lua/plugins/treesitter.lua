return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "query",
      "bash", "fish",
      "ruby", "elixir",
      "javascript", "typescript", "tsx",
      "html", "css", "json", "yaml", "toml",
      "markdown", "markdown_inline",
      "python", "go", "rust",
      "dockerfile", "gitcommit", "diff",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
  },
}
