local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local servers = {
  "gopls",
  "templ",
  -- "rust_analyzer", -- Removed to avoid conflict with rustaceanvim
  "elixirls",
  "clangd",
  -- "tsserver", -- Replaced by typescript-tools.nvim
  "tailwindcss",
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

-- ESLint: only enable when vscode-eslint-language-server is resolvable,
-- otherwise spawning fails at runtime (nixpkgs vscode-langservers-extracted
-- is the primary source; mason eslint-lsp is the fallback)
local eslint_cmd = vim.fn.exepath("vscode-eslint-language-server")
if eslint_cmd == "" then
  local mason_path = vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server"
  if vim.fn.executable(mason_path) == 1 then
    eslint_cmd = mason_path
  end
end

if eslint_cmd ~= "" then
  vim.lsp.config("eslint", {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { eslint_cmd, "--stdio" },
    settings = {
      format = { enable = false },
      workingDirectory = { mode = "location" },
    },
  })
  vim.lsp.enable("eslint")
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
  filetypes = { "html", "templ", "heex" },
  init_options = {
    provideFormatter = false,
  },
})
vim.lsp.enable('html')

-- Tailwind CSS configuration
vim.lsp.config('tailwindcss', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "templ", "astro", "javascript", "typescript",
    "react", "typescriptreact", "heex"
  },
  init_options = { userLanguages = { templ = "html", heex = "html" } },
})
vim.lsp.enable('tailwindcss')
