-- options = { noremap = true }
-- Source Lua Packer plugin
-- require("plugins")
vim.opt.termguicolors = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

local function open_nvim_tree()
    -- open the tree.
    require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
end
-- Call the open_nvim_tree function after all plugins has been loaded ("VimEnter"). If not here, not working with alpha plugin.
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
require("keyboard-shortcuts")
