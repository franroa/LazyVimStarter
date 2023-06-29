return {
  {
    "tpope/vim-fugitive",
    lazy = false,
    keys = {
      {
        "<leader>gC",
        function()
          term = GetCurrentTerminal()
          if term ~= nil then
            term:toggle()
          end

          vim.cmd("Git commit")

          if term ~= nil then
            term:toggle()
          end
        end,
        desc = "Hide lazygit and open commit template",
      },
    },
  }
}
