return {
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-cmdline" },

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"tailwindcss",
				"biome",
				"ts_ls",
				"css_variables",
				"cssmodules_ls",
				"emmet_language_server",
				"html",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{ "neovim/nvim-lspconfig" },
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				{}, --  client.config.settings.Lua,
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("cssls", {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = {
								"lua/?.lua",
								"lua/?/init.lua",
							},
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "never",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "biome", "biome-check", "biome-organize-imports" },
				typescript = { "biome", "biome-check", "biome-organize-imports" },
				typescriptreact = { "biome", "biome-check", "biome-organize-imports" },
				javascriptreact = { "biome", "biome-check", "biome-organize-imports" },
				css = { "biome" },
				scss = { "biome" },
				json = { "biome" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				toml = { "tombi" },
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "0", "-ci", "-bn" },
				},
			},
		},
	},

	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
					["<Down>"] = cmp.mapping.select_next_item(cmp_select),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-q>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{
						name = "path",
						option = {
							pathMappings = {
								["@"] = "${folder}/src",
							},
						},
					},
				}, {
					{ name = "buffer" },
				}),
			})

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- or "", "▎", "■"
					spacing = 2,
					source = true,
				},
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
				},
			})
		end,
	},
}
