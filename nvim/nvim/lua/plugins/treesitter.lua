return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            rainbow = {
                enable = false,
                extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
                max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
            },
            auto_install = true,
            indent = { enable = true, disable = { "yaml", "python" } },
            highlight = { enable = "true" },
        })
    end,
}
