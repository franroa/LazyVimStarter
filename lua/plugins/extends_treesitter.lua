return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true, disable = { "yaml" } },
      ensure_installed = { "go", "gomod", "java" },
      ignore_install = { "help" }
    }
  }
}
