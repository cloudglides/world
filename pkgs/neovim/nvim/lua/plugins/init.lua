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
      vim.list_extend(opts.ensure_installed, { "svelte", "html", "css", "javascript", "typescript", "elixir", "heex", "eex", "nix", "go", "rust", "templ" })
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
      opts.highlight.additional_vim_regex_highlighting = false
      opts.indent = opts.indent or {}
      opts.indent.enable = true
      -- Fix for nvim 0.12.1 parser issues
      opts.auto_install = true
      opts.sync_install = false
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
-- Treesitter Context - nvim 0.12.1 compatibility fix
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
      on_attach = function(buf)
        return vim.api.nvim_buf_line_count(buf) < 5000
      end,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
      -- Workaround for nvim 0.12.1 "No handler for match-percent-separator" and assertion errors
      local context_mod = require("treesitter-context.context")
      local orig_get = context_mod.get
      context_mod.get = function(...)
        local ok, ranges, lines = pcall(orig_get, ...)
        if not ok then return {}, {} end
        if not ranges then return {}, {} end
        if not lines then return ranges, {} end
        return ranges, lines
      end
    end,
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
  -- Trouble - nvim 0.12+ treesitter source fix
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = function()
      return {
        modes = {
          diagnostics = {
            source = false, -- disable treesitter source to avoid "attempt to call a nil value" error
          },
        },
      }
    end,
  },
  -- Todo Comments - nvim 0.12+ extmark regression fix
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = function()
      local ok, err = pcall(require, "todo-comments")
      if not ok then
        vim.notify("todo-comments.nvim failed to load: " .. tostring(err), vim.log.levels.WARN)
      end
    end,
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
  -- Colorizer - nvim 0.12+ startup error fix
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    config = function()
      local ok, err = pcall(require, "nvim-highlight-colors")
      if not ok then
        vim.notify("nvim-highlight-colors failed to load: " .. tostring(err), vim.log.levels.WARN)
      else
        require("nvim-highlight-colors").setup({ render = "background" })
      end
    end,
  },
  -- Markdown Preview - DISABLED: nvim 0.12+ treesitter API incompatibility
  -- "OXY2DEV/markview.nvim" causes: attempt to call method 'range' (a nil value)
  -- Waiting for upstream fix: https://github.com/OXY2DEV/markview.nvim/issues
  -- {
  --   "OXY2DEV/markview.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     local ok, err = pcall(require, "markview")
  --     if not ok then
  --       vim.notify("markview.nvim failed to load: " .. tostring(err), vim.log.levels.WARN)
  --     end
  --   end,
  -- },
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
