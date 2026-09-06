local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local servers = {
  "eslint",
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

  -- ESLint: use vscode-eslint-language-server (installed via mason as eslint-lsp)
  if lsp == "eslint" then
    local eslint_cmd = vim.fn.exepath("vscode-eslint-language-server")
    if eslint_cmd ~= "" then
      config.cmd = { eslint_cmd, "--stdio" }
    else
      -- Fallback: try mason path
      local mason_path = vim.fn.stdpath("data") .. "/mason/bin/vscode-eslint-language-server"
      if vim.fn.executable(mason_path) == 1 then
        config.cmd = { mason_path, "--stdio" }
      end
    end
    config.settings = {
      format = { enable = false },
      workingDirectory = { mode = "location" },
    }
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
