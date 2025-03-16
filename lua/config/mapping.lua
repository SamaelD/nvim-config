local keymap = vim.keymap

keymap.set("n", "<C-s>", ":w<cr>")
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("n", "J", ":m .+1<CR>==", { silent = true })
keymap.set("n", "K", ":m .-2<CR>==", { silent = true })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- remap neovim increment/decrement to Alt+, as as Ctrl+A - is used by tmux
keymap.set('n', '<A-a>', '<C-a>', { noremap = true, silent = true })
keymap.set('n', '<A-x>', '<C-x>', { noremap = true, silent = true })
