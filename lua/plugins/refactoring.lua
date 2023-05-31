-- TODO: also take a look to: https://github.com/ThePrimeagen/refactoring.nvim
-- TODO: You should be able to do this with the LSP. Maybe you can completely remove this file!
return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          if require("lazyvim.util").has("noice.nvim") then
            opts.defaults["<leader>r"] = { name = "+refactor" }
          end
        end,
      },
    },
    event = "BufRead",
    keys = {
      {
        "<leader>rc",
        ":lua require('refactoring').debug.cleanup({})<CR>",
        desc = "Printf"
      },
      {
        "<leader>rv",
        ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
        desc = "Print var"
      },
      {
        "<leader>rv",
        ":lua require('refactoring').debug.print_var({})<CR>",
        desc = "Print var",
        mode = "v"
      },
      {
        "<leader>rp",
        ":lua require('refactoring').debug.printf({below = false})<CR>",
        desc = "Printf"
      },
      {
        "<leader>rr",
        ":lua require('refactoring').select_refactor()<CR>",
        mode = "v",
        desc = "Refactor"
      },
      {
        "<leader>re",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
        mode = "v",
        desc = "Extract Function"
      },
      {
        "<leader>rf",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
        mode = "v",
        desc = "Extract function to file"
      },
      {
        "<leader>rv",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
        mode = "v",
        desc = "Extract variable"
      },
      {
        "<leader>ri",
        [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        mode = "v",
        desc = "Inline variable"
      },
      {
        "<leader>rb",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
        desc = "Extract block"
      },
      {
        "<leader>rbf",
        [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
        desc = "Extract block to file"
      },
      {
        "<leader>re",
        [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
        desc = "Inline variable"
      },
    },
  }
}
