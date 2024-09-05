local keymap = vim.keymap

keymap.set("n", "<C-s>", ":w<cr>")
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
keymap.set("n", "J", ":m .+1<CR>==", { silent = true })
keymap.set("n", "K", ":m .-2<CR>==", { silent = true })
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
