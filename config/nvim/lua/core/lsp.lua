vim.lsp.config('clang_lsp', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
})
vim.lsp.enable('clang_lsp')
