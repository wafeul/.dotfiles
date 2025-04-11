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
                },
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = "",
                })
            end

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.angularls.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
            lspconfig.dockerls.setup({
                cmd = { "docker-langserver", "--stdio" },
                filetypes = { "Dockerfile", "dockerfile" }
            })
            lspconfig.phpactor.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                init_options = {
                    ["language_server_phpstan.enabled"] = false,
                    ["language_server_psalm.enabled"] = false,
                },
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
