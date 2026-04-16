-- ~/.config/nvim/lua/plugins/init.lua

return {
  -- Colorscheme
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruber-darker").setup({})
      vim.cmd("colorscheme gruber-darker")
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", opts = {} },

  -- UI & Essentials
  { "folke/trouble.nvim", opts = {} },
  { "akinsho/toggleterm.nvim", opts = {} },
  { "folke/todo-comments.nvim", opts = {} },
  { "mrjones2014/smart-splits.nvim", opts = {} },
  { "ThePrimeagen/refactoring.nvim", opts = {} },
  { "windwp/nvim-ts-autotag", opts = {} },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "go", "html", "javascript", "json", "lua", "nim", "python", "rust", "toml", "typescript", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Overseer (Task runner)
  {
    "stevearc/overseer.nvim",
    config = function()
      local overseer = require("overseer")
      overseer.setup({ strategy = "toggleterm", dap = true })
      -- C++ Build template
      overseer.register_template({
        name = "C++ build & run",
        builder = function()
          local file = vim.fn.expand("%:p")
          local bin = vim.fn.expand("%:p:r")
          return {
            cmd = {"g++"}, args = { "-O2", file, "-o", bin },
            components = {
              { "on_result_diagnostics_quickfix", open = true },
              { "on_output_quickfix", open = true, close = true },
              "default",
              { "run_after", task_names = {"Run compiled binary"} },
              { "on_complete_dispose", timeout = 1000 },
            },
          }
        end,
        condition = { filetype = { "cpp" } }
      })
      overseer.register_template({
        name = "Run compiled binary",
        builder = function()
          local bin = vim.fn.expand("%:p:r")
          return { cmd = {bin}, components = { "default", { "on_complete_dispose", timeout = 1000 } } }
        end,
      })
    end,
  },

  -- Utilities
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        is_always_hidden = function(name) return vim.tbl_contains({ ".git", ".DS_Store", "node_modules", "target" }, name) end,
        is_hidden_file = function(name) return vim.startswith(name, ".") end,
        show_hidden = true,
      },
    },
  },
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim" }, opts = { lsp = { progress = { enabled = false } } } },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter", "nvim-neotest/neotest-plenary", "nvim-neotest/neotest-python", "rouge8/neotest-rust" },
    config = function()
      require("neotest").setup({ adapters = { require("neotest-plenary"), require("neotest-python"), require("neotest-rust") } })
    end,
  },

  -- Mini.nvim suite
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.visits").setup()
      require("mini.surround").setup({ n_lines = 50 })
      require("mini.statusline").setup()
      require("mini.pick").setup()
      require("mini.pairs").setup()
      require("mini.notify").setup()
      require("mini.indentscope").setup({ symbol = "│" })
      require("mini.git").setup()
      require("mini.diff").setup()
      require("mini.comment").setup()
      require("mini.clue").setup({
        triggers = {
          { keys = "<leader>", mode = "n" }, { keys = "<leader>", mode = "x" },
          { keys = "g", mode = "n" }, { keys = "g", mode = "x" },
          { keys = "<C-w>", mode = "n" }, { keys = "z", mode = "n" },
          { keys = "[", mode = "n" }, { keys = "]", mode = "n" },
        },
      })
    end,
  },

  -- LSP, Completion, Dial
  { "nvimdev/lspsaga.nvim", opts = { lightbulb = { enable = false } } },
  { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = function() require("lsp_lines").setup() end },
  { "lukas-reineke/lsp-format.nvim", opts = {} },
  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"], augend.date.alias["%Y-%m-%d"],
          augend.constant.alias.bool, augend.semver.alias.semver,
          augend.constant.new({ elements = { "and", "or" }, word = true, cyclic = true }),
          augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        },
      })
    end,
  },

  -- DAP (Debugging)
  {
    "mfussenegger/nvim-dap",
    dependencies = { "theHamsta/nvim-dap-virtual-text", "igorlfs/nvim-dap-view", "julianolf/nvim-dap-lldb", "mfussenegger/nvim-dap-python", "leoluz/nvim-dap-go" },
    config = function()
      require("nvim-dap-virtual-text").setup()
      require("dap-view").setup()
      require("dap-lldb").setup()
      -- Nixの絶対パスを汎用パスに変更
      require("dap-python").setup("python3", {})
      require("dap-go").setup()
    end,
  },

  -- Compiler
  { "Zeioth/compiler.nvim", dependencies = { "stevearc/overseer.nvim" }, opts = {} },

  -- Blink.cmp (Completion)
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = { "ribru17/blink-cmp-spell", "Xantibody/blink-cmp-skkeleton" },
    opts = {
      appearance = { use_nvim_cmp_as_default = false },
      completion = { ghost_text = { enabled = true } },
      keymap = {
        ["<C-e>"] = { "cancel" }, ["<C-n>"] = { "select_next" }, ["<C-p>"] = { "select_prev" },
        ["<C-y>"] = { "accept" }, ["<S-Tab>"] = { "snippet_backward", "fallback" }, ["<Tab>"] = { "snippet_forward", "fallback" },
        preset = "none",
      },
      signature = { enabled = true },
      sources = {
        providers = {
          buffer = { name = "Buffer", module = "blink.cmp.sources.buffer" },
          lsp = { name = "LSP", module = "blink.cmp.sources.lsp" },
          path = { name = "Path", module = "blink.cmp.sources.path" },
          skkeleton = { name = "Skkeleton", module = "blink-cmp-skkeleton" },
          spell = { name = "Spell", module = "blink-cmp-spell" },
        },
      },
    },
  },
  
  -- Aerial
  { "stevearc/aerial.nvim", opts = { layout = { default_direction = "right" } } },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      
      local servers = { "clangd", "gopls", "html", "jsonls", "lua_ls", "rust_analyzer", "ts_ls", "ty", "yamlls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({ capabilities = capabilities })
      end
    end,
  },

  -- Skkeleton & Input (Japanese)
  {
    "vim-skk/skkeleton",
    dependencies = { "vim-denops/denops.vim", "delphinus/skkeleton_indicator.nvim" },
    config = function()
      vim.fn["skkeleton#config"]({
        userDictionary = vim.fn.expand("~/.local/share/fcitx5/skk/user.dict"),
        globalDictionaries = {
          { "/usr/share/skk/SKK-JISYO.L", "euc-jp" },
        },
      })
    end,
  },
}
