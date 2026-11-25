-- Python language server: ty (https://github.com/astral-sh/ty).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ty = {},
      },
    },
  },
  -- Also install ty through Mason's own tool list.
  -- mason-lspconfig skips installing servers when it thinks nvim is headless.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "ty" },
    },
  },
}
