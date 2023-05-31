return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- add pyright to lspconfig
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      config = function()
        require("telescope").load_extension("dap")
      end,
    },
  },
  {
    "telescope.nvim",
    event = "TermOpen",
    dependencies = {
      "tknightz/telescope-termfinder.nvim",
      config = function()
        require("telescope").load_extension("termfinder")
      end,
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      -- opts = {
      --   media_files = {
      --     -- filetypes whitelist
      --     -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      --     filetypes = { "png", "webp", "jpg", "jpeg" },
      --     -- find command (defaults to `fd`)
      --     find_cmd = "rg",
      --   },
      -- },
      config = function()
        require("telescope").load_extension("media_files")
      end,
    },
  },
}
