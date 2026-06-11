return {
	"nvim-tree/nvim-tree.lua",
    lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
                number = true,
                relativenumber = true,
                centralize_selection = true,
                width = 35,
			},
			renderer = {
				icons = {
                    glyphs = {
                        git = {
                          unstaged = "✗",
                          staged = "✓",
                          unmerged = "",
                          renamed = "",
                          untracked = "★",
                          deleted = "",
                          ignored = "",
                        },
                    },
				},
			},
			filters = {
                git_ignored = false,
			},
		})
	end,
}
