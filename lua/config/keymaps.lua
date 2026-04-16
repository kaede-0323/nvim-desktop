-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

-- Toggleterm Maximizer (Global function needed by keybinds)
_G.last_height = nil
function _G.toggleTermMaximize()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype ~= "terminal" then return end
    local win = vim.fn.bufwinid(buf)
    if win == -1 then return end
    local cur_height = vim.api.nvim_win_get_height(win)
    if _G.last_height == nil then
        _G.last_height = cur_height
        local max_height = vim.o.lines - 5
        vim.api.nvim_win_set_height(win, max_height)
    else
        vim.api.nvim_win_set_height(win, _G.last_height)
        _G.last_height = nil
    end
end

-- Oil / Explorer
map("n", "<leader>e", function()
    if vim.bo.filetype == "toggleterm" then return end
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then path = vim.uv.cwd() else path = vim.fn.fnamemodify(path, ":h") end
    require("oil").open(path)
end, { desc = "Open Oil", silent = true })

-- Smart Splits
map("n", "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<CR>")
map("n", "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<CR>")
map("n", "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<CR>")
map("n", "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<CR>")
map("n", "<A-h>", "<cmd>lua require('smart-splits').resize_left()<CR>")
map("n", "<A-j>", "<cmd>lua require('smart-splits').resize_down()<CR>")
map("n", "<A-k>", "<cmd>lua require('smart-splits').resize_up()<CR>")
map("n", "<A-l>", "<cmd>lua require('smart-splits').resize_right()<CR>")

-- Mini Pick
map("n", "<leader>ff", "<cmd>lua require('mini.pick').builtin.files()<CR>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fg", "<cmd>lua require('mini.pick').builtin.grep_live()<CR>", { desc = "[F]ind [G]rep" })
map("n", "<leader>fb", "<cmd>lua require('mini.pick').builtin.buffers()<CR>", { desc = "[F]ind [B]uffers" })
map("n", "<leader>fh", "<cmd>lua require('mini.pick').builtin.help()<CR>", { desc = "[F]ind [H]elps" })
map("n", "<leader>fr", "<cmd>lua require('mini.pick').builtin.resume()<CR>", { desc = "[F]ind [R]esume" })
map("n", "<leader>fl", "<cmd>lua require('mini.pick').builtin.visit_paths()<CR>", { desc = "[F]ind [L]ast" })

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<leader>fo", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "[FO]rmat", silent = true })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Quickfix list" })

-- Dial
map("n", "<C-a>", "<cmd>lua require('dial.map').manipulate('increment', 'normal')<CR>")
map("n", "<C-x>", "<cmd>lua require('dial.map').manipulate('decrement', 'normal')<CR>")
map("n", "g<C-a>", "<cmd>lua require('dial.map').manipulate('increment', 'gnormal')<CR>")
map("n", "g<C-x>", "<cmd>lua require('dial.map').manipulate('decrement', 'gnormal')<CR>")
map("x", "<C-a>", "<cmd>lua require('dial.map').manipulate('increment', 'visual')<CR>")
map("x", "<C-x>", "<cmd>lua require('dial.map').manipulate('decrement', 'visual')<CR>")
map("x", "g<C-a>", "<cmd>lua require('dial.map').manipulate('increment', 'gvisual')<CR>")
map("x", "g<C-x>", "<cmd>lua require('dial.map').manipulate('decrement', 'gvisual')<CR>")

-- Refactoring
map({ "n", "x" }, "<leader>re", "<cmd>lua require('refactoring').refactor('Extract Function')<CR>")
map({ "n", "x" }, "<leader>rf", "<cmd>lua require('refactoring').refactor('Extract Function To File')<CR>")
map({ "n", "x" }, "<leader>rv", "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>")
map({ "n", "x" }, "<leader>rI", "<cmd>lua require('refactoring').refactor('Inline Function')<CR>")
map({ "n", "x" }, "<leader>ri", "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>")

-- Misc
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { silent = true })
map("n", "<F5>", ":OverseerRun<CR>", { desc = "Build & Run with Overseer" })
map("n", "<leader>t", ":ToggleTerm<CR>", { desc = "[T]oggleTerm" })
map("i", "jj", "<Esc>", { noremap = true, silent = true })
map("t", "<esc>", "<C-\\><C-n>")
map("t", "<C-h>", "<Cmd>wincmd h<CR>")
map("t", "<C-j>", "<Cmd>wincmd j<CR>")
map("t", "<C-k>", "<Cmd>wincmd k<CR>")
map("t", "<C-l>", "<Cmd>wincmd l<CR>")
map("n", "<leader>Tm", "<cmd>lua _G.toggleTermMaximize()<CR>", { desc = "[T]erminal [M]ax", noremap = true, silent = true })

-- Skkeleton
map("i", "<C-j>", "<Plug>(skkeleton-toggle)")
