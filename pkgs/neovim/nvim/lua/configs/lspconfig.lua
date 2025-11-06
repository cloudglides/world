local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local servers = {
  "eslint",
  "gopls",
  "templ",
  -- "rust_analyzer", -- Removed to avoid conflict with rustaceanvim
  "elixirls",
  "clangd", -- Added for C/C++ support
}

-- Configure standard servers
for _, lsp in ipairs(servers) do
  local config = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  -- Elixir special config
  if lsp == "elixirls" then
    config.cmd = { "elixir-ls" } -- assumes elixir-ls is in PATH
  end

  vim.lsp.config(lsp, config)
  vim.lsp.enable(lsp)
end

-- nil_ls configuration
vim.lsp.config('nil_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "nix" },
  cmd = { "nil" },
  settings = {
    ["nil"] = {
      flake = {
        autoArchive = true,
      },
    },
  },
})
vim.lsp.enable('nil_ls')

-- HTML configuration
vim.lsp.config('html', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})
vim.lsp.enable('html')

-- HTMX configuration
vim.lsp.config('htmx', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})
vim.lsp.enable('htmx')

-- Tailwind CSS configuration
vim.lsp.config('tailwindcss', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "templ", "astro", "javascript", "typescript",
    "react", "typescriptreact"
  },
  init_options = { userLanguages = { templ = "html" } },
})
vim.lsp.enable('tailwindcss')
