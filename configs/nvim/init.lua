-- JumpDev OS Neovim Configuration
-- Offline-ready: uses system-installed LSPs, no downloads required

-- Leader key (must be before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.cursorline = true

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          native_lsp = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filesystem = { follow_current_file = { enabled = true } },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  -- Treesitter (graceful loading)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup({
          ensure_installed = {
            "lua", "vim", "vimdoc", "bash",
            "javascript", "typescript", "tsx",
            "python", "rust", "go",
            "html", "css", "json", "yaml", "toml", "markdown",
          },
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    end,
  },

  -- LSP (uses system-installed servers)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
        end,
      })

      -- Setup system-installed LSP servers
      local servers = { "lua_ls", "ts_ls", "pyright", "rust_analyzer" }
      for _, server in ipairs(servers) do
        local ok, _ = pcall(function()
          lspconfig[server].setup({})
        end)
      end
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Git signs
  { "lewis6991/gitsigns.nvim", opts = {} },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "catppuccin" } },
  },

  -- Auto pairs
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

  -- Comment toggle
  { "numToStr/Comment.nvim", config = true },

  -- Which key
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
}, {
  -- Lazy.nvim options: don't notify about missing plugins
  checker = { enabled = false },
  change_detection = { notify = false },
})

-- Keymaps
local keymap = vim.keymap.set

-- General
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search" })

-- File explorer
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle explorer" })

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigation
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Move lines
keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Stay centered
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
