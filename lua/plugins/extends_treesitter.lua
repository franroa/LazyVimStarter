return {
  {
    "nvim-treesitter/nvim-treesitter",

    dependencies = { "HiPhish/nvim-ts-rainbow2" },
    opts = {
      highlight = { enable = true, disable = { "yaml" } },
      ensure_installed = { "go", "gomod", "java", "html", "css", "terraform", "hcl" },
      ignore_install = { "help" }
    }
  }
}
