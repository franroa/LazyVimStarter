return {
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
