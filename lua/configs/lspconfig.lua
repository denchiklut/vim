require("nvchad.configs.lspconfig").defaults()

local servers = { "ts_ls", "eslint", "html", "cssls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
