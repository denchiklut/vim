return {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = vim.keymap.set
    map("n", "<leader>gh", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
    map("n", "<leader>gB", gs.blame_line, { buffer = bufnr, desc = "Blame line" })
    map("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
  end,
}
