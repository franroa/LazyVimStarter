return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true, disable = { "yaml" } },
      ensure_installed = { "go", "gomod", "java", "html", "css" },
      ignore_install = { "help" }
    }
  }
}
