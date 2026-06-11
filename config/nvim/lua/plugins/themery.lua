return {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 999,
    config = function()
        require("themery").setup({
            themes = {
                { name = "Catppuccin", colorscheme = "catppuccin" },
                { name = "Cyberdream", colorscheme = "cyberdream" },
                { name = "Gruvbox", colorscheme = "gruvbox" },
                { name = "Kanagawa", colorscheme = "kanagawa" },
            },
            livePreview = true,
        })
    end,
}
