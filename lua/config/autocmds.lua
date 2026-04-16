-- ~/.config/nvim/lua/config/autocmds.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
    desc = "Restore cursor",
    callback = function()
        local l = vim.fn.line
        local p = l("'\"")
        if p > 0 and p <= l("$") then
            vim.api.nvim_win_set_cursor(0, { p, 0 })
        end
    end,
})

autocmd("TextYankPost", {
    desc = "Yank highlight",
    callback = function() vim.highlight.on_yank() end,
})

autocmd("BufEnter", {
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert!")
        for _, w in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(w).relative == "" and vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= "toggleterm" then
                return
            end
        end
        vim.cmd("quitall")
    end,
})

autocmd("VimEnter", {
    once = true,
    callback = function()
        local ok, mod = pcall(require, "skkeleton_indicator")
        if ok then mod.setup() end
    end,
})

autocmd({ "BufEnter", "BufLeave" }, {
    pattern = "term://*",
    callback = function()
        if vim.fn.expand("<abuf>") ~= vim.fn.bufnr() then return end
        if vim.bo.filetype == "lazygit" then return end
        _G.toggleTermMaximize()
    end,
})

-- Git message placeholder
-- autocmd("FileType", {
--     pattern = "gitcommit",
--     callback = function()
--         if vim.b.git_placeholder_done then return end
--         local handle = io.popen("git diff --name-only --cached")
--         if not handle then return end
--         local files = {}
--         for line in handle:lines() do
--             if #line > 0 then files[#files + 1] = line:gsub("([^/])[^/]*/", "%1/") end
--         end
--         handle:close()
--         if #files == 0 then return end
--         local repl = table.concat(files, ", ")
--         local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
--         for i = 1, #lines do
--             local l = lines[i]
--             if l:find("_GITMESSAGE_MODIFIED_FILE_PLACEHOLDER_", 1, true) then
--                 vim.api.nvim_buf_set_lines(0, i - 1, i, false, { (l:gsub("_GITMESSAGE_MODIFIED_FILE_PLACEHOLDER_", repl, 1)) })
--                 break
--             end
--         end
--         vim.b.git_placeholder_done = true
--     end,
-- })
