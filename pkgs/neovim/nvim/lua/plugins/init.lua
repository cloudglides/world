local overrides = require("configs.overrides")
local plugins = {
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("configs.conform")
    end,
  },
    -- Amp Plugin
{
  "sourcegraph/amp.nvim",
  branch = "main", 
  lazy = false,
  opts = { auto_start = true, log_level = "info" },
},
  -- Treesitter with Svelte support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "svelte", "html", "css", "javascript", "typescript", "elixir", "heex", "eex" })
    end,
  },
  { 'wakatime/vim-wakatime', lazy = false },
  -- Mason
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        winblend = 0,
      },
    },
  },
  -- Session Manager
  {
    "Shatur/neovim-session-manager",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    event = "BufWritePost",
    cmd = "SessionManager",
  },
  -- Noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = function()
      return require("configs.noice")
    end,
  },
  -- LSP with Svelte support
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require("configs.lspconfig")
      -- Svelte LSP configuration using new API
      vim.lsp.config('svelte', {})
      vim.lsp.enable('svelte')
    end,
  },
  -- Autopairs with cmp integration
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
        fast_wrap = {},
      })
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  -- Auto-tagging for Svelte
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "html", "heex" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- Auto-insert `end` for Elixir/Ruby blocks
  {
    "RRethy/nvim-treesitter-endwise",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({ endwise = { enable = true } })
    end,
  },
  -- Rainbow nesting so `do`/`end` pairs are visually distinct
  {
    "hiphish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local r = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = r.strategy["global"],
          elixir = r.strategy["local"],
          heex = r.strategy["local"],
        },
      })
    end,
  },
  -- Treesitter Context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
  },
  -- Rust support
  {
    "mrcjkb/rustaceanvim",
    config = function()
      require("configs.rust")
    end,
    version = "^4",
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    ft = { "rust" },
  },
  -- TypeScript tools
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("configs.ts")
    end,
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  },
  -- Outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    opts = {},
  },
  -- cord
  {
    'vyfor/cord.nvim',
    build = ':Cord update',
    lazy = false,
    -- opts = {}
  },
  -- Trouble
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
  },
  -- Todo Comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
  },
  -- Lazydev (neodev replacement)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "nvim-dap-ui" },
      },
    },
  },
  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("configs.dap")
    end,
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
  },
  -- Colorizer
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    config = function()
      require("nvim-highlight-colors").setup({ render = "background" })
    end,
  },
  -- Markdown Preview
  {
    "OXY2DEV/markview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  -- Linting (replaces null-ls linting)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        nix = { "deadnix", "statix" },
        go = { "staticcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  -- Clipboard Enhancements
  {
    "ibhagwan/smartyank.nvim",
    event = "VeryLazy",
    config = function()
      require("configs.smart-yank")
    end,
  },
}
return plugins
