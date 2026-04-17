return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Telescope find files" },
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Telescope live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Telescope buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Telescope help tags" },
      { "<leader>fr", function() require("telescope.builtin").resume() end, desc = "Telescope resume" },
      { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Telescope oldfiles" },
      { "<leader>ft", function() require("telescope.builtin").tags() end, desc = "Telescope tags" },
      { "<leader>/",  function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Fuzzy find in buffer" },
    },
    init = function()
      vim.cmd([[
        cabbrev f Telescope find_files
        cabbrev t Telescope tags
      ]])
    end,
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "truncate" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
}
