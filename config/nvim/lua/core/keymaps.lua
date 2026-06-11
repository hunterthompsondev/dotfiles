vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Syntax highlighting debugging
vim.keymap.set("n", "<leader>m", "<cmd>lua vim.treesitter.start()<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>lua vim.treesitter.stop()<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>checkhealth vim.treesitter<CR>")

