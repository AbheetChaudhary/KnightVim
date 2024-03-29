local opts = { noremap = true, silent = true }

-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Toggle word wrap
keymap("n", "<A-z>", "<cmd>set wrap! linebreak<CR>", opts)

vim.keymap.set("n", "<leader>ls", ":buffers<CR>")
vim.keymap.set("n", "<leader>,", ":source %<CR>", {silent = true})

-- Although either Nvim-tree or project-nvim dont respect it
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>", {silent = true})

-- Copy to system clipboard
keymap("v", "Y", '"+y', opts)
keymap("n", "Y", '"+y', opts)
keymap("n", "yY", '"+yy', opts)

-- Motion f/F and t/T remapped using Hop

-- Resize with arrows keys in split window mode
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
keymap("n", "<c-PageDown>", ":bnext<CR>", opts)
keymap("n", "<c-PageUp>", ":bprevious<CR>", opts)
keymap("n", "<a-w>", "<cmd>bdelete!<CR>", opts)

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
keymap("v", "<leader>p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Comment
keymap("n", "<C-_>", "<cmd>lua require('Comment.api').toggle.linewise()<CR>", opts) -- better to use the universal line comment shortcut. The keybinding is <C-/> but why do i need to
-- write it as <C-_>
-- Other keymaps are in user.comments

keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- some toggleterm related keymaps in user.toggleterm.

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files theme=dropdown previewer=false winblend=10<CR>",
	opts
)
keymap(
	"n",
	"<leader>sf",
	"<cmd>Telescope find_files theme=dropdown winblend=10<CR>",
	opts
)
keymap(
	"n",
	"<leader>fe",
	"<cmd>Telescope find_files theme=dropdown previewer=false cwd=~/.config/nvim/<CR>",
	opts
)
keymap("n", "<leader>st", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>sp", "<cmd>Telescope projects theme=dropdown winblend=10<CR>", opts)
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", opts)
keymap("n", "<leader>sb", "<cmd>Telescope buffers theme=dropdown winblend=10<CR>", opts)
keymap("n", "<leader>sc", "<cmd>Telescope commands<CR>", opts)
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", opts)
keymap("n", "<leader>sr", "<cmd>Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles previewer=false theme=dropdown winblend=10<CR>", opts)
keymap(
	"n",
	"<leader>/",
	"<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({previewer = false, winblend = 10}), {sorting_strategy='ascending'})<CR>",
	opts
)
-- and many in user.telescope for when telescope buffer is open.


-- Completion 
-- cmp completion related plugins are in user.cmp

-- LSP
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format {async = true } <CR>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
keymap("n", "<leader>lI", "<cmd>Mason<CR>", opts)
keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
-- few more lsp related plugins are in user.lsp.settings.nvim-lspconfig. They work only in lsp's presence

-- Debuggers
-- some keybindings in user.dap

-- Harpoon
keymap("n", "<leader>m","<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>pa", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<C-h>",  "<cmd>lua require'harpoon.ui'.nav_file(1)<CR>", opts)
keymap("n", "<C-t>",  "<cmd>lua require'harpoon.ui'.nav_file(2)<CR>", opts)
keymap("n", "<C-n>",  "<cmd>lua require'harpoon.ui'.nav_file(3)<CR>", opts)
keymap("n", "<C-s>",  "<cmd>lua require'harpoon.ui'.nav_file(4)<CR>", opts)

-- JABS
keymap("n", "<leader>bj",  "<cmd>JABSOpen<CR>", opts)  -- a few more in user.jabs

--cybu -- need to remove this...or rethink may be
vim.keymap.set("n", "[b", "<Plug>(CybuLastusedPrev)")
vim.keymap.set("n", "]b", "<Plug>(CybuLastusedNext)")
vim.keymap.set("n", "<S-h>", "<plug>(CybuPrev)")
vim.keymap.set("n", "<S-l>", "<plug>(CybuNext)")
