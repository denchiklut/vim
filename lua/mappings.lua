require "nvchad.mappings"

local map = vim.keymap.set
local builtin = require "telescope.builtin"

map("i", "jj", "<esc>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", ";", ":", { desc = "Enter command mode" })

map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

map("n", "<leader>gc", ":Neogit commit<cr>", { desc = "Commit changes" })
map("n", "<leader>gp", ":Neogit push<cr>", { desc = "Push changes" })
map("n", "<leader>gP", ":Neogit pull<cr>", { desc = "Pull changes" })

map("n", "<leader>fc", builtin.commands, { desc = "Commands" })
map("n", "<leader>fr", builtin.registers, { desc = "Registers" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>gr", builtin.lsp_references, { desc = "LSP: References" })
map("n", "<leader>gb", builtin.git_branches, { desc = "Git: Branches" })
map("n", "<leader>gh", builtin.git_bcommits, { desc = "Git: History" })
map("n", "<leader>gs", builtin.git_stash, { desc = "Git: Stashes" })

map("n", "<leader>tn", ":tabnext<cr>", { silent = true, desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<cr>", { silent = true, desc = "Previous tab" })
map("n", "<leader>tt", ":tabnew<cr>", { silent = true, desc = "New tab" })
map("n", "<leader>tx", ":tabclose<cr>", { silent = true, desc = "Close tab" })

map("n", "<A-h>", ":TmuxNavigateLeft<cr>", { silent = true })
map("n", "<A-j>", ":TmuxNavigateDown<cr>", { silent = true })
map("n", "<A-k>", ":TmuxNavigateUp<cr>", { silent = true })
map("n", "<A-l>", ":TmuxNavigateRight<cr>", { silent = true })
map("n", "<A-\\>", ":TmuxNavigatePrevious<cr>", { silent = true })

map("n", "<leader>u", ":TestNearest<cr>", { silent = true })
map("n", "<leader>T", ":TestFile<cr>", { silent = true })
map("n", "<leader>s", ":TestSuite<cr>", { silent = true })
map("n", "<leader>l", ":TestLast<cr>", { silent = true })

map({ "i", "n" }, "<C-x>", "copilot#Dismiss()", { expr = true, silent = true, desc = "Copilot: Dismiss" })
map("i", "<C-e>", "copilot#Accept()", { expr = true, silent = true, desc = "Copilot: Accept" })
map("i", "<C-n>", "copilot#Next()", { expr = true, silent = true, desc = "Copilot: Next" })
map("i", "<C-p>", "copilot#Previous()", { expr = true, silent = true, desc = "Copilot: Previous" })

map({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
map({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

vim.cmd [[cab cc CodeCompanion]]
