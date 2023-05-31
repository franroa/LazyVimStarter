return {
  {
    "m4xshen/smartcolumn.nvim",
    event = "BufRead",
    config = {
      colorcolumn = "110",
      disabled_filetypes = { "help", "text", "markdown", "mason", "lspinfo" },
      custom_colorcolumn = {},
      scope = "file",
    },
  },
}
