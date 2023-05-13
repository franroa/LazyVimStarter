return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "helm-ls",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "helm_ls",
        "helm-ls",
      },
      automatic_installation = true,
    },
  },
}
