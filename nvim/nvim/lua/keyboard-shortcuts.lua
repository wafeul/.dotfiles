----------------------------------------------------------------------------------
-- Spectre 
----------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
    desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

----------------------------------------------------------------------------------
-- Neotest
----------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>tn', function() require('neotest').run.run() end)
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end)

----------------------------------------------------------------------------------
-- DAP
----------------------------------------------------------------------------------

local dap = require("dap")
vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>dc", dap.continue, {})
vim.keymap.set("n", "<leader>du", ":lua require'dapui'.toggle()<cr>", {})

----------------------------------------------------------------------------------
-- Transparent
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>tr", ":TransparentToggle<CR>", {})

----------------------------------------------------------------------------------
-- LazyGit
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", {})
vim.keymap.set("n", "<leader>lc", ":LazyGitConfig<CR>", {})

----------------------------------------------------------------------------------
-- Telescope
----------------------------------------------------------------------------------

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

----------------------------------------------------------------------------------
-- NvimTree
----------------------------------------------------------------------------------

vim.keymap.set("n", "<leader>o", ":NvimTreeOpen<CR>", {})
vim.keymap.set("n", "<leader>c", ":NvimTreeClose<CR>", {})
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", {})

----------------------------------------------------------------------------------
-- LSP
----------------------------------------------------------------------------------

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Disable ESLint LSP server and hide virtual text in Neovim
-- Add this to your init.lua or init.vim file
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible,
    })
end)

----------------------------------------------------------------------------------
-- Completion
----------------------------------------------------------------------------------

local cmp = require("cmp")
local luasnip = require("luasnip")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),
		["<Tab>"] = cmp.mapping(function(fallback)
			local col = vim.fn.col(".") - 1

			if cmp.visible() then
				cmp.select_next_item(select_opts)
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				fallback()
			else
				cmp.complete()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item(select_opts)
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
})

----------------------------------------------------------------------------------
-- Personal shortcuts
----------------------------------------------------------------------------------
vim.keymap.set("i", "<c-a>", "<Esc>A", {})
-- vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
-- vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
-- vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
-- vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
