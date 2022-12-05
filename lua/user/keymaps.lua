local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation in split window mode
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows keys in split window mode
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<c-PageDown>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<c-PageUp>", ":bprevious<CR>", opts)
keymap("n", "<a-w>", "<cmd>Bdelete!<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode while tab shifting entire block
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- hold on to what was yanked while pasting on top of some other highlighted block in visual mode
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Misc
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise()<CR>", opts)
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)


-- Better terminal navigation
-- Terminal --
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope
keymap("n", "<leader>sf", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>st", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>sp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>sb", "<cmd>Telescope buffers theme=dropdown<cr>", opts)
keymap("n", "<leader>sc", "<cmd>Telescope commands<cr>", opts)
keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<cr>", opts)

-- LSP
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format {async = true } <cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)

-- Harpoon
keymap("n", "<leader>pm", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>pq", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

keymap("n", "<leader>pn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", opts)
keymap("n", "<leader>pp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts)
