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
	-- Treesitter with Svelte support
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "svelte", "html", "css", "javascript", "typescript", "elixir" })
		end,
	},
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
			require("lspconfig").svelte.setup({})
		end,
	},
	-- null-ls for formatting (Prettier)
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		opts = function()
			return require("configs.null-ls")
		end,
	},
	-- Auto-tagging for Svelte
	{
		"windwp/nvim-ts-autotag",
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
		config = function()
			require("nvim-ts-autotag").setup()
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
	-- Wakatime
	{
		"wakatime/vim-wakatime",
		lazy = false,
	},
	-- Outline
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		opts = {},
	},
	-- Trouble
	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
	},
	-- Todo Comments
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		config = true,
	},
	-- Neodev
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
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
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPost",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- Markdown Preview
	{
		"OXY2DEV/markview.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},
	-- Clipboard Enhancements
	{
		"ibhagwan/smartyank.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.smart-yank")
		end,
	},
	-- Discord RPC
	{
		"vyfor/cord.nvim",
		branch = "client-server",
		build = ":Cord update",
		lazy = false,
		-- opts = {}
	},
}

return plugins
