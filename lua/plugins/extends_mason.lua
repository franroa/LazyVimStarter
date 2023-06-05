return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed =
      { "delve", "gotests", "golangci-lint", "gofumpt", "goimports", "golangci-lint-langserver", "impl", "gomodifytags",
        "iferr", "gotestsum", "helm-ls", -- GO
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettierd",
        -- "jdtls", "java-debug-adapter", "java-test", "google-java-format", -- JAVA
      },
    },
  },
}
