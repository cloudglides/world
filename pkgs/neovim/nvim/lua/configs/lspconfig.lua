local configs = require("nvchad.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities
local lspconfig = require("lspconfig")
local servers = {
  "eslint",
  "gopls",
  "templ",
  -- "rust_analyzer", -- Removed to avoid conflict with rustaceanvim
  "elixirls",
  "clangd", -- Added for C/C++ support
}
for _, lsp in ipairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  -- Elixir special config
  if lsp == "elixirls" then
    opts.cmd = { "elixir-ls" } -- assumes elixir-ls is in PATH
  end
  lspconfig[lsp].setup(opts)
end
lspconfig.nil_ls.setup({
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
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})
lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ" },
})
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "templ", "astro", "javascript", "typescript",
    "react", "typescriptreact"
  },
  init_options = { userLanguages = { templ = "html" } },
})
