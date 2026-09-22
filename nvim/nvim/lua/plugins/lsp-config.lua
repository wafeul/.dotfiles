return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
				ensure_installed = {
					"json-to-sruct",
					"easy-coding-standard",
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vimls",
					"phpactor",
					"jsonls",
					"angularls",
					"dockerls",
					"html",
					"bashls",
					"pylsp",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local util = require("lspconfig.util")

			local sign = function(opts)
				vim.fn.sign_define(opts.name, {
					texthl = opts.name,
					text = opts.text,
					numhl = "",
				})
			end

			local function check_angular_deps(root_dir)
				local missing = {}

				if not util.path.exists(root_dir .. "/node_modules/typescript") then
					table.insert(missing, "typescript")
				end
				if not util.path.exists(root_dir .. "/node_modules/@angular/language-service") then
					table.insert(missing, "@angular/language-service")
				end

				if #missing > 0 then
					vim.schedule(function()
						require("angular_deps").pick(missing)
					end)
				end
			end

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
			})

			vim.lsp.config("angularls", {
				capabilities = capabilities,
				on_new_config = function(new_config, root_dir)
					check_angular_deps(root_dir)

					new_config.cmd = {
						"ngserver",
						"--stdio",
						"--tsProbeLocations",
						root_dir .. "/node_modules",
						"--ngProbeLocations",
						root_dir .. "/node_modules",
					}
				end,
			})

			vim.lsp.config("html", {
				capabilities = capabilities,
			})

			vim.lsp.config("bashls", {
				capabilities = capabilities,
			})

			vim.lsp.config("dockerls", {
				cmd = { "docker-langserver", "--stdio" },
				filetypes = { "Dockerfile", "dockerfile" },
			})

			vim.lsp.config("phpactor", {
				cmd = {
					vim.fn.stdpath("data") .. "/mason/bin/phpactor",
					"language-server",
				},
				filetypes = { "php" },
				root_markers = {
					"composer.json",
					".git",
					".phpactor.json",
					".phpactor.yml",
				},
				workspace_required = true,
				capabilities = capabilities,
				init_options = {
					["language_server_phpstan.enabled"] = false,
					["language_server_psalm.enabled"] = false,
				},
			})

			vim.lsp.config("pylsp", {
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = { enabled = false },
							flake8 = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							black = { enabled = true },
							pylint = { enabled = true },
						},
					},
				},
			})

			vim.lsp.enable({
				"lua_ls",
				"angularls",
				"html",
				"bashls",
				"dockerls",
				"phpactor",
				"pylsp",
			})

			sign({ name = "DiagnosticSignError", text = "✘" })
			sign({ name = "DiagnosticSignWarn", text = "▲" })
			sign({ name = "DiagnosticSignHint", text = "⚑" })
			sign({ name = "DiagnosticSignInfo", text = "»" })

			vim.diagnostic.config({
				virtual_text = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		end,
	},
}
